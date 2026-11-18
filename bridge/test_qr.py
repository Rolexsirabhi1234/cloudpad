import sys, types, os, cv2, numpy as np, qrcode, urllib.request, threading, socket, asyncio, time, struct
src=open("/home/claude/cloudpad/bridge/CloudPad Bridge.pyw",encoding="utf-8").read()
m=types.ModuleType("bridge"); m.__file__="bridge.py"; sys.modules["bridge"]=m
exec(compile(src,"bridge.pyw","exec"),m.__dict__)
ok=True
def check(n,c):
    global ok; ok&=bool(c); print(("PASS " if c else "FAIL ")+n)
det=cv2.QRCodeDetector()
def decode(mat,scale=8,quiet=4):
    n=len(mat); img=np.full(((n+2*quiet)*scale,)*2,255,np.uint8)
    for y,row in enumerate(mat):
        for x,v in enumerate(row):
            if v: img[(y+quiet)*scale:(y+quiet+1)*scale,(x+quiet)*scale:(x+quiet+1)*scale]=0
    return det.detectAndDecode(img)[0]
texts=["http://192.168.137.1:47125/","http://10.253.57.1:47125/","http://172.17.57.250:47125/","a","http://192.168.0.105:47125/?x=1234567890abcdef","x"*70,"y"*100]
for t in texts:
    got=decode(m.qr_matrix(t)); check("decodes %d-char text (v%d)"%(len(t),(len(m.qr_matrix(t))-17)//4), got==t)
# same matrix size as reference library for same text
ref=qrcode.QRCode(error_correction=qrcode.constants.ERROR_CORRECT_L,border=0); ref.add_data("http://192.168.137.1:47125/"); ref.make()
check("same version as the reference library", len(ref.get_matrix())==len(m.qr_matrix("http://192.168.137.1:47125/")))
try: m.qr_matrix("z"*200); check("too-long text rejected",False)
except ValueError: check("too-long text rejected",True)

# bounce page
srv,port=m.start_bounce(47124)
body=urllib.request.urlopen("http://127.0.0.1:%d/"%port,timeout=3).read().decode()
check("page has the intent link with ip and port", "intent://connect?ip=127.0.0.1&port=47124&n=" in body and "package=com.cloudpad.controller" in body)
srv.shutdown(); srv.server_close()

# phone-initiated join: phone sends CPN1 to the Bridge's fixed port
os.environ["CLOUDPAD_WIFI_IPS"]=""
logs=[]
async def run():
    eng=m.Engine(logs.append)
    class P:
        def __init__(s): s.got=[]
        def apply(s,st): s.got.append(st); return True
        def release_all(s): pass
    eng.ensure_pad=lambda slot: setattr(slot,"pad",slot.pad or P())
    eng.mode="wifi"
    task=asyncio.create_task(eng.usb_loop()); await asyncio.sleep(0.6)
    check("Bridge listens on the fixed port", eng.udp_port==m.LINK_PORT)
    ph=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); ph.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1); ph.bind(("127.0.0.1",m.USB_PORT)); ph.settimeout(0.2)
    seen=[]
    def phone():
        t0=time.time()
        ph.sendto(b"CPN1Friend's phone",("127.0.0.1",m.LINK_PORT))
        while time.time()-t0<2.5:
            try: d,a=ph.recvfrom(100)
            except socket.timeout: continue
            seen.append(d[:4])
            if d[:4]==b"CPH1":
                ph.sendto(b"CPN1Friend's phone",a)
                ph.sendto(bytes([1,0,1,0,0])+struct.pack("<hhhh",900,0,0,0)+bytes([0,0]),a)
    th=threading.Thread(target=phone); th.start(); await asyncio.sleep(2.6); th.join()
    s1=eng.slots[0]
    check("phone that said hello first joined", s1.connected and s1.key=="Friend's phone")
    check("shown as Wi-Fi (not USB)", s1.link=="wifi")
    check("Bridge then started its normal hello exchange", b"CPH1" in seen)
    check("input arrives", s1.pad and len(s1.pad.got)>0)
    task.cancel()
asyncio.run(run())
print("ALL OK" if ok else "FAILURES")
