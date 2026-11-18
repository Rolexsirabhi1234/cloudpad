"""
CloudPad Bridge - phones as Xbox controllers for games installed on this laptop.

Double-click to open. Up to 4 phones (local co-op), each one its own Xbox 360 controller.
  * Bluetooth: hold a phone next to the laptop to join (distance is adjustable).
  * USB cable: plug the phone in and turn on USB tethering - it joins by itself and is the
    most reliable option. A Bluetooth player who plugs in moves to the cable automatically.
  * Wi-Fi: press Show QR in the Wi-Fi box and scan it with the phone's camera (no network probing),
    or turn Wi-Fi on so the Bridge finds phones itself. Best network: this laptop's Mobile Hotspot.

Needs:  python -m pip install bleak vgamepad   (the window has an Install button)
"""

import asyncio
import ipaddress
import json
import os
import queue
import re
import socket
import struct
import subprocess
import sys
import threading
import time

APP = "CloudPad Bridge"
IS_WIN = sys.platform == "win32"
SERVICE_UUID = "4c1b0001-7e36-4f0a-9b5d-2a8e6c3f1d70"
INPUT_UUID = "4c1b0002-7e36-4f0a-9b5d-2a8e6c3f1d70"
OUTPUT_UUID = "4c1b0003-7e36-4f0a-9b5d-2a8e6c3f1d70"
USB_PORT = 47123
LINK_PORT = 47124      # the Bridge's own UDP port, so a phone can say hello first (QR join)
QR_HTTP_PORT = 47125   # tiny page the QR code points at
MAX_PLAYERS = 4
DISTANCES = [("Next to laptop", -60), ("Same desk", -72), ("Anywhere", -110)]

A, B, X, Y, LB, RB, LT, RT, VIEW, MENU, L3, R3, UP, DOWN, LEFT, RIGHT, GUIDE = range(17)


# --------------------------------------------------------------------------- protocol
def parse_state(data):
    """15-byte state packet: [0]=1, [1]=seq, [2..4]=buttons, [5..12]=lx,ly,rx,ry int16, [13]=LT, [14]=RT."""
    if len(data) < 15 or data[0] != 1:
        return None
    buttons = data[2] | (data[3] << 8) | (data[4] << 16)
    lx, ly, rx, ry = struct.unpack_from("<hhhh", data, 5)
    lt, rt = data[13], data[14]
    if buttons & (1 << LT):
        lt = 255
    if buttons & (1 << RT):
        rt = 255
    return buttons, lx, ly, rx, ry, lt, rt


def rumble_packet(large, small, ms):
    return bytes([1, large & 255, small & 255, ms & 255, (ms >> 8) & 255])


F1_PORT = 20777


def parse_f1_2020(data):
    """F1 2020 UDP 'Car Telemetry' packet (id 6, 1307 bytes) -> (speed km/h, rpm, gear, drs) of the player's car."""
    if len(data) != 1307 or data[5] != 6 or struct.unpack_from("<H", data, 0)[0] != 2020:
        return None
    idx = data[22]
    if idx >= 22:
        return None
    o = 24 + idx * 58
    speed = struct.unpack_from("<H", data, o)[0]
    gear = struct.unpack_from("<b", data, o + 15)[0]
    rpm = struct.unpack_from("<H", data, o + 16)[0]
    return speed, rpm, gear, data[o + 18]


def telemetry_packet(speed, rpm, gear, drs):
    """Sent to the phone: [3, speed u16, rpm u16, gear i8, drs u8, 0]."""
    return struct.pack("<BHHbBB", 3, min(speed, 65535), min(rpm, 65535), gear, drs, 0)


class _F1Udp(asyncio.DatagramProtocol):
    def __init__(self, engine):
        self.engine = engine

    def datagram_received(self, data, addr):
        self.engine.on_f1(data)

    def error_received(self, exc):
        pass


def _c16(v):
    return max(-32768, min(32767, v))


class Pad:
    """One virtual Xbox 360 controller."""

    def __init__(self, vg, on_rumble):
        self.pad = vg.VX360Gamepad()
        b = vg.XUSB_BUTTON
        self.map = [(A, b.XUSB_GAMEPAD_A), (B, b.XUSB_GAMEPAD_B), (X, b.XUSB_GAMEPAD_X), (Y, b.XUSB_GAMEPAD_Y),
                    (LB, b.XUSB_GAMEPAD_LEFT_SHOULDER), (RB, b.XUSB_GAMEPAD_RIGHT_SHOULDER),
                    (VIEW, b.XUSB_GAMEPAD_BACK), (MENU, b.XUSB_GAMEPAD_START),
                    (L3, b.XUSB_GAMEPAD_LEFT_THUMB), (R3, b.XUSB_GAMEPAD_RIGHT_THUMB),
                    (UP, b.XUSB_GAMEPAD_DPAD_UP), (DOWN, b.XUSB_GAMEPAD_DPAD_DOWN),
                    (LEFT, b.XUSB_GAMEPAD_DPAD_LEFT), (RIGHT, b.XUSB_GAMEPAD_DPAD_RIGHT),
                    (GUIDE, b.XUSB_GAMEPAD_GUIDE)]
        self.last = None
        self.pad.register_notification(callback_function=on_rumble)

    def apply(self, state):
        """Returns True when the input changed (used for the activity light)."""
        if state == self.last:
            return False
        self.last = state
        buttons, lx, ly, rx, ry, lt, rt = state
        for bit, xb in self.map:
            if buttons & (1 << bit):
                self.pad.press_button(button=xb)
            else:
                self.pad.release_button(button=xb)
        self.pad.left_joystick(x_value=_c16(lx), y_value=_c16(-ly))     # phone: down = +, Xbox: up = +
        self.pad.right_joystick(x_value=_c16(rx), y_value=_c16(-ry))
        self.pad.left_trigger(value=lt)
        self.pad.right_trigger(value=rt)
        self.pad.update()
        return True

    def release_all(self):
        self.last = None
        self.pad.reset()
        self.pad.update()


def vigem_installer():
    """The ViGEmBus driver installer that ships inside the vgamepad package."""
    import importlib.util
    import platform
    spec = importlib.util.find_spec("vgamepad")
    if not spec or not spec.submodule_search_locations:
        return None
    arch = "x64" if platform.machine().endswith("64") else "x86"
    path = os.path.join(list(spec.submodule_search_locations)[0], "win", "vigem", "install", arch,
                        "ViGEmBusSetup_%s.msi" % arch)
    return path if os.path.exists(path) else None


# --------------------------------------------------------------------------- USB tethering discovery
SKIP_NETS = re.compile(r"wi-?fi|wireless|wlan|802\.11|bluetooth|hyper-v|vethernet|virtualbox|vmware|wsl|"
                       r"loopback|tap-|vpn|wireguard|tailscale|zerotier|npcap|kernel debug", re.I)
PHONE_NETS = re.compile(r"ndis|ncm|android|apple mobile|tether|mobile|iphone", re.I)


def _net_configs():
    """Every adapter that has an IPv4 address, as dicts (Windows only)."""
    if not IS_WIN:
        return []
    ps = ("Get-NetIPConfiguration | Where-Object { $_.IPv4Address } | ForEach-Object { [pscustomobject]@{ "
          "alias=[string]$_.InterfaceAlias; desc=[string]$_.InterfaceDescription; "
          "ip=[string]$_.IPv4Address[0].IPAddress; prefix=[int]$_.IPv4Address[0].PrefixLength; "
          "gw=[string](($_.IPv4DefaultGateway | Select-Object -First 1).NextHop) } } | ConvertTo-Json -Compress")
    try:
        out = subprocess.run(["powershell", "-NoProfile", "-NonInteractive", "-Command", ps],
                             capture_output=True, text=True, timeout=20, creationflags=0x08000000).stdout.strip()
        data = json.loads(out) if out else []
    except Exception:
        return []
    return [data] if isinstance(data, dict) else data


