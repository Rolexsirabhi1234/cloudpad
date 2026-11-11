'use strict';
/* CloudPad controller UI: state, input, editor, screens, native API. */

const G = {
  view: 'home', preset: 'xbox', controls: [], area: { x0: 0, y0: 0, w: 1, h: 1, U: 1 },
  down: new Set(), val: {}, rot: {}, pointers: new Map(), pulses: {},
  steerMode: store('cp_steer') === 'wheel' ? 'wheel' : 'gyro', steeringAvailable: true,
  steer: 0, wheelUser: 0, wheelVis: 0, wheelOut: 0,
  edit: false, sel: null, snapshot: '', editPtrs: new Map(), pinch: null,
  insets: { l: 0, t: 0, r: 0, b: 0 }, drsOn: false, carbon: null, touchedLook: false,
  status: { level: 0, title: 'Waiting', detail: '' }, connected: false,
  lastSent: '', lastBits: 0, gyroSent: null,
};
const TB = 46;                         // toolbar height (css px)
const MAX_WHEEL = (100 * Math.PI) / 180; // wheel lock: +-100 degrees = full steering
const cv = $('#cv'), ctx = cv.getContext('2d');
let W = 0, H = 0, DPR = 1;

function isRacing() { return PRESETS[G.preset].racing; }

/* ------------------------------------------------------------------ geometry */
function computeArea() {
  const i = G.insets;
  const top = i.t + (G.view === 'pad' ? TB : 0);
  G.area = { x0: i.l + 4, y0: top, w: Math.max(100, W - i.l - i.r - 8), h: Math.max(100, H - top - i.b - 4) };
  G.area.U = Math.min(G.area.h, G.area.w / 1.9);
}
function resolve(c) {
  const a = G.area, U = a.U;
  c.cx = a.x0 + c.x * a.w; c.cy = a.y0 + c.y * a.h;
  switch (c.t) {
    case 'btn': case 'stick': case 'dpad': case 'wheel': case 'rotary': case 'speedo': c.R = c.r * U * c.s; break;
    case 'pill': case 'pedal': c.W = c.w * U * c.s; c.H = c.h * U * c.s; break;
    case 'graph': case 'lights': case 'touchpad': c.W = c.w * a.w * c.s; c.H = c.h * a.h * c.s; break;
    case 'look': c.W = c.w * a.w; c.H = c.h * a.h; c.lookR = 0.15 * U; break;
  }
}
function resolveAll() { for (const c of G.controls) resolve(c); }

function resize() {
  DPR = window.devicePixelRatio || 1; W = window.innerWidth; H = window.innerHeight;
  cv.width = Math.round(W * DPR); cv.height = Math.round(H * DPR);
  cv.style.width = W + 'px'; cv.style.height = H + 'px';
  computeArea(); resolveAll();
}

/* ------------------------------------------------------------------ hit testing */
const INTERACTIVE = { btn: 1, pill: 1, pedal: 1, dpad: 1, rotary: 1, wheel: 1, stick: 1, look: 1 };
const PRIO = { btn: 1, pill: 1, pedal: 1, dpad: 1, rotary: 1, wheel: 2, stick: 3, look: 4, speedo: 5, graph: 6, lights: 6 };
function hit(c, x, y, pad) {
  const dx = x - c.cx, dy = y - c.cy;
  switch (c.t) {
    case 'btn': case 'rotary': case 'speedo': return Math.hypot(dx, dy) <= c.R + pad;
    case 'stick': return Math.hypot(dx, dy) <= c.R * 1.75;
    case 'dpad': return Math.abs(dx) <= c.R + pad && Math.abs(dy) <= c.R + pad;
    case 'wheel': return Math.hypot(dx, dy) <= c.R * 1.08;
    default: return Math.abs(dx) <= c.W / 2 + pad && Math.abs(dy) <= c.H / 2 + pad;
  }
}
function pick(x, y, editing) {
  let best = null, bp = 99, bd = 1e9;
  for (const c of G.controls) {
    if (c.static && !editing) continue;
    if (!editing) { if (c.hidden || !INTERACTIVE[c.t]) continue; if (c.t === 'wheel' && G.steerMode !== 'wheel') continue; if (c.pid !== undefined && c.t !== 'btn') continue; }
    else if (c.t === 'touchpad') continue;
    if (!hit(c, x, y, editing ? 6 : 10)) continue;
    const p = PRIO[c.t] || 3, d = Math.hypot(x - c.cx, y - c.cy);
    if (p < bp || (p === bp && d < bd)) { best = c; bp = p; bd = d; }
  }
  return best;
}

