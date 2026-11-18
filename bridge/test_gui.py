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
            qr=[b for b in btns if b.cget("text")=="Show QR"][0]
            res["wifi_btn_text"]=[b.cget("text") for b in btns if b.cget("text") in ("Turn on","Turn off")]
            qr.invoke(); self.update()
            tops=[w for w in walk(self) if isinstance(w,tk.Toplevel)]
            res["toplevels"]=len(tops)
            cv=[w for w in walk(tops[0]) if isinstance(w,tk.Canvas)][0]
            res["qr_rects"]=len(cv.find_all())
            res["info"]=[w.cget("text") for w in walk(tops[0]) if isinstance(w,tk.Label)]
            # toggle wifi button too
            tw=[b for b in btns if b.cget("text")=="Turn on"][0]; tw.invoke(); self.update()
            res["after_toggle"]=tw.cget("text"); res["engine_wifi"]=self.engine_ref.wifi if hasattr(self,"engine_ref") else None
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