def find_usb_nets(data=None):
    """Wired networks a phone could be on (USB tethering shows up as RNDIS or, on newer phones, NCM).
    Each entry: alias, desc, ip, phone (looks like a phone), targets (addresses to say hello to)."""
    env = os.environ.get("CLOUDPAD_USB_IPS")
    if env:
        return [{"alias": "Test", "desc": "Remote NDIS test", "ip": ip.strip(), "phone": True,
                 "targets": [ip.strip()]} for ip in env.split(",") if ip.strip()]
    if data is None:
        data = _net_configs()
    nets = []
    for d in data:
        name = "%s %s" % (d.get("alias", ""), d.get("desc", ""))
        ip = d.get("ip") or ""
        if SKIP_NETS.search(name) or not ip or ip.startswith(("127.", "169.254.")):
            continue
        targets = [d["gw"]] if d.get("gw") else []
        try:
            net = ipaddress.IPv4Network("%s/%s" % (ip, d.get("prefix") or 24), strict=False)
            targets.append(str(net.broadcast_address))
            if not d.get("gw") and net.num_addresses <= 256:    # no gateway listed: try every address
                targets += [str(h) for h in net.hosts() if str(h) != ip]
        except Exception:
            pass
        nets.append({"alias": d.get("alias", ""), "desc": d.get("desc", ""), "ip": ip,
                     "phone": bool(PHONE_NETS.search(name)), "targets": list(dict.fromkeys(targets))})
    return nets


# Wi-Fi (and the laptop's own Mobile Hotspot, which Windows shows as a "Wi-Fi Direct Virtual Adapter")
WIFI_NETS = re.compile(r"wi-?fi|wireless|wlan|802\.11|local area connection\*", re.I)
NOT_WIFI = re.compile(r"bluetooth|hyper-v|vethernet|virtualbox|vmware|wsl|loopback|tap-|vpn|wireguard|tailscale|"
                      r"zerotier|npcap|kernel debug", re.I)


def find_wifi_nets(data=None):
    """Private Wi-Fi / hotspot networks a phone could be on. Same shape as find_usb_nets, plus wifi=True and
    net (the /24 or smaller network, as text). Targets: broadcast, gateway, then every address."""
    env = os.environ.get("CLOUDPAD_WIFI_IPS")
    if env:
        return [{"alias": "Test", "desc": "Wi-Fi test", "ip": ip.strip(), "phone": False, "wifi": True,
                 "net": ip.strip() + "/32", "targets": [ip.strip()]} for ip in env.split(",") if ip.strip()]
    if data is None:
        data = _net_configs()
    nets = []
    for d in data:
        name = "%s %s" % (d.get("alias", ""), d.get("desc", ""))
        ip = d.get("ip") or ""
        if not ip or not WIFI_NETS.search(name) or (NOT_WIFI.search(name) and "direct" not in name.lower()):
            continue
        try:
            addr = ipaddress.IPv4Address(ip)
            if not addr.is_private or addr.is_link_local or addr.is_loopback:
                continue
            prefix = max(24, int(d.get("prefix") or 24))        # never sweep more than 254 addresses
            net = ipaddress.IPv4Network("%s/%d" % (ip, prefix), strict=False)
        except Exception:
            continue
        targets = [str(net.broadcast_address)]
        if d.get("gw"):
            targets.insert(0, d["gw"])
        targets += [str(h) for h in net.hosts() if str(h) != ip and str(h) != d.get("gw")]
        nets.append({"alias": d.get("alias", ""), "desc": d.get("desc", ""), "ip": ip, "phone": False,
                     "wifi": True, "net": str(net), "targets": list(dict.fromkeys(targets))})
    return nets


def find_all_nets(wifi):
    data = _net_configs()
    nets = find_usb_nets(data)
    if wifi:
        nets += find_wifi_nets(data)
    return nets


# --------------------------------------------------------------------------- QR code (byte mode, ECC L, v1-5)
_QR_CAP = {1: (19, 7), 2: (34, 10), 3: (55, 15), 4: (80, 20), 5: (108, 26)}   # version: (data, ecc codewords)
_QR_ALIGN = {2: 18, 3: 22, 4: 26, 5: 30}


def _rs_ecc(data, n):
    exp, log = [0] * 512, [0] * 256
    x = 1
    for i in range(255):
        exp[i], log[x] = x, i
        x <<= 1
        if x & 0x100:
            x ^= 0x11D
    for i in range(255, 512):
        exp[i] = exp[i - 255]
    mul = lambda a, b: 0 if not a or not b else exp[log[a] + log[b]]
    gen = [1]
    for i in range(n):
        nxt = [0] * (len(gen) + 1)
        for j, c in enumerate(gen):
            nxt[j] ^= c
            nxt[j + 1] ^= mul(c, exp[i])
        gen = nxt
    rem = [0] * n
    for b in data:
        f = b ^ rem[0]
        rem = rem[1:] + [0]
        for i in range(n):
            rem[i] ^= mul(gen[i + 1], f)
    return rem