/* ------------------------------------------------------------------ input state -> controller state */
function pulse(bit, ms) {
  G.pulses[bit] = performance.now() + ms; emit();
  setTimeout(emit, ms + 8);
}
function emit() {
  if (G.view !== 'pad' || G.edit) { if (G.lastSent !== 'idle') { send(0, 0, 0, 0, 0, 0, 0); G.lastSent = 'idle'; } return; }
  let btns = 0, lx = 0, ly = 0, rx = 0, ry = 0, lt = 0, rt = 0;
  const t = performance.now();
  for (const c of G.controls) {
    if (c.hidden) continue;
    switch (c.t) {
      case 'btn': case 'pill':
        if (G.down.has(c.id)) { btns |= 1 << c.bind; if (c.bind === B.LT) lt = 1; if (c.bind === B.RT) rt = 1; }
        break;
      case 'pedal': {
        const v = G.val[c.id] || 0;
        if (c.bind === B.LT) lt = Math.max(lt, v); else if (c.bind === B.RT) rt = Math.max(rt, v); else if (v >= 0.12) btns |= 1 << c.bind;
        break;
      }
      case 'stick': case 'look':
        if (c.axis === 'l') { lx = c.sx || 0; ly = c.sy || 0; } else { rx = c.sx || 0; ry = c.sy || 0; }
        break;
      case 'dpad': btns |= c.mask || 0; break;
    }
  }
  for (const k in G.pulses) { if (G.pulses[k] > t) btns |= 1 << +k; }
  if (isRacing()) lx = G.steerMode === 'wheel' ? G.wheelOut : G.steer;
  // buttons that act as analog triggers
  if (lt >= 0.12) btns |= 1 << B.LT;
  if (rt >= 0.12) btns |= 1 << B.RT;
  if (btns & (1 << B.LT)) lt = Math.max(lt, 0.0);
  const key = [btns, lx.toFixed(3), ly.toFixed(3), rx.toFixed(3), ry.toFixed(3), lt.toFixed(3), rt.toFixed(3)].join('|');
  live.thr = rt; live.brk = lt; live.steer = clamp(lx, -1, 1);
  if (key === G.lastSent) return;
  G.lastSent = key;
  const fresh = btns & ~G.lastBits & ~((1 << B.LT) | (1 << B.RT));
  G.lastBits = btns;
  send(btns, lx, ly, rx, ry, lt, rt);
  if (fresh) N.pressed(fresh);
}
function send(b, lx, ly, rx, ry, lt, rt) { N.state(b | 0, lx, ly, rx, ry, lt, rt); }

function syncGyro() {
  const on = G.view === 'pad' && !G.edit && isRacing() && G.steerMode === 'gyro';
  if (G.gyroSent !== on) { G.gyroSent = on; N.gyro(on); }
}

/* ------------------------------------------------------------------ touch handling (play mode) */
function localXY(e) { const r = cv.getBoundingClientRect(); return [e.clientX - r.left, e.clientY - r.top]; }

function stickUpdate(c, x, y, radius) {
  const [sx, sy] = stickMath((x - c.ox) / radius, (y - c.oy) / radius, tuning.stickDeadzone, tuning.stickOuterDeadzone);
  c.sx = sx; c.sy = sy;
}
function pedalValue(c, y) {
  if (!tuning.analogPedals) return 1;
  const top = c.cy - c.H / 2;
  return pedalMath((top + c.H - y) / c.H, tuning.pedalDeadzone, tuning.pedalFullAt);
}
function dpadMask(c, x, y) {
  const dx = x - c.cx, dy = y - c.cy;
  if (dx * dx + dy * dy < Math.pow(c.R * 0.18, 2)) return 0;
  let d = (Math.atan2(dy, dx) * 180) / Math.PI; if (d < 0) d += 360;
  const U = 1 << B.UP, D = 1 << B.DOWN, L = 1 << B.LEFT, R = 1 << B.RIGHT;
  return d < 30 || d >= 330 ? R : d < 60 ? R | D : d < 120 ? D : d < 150 ? D | L : d < 210 ? L : d < 240 ? L | U : d < 300 ? U : U | R;
}

