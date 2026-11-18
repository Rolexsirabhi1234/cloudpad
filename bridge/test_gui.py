import sys, types, os, time, asyncio
src=open("/home/claude/cloudpad/bridge/CloudPad Bridge.pyw",encoding="utf-8").read()
m=types.ModuleType("bridge"); m.__file__="bridge.py"; m.__name__="bridge"; sys.modules["bridge"]=m
exec(compile(src,"bridge.pyw","exec"),m.__dict__)
import tkinter as tk
async def fake_main(self):
    self.problem=None
    await self.usb_loop()
m.Engine.main=fake_main
res={}
orig=tk.Tk.mainloop
def walk(w):
    yield w
    for c in w.winfo_children(): yield from walk(c)
def hook(self,n=0):
    def go():
        try:
            btns=[w for w in walk(self) if isinstance(w,tk.Button)]
            def mode(t): [b for b in btns if b.cget("text")==t and b.master.master.master is self or True][0]
            seg=[b for b in btns if b.cget("text") in ("Bluetooth","Wi-Fi","USB cable","Bluetooth + USB")]
            res["mode_buttons"]=[b.cget("text") for b in seg]
            def visible(txt): return any(w.winfo_ismapped() for w in walk(self) if isinstance(w,tk.Label) and w.cget("text")==txt)
            res["auto_sections"]=(visible("Phones nearby"),visible("USB cable"),visible("Wi-Fi"))
            [b for b in seg if b.cget("text")=="Wi-Fi"][0].invoke(); self.update()
            res["wifi_sections"]=(visible("Phones nearby"),visible("USB cable"),visible("Wi-Fi"))
            [b for b in seg if b.cget("text")=="USB cable"][0].invoke(); self.update()
            res["usb_sections"]=(visible("Phones nearby"),visible("USB cable"),visible("Wi-Fi"))
            [b for b in seg if b.cget("text")=="Bluetooth"][0].invoke(); self.update()
            res["bt_sections"]=(visible("Phones nearby"),visible("USB cable"),visible("Wi-Fi"))
            [b for b in seg if b.cget("text")=="Wi-Fi"][0].invoke(); self.update()
            qr=[b for b in btns if b.cget("text")=="Show QR"][0]
            qr.invoke(); self.update()
            tops=[w for w in walk(self) if isinstance(w,tk.Toplevel)]
            res["toplevels"]=len(tops)
            cv=[w for w in walk(tops[0]) if isinstance(w,tk.Canvas)][0]
            res["qr_rects"]=len(cv.find_all())
            res["info"]=[w.cget("text") for w in walk(tops[0]) if isinstance(w,tk.Label)]
            # toggle wifi button too
            # close QR window
            [b for b in walk(tops[0]) if isinstance(b,tk.Button) and b.cget("text")=="Close"][0].invoke(); self.update()
            res["closed"]=len([w for w in walk(self) if isinstance(w,tk.Toplevel)])==0
        except Exception as e:
            import traceback; res["error"]=traceback.format_exc()
        self.destroy()
    self.after(1500,go)
    orig(self,n)
tk.Tk.mainloop=hook
m.run_gui()
print(res)