def qr_matrix(text):
    """Return a list of rows of booleans (True = dark) for `text`, or raise ValueError if it is too long."""
    raw = text.encode("utf-8")
    ver = next((v for v in sorted(_QR_CAP) if len(raw) <= {1: 17, 2: 32, 3: 53, 4: 78, 5: 106}[v]), None)
    if ver is None:
        raise ValueError("text too long for the QR code")
    ndata, necc = _QR_CAP[ver]
    bits = [0, 1, 0, 0] + [(len(raw) >> i) & 1 for i in range(7, -1, -1)]
    for b in raw:
        bits += [(b >> i) & 1 for i in range(7, -1, -1)]
    bits += [0] * min(4, ndata * 8 - len(bits))
    bits += [0] * (-len(bits) % 8)
    cw = [int("".join(map(str, bits[i:i + 8])), 2) for i in range(0, len(bits), 8)]
    pad = [0xEC, 0x11]
    while len(cw) < ndata:
        cw.append(pad[(len(cw) - len(bits) // 8) % 2])
    cw += _rs_ecc(cw, necc)
    size = 17 + 4 * ver
    mod = [[False] * size for _ in range(size)]
    fn = [[False] * size for _ in range(size)]

    def setf(x, y, v):
        mod[y][x] = v
        fn[y][x] = True

    for i in range(size):                       # timing patterns
        setf(6, i, i % 2 == 0)
        setf(i, 6, i % 2 == 0)

    def finder(cx, cy):
        for dy in range(-4, 5):
            for dx in range(-4, 5):
                x, y = cx + dx, cy + dy
                if 0 <= x < size and 0 <= y < size:
                    d = max(abs(dx), abs(dy))
                    setf(x, y, d not in (2, 4))
    finder(3, 3); finder(size - 4, 3); finder(3, size - 4)
    if ver >= 2:                                # alignment pattern (bottom-right)
        c = _QR_ALIGN[ver]
        for dy in range(-2, 3):
            for dx in range(-2, 3):
                setf(c + dx, c + dy, max(abs(dx), abs(dy)) != 1)

    def format_bits(mask):
        data = (1 << 3) | mask                  # ECC level L = 01
        rem = data
        for _ in range(10):
            rem = (rem << 1) ^ ((rem >> 9) * 0x537)
        bits = ((data << 10) | rem) ^ 0x5412
        g = lambda i: ((bits >> i) & 1) != 0
        for i in range(6):
            setf(8, i, g(i))
        setf(8, 7, g(6)); setf(8, 8, g(7)); setf(7, 8, g(8))
        for i in range(9, 15):
            setf(14 - i, 8, g(i))
        for i in range(8):
            setf(size - 1 - i, 8, g(i))
        for i in range(8, 15):
            setf(8, size - 15 + i, g(i))
        setf(8, size - 8, True)
    format_bits(0)                              # reserve the format areas first
    i = 0
    for right in range(size - 1, 0, -2):        # zig-zag data placement
        if right <= 6:                          # skip the vertical timing column
            right -= 1
        for vert in range(size):
            for j in range(2):
                x = right - j
                y = size - 1 - vert if ((right + 1) & 2) == 0 else vert
                if not fn[y][x] and i < len(cw) * 8:
                    mod[y][x] = ((cw[i >> 3] >> (7 - (i & 7))) & 1) != 0
                    i += 1
    masks = [lambda x, y: (x + y) % 2 == 0, lambda x, y: y % 2 == 0, lambda x, y: x % 3 == 0,
             lambda x, y: (x + y) % 3 == 0, lambda x, y: (x // 3 + y // 2) % 2 == 0,
             lambda x, y: x * y % 2 + x * y % 3 == 0, lambda x, y: (x * y % 2 + x * y % 3) % 2 == 0,
             lambda x, y: ((x + y) % 2 + x * y % 3) % 2 == 0]

    def penalty(m):
        sc = 0
        for grid in (m, [list(r) for r in zip(*m)]):
            for row in grid:
                run = 1
                for k in range(1, size):
                    if row[k] == row[k - 1]:
                        run += 1
                        if run == 5:
                            sc += 3
                        elif run > 5:
                            sc += 1
                    else:
                        run = 1
                line = "".join("1" if v else "0" for v in row)
                sc += 40 * (line.count("10111010000") + line.count("00001011101"))
        for y in range(size - 1):
            for x in range(size - 1):
                if m[y][x] == m[y][x + 1] == m[y + 1][x] == m[y + 1][x + 1]:
                    sc += 3
        dark = sum(v for r in m for v in r)
        sc += 10 * (abs(dark * 20 - size * size * 10) // (size * size))
        return sc
    best = None
    for k, f in enumerate(masks):
        m = [row[:] for row in mod]
        for y in range(size):
            for x in range(size):
                if not fn[y][x] and f(x, y):
                    m[y][x] = not m[y][x]
        mod_backup = mod
        mod = m
        format_bits(k)
        m = mod
        mod = mod_backup
        sc = penalty(m)
        if best is None or sc < best[0]:
            best = (sc, m)
    return best[1]


def _bounce_handler():
    import http.server

    class H(http.server.BaseHTTPRequestHandler):
        def log_message(self, *a):
            pass

        def do_GET(self):
            ip = self.request.getsockname()[0]               # the address the phone used to reach this laptop
            q = "ip=%s&port=%d&n=%s" % (ip, self.server.udp_port, socket.gethostname().replace(" ", "-"))
            page = ("<!doctype html><meta name=viewport content='width=device-width,initial-scale=1'>"
                    "<title>CloudPad</title><body style='font:18px sans-serif;background:#0B0708;color:#F6EFEF;"
                    "text-align:center;padding:40px 20px'><h2>Opening CloudPad...</h2>"
                    "<p><a id=a style='display:inline-block;background:#E03A4B;color:#fff;padding:16px 28px;"
                    "border-radius:12px;text-decoration:none;font-weight:bold' href='intent://connect?%s#Intent;"
                    "scheme=cloudpad;package=com.cloudpad.controller;end'>Open CloudPad</a></p>"
                    "<p style='color:#A8979A'>Nothing happened? Install CloudPad 1.7 or newer on this phone, then "
                    "scan the code again.</p><script>setTimeout(function(){location.href=document.getElementById"
                    "('a').href},400)</script>" % q).encode()
            self.send_response(200)
            self.send_header("Content-Type", "text/html; charset=utf-8")
            self.send_header("Content-Length", str(len(page)))
            self.end_headers()
            self.wfile.write(page)
    return H


def start_bounce(udp_port):
    """Start the page the QR code points at. Returns (server, port)."""
    import http.server
    import threading
    for port in (QR_HTTP_PORT, 0):
        try:
            srv = http.server.ThreadingHTTPServer(("0.0.0.0", port), _bounce_handler())
            break
        except OSError:
            srv = None
    if srv is None:
        raise OSError("no free port for the QR page")
    srv.daemon_threads = True
    srv.udp_port = udp_port
    threading.Thread(target=srv.serve_forever, daemon=True).start()
    return srv, srv.server_address[1]


def lan_addresses():
    """Private IPv4 addresses of this laptop's Wi-Fi / hotspot networks, hotspot first."""
    nets = find_wifi_nets()
    nets.sort(key=lambda n: 0 if "direct" in (n["desc"] + n["alias"]).lower() else 1)
    return [(n["ip"], n["alias"] or n["desc"]) for n in nets]


def allow_in_firewall():
    """Ask Windows (with an admin prompt) to let Python receive the phones' replies."""
    import ctypes
    exes = {sys.executable}
    base = os.path.dirname(sys.executable)
    for n in ("python.exe", "pythonw.exe"):
        if os.path.exists(os.path.join(base, n)):
            exes.add(os.path.join(base, n))
    cmds = " & ".join('netsh advfirewall firewall add rule name="CloudPad Bridge" dir=in action=allow '
                      'program="%s" enable=yes profile=any' % e for e in sorted(exes))
    return ctypes.windll.shell32.ShellExecuteW(None, "runas", "cmd.exe", '/s /c "%s"' % cmds, None, 0) > 32


class _Udp(asyncio.DatagramProtocol):
    def __init__(self, engine):
        self.engine = engine

    def datagram_received(self, data, addr):
        self.engine.on_udp(data, addr)

    def error_received(self, exc):
        pass


# --------------------------------------------------------------------------- engine
class Slot:
    def __init__(self, number):
        self.number = number
        self.key = None            # which phone owns this player (its name)
        self.connected = False
        self.transport = None      # "bluetooth" | "usb"
        self.client = None
        self.address = None        # Bluetooth address
        self.addr = None           # USB / Wi-Fi (ip, port)
        self.link = None           # "usb" or "wifi" for network players
        self.pad = None
        self.last_input = 0.0
        self.large = self.small = 0
        self.dirty = False
        self.rumble_sent = 0.0
        self.left_at = 0.0
        self.left_via = None


class Engine:
    def __init__(self, log):
        self.log = log
        self.loop = None
        self.target = 2
        self.rssi_min = DISTANCES[0][1]
        self.slots = [Slot(n) for n in range(1, MAX_PLAYERS + 1)]
        self.nearby = {}
        self.problem = None        # "vgamepad", "driver" or "bleak"
        self.problem_detail = ""
        self.status = "Starting..."
        self.scanning = False
        self.busy = False
        self.ble_ok = False
        self.udp = None
        self.usb_peers = {}
        self.usb_nets = []
        self.udp_port = 0
        self.wifi = False          # Wi-Fi phones are opt-in (it probes the local network)
        self.usb_first_seen = {}   # net ip -> when we first saw that network
        self.usb_replied = {}      # net ip -> last reply from a phone on it
        self.usb_known = {}        # phone ip -> last reply: these get a hello on every tick
        self.force_find = False
        self.wake = None
        self.vg = None

    # -- thread entry
    def start(self):
        threading.Thread(target=self._thread, daemon=True).start()

    def _thread(self):
        self.loop = asyncio.new_event_loop()
        asyncio.set_event_loop(self.loop)
        try:
            self.loop.run_until_complete(self.main())
        except Exception as e:
            self.log("Stopped: %s" % e)

    async def main(self):
        import importlib
        importlib.invalidate_caches()
        try:
            import vgamepad as vg
            self.vg = vg
        except Exception as e:
            import importlib.util
            self.status = "Setup needed"
            if importlib.util.find_spec("vgamepad") is not None:
                # vgamepad connects to the ViGEmBus driver as soon as it loads, so a missing
                # driver shows up here even though the package itself is installed.
                self.problem = "driver"
                self.problem_detail = str(e)
                self.log("vgamepad is installed, but the ViGEmBus driver isn't (%s). Press Install driver." % e)
            else:
                self.problem = "vgamepad"
                self.log("The 'vgamepad' package is missing (%s). Press Install." % e)
            return
        try:
            self.ensure_pad(self.slots[0])      # proves the controller driver works
        except Exception as e:
            self.status = "Setup needed"
            self.problem_detail = str(e)
            if "VIGEM" in str(e).upper() or "VIGEMBUS" in str(e).upper():
                self.problem = "driver"
                self.log("The ViGEmBus controller driver isn't working: %s" % e)
            else:
                self.problem = "error"
                self.log("Couldn't create the virtual controller: %s" % e)
            return
        try:
            import bleak  # noqa: F401
            self.ble_ok = True
        except Exception:
            self.problem = "bleak"
            self.log("The 'bleak' package is missing - Bluetooth is off, USB cable still works. Press Install.")
        jobs = [self.usb_loop(), self.rumble_loop(), self.f1_loop()]
        if self.ble_ok:
            jobs.append(self.ble_loop())
        await asyncio.gather(*jobs)

    # -- players
    def connected_count(self):
        return sum(s.connected for s in self.slots)

    def ensure_pad(self, slot):
        if slot.pad is None:
            loop = asyncio.get_running_loop()

            s = slot

            # vgamepad only accepts a callback with exactly these parameter names.
            def on_rumble(client, target, large_motor, small_motor, led_number, user_data):
                def apply():
                    if (large_motor, small_motor) != (s.large, s.small):
                        s.large, s.small, s.dirty = large_motor, small_motor, True
                loop.call_soon_threadsafe(apply)
            slot.pad = Pad(self.vg, on_rumble)

    def slot_for(self, key):
        for s in self.slots:                       # same phone as before keeps its number
            if s.key == key and not s.connected:
                return s
        for s in self.slots:                       # a number nobody has used yet
            if s.key is None and not s.connected:
                return s
        for s in self.slots:                       # the number of a phone that left
            if not s.connected:
                return s
        return None

    def attach(self, slot, key, transport, client=None, addr=None):
        self.ensure_pad(slot)
        slot.key, slot.transport, slot.client, slot.addr = key, transport, client, addr
        slot.link = self.link_for(addr) if transport == "usb" else None
        slot.connected = True
        slot.large = slot.small = 0
        self.nearby.pop(key, None)
        self.log("%s joined as Player %d (%s)." % (key, slot.number, {"usb": "USB cable", "wifi": "Wi-Fi"}.get(slot.link, "Bluetooth")))
        asyncio.get_running_loop().create_task(self.buzz(slot))

    def link_for(self, addr):
        """'wifi' if this phone address sits on a Wi-Fi / hotspot network we probe, else 'usb'."""
        try:
            ip = ipaddress.IPv4Address(addr[0])
            for n in self.usb_nets:
                if n.get("wifi") and ip in ipaddress.IPv4Network(n["net"], strict=False):
                    return "wifi"
            for n in self.usb_nets:             # a network we know to be a cable
                if not n.get("wifi") and ip in ipaddress.IPv4Network(n["ip"] + "/24", strict=False):
                    return "usb"
        except Exception:
            pass
        return "wifi"                           # a phone that found us itself (QR) on some other network

    def detach(self, slot, why):
        if not slot.connected:
            return
        slot.left_at, slot.left_via = time.time(), slot.transport
        slot.connected = False
        slot.client = slot.addr = None
        slot.large = slot.small = 0
        if slot.pad:
            slot.pad.release_all()
        self.log("%s (Player %d) %s. It gets Player %d back when it returns." % (slot.key, slot.number, why, slot.number))

    async def write(self, slot, packet):
        try:
            if slot.transport == "usb" and self.udp and slot.addr:
                self.udp.sendto(packet, slot.addr)
            elif slot.client is not None and slot.client.is_connected:
                await slot.client.write_gatt_char(OUTPUT_UUID, packet, response=False)
        except Exception:
            pass

    async def buzz(self, slot):
        """1 buzz = Player 1, 2 buzzes = Player 2..."""
        await asyncio.sleep(0.3)
        for _ in range(slot.number):
            await self.write(slot, rumble_packet(255, 0, 180))
            await asyncio.sleep(0.45)

    async def rumble_loop(self):
        while True:
            await asyncio.sleep(0.05)
            now = time.time()
            for s in self.slots:
                if not s.connected:
                    continue
                active = s.large > 0 or s.small > 0
                if s.dirty or (active and now - s.rumble_sent > 1.0):
                    s.dirty = False
                    s.rumble_sent = now
                    await self.write(s, rumble_packet(s.large, s.small, 1500 if active else 0))

    # -- Bluetooth
    async def ble_loop(self):
        from bleak import BleakScanner
        self.wake = asyncio.Event()
        while True:
            if self.connected_count() >= self.target or self.busy:
                self.scanning = False
                now = time.time()
                for k in [k for k, v in self.nearby.items() if now - v["seen"] > 12]:
                    del self.nearby[k]
                await asyncio.sleep(0.5)
                continue
            self.scanning = True
            try:
                found = await BleakScanner.discover(timeout=3.0, return_adv=True)
            except Exception as e:
                self.scanning = False
                self.log("Bluetooth scan failed (%s). Is Bluetooth on?" % e)
                await asyncio.sleep(4)
                continue
            self.scanning = False
            now, best = time.time(), None
            for dev, adv in found.values():
                if SERVICE_UUID not in [u.lower() for u in (adv.service_uuids or [])]:
                    continue
                key = (adv.local_name or dev.name or dev.address).strip()
                for s in self.slots:              # two phones with the same name
                    if s.connected and s.key == key and s.transport == "bluetooth" and s.address != dev.address:
                        key = "%s (%s)" % (key, dev.address[-5:])
                if any(s.connected and s.key == key for s in self.slots):
                    continue
                if any(s.key == key and s.left_via == "usb" and now - s.left_at < 15 for s in self.slots):
                    continue                      # it was just on the cable: give USB a moment to come back
                rssi = adv.rssi if adv.rssi is not None else -127
                known = any(s.key == key for s in self.slots)   # a returning player rejoins from anywhere
                ok = rssi >= self.rssi_min or known
                self.nearby[key] = {"rssi": rssi, "seen": now, "ok": ok, "via": "bluetooth"}
                if ok and (best is None or rssi > best[0]):
                    best = (rssi, key, dev)
            for k in [k for k, v in self.nearby.items() if now - v["seen"] > 12]:
                del self.nearby[k]
            if best and self.connected_count() < self.target:
                slot = self.slot_for(best[1])
                if slot:
                    self.busy = True
                    asyncio.get_running_loop().create_task(self.ble_session(slot, best[2], best[1]))
            try:                                  # gaps between scans keep existing links stable
                await asyncio.wait_for(self.wake.wait(), 1.5)
            except asyncio.TimeoutError:
                pass
            self.wake.clear()

    async def ble_session(self, slot, dev, key):
        from bleak import BleakClient
        loop = asyncio.get_running_loop()
        gone = asyncio.Event()

        def on_disc(_c):
            loop.call_soon_threadsafe(gone.set)

        def on_input(_s, data):
            if slot.transport != "bluetooth" or not slot.connected or slot.pad is None:
                return
            st = parse_state(bytes(data))
            if st and slot.pad.apply(st):
                slot.last_input = time.time()

        kw = {"disconnected_callback": on_disc, "timeout": 15.0}
        if IS_WIN:
            kw["winrt"] = {"use_cached_services": False}
        self.log("Connecting %s..." % key)
        try:
            async with BleakClient(dev, **kw) as client:
                await client.start_notify(INPUT_UUID, on_input)
                slot.address = dev.address
                self.attach(slot, key, "bluetooth", client=client)
                await asyncio.sleep(3.0)          # let the new link settle before scanning again
                self.busy = False
                while not gone.is_set() and slot.connected and slot.transport == "bluetooth":
                    try:
                        await asyncio.wait_for(gone.wait(), 0.5)
                    except asyncio.TimeoutError:
                        pass
        except Exception as e:
            self.log("Couldn't connect %s: %s" % (key, e))
        finally:
            self.busy = False
            if slot.connected and slot.transport == "bluetooth":
                self.detach(slot, "disconnected")

    # -- F1 2020 telemetry -> phone gauges
    async def f1_loop(self):
        self.f1_last = 0.0
        self.f1_seen = False
        try:
            await asyncio.get_running_loop().create_datagram_endpoint(lambda: _F1Udp(self), local_addr=("0.0.0.0", F1_PORT))
        except Exception as e:
            self.log("F1 telemetry listener unavailable (port %d busy?): %s" % (F1_PORT, e))
            return
        while True:
            await asyncio.sleep(3600)

    def on_f1(self, data):
        t = parse_f1_2020(data)
        if t is None:
            return
        now = time.time()
        if not self.f1_seen:
            self.f1_seen = True
            self.log("F1 2020 telemetry is arriving - the phone's speedometer will go LIVE.")
        if now - self.f1_last < 0.05:                      # 20 updates a second is plenty
            return
        self.f1_last = now
        for s in self.slots:                               # Player 1 is the driver
            if s.connected:
                asyncio.ensure_future(self.write(s, telemetry_packet(*t)))
                break

    # -- USB cable
    async def usb_loop(self):
        loop = asyncio.get_running_loop()
        try:
            try:
                tr, _ = await loop.create_datagram_endpoint(lambda: _Udp(self), local_addr=("0.0.0.0", LINK_PORT))
            except OSError:                       # port taken (second Bridge?): any free port still works, just not by QR
                tr, _ = await loop.create_datagram_endpoint(lambda: _Udp(self), local_addr=("0.0.0.0", 0))
            self.udp_port = tr.get_extra_info("sockname")[1]
            tr.get_extra_info("socket").setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        except Exception as e:
            self.log("USB cable mode unavailable: %s" % e)
            return
        self.udp = tr
        last_find = 0.0
        while True:
            now = time.time()
            # look for new USB networks often until a phone answers, then rarely (PowerShell costs CPU)
            find_every = 12.0 if any(now - t < 5 for t in self.usb_known.values()) else 3.0
            if now - last_find > find_every or self.force_find:
                self.force_find = False
                last_find = now
                self.usb_nets = await loop.run_in_executor(None, find_all_nets, self.wifi)
                ips = {n["ip"] for n in self.usb_nets}
                for ip in ips:
                    self.usb_first_seen.setdefault(ip, now)
                for k in [k for k in self.usb_first_seen if k not in ips]:
                    del self.usb_first_seen[k]
            sweep = int(now * 4) % 8 == 0              # full address sweep every ~2 s, the rest 4x a second
            send_to = set()
            for n in self.usb_nets:
                if n.get("wifi") and self.wifi_has_phone(n, now):
                    send_to.update(n["targets"][:2])       # a phone is on this network: stop sweeping it
                else:
                    send_to.update(n["targets"] if sweep else n["targets"][:2])
            for ip, t in list(self.usb_known.items()):  # phones that answered: every tick, directly
                if now - t > 30:
                    del self.usb_known[ip]
                else:
                    send_to.add(ip)
            for ip in send_to:
                try:
                    tr.sendto(b"CPH1", (ip, USB_PORT))
                except Exception:
                    pass
            for addr, peer in list(self.usb_peers.items()):
                if now - peer["seen"] > 4.0:
                    del self.usb_peers[addr]
                    s = peer["slot"]
                    if s and s.connected and s.transport == "usb" and s.addr == addr:
                        self.detach(s, "was unplugged" if s.link == "usb" else "lost the Wi-Fi link")
            await asyncio.sleep(0.25)

    def usb_status(self):
        """(state, text) for the window: none / waiting / ok / off."""
        if self.udp is None:
            return "off", "USB cable mode isn't available on this laptop."
        now = time.time()
        phones = [n for n in self.usb_nets if n["phone"]]
        quiet = [n for n in phones
                 if now - self.usb_replied.get(n["ip"], 0) > 3 and now - self.usb_first_seen.get(n["ip"], now) > 6]
        live = sum(1 for s in self.slots if s.connected and s.transport == "usb" and s.link != "wifi")
        if quiet:
            n = quiet[0]
            return "waiting", ("Found the phone's USB network (%s) but CloudPad isn't answering on it. Open "
                               "CloudPad 1.3 or newer on that phone and keep it on screen. If the phone says "
                               "'Connected by USB cable' but nobody joins here, press Allow in firewall."
                               % (n["desc"] or n["alias"]))
        if live:
            return "ok", "%d phone%s connected by USB cable." % (live, "" if live == 1 else "s")
        if phones:
            return "none", "Phone USB network found. Waiting for CloudPad to answer..."
        return "none", "No phone on USB yet. Plug one in and turn on USB tethering (Settings > Hotspot & tethering)."

    def wifi_has_phone(self, n, now):
        try:
            net = ipaddress.IPv4Network(n["net"], strict=False)
            return any(now - t < 30 and ipaddress.IPv4Address(ip) in net for ip, t in self.usb_known.items())
        except Exception:
            return False

    def wifi_status(self):
        """(state, text) for the Wi-Fi box: off / none / waiting / ok."""
        if self.udp is None:
            return "off", "Network mode isn't available on this laptop."
        if not self.wifi:
            return "off", "Wi-Fi is off. Turn it on to let phones join over Wi-Fi or this laptop's Mobile Hotspot."
        now = time.time()
        nets = [n for n in self.usb_nets if n.get("wifi")]
        live = sum(1 for s in self.slots if s.connected and s.link == "wifi")
        if live:
            return "ok", "%d phone%s connected over Wi-Fi." % (live, "" if live == 1 else "s")
        if not nets:
            return "none", ("No Wi-Fi or hotspot network found. Connect this laptop to Wi-Fi, or turn on Mobile "
                            "Hotspot (Settings > Network > Mobile hotspot).")
        n = nets[0]
        quiet = now - self.usb_first_seen.get(n["ip"], now) > 10
        if quiet and not any(now - self.usb_replied.get(m["ip"], 0) < 5 for m in nets):
            return "waiting", ("Looking for phones on %s (%s). Put the phone on the same Wi-Fi and open CloudPad. "
                               "If nothing shows up, this network may block phones from reaching the laptop "
                               "(common in hostels): turn on Mobile Hotspot here and join it from the phone, or "
                               "press Allow in firewall." % (n["alias"] or n["desc"], n["ip"]))
        return "none", "Looking for phones on %s (%s)..." % (n["alias"] or n["desc"], n["ip"])

    def refresh(self):
        """Look again right now: rescan Bluetooth and USB, forget stale nearby phones."""
        self.force_find = True
        if self.loop is not None:
            self.loop.call_soon_threadsafe(self.nearby.clear)
            if self.wake is not None:
                self.loop.call_soon_threadsafe(self.wake.set)

    def on_udp(self, data, addr):
        now = time.time()
        self.usb_known[addr[0]] = now
        try:
            for n in self.usb_nets:          # remember which USB network this reply came from
                if ipaddress.IPv4Address(addr[0]) in ipaddress.IPv4Network(n["ip"] + "/24", strict=False):
                    self.usb_replied[n["ip"]] = now
        except Exception:
            pass
        peer = self.usb_peers.setdefault(addr, {"seen": now, "slot": None, "name": None})
        peer["seen"] = now
        if data[:4] == b"CPN1":
            name = data[4:].decode("utf-8", "replace").strip() or addr[0]
            peer["name"] = name
            s = peer["slot"]
            if s is None or not s.connected or s.addr != addr:
                self.usb_join(peer, name, addr)
            return
        s = peer["slot"]
        if s is not None and s.connected and s.transport == "usb" and s.addr == addr:
            st = parse_state(data)
            if st and s.pad.apply(st):
                s.last_input = now

    def usb_join(self, peer, name, addr):
        for s in self.slots:
            if s.connected and s.key == name:
                if s.transport == "bluetooth":         # same phone: move it onto the cable
                    s.transport, s.addr = "usb", addr
                    peer["slot"] = s
                    s.link = self.link_for(addr)
                    self.log("%s (Player %d) switched to the %s." % (name, s.number, "Wi-Fi link" if s.link == "wifi" else "USB cable"))
                    return
                if s.addr == addr:
                    peer["slot"] = s
                    return
                name = "%s (%s)" % (name, addr[0])     # a different phone with the same name
                break
        if self.connected_count() >= self.target:
            self.nearby[name] = {"rssi": None, "seen": time.time(), "ok": False, "via": "usb"}
            return
        s = self.slot_for(name)
        if s is None:
            return
        peer["slot"] = s
        self.attach(s, name, "usb", addr=addr)


# --------------------------------------------------------------------------- window
def run_gui():
    import tkinter as tk
    from tkinter import messagebox

    # rich black with neon: every player owns one neon colour
    BG, SURFACE, RAISED, LINE = "#0B0708", "#151011", "#201819", "#3A2B2D"
    TEXT, MUTED, ACCENT, GOOD, BAD = "#F6EFEF", "#A8979A", "#E03A4B", "#5DBB87", "#D8505A"
    COLORS = ["#E03A4B", "#B9A66B", "#8FAAC8", "#D8A15A"]      # Player 1-4: crimson, brass, steel, amber
    TITLE = ("Bahnschrift SemiBold", 19)
    NUM = ("Bahnschrift SemiBold", 20)
    HEAD = ("Segoe UI Semibold", 11)
    BODY = ("Segoe UI", 10)
    BODY_B = ("Segoe UI Semibold", 10)
    SMALL = ("Segoe UI", 9)

    logq = queue.Queue()
    engine = Engine(logq.put)
    engine.start()

    root = tk.Tk()
    root.title(APP)
    root.geometry("820x860")
    root.minsize(720, 760)
    root.configure(bg=BG)

    def label(parent, text="", font=BODY, fg=TEXT, **kw):
        return tk.Label(parent, text=text, font=font, fg=fg, bg=parent["bg"], **kw)

    def button(parent, text, cmd, bg=ACCENT, fg=BG, small=False):
        b = tk.Button(parent, text=text, command=cmd, relief="flat", bd=0, cursor="hand2", bg=bg, fg=fg,
                      activebackground=bg, activeforeground=fg, font=SMALL if small else BODY_B,
                      padx=10 if small else 16, pady=4 if small else 7, highlightthickness=0)
        return b

    # header
    head = tk.Frame(root, bg=BG)
    head.pack(fill="x", padx=22, pady=(18, 4))
    lh = tk.Frame(head, bg=BG)
    lh.pack(side="left")
    label(lh, "CloudPad Bridge", TITLE).pack(anchor="w")
    label(lh, "Your phones as Xbox controllers for games on this laptop", SMALL, MUTED).pack(anchor="w")
    pill = label(head, "Starting...", BODY_B, MUTED)
    pill.config(bg=RAISED, padx=12, pady=5)
    pill.pack(side="right", anchor="n", pady=4)

    # setup banner (only when something is missing)
    banner = tk.Frame(root, bg="#241315", highlightthickness=1, highlightbackground=COLORS[1])
    banner_text = label(banner, "", BODY, TEXT, wraplength=560, justify="left")
    banner_text.pack(side="left", padx=14, pady=10)

    def do_install():
        if engine.problem == "driver":
            msi = vigem_installer()
            try:
                if msi and IS_WIN:
                    os.startfile(msi)
                    logq.put("Opened the ViGEmBus driver setup. Click Yes / Install, then press Refresh.")
                else:
                    import webbrowser
                    webbrowser.open("https://github.com/nefarius/ViGEmBus/releases")
                    logq.put("Opened the ViGEmBus download page. Install it, then reopen CloudPad Bridge.")
            except Exception as e:
                logq.put("Couldn't open the driver setup: %s" % e)
            return
        install_btn.config(state="disabled", text="Installing...")
        def work():
            exe = sys.executable
            if exe.lower().endswith("pythonw.exe") and os.path.exists(exe[:-5] + ".exe"):
                exe = exe[:-5] + ".exe"
            try:
                r = subprocess.run([exe, "-m", "pip", "install", "--upgrade", "--no-cache-dir", "bleak", "vgamepad"],
                                   capture_output=True, text=True, creationflags=0x08000000 if IS_WIN else 0)
                tail = (r.stdout + r.stderr).strip().splitlines()[-3:]
                for line in tail:
                    logq.put(line)
                logq.put("__installed__" if r.returncode == 0 else "Install failed - see the lines above.")
            except Exception as e:
                logq.put("Install failed: %s" % e)
        threading.Thread(target=work, daemon=True).start()

    install_btn = button(banner, "Install", do_install)
    install_btn.pack(side="right", padx=14)

    # controls
    ctl = tk.Frame(root, bg=BG)
    ctl.pack(fill="x", padx=22, pady=(12, 4))
    seg_state = {"players": 2, "dist": 0}

    def segmented(parent, title, options, key, on_pick):
        f = tk.Frame(parent, bg=BG)
        label(f, title, BODY_B).pack(anchor="w")
        row = tk.Frame(f, bg=RAISED)
        row.pack(anchor="w", pady=(4, 0))
        btns = []

        def pick(i):
            seg_state[key] = i
            for j, b in enumerate(btns):
                b.config(bg=ACCENT if j == i else RAISED, fg=BG if j == i else TEXT,
                         activebackground=ACCENT if j == i else LINE)
            on_pick(i)

        for i, text in enumerate(options):
            b = tk.Button(row, text=text, relief="flat", bd=0, cursor="hand2", font=BODY_B, padx=14, pady=6,
                          highlightthickness=0, command=lambda i=i: pick(i))
            b.pack(side="left")
            btns.append(b)
        return f, pick

    def set_players(i):
        engine.target = i + 1

    def set_dist(i):
        engine.rssi_min = DISTANCES[i][1]

    pf, pick_players = segmented(ctl, "Players", ["1", "2", "3", "4"], "players", set_players)
    pf.pack(side="left")
    df, pick_dist = segmented(ctl, "Join from", [d[0] for d in DISTANCES], "dist", set_dist)
    df.pack(side="left", padx=(36, 0))
    pick_players(1)
    pick_dist(0)

    def do_refresh():
        nonlocal engine
        if engine.problem in ("vgamepad", "driver", "error"):
            engine = Engine(logq.put)               # check the setup again without reopening
            engine.target = seg_state["players"] + 1
            engine.rssi_min = DISTANCES[seg_state["dist"]][1]
            engine.start()
            logq.put("Checking the setup again...")
        else:
            engine.refresh()
            logq.put("Looking for phones again (Bluetooth, USB and Wi-Fi)...")

    refresh_btn = button(ctl, "Refresh", do_refresh, bg=RAISED, fg=TEXT)
    refresh_btn.pack(side="right", anchor="s")
    label(root, "Bluetooth: hold a phone next to the laptop until it shows up below, then sit back. "
                "USB: plug the phone in and turn on USB tethering - it joins by itself. "
                "Wi-Fi: press Show QR in the Wi-Fi box and scan it with the phone's camera, or turn Wi-Fi on and open CloudPad.",
          SMALL, MUTED, wraplength=760, justify="left").pack(anchor="w", padx=22, pady=(8, 10))

    # player cards
    grid = tk.Frame(root, bg=BG)
    grid.pack(fill="x", padx=22)
    grid.columnconfigure(0, weight=1, uniform="c")
    grid.columnconfigure(1, weight=1, uniform="c")
    cards = []
    for n in range(MAX_PLAYERS):
        c = tk.Frame(grid, bg=SURFACE, highlightthickness=2, highlightbackground=SURFACE)
        c.grid(row=n // 2, column=n % 2, sticky="nsew", padx=(0, 8) if n % 2 == 0 else (8, 0), pady=6)
        stripe = tk.Frame(c, bg=COLORS[n], width=6)
        stripe.pack(side="left", fill="y")
        inner = tk.Frame(c, bg=SURFACE)
        inner.pack(side="left", fill="both", expand=True, padx=14, pady=12)
        top = tk.Frame(inner, bg=SURFACE)
        top.pack(fill="x")
        num = label(top, "Player %d" % (n + 1), NUM, COLORS[n])
        num.pack(side="left")
        dot = tk.Canvas(top, width=16, height=16, bg=SURFACE, highlightthickness=0)
        dot.pack(side="right", pady=6)
        chip = label(top, "", SMALL, TEXT)
        chip.pack(side="right", padx=8)
        name = label(inner, "", BODY_B)
        name.pack(anchor="w", pady=(6, 0))
        state = label(inner, "", SMALL, MUTED)
        state.pack(anchor="w")
        cards.append({"frame": c, "stripe": stripe, "num": num, "dot": dot, "chip": chip, "name": name,
                      "state": state, "color": COLORS[n]})

    # nearby phones
    label(root, "Phones nearby", HEAD).pack(anchor="w", padx=22, pady=(14, 4))
    near_box = tk.Frame(root, bg=SURFACE)
    near_box.pack(fill="x", padx=22)
    near_rows = [None]          # forces the first draw, so the empty-state hint shows

    label(root, "USB cable", HEAD).pack(anchor="w", padx=22, pady=(14, 4))
    usb_box = tk.Frame(root, bg=SURFACE)
    usb_box.pack(fill="x", padx=22)
    usb_dot = tk.Canvas(usb_box, width=14, height=14, bg=SURFACE, highlightthickness=0)
    usb_dot.pack(side="left", padx=(12, 0), pady=12, anchor="n")
    usb_text = label(usb_box, "", SMALL, TEXT, wraplength=560, justify="left")
    usb_text.pack(side="left", padx=10, pady=10, anchor="w")

    label(root, "Wi-Fi", HEAD).pack(anchor="w", padx=22, pady=(14, 4))
    wifi_box = tk.Frame(root, bg=SURFACE)
    wifi_box.pack(fill="x", padx=22)
    wifi_dot = tk.Canvas(wifi_box, width=14, height=14, bg=SURFACE, highlightthickness=0)
    wifi_dot.pack(side="left", padx=(12, 0), pady=12, anchor="n")
    wifi_text = label(wifi_box, "", SMALL, TEXT, wraplength=520, justify="left")
    wifi_text.pack(side="left", padx=10, pady=10, anchor="w")

    def toggle_wifi():
        engine.wifi = not engine.wifi
        engine.force_find = True
        wifi_btn.config(text="Turn off" if engine.wifi else "Turn on")
        logq.put("Wi-Fi phones are %s." % ("on: phones on the same network can join" if engine.wifi else "off"))

    def do_firewall():
        try:
            ok = allow_in_firewall()
            logq.put("Firewall rule added - press Refresh." if ok else "The firewall change was cancelled.")
        except Exception as e:
            logq.put("Couldn't change the firewall: %s" % e)

    fw_btn = button(usb_box, "Allow in firewall", do_firewall, bg=RAISED, fg=TEXT, small=True)
    wifi_btn = button(wifi_box, "Turn on", toggle_wifi, bg=RAISED, fg=TEXT, small=True)
    wifi_btn.pack(side="right", padx=(4, 12))

    def show_qr():
        import tkinter as tk2
        if engine.udp is None or not engine.udp_port:
            logq.put("The network link isn't ready yet - try again in a moment.")
            return
        ips = lan_addresses() if IS_WIN else [("127.0.0.1", "Test")]
        if not ips:
            logq.put("No Wi-Fi or hotspot network found. Connect this laptop to Wi-Fi or turn on Mobile Hotspot first.")
            return
        try:
            srv, port = start_bounce(engine.udp_port)
        except Exception as e:
            logq.put("Couldn't start the QR page: %s" % e)
            return
        win = tk2.Toplevel(root)
        win.title("Join with QR")
        win.configure(bg=BG)
        win.resizable(False, False)
        idx = [0]
        cv = tk2.Canvas(win, bg="#FFFFFF", highlightthickness=0)
        cv.pack(padx=24, pady=(24, 10))
        info = label(win, "", SMALL, TEXT, wraplength=330, justify="center")
        info.pack(padx=24)

        def draw():
            ip, name = ips[idx[0]]
            m = qr_matrix("http://%s:%d/" % (ip, port))
            n, px, q = len(m), 8, 4
            cv.config(width=(n + 2 * q) * px, height=(n + 2 * q) * px)
            cv.delete("all")
            for y, row in enumerate(m):
                for x, v in enumerate(row):
                    if v:
                        cv.create_rectangle((x + q) * px, (y + q) * px, (x + q + 1) * px, (y + q + 1) * px,
                                            fill="#000000", outline="")
            info.config(text="Scan with the phone's camera and tap the link: CloudPad opens and joins.\n"
                             "The phone must be on the same network as this laptop: %s (%s)." % (name, ip))
        draw()
        if len(ips) > 1:
            def nxt():
                idx[0] = (idx[0] + 1) % len(ips)
                draw()
            button(win, "Use another network (%d found)" % len(ips), nxt, bg=RAISED, fg=TEXT, small=True).pack(pady=8)

        def close():
            try:
                srv.shutdown()
                srv.server_close()
            except Exception:
                pass
            win.destroy()
        button(win, "Close", close, bg=ACCENT, fg=BG, small=True).pack(pady=(4, 20))
        win.protocol("WM_DELETE_WINDOW", close)

    qr_btn = button(wifi_box, "Show QR", show_qr, bg=ACCENT, fg=BG, small=True)
    qr_btn.pack(side="right", padx=4)
    wifi_fw = button(wifi_box, "Allow in firewall", do_firewall, bg=RAISED, fg=TEXT, small=True)
    wifi_shown = {"text": None}
    usb_shown = {"text": None}

    def bars(rssi):
        if rssi is None:
            return 4
        return 4 if rssi >= -55 else 3 if rssi >= -65 else 2 if rssi >= -75 else 1

    logbox = tk.Text(root, height=5, bg=SURFACE, fg=MUTED, font=SMALL, relief="flat", padx=10, pady=8,
                     highlightthickness=0, state="disabled", wrap="word")
    logbox.pack(fill="both", expand=True, padx=22, pady=(14, 18))

    def tick():
        # log
        while True:
            try:
                m = logq.get_nowait()
            except queue.Empty:
                break
            if m == "__installed__":
                install_btn.config(text="Installed")
                install_btn.config(state="normal")
                messagebox.showinfo(APP, "Installed. If a ViGEmBus setup window opened, finish it.\n"
                                         "Then press Refresh.")
                continue
            logbox.config(state="normal")
            logbox.insert("end", time.strftime("%H:%M  ") + m + "\n")
            logbox.see("end")
            logbox.config(state="disabled")
        # banner
        prob = engine.problem
        if prob:
            msg = {"vgamepad": "Two free Python packages are needed (bleak and vgamepad). Press Install - it takes "
                               "about a minute. Accept the ViGEmBus driver setup if it appears.",
                   "driver": "The ViGEmBus controller driver isn't installed or isn't running (%s). Press "
                             "Install driver, click Yes and Install, then press Refresh. Still failing? "
                             "Restart the laptop." % (engine.problem_detail or "no details"),
                   "error": "Couldn't create the virtual controller (%s). Send this message to whoever gave you "
                            "CloudPad Bridge." % (engine.problem_detail or "no details"),
                   "bleak": "Bluetooth needs the free 'bleak' package. USB cable players work already. "
                            "Press Install to add Bluetooth."}[prob]
            banner_text.config(text=msg)
            install_btn.config(text="Install driver" if prob == "driver" else install_btn.cget("text"))
            if not banner.winfo_ismapped():
                banner.pack(fill="x", padx=22, pady=(8, 0), after=head)
        elif banner.winfo_ismapped():
            banner.pack_forget()
        # status pill
        n, target = engine.connected_count(), engine.target
        if prob in ("vgamepad", "driver", "error"):
            pill.config(text="Setup needed", fg=BAD)
        elif n >= target:
            pill.config(text="All %d player%s ready" % (target, "" if target == 1 else "s"), fg=GOOD)
        elif engine.busy:
            pill.config(text="Connecting a phone...", fg=ACCENT)
        else:
            pill.config(text="Looking for phones  %d/%d" % (n, target), fg=TEXT)
        # cards
        now = time.time()
        for i, (s, c) in enumerate(zip(engine.slots, cards)):
            in_use = i < target or s.connected
            if s.connected:
                c["frame"].config(highlightbackground=c["color"])
                c["stripe"].config(bg=c["color"])
                c["num"].config(fg=c["color"])
                c["name"].config(text=s.key, fg=TEXT)
                c["chip"].config(text={"usb": " USB cable ", "wifi": " Wi-Fi "}.get(s.link, " Bluetooth ") if s.transport == "usb" else " Bluetooth ",
                                 bg=RAISED, fg=c["color"])
                c["state"].config(text="Connected - press a button to see this light up")
                lit = now - s.last_input < 0.25
                c["dot"].delete("all")
                c["dot"].create_oval(2, 2, 14, 14, fill=c["color"] if lit else RAISED, outline=c["color"])
            else:
                c["frame"].config(highlightbackground=LINE if in_use else SURFACE)
                c["stripe"].config(bg=c["color"] if in_use else LINE)
                c["num"].config(fg=c["color"] if in_use else LINE)
                c["chip"].config(text="", bg=SURFACE)
                c["dot"].delete("all")
                if in_use:
                    c["name"].config(text="Waiting for a phone" if not s.key else "Waiting for %s" % s.key,
                                     fg=MUTED)
                    c["state"].config(text="Hold a phone next to the laptop, or plug one in")
                else:
                    c["name"].config(text="Not playing", fg=LINE)
                    c["state"].config(text="Pick more players above to use this slot")
        # USB cable row
        state_usb, text_usb = engine.usb_status() if not engine.problem or engine.problem == "bleak" else (
            "off", "Finish the setup above first.")
        if text_usb != usb_shown["text"]:
            usb_shown["text"] = text_usb
            usb_text.config(text=text_usb)
            usb_dot.delete("all")
            usb_dot.create_oval(2, 2, 12, 12, outline="", fill={"ok": GOOD, "waiting": BAD, "none": MUTED,
                                                                 "off": LINE}[state_usb])
            if state_usb == "waiting" and IS_WIN:
                fw_btn.pack(side="right", padx=12)
            else:
                fw_btn.pack_forget()
        # Wi-Fi row
        state_wifi, text_wifi = engine.wifi_status() if not engine.problem or engine.problem == "bleak" else (
            "off", "Finish the setup above first.")
        if text_wifi != wifi_shown["text"]:
            wifi_shown["text"] = text_wifi
            wifi_text.config(text=text_wifi)
            wifi_dot.delete("all")
            wifi_dot.create_oval(2, 2, 12, 12, outline="", fill={"ok": GOOD, "waiting": BAD, "none": MUTED,
                                                                  "off": LINE}[state_wifi])
            if state_wifi == "waiting" and IS_WIN:
                wifi_fw.pack(side="right", padx=4)
            else:
                wifi_fw.pack_forget()
        # nearby list
        items = sorted(engine.nearby.items(), key=lambda kv: -(kv[1]["rssi"] or 0))[:4]
        sig = [(k, v["rssi"], v["ok"], v.get("via")) for k, v in items]
        if sig != near_rows:
            near_rows[:] = sig
            for w in near_box.winfo_children():
                w.destroy()
            if not sig:
                label(near_box, "Open CloudPad on a phone (Settings > Play on > Installed PC games) and it will "
                                "show up here.", SMALL, MUTED, wraplength=740, justify="left").pack(
                    anchor="w", padx=12, pady=10)
            for k, rssi, ok, via in sig:
                r = tk.Frame(near_box, bg=SURFACE)
                r.pack(fill="x", padx=12, pady=4)
                cv = tk.Canvas(r, width=26, height=18, bg=SURFACE, highlightthickness=0)
                cv.pack(side="left")
                for b in range(4):
                    h = 4 + b * 4
                    cv.create_rectangle(b * 6, 18 - h, b * 6 + 4, 18,
                                        fill=(GOOD if ok else ACCENT) if b < bars(rssi) else RAISED, outline="")
                label(r, k, BODY_B).pack(side="left", padx=8)
                if via == "usb":
                    hint = "Plugged in. All player slots are full: pick more players above."
                elif engine.connected_count() >= engine.target:
                    hint = "All player slots are full: pick more players above to add it."
                elif ok:
                    hint = "Close enough. Joining..."
                else:
                    hint = "Bring it closer to the laptop to join (%d dBm)" % rssi
                label(r, hint, SMALL, MUTED).pack(side="left")
        root.after(150, tick)

    def on_close():
        root.destroy()

    root.protocol("WM_DELETE_WINDOW", on_close)
    tick()
    if os.environ.get("CLOUDPAD_SELFTEST_MS"):
        root.after(int(os.environ["CLOUDPAD_SELFTEST_MS"]), on_close)
    root.mainloop()


def main():
    try:
        run_gui()
    except Exception:
        import traceback
        err = traceback.format_exc()
        path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "cloudpad_error.txt")
        try:
            with open(path, "w") as fh:
                fh.write(err)
        except Exception:
            pass
        if IS_WIN:
            import ctypes
            ctypes.windll.user32.MessageBoxW(0, "CloudPad Bridge could not start:\n\n%s\n\nSaved to %s" % (
                err.strip().splitlines()[-1], path), APP, 0x10)
        raise


if __name__ == "__main__":
    main()