function playDown(e) {
  const [x, y] = localXY(e);
  const c = pick(x, y, false);
  if (!c) return;
  const p = { c, x0: x, y0: y, moved: 0 };
  G.pointers.set(e.pointerId, p);
  switch (c.t) {
    case 'btn': case 'pill': G.down.add(c.id); break;
    case 'pedal': G.val[c.id] = pedalValue(c, y); break;
    case 'dpad': c.mask = dpadMask(c, x, y); break;
    case 'stick': {
      c.pid = e.pointerId;
      if (tuning.floatingSticks) {
        const r = c.R * 0.9;
        c.ox = clamp(x, G.area.x0 + r, G.area.x0 + G.area.w - r); c.oy = clamp(y, G.area.y0 + r, G.area.y0 + G.area.h - r);
      } else { c.ox = c.cx; c.oy = c.cy; }
      stickUpdate(c, x, y, c.R); break;
    }
    case 'look': c.pid = e.pointerId; c.ox = x; c.oy = y; G.touchedLook = true; stickUpdate(c, x, y, c.lookR); break;
    case 'wheel': c.pid = e.pointerId; p.a0 = Math.atan2(y - c.cy, x - c.cx); p.w0 = G.wheelUser; break;
    case 'rotary': p.a0 = Math.atan2(y - c.cy, x - c.cx); p.acc = 0; break;
  }
  try { cv.setPointerCapture(e.pointerId); } catch (err) { /* ignore */ }
  emit();
}
function playMove(e) {
  const p = G.pointers.get(e.pointerId); if (!p) return;
  const [x, y] = localXY(e), c = p.c;
  p.moved = Math.max(p.moved, Math.hypot(x - p.x0, y - p.y0));
  switch (c.t) {
    case 'pedal': G.val[c.id] = pedalValue(c, y); break;
    case 'dpad': c.mask = dpadMask(c, x, y); break;
    case 'stick': stickUpdate(c, x, y, c.R); break;
    case 'look': stickUpdate(c, x, y, c.lookR); break;
    case 'wheel': {
      let d = Math.atan2(y - c.cy, x - c.cx) - p.a0; while (d > Math.PI) d -= TAU; while (d < -Math.PI) d += TAU;
      G.wheelUser = clamp(p.w0 + d * 1.4, -MAX_WHEEL, MAX_WHEEL); G.wheelOut = G.wheelUser / MAX_WHEEL; break;
    }
    case 'rotary': {
      const a = Math.atan2(y - c.cy, x - c.cx); let d = a - p.a0; while (d > Math.PI) d -= TAU; while (d < -Math.PI) d += TAU;
      p.a0 = a; p.acc += d; G.rot[c.id] = (G.rot[c.id] || 0) + d;
      const step = (26 * Math.PI) / 180;
      while (p.acc >= step) { p.acc -= step; pulse(c.cw, 70); }
      while (p.acc <= -step) { p.acc += step; pulse(c.ccw, 70); }
      break;
    }
  }
  emit();
}
function playUp(e) {
  const p = G.pointers.get(e.pointerId); if (!p) return;
  G.pointers.delete(e.pointerId);
  const c = p.c;
  switch (c.t) {
    case 'btn': case 'pill': { let still = false; for (const q of G.pointers.values()) if (q.c === c) still = true; if (!still) G.down.delete(c.id); break; }
    case 'pedal': G.val[c.id] = 0; break;
    case 'dpad': c.mask = 0; break;
    case 'stick': case 'look': c.pid = undefined; c.sx = 0; c.sy = 0; break;
    case 'wheel': c.pid = undefined; break;
    case 'rotary': if (p.moved < 10) pulse(c.tap, 90); break;
  }
  emit();
}
function releaseAll() {
  for (const c of G.controls) { c.pid = undefined; c.sx = 0; c.sy = 0; c.mask = 0; }
  G.pointers.clear(); G.down.clear(); G.val = {}; G.pulses = {};
  emit();
}

