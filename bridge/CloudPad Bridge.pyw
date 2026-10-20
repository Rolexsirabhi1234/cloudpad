"""
CloudPad Bridge - phones as Xbox controllers for games installed on this laptop.

Double-click to open. Up to 4 phones (local co-op), each one its own Xbox 360 controller.
  * Bluetooth: hold a phone next to the laptop to join (distance is adjustable).
  * USB cable: plug the phone in and turn on USB tethering - it joins by itself and is the
    most reliable option. A Bluetooth player who plugs in moves to the cable automatically.

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


def find_usb_nets():
    """Wired networks a phone could be on (USB tethering shows up as RNDIS or, on newer phones, NCM).
    Each entry: alias, desc, ip, phone (looks like a phone), targets (addresses to say hello to)."""
    env = os.environ.get("CLOUDPAD_USB_IPS")
    if env:
        return [{"alias": "Test", "desc": "Remote NDIS test", "ip": ip.strip(), "phone": True,
                 "targets": [ip.strip()]} for ip in env.split(",") if ip.strip()]
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
    if isinstance(data, dict):
        data = [data]
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
        self.addr = None           # USB (ip, port)
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
        jobs = [self.usb_loop(), self.rumble_loop()]
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
        slot.connected = True
        slot.large = slot.small = 0
        self.nearby.pop(key, None)
        self.log("%s joined as Player %d (%s)." % (key, slot.number, "USB cable" if transport == "usb" else "Bluetooth"))
        asyncio.get_running_loop().create_task(self.buzz(slot))

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

    # -- USB cable
    async def usb_loop(self):
        loop = asyncio.get_running_loop()
        try:
            tr, _ = await loop.create_datagram_endpoint(lambda: _Udp(self), local_addr=("0.0.0.0", 0))
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
                self.usb_nets = await loop.run_in_executor(None, find_usb_nets)
                ips = {n["ip"] for n in self.usb_nets}
                for ip in ips:
                    self.usb_first_seen.setdefault(ip, now)
                for ip in [k for k in self.usb_first_seen if k not in ips]:
                    del self.usb_first_seen[k]
            sweep = int(now * 4) % 8 == 0              # full address sweep every ~2 s, the rest 4x a second
            send_to = set()
            for n in self.usb_nets:
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
                        self.detach(s, "was unplugged")
            await asyncio.sleep(0.25)

    def usb_status(self):
        """(state, text) for the window: none / waiting / ok / off."""
        if self.udp is None:
            return "off", "USB cable mode isn't available on this laptop."
        now = time.time()
        phones = [n for n in self.usb_nets if n["phone"]]
        quiet = [n for n in phones
                 if now - self.usb_replied.get(n["ip"], 0) > 3 and now - self.usb_first_seen.get(n["ip"], now) > 6]
        live = sum(1 for s in self.slots if s.connected and s.transport == "usb")
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
                    self.log("%s (Player %d) switched to the USB cable." % (name, s.number))
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
    BG, SURFACE, RAISED, LINE = "#07070C", "#111119", "#1B1B27", "#2B2B3D"
    TEXT, MUTED, ACCENT, GOOD, BAD = "#F2F2FA", "#8B8BA7", "#9D5CFF", "#2EFF9A", "#FF3D5A"
    COLORS = ["#00E5FF", "#FF2E9A", "#B8FF2E", "#FF9F1C"]      # Player 1-4: cyan, magenta, lime, orange
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
    banner = tk.Frame(root, bg="#1E0A1A", highlightthickness=1, highlightbackground=COLORS[1])
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
            logq.put("Looking for phones again (Bluetooth and USB)...")

    refresh_btn = button(ctl, "Refresh", do_refresh, bg=RAISED, fg=TEXT)
    refresh_btn.pack(side="right", anchor="s")
    label(root, "Bluetooth: hold a phone next to the laptop until it shows up below, then sit back. "
                "USB: plug the phone in and turn on USB tethering - it joins by itself.",
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

    def do_firewall():
        try:
            ok = allow_in_firewall()
            logq.put("Firewall rule added - press Refresh." if ok else "The firewall change was cancelled.")
        except Exception as e:
            logq.put("Couldn't change the firewall: %s" % e)

    fw_btn = button(usb_box, "Allow in firewall", do_firewall, bg=RAISED, fg=TEXT, small=True)
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
                c["chip"].config(text=" USB cable " if s.transport == "usb" else " Bluetooth ",
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
