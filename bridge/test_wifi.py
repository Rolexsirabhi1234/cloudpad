import asyncio, os, socket, struct, sys, importlib.util, time, threading
os.environ["CLOUDPAD_WIFI_IPS"]="127.0.0.1"
spec=importlib.util.spec_from_loader("bridge",loader=None)
import types
src=open("/home/claude/cloudpad/bridge/CloudPad Bridge.pyw",encoding="utf-8").read()
m=types.ModuleType("bridge"); m.__file__="bridge.py"; sys.modules["bridge"]=m
exec(compile(src,"bridge.pyw","exec"),m.__dict__) if "__main__" not in src.split("if __name__")[0] else None
ok=True
def check(n,c):
    global ok; ok&=bool(c); print(("PASS " if c else "FAIL ")+n)

# 1. classifier on realistic PowerShell data
data=[{"alias":"Wi-Fi","desc":"Intel(R) Wi-Fi 6E AX211","ip":"172.17.57.250","prefix":16,"gw":"172.17.0.1"},
 {"alias":"Local Area Connection* 10","desc":"Microsoft Wi-Fi Direct Virtual Adapter #2","ip":"192.168.137.1","prefix":24,"gw":""},
 {"alias":"Bluetooth Network Connection","desc":"Bluetooth Device (Personal Area Network)","ip":"192.168.5.2","prefix":24,"gw":""},
 {"alias":"Ethernet 3","desc":"Remote NDIS based Internet Sharing Device","ip":"10.253.57.1","prefix":24,"gw":""},
 {"alias":"vEthernet (WSL)","desc":"Hyper-V Virtual Ethernet Adapter","ip":"172.20.0.1","prefix":20,"gw":""},
 {"alias":"Wi-Fi 2","desc":"Wireless","ip":"169.254.3.3","prefix":16,"gw":""},
 {"alias":"Wi-Fi 3","desc":"Wireless","ip":"8.8.4.4","prefix":24,"gw":""}]
os.environ.pop("CLOUDPAD_WIFI_IPS")
w=m.find_wifi_nets(data)
names=[n["alias"] for n in w]
check("wifi + hotspot found, others skipped", names==["Wi-Fi","Local Area Connection* 10"])
check("big /16 clamped to a /24 sweep", w[0]["net"]=="172.17.57.0/24" and len(w[0]["targets"])<=256)
check("gateway + broadcast first", w[0]["targets"][:2]==["172.17.0.1","172.17.57.255"])
u=m.find_usb_nets(data); check("usb finder still finds the RNDIS adapter only", [n["alias"] for n in u]==["Ethernet 3"])

# 2. end-to-end with a fake phone on loopback
os.environ["CLOUDPAD_WIFI_IPS"]="127.0.0.1"
logs=[]
async def run():
    eng=m.Engine(logs.append)
    class P:
        def __init__(s): s.got=[]
        def apply(s,st): s.got.append(st); return True
        def release_all(s): pass
    eng.ensure_pad=lambda slot: setattr(slot,"pad",slot.pad or P())
    eng.mode='wifi'; eng.loop=asyncio.get_running_loop()
    # fake phone
    ph=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); ph.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1); ph.bind(("127.0.0.1",m.USB_PORT)); ph.settimeout(0.2)
    rumble=[]
    def phone():
        t0=time.time()
        while time.time()-t0<14:
            try: d,a=ph.recvfrom(100)
            except socket.timeout: continue
            if d[:4]==b"CPH1":
                ph.sendto(b"CPN1Rahul's phone",a)
                pkt=bytes([1,0,1,0,0])+struct.pack("<hhhh",1000,0,0,0)+bytes([0,0])
                ph.sendto(pkt,a)
            else: rumble.append(d)
    th=threading.Thread(target=phone); th.start()
    task=asyncio.create_task(eng.usb_loop())
    await asyncio.sleep(2.0)
    s1=eng.slots[0]
    check("fake phone joined as Player 1", s1.connected and s1.key=="Rahul's phone")
    check("labelled Wi-Fi, not USB", s1.link=="wifi")
    check("input reached the pad", s1.pad and len(s1.pad.got)>0)
    check("status says connected over Wi-Fi", eng.wifi_status()[0]=="ok" and "Wi-Fi" in eng.wifi_status()[1])
    check("USB status unaffected (no USB phones)", eng.usb_status()[0]!="ok")
    await eng.write(s1,m.rumble_packet(200,0,100)); await asyncio.sleep(0.4)
    check("rumble sent back to the phone over the network", any(r[:1]==b"\x01" for r in rumble))
    await eng.write(s1,m.telemetry_packet(250,11500,5,1)); await asyncio.sleep(0.4)
    check("F1 telemetry packet reaches the phone", any(r[:1]==b"\x03" and len(r)==8 for r in rumble))
    check("mode wifi: only wifi allowed", eng.allow("wifi") and not eng.allow("usb") and not eng.allow("bluetooth"))
    eng.set_mode("usb"); await asyncio.sleep(3.8)
    check("switching to USB drops the Wi-Fi player", not s1.connected)
    check("switching to USB stops probing Wi-Fi", not any(n.get("wifi") for n in eng.usb_nets))
    check("Wi-Fi phone is ignored while in USB mode", not s1.connected and not any(s.connected for s in eng.slots))
    eng.set_mode("bluetooth"); await asyncio.sleep(0.6)
    check("Bluetooth mode sends no hellos", eng.usb_nets==[])
    eng.set_mode("wifi"); await asyncio.sleep(3.0)
    check("back to Wi-Fi: phone rejoins", any(s.connected and s.link=="wifi" for s in eng.slots))
    eng.set_mode("auto")
    check("auto = Bluetooth + USB only", eng.allow("bluetooth") and eng.allow("usb") and not eng.allow("wifi"))
    check("auto's find_all_nets never returns wifi", all(not n.get("wifi") for n in m.find_all_nets("auto")))
    check("bluetooth mode finds no networks", m.find_all_nets("bluetooth")==[])
    task.cancel(); th.join()
asyncio.run(run())
print("ALL OK" if ok else "FAILURES")