cv.addEventListener('pointerdown', (e) => { e.preventDefault(); if (G.view !== 'pad') return; closeMenu(); if (G.edit) editDown(e); else playDown(e); });
cv.addEventListener('pointermove', (e) => { e.preventDefault(); if (G.view !== 'pad') return; if (G.edit) editMove(e); else playMove(e); });
const upH = (e) => { if (G.view !== 'pad') return; if (G.edit) editUp(e); else playUp(e); };
cv.addEventListener('pointerup', upH);
cv.addEventListener('pointercancel', upH);
cv.addEventListener('lostpointercapture', upH);
document.addEventListener('contextmenu', (e) => e.preventDefault());
document.addEventListener('gesturestart', (e) => e.preventDefault());

/* ------------------------------------------------------------------ layout editing */
function editSel(c) { G.sel = c; updateEditBar(); }
function editDown(e) {
  const [x, y] = localXY(e);
  if (G.sel && G.editPtrs.size === 1) { // second finger: pinch-scale the selected control
    const first = G.editPtrs.values().next().value;
    G.pinch = { d0: Math.max(20, Math.hypot(first.x - x, first.y - y)), s0: G.sel.s };
    G.editPtrs.set(e.pointerId, { x, y, pinch: true });
    return;
  }
  const c = pick(x, y, true);
  editSel(c);
  if (c) G.editPtrs.set(e.pointerId, { x, y, ox: c.cx - x, oy: c.cy - y });
  try { cv.setPointerCapture(e.pointerId); } catch (err) { /* ignore */ }
}
function editMove(e) {
  const p = G.editPtrs.get(e.pointerId); if (!p) return;
  const [x, y] = localXY(e); p.x = x; p.y = y;
  const c = G.sel; if (!c) return;
  if (G.pinch && G.editPtrs.size >= 2) {
    const pts = [...G.editPtrs.values()];
    const d = Math.hypot(pts[0].x - pts[1].x, pts[0].y - pts[1].y);
    c.s = clamp(G.pinch.s0 * (d / G.pinch.d0), 0.5, 2.2); resolve(c); return;
  }
  if (p.pinch || G.editPtrs.size > 1) return;
  const a = G.area;
  c.x = clamp((x + p.ox - a.x0) / a.w, 0.02, 0.98); c.y = clamp((y + p.oy - a.y0) / a.h, 0.02, 0.98); resolve(c);
}
function editUp(e) {
  G.editPtrs.delete(e.pointerId);
  if (G.editPtrs.size < 2) G.pinch = null;
  if (G.editPtrs.size === 1) { const q = [...G.editPtrs.values()][0]; if (G.sel) { q.ox = G.sel.cx - q.x; q.oy = G.sel.cy - q.y; } }
}
function startEdit() {
  if (G.view !== 'pad') openPreset(store('cp_last') || 'xbox');
  releaseAll(); G.edit = true; G.sel = null; G.snapshot = serializeLayout(G.controls);
  $('#bar').classList.add('hidden'); $('#ebar').classList.remove('hidden'); closeMenu(); updateEditBar();
  N.editing(true); syncGyro();
}
function endEdit(save) {
  if (!G.edit) return;
  if (save) {
    const data = serializeLayout(G.controls);
    store('cp_layout_' + G.preset, data); N.layoutSaved(G.preset, data); toast('Layout saved');
  } else { applySaved(G.controls, JSON.parse(G.snapshot || '{}')); resolveAll(); }
  G.edit = false; G.sel = null; G.editPtrs.clear(); G.pinch = null;
  $('#ebar').classList.add('hidden'); $('#bar').classList.remove('hidden');
  N.editing(false); syncGyro(); emit();
}
function updateEditBar() {
  const c = G.sel;
  $('#eName').textContent = c ? c.name : 'Tap a control to move it';
  $('#eHint').textContent = c ? 'Drag to move · pinch or use − / + to resize' : 'Drag any control · pinch to resize';
  for (const id of ['eSm', 'eBig', 'eHide', 'eOp']) $('#' + id).disabled = !c;
  $('#eOp').textContent = 'Opacity' + (c ? ' ' + Math.round((c.op === undefined ? 1 : c.op) * 100) + '%' : '');
  $('#eHide').textContent = c && c.hidden ? 'Show' : 'Hide';
  const canBind = c && (c.t === 'btn' || c.t === 'pill') && c.bind !== undefined;
  $('#eBind').disabled = !canBind;
  $('#eBind').textContent = canBind ? 'Button: ' + BTN_NAMES[c.bind].split(' ')[0] : 'Button';
}
const OPS = [1, 0.8, 0.6, 0.4, 0.2];
function nextOp(v) { let i = OPS.findIndex((o) => Math.abs(o - v) < 0.03); return OPS[(i + 1) % OPS.length]; }
G.opAll = parseFloat(store('cp_opacity')) || 1;
function paintOpMenu() { $('#mOpacity').textContent = 'Control opacity: ' + Math.round(G.opAll * 100) + '%'; }
paintOpMenu();
$('#mOpacity').onclick = (e) => { e.stopPropagation(); G.opAll = nextOp(G.opAll); store('cp_opacity', String(G.opAll)); paintOpMenu(); };
$('#eOp').onclick = () => { if (G.sel) { G.sel.op = nextOp(G.sel.op === undefined ? 1 : G.sel.op); updateEditBar(); } };
let resetArmed = 0;
$('#eSm').onclick = () => { if (G.sel) { G.sel.s = clamp(G.sel.s * 0.9, 0.5, 2.2); resolve(G.sel); } };
$('#eBig').onclick = () => { if (G.sel) { G.sel.s = clamp(G.sel.s * 1.1, 0.5, 2.2); resolve(G.sel); } };
$('#eHide').onclick = () => { if (G.sel) { G.sel.hidden = !G.sel.hidden; updateEditBar(); } };
$('#eBind').onclick = () => { if (G.sel) openBind(G.sel); };
$('#eReset').onclick = () => {
  const btnEl = $('#eReset');
  if (performance.now() - resetArmed > 2500) { resetArmed = performance.now(); btnEl.textContent = 'Tap again'; setTimeout(() => { btnEl.textContent = 'Reset'; }, 2500); return; }
  resetArmed = 0; btnEl.textContent = 'Reset'; applySaved(G.controls, {}); resolveAll(); updateEditBar(); toast('Reset to default');
};
$('#eCancel').onclick = () => endEdit(false);
$('#eDone').onclick = () => endEdit(true);

function openBind(c) {
  const list = $('#bindGrid'); list.innerHTML = '';
  BTN_NAMES.forEach((n, i) => {
    const b = document.createElement('button'); b.textContent = n; if (i === c.bind) b.classList.add('on');
    b.onclick = () => { c.bind = i; $('#bindlist').classList.add('hidden'); updateEditBar(); };
    list.appendChild(b);
  });
  $('#bindlist').classList.remove('hidden');
}
$('#bindClose').onclick = () => $('#bindlist').classList.add('hidden');

/* ------------------------------------------------------------------ presets & screens */
function openPreset(id) {
  if (!PRESETS[id]) id = 'xbox';
  G.preset = id; store('cp_last', id);
  G.view = 'pad';
  $('#home').classList.add('hidden'); $('#bar').classList.remove('hidden');
  computeArea();
  G.controls = buildLayout(id, G.area);
  applySaved(G.controls, loadSaved(id));
  G.touchedLook = false; G.wheelUser = 0; G.wheelOut = 0; G.steer = 0;
  resolveAll(); releaseAll();
  $('#title').textContent = PRESETS[id].name;
  $('#seg').classList.toggle('hidden', !isRacing());
  setSeg();
  N.preset(id, isRacing());
  syncGyro(); emit();
}
function goHome() {
  if (G.edit) endEdit(false);
  releaseAll(); G.view = 'home'; closeMenu();
  $('#home').classList.remove('hidden'); $('#bar').classList.add('hidden');
  computeArea(); syncGyro(); emit(); refreshHome();
}
function setSeg() { for (const b of document.querySelectorAll('#seg button')) b.classList.toggle('on', b.dataset.m === G.steerMode); }
function setSteerMode(m) {
  G.steerMode = m; store('cp_steer', m); G.wheelUser = 0; G.wheelOut = 0; setSeg(); syncGyro(); emit();
  toast(m === 'wheel' ? 'On-screen wheel: drag the wheel to steer' : 'Tilt steering: turn the phone like a wheel');
}
for (const b of document.querySelectorAll('#seg button')) b.onclick = () => setSteerMode(b.dataset.m);
$('#bHome').onclick = goHome;
$('#bEdit').onclick = startEdit;
$('#bGear').onclick = (e) => { e.stopPropagation(); $('#menu').classList.toggle('hidden'); $('#mSteer').classList.toggle('hidden', !isRacing()); $('#mCenter').classList.toggle('hidden', !(isRacing() && G.steerMode === 'gyro')); };
function closeMenu() { $('#menu').classList.add('hidden'); }
document.addEventListener('pointerdown', (e) => { if (!e.target.closest('#menu') && !e.target.closest('#bGear')) closeMenu(); });
$('#mEdit').onclick = startEdit;
$('#mSteer').onclick = () => { closeMenu(); setSteerMode(G.steerMode === 'gyro' ? 'wheel' : 'gyro'); };
$('#mCenter').onclick = () => { closeMenu(); N.center(); };
$('#mReset').onclick = () => { closeMenu(); store('cp_layout_' + G.preset, null); applySaved(G.controls, {}); resolveAll(); toast('Layout reset'); };
$('#mHome').onclick = () => { closeMenu(); goHome(); };
$('#mSettings').onclick = () => { closeMenu(); N.settings(); };
$('#pill').onclick = () => N.status();
$('#hPill').onclick = () => N.status();
$('#hSettings').onclick = () => N.settings();

/* ---- home */
const ART = {
  xbox: '<svg viewBox="0 0 120 70"><circle cx="90" cy="28" r="7" fill="none" stroke="#FF4D5E" stroke-width="3"/><circle cx="104" cy="42" r="7" fill="none" stroke="#3DDC84" stroke-width="3"/><circle cx="76" cy="42" r="7" fill="none" stroke="#4DA3FF" stroke-width="3"/><circle cx="90" cy="56" r="7" fill="none" stroke="#FFD23F" stroke-width="3"/><circle cx="30" cy="30" r="13" fill="none" stroke="#8791A8" stroke-width="3"/><path d="M52 50 h18 M61 41 v18" stroke="#8791A8" stroke-width="5" stroke-linecap="round"/></svg>',
  ps5: '<svg viewBox="0 0 120 70"><path d="M90 14 l8 14 h-16z" fill="none" stroke="#35E0B0" stroke-width="3" stroke-linejoin="round"/><circle cx="104" cy="42" r="7" fill="none" stroke="#FF5C6C" stroke-width="3"/><path d="M70 36 l12 12 m0 -12 l-12 12" stroke="#5DA9FF" stroke-width="3" stroke-linecap="round"/><rect x="88" y="52" width="13" height="13" fill="none" stroke="#FF8AD8" stroke-width="3" rx="1"/><circle cx="36" cy="46" r="12" fill="none" stroke="#8791A8" stroke-width="3"/><rect x="34" y="10" width="52" height="14" rx="6" fill="none" stroke="#2B3248" stroke-width="3"/></svg>',
  shooter: '<svg viewBox="0 0 120 70"><circle cx="60" cy="35" r="20" fill="none" stroke="#FF4D5E" stroke-width="3"/><path d="M60 6 v16 M60 48 v16 M26 35 h16 M78 35 h16" stroke="#FF4D5E" stroke-width="3" stroke-linecap="round"/><circle cx="60" cy="35" r="2.5" fill="#FF4D5E"/></svg>',
  racing: '<svg viewBox="0 0 120 70"><circle cx="60" cy="38" r="26" fill="none" stroke="#8791A8" stroke-width="6"/><path d="M36 38 h48 M60 38 v24" stroke="#8791A8" stroke-width="5" stroke-linecap="round"/><rect x="57" y="8" width="6" height="9" fill="#FF9F1C" rx="1"/><circle cx="60" cy="38" r="6" fill="#00E5FF"/></svg>',
  f1: '<svg viewBox="0 0 120 70"><path d="M30 14 h60 q8 0 10 8 l8 30 q2 10 -8 10 h-22 l-6 -8 h-24 l-6 8 h-22 q-10 0 -8 -10 l8 -30 q2 -8 10 -8z" fill="#10131B" stroke="#3A4160" stroke-width="3"/><rect x="42" y="18" width="36" height="22" rx="3" fill="#04060A" stroke="#00E5FF" stroke-width="2"/><circle cx="26" cy="44" r="5" fill="#FFD23F"/><circle cx="94" cy="44" r="5" fill="#00E5FF"/><circle cx="26" cy="29" r="4" fill="#FF2E9A"/><circle cx="94" cy="29" r="4" fill="#B070FF"/></svg>',
};
function buildHome() {
  const grid = $('#cards'); grid.innerHTML = '';
  PRESET_ORDER.forEach((id) => {
    const p = PRESETS[id], el = document.createElement('button'); el.className = 'card'; el.dataset.id = id; el.style.setProperty('--i', PRESET_ORDER.indexOf(id));
    el.innerHTML = '<div class="art">' + ART[id] + '</div><div class="nm">' + p.name + '</div><div class="sb">' + p.sub + '</div>';
    el.onclick = () => openPreset(id);
    grid.appendChild(el);
  });
}
function refreshHome() {
  const last = store('cp_last') || N.lastPreset() || '';
  for (const el of document.querySelectorAll('.card')) el.classList.toggle('last', el.dataset.id === last);
  $('#hLast').textContent = last && PRESETS[last] ? 'Last used: ' + PRESETS[last].name : 'Pick a layout to start';
}

/* ------------------------------------------------------------------ status, toast */
function paintStatus() {
  const s = G.status, col = s.level === 1 ? COL.green : s.level === 2 ? COL.red : COL.amber;
  for (const id of ['pill', 'hPill']) {
    const el = $('#' + id); el.querySelector('i').style.background = col; el.querySelector('i').style.boxShadow = '0 0 8px ' + col;
    el.querySelector('b').textContent = s.title || 'Waiting';
  }
  $('#hDetail').textContent = s.detail || '';
}
let toastT = 0;
function toast(msg) { const t = $('#toast'); t.textContent = msg; t.classList.add('show'); clearTimeout(toastT); toastT = setTimeout(() => t.classList.remove('show'), 2200); }

/* ------------------------------------------------------------------ render loop */
const ORDER = ['look', 'touchpad', 'graph', 'lights', 'speedo', 'pedal', 'wheel', 'stick', 'dpad', 'btn', 'pill', 'rotary'];
let last = performance.now();
function frame(now) {
  const dt = Math.min(0.05, (now - last) / 1000); last = now;
  if (G.view === 'pad') {
    stepLive(dt, now);
    G.drsOn = !!live.drs || G.down.has('drs');
    live.ers = G.down.has('ers') || G.down.has('ovt');
    // wheel spring + visual angle
    if (G.steerMode === 'wheel') {
      const w = G.controls.find((c) => c.t === 'wheel');
      if (!(w && w.pid !== undefined) && Math.abs(G.wheelUser) > 1e-4) { G.wheelUser *= Math.exp(-dt * 11); if (Math.abs(G.wheelUser) < 0.002) G.wheelUser = 0; G.wheelOut = G.wheelUser / MAX_WHEEL; emit(); }
      G.wheelVis = G.wheelUser;
    } else G.wheelVis = G.steer * MAX_WHEEL;
    draw();
  }
  requestAnimationFrame(frame);
}
function draw() {
  ctx.setTransform(DPR, 0, 0, DPR, 0, 0);
  ctx.clearRect(0, 0, W, H);
  backdrop(ctx, W, H, DPR);
  if (G.edit) drawGrid();
  const fns = { look: drawLook, touchpad: drawTouchpad, graph: drawGraph, lights: drawLights, speedo: drawSpeedo, pedal: drawPedal, wheel: drawWheel, stick: drawStick, dpad: drawDpad, btn: drawBtn, pill: drawPill, rotary: drawRotary };
  for (const t of ORDER) {
    for (const c of G.controls) {
      if (c.t !== t) continue;
      if (c.hidden && !G.edit) continue;
      ctx.globalAlpha = (c.op === undefined ? 1 : c.op) * G.opAll * (c.hidden ? 0.22 : 1);
      fns[t](ctx, c);
      ctx.globalAlpha = 1;
    }
  }
  if (G.edit && G.sel) drawSelection(G.sel);
}
function bounds(c) {
  switch (c.t) {
    case 'btn': case 'rotary': case 'speedo': case 'wheel': case 'stick': case 'dpad': { const r = c.R * (c.t === 'stick' ? 1.1 : 1.08); return [c.cx - r, c.cy - r, r * 2, r * 2]; }
    default: return [c.cx - c.W / 2, c.cy - c.H / 2, c.W, c.H];
  }
}
function drawSelection(c) {
  const [x, y, w, h] = bounds(c);
  ctx.save(); ctx.setLineDash([7, 5]); ctx.lineWidth = 2.5; ctx.strokeStyle = COL.cyan; rr(ctx, x - 6, y - 6, w + 12, h + 12, 12); ctx.stroke(); ctx.restore();
}
function drawGrid() {
  ctx.strokeStyle = 'rgba(255,255,255,.045)'; ctx.lineWidth = 1;
  const a = G.area;
  for (let i = 0; i <= 10; i++) { const xx = a.x0 + (a.w * i) / 10; ctx.beginPath(); ctx.moveTo(xx, a.y0); ctx.lineTo(xx, a.y0 + a.h); ctx.stroke(); }
  for (let i = 0; i <= 6; i++) { const yy = a.y0 + (a.h * i) / 6; ctx.beginPath(); ctx.moveTo(a.x0, yy); ctx.lineTo(a.x0 + a.w, yy); ctx.stroke(); }
}

/* ------------------------------------------------------------------ API called by the Android side */
window.cp = {
  setMode(mode) { // legacy 'gamepad' / 'racing' switch from the phone's Settings screen
    const wantRacing = mode === 'racing';
    if (G.view === 'pad' && wantRacing !== isRacing()) openPreset(wantRacing ? 'racing' : 'xbox');
  },
  setTuning(t) { Object.assign(tuning, t); },
  setSteeringAvailable(b) { G.steeringAvailable = !!b; },
  setSteering(f) { G.steer = clamp(+f || 0, -1, 1); },
  setConnected(b) { G.connected = !!b; },
  setStatus(level, title, detail) { G.status = { level: level | 0, title: title || '', detail: detail || '' }; paintStatus(); },
  releaseAll,
  startEditing: startEdit,
  cancelEditing() { endEdit(false); },
  resetLayout() { store('cp_layout_' + G.preset, null); applySaved(G.controls, {}); resolveAll(); },
  setInsets(l, t, r, b) { G.insets = { l: +l || 0, t: +t || 0, r: +r || 0, b: +b || 0 }; $('#bar').style.paddingLeft = (G.insets.l + 8) + 'px'; $('#bar').style.paddingRight = (G.insets.r + 8) + 'px'; $('#bar').style.top = G.insets.t + 'px'; $('#ebar').style.top = G.insets.t + 'px'; $('#ebar').style.paddingLeft = (G.insets.l + 8) + 'px'; $('#ebar').style.paddingRight = (G.insets.r + 8) + 'px'; resize(); },
  telemetry(t) { // optional real data: {speed (km/h), rpm, gear, drs}
    if (!t) return;
    live.telemetryAt = performance.now();
    if (isFinite(t.speed)) live.speed = t.speed; if (isFinite(t.rpm)) live.rpm = t.rpm; if (isFinite(t.gear)) live.gear = t.gear | 0; if (t.drs !== undefined) live.drs = !!t.drs;
  },
};

window.addEventListener('resize', resize);
buildHome(); resize(); paintStatus(); refreshHome(); setSeg();
requestAnimationFrame(frame);
N.ready();
