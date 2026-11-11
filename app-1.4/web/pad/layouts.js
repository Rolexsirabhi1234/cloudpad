'use strict';
/* Layout presets. Positions are fractions of the play area (x, y = centre), sizes are in "U" units
   (U = height of the play area). Everything here can be moved, resized, hidden and re-bound in Edit mode. */

const PRESETS = {
  xbox:    { name: 'Xbox',      sub: 'Classic controller',        racing: false },
  ps5:     { name: 'PS5',       sub: 'DualSense style',           racing: false },
  shooter: { name: 'Shooter',   sub: 'Move, aim, fire',           racing: false },
  racing:  { name: 'Racing',    sub: 'Wheel or tilt steering',    racing: true  },
  f1:      { name: 'Formula 1', sub: 'DRS, ERS, live gauges',     racing: true  },
};
const PRESET_ORDER = ['xbox', 'ps5', 'shooter', 'racing', 'f1'];

// control constructors ---------------------------------------------------------------------------
function btn(id, x, y, r, lbl, col, bind, extra) { return Object.assign({ id, t: 'btn', x, y, r, lbl, col, bind, name: lbl || id }, extra); }
function pill(id, x, y, w, h, lbl, col, bind, extra) { return Object.assign({ id, t: 'pill', x, y, w, h, lbl, col, bind, name: lbl || id }, extra); }
function stick(id, x, y, r, axis, extra) { return Object.assign({ id, t: 'stick', x, y, r, axis, name: axis === 'l' ? 'Left stick' : 'Right stick' }, extra); }
function dpad(id, x, y, r, extra) { return Object.assign({ id, t: 'dpad', x, y, r, name: 'D-pad' }, extra); }
function pedal(id, x, y, w, h, lbl, col, bind) { return { id, t: 'pedal', x, y, w, h, lbl, col, bind, name: lbl + ' pedal' }; }

function buildLayout(preset, area) {
  const U = area.U, ax = area.w, ay = area.h;
  const dx = (u) => (u * U) / ax;      // U-units to x fraction
  const dy = (u) => (u * U) / ay;      // U-units to y fraction
  const L = [];
  const small = (id, x, y, lbl, bind) => btn(id, x, y, 0.07, lbl, COL.dim, bind, { style: 'small' });

  if (preset === 'xbox') {
    L.push(pill('lt', 0.11, 0.07, 0.40, 0.13, 'LT', COL.dim, B.LT, { analog: 'lt' }));
    L.push(pill('lb', 0.11, 0.22, 0.40, 0.12, 'LB', COL.dim, B.LB));
    L.push(pill('rt', 0.89, 0.07, 0.40, 0.13, 'RT', COL.dim, B.RT, { analog: 'rt' }));
    L.push(pill('rb', 0.89, 0.22, 0.40, 0.12, 'RB', COL.dim, B.RB));
    L.push(stick('ls', 0.17, 0.66, 0.19, 'l'));
    L.push(dpad('dp', 0.36, 0.84, 0.15));
    L.push(stick('rs', 0.66, 0.84, 0.15, 'r'));
    const fx = 0.84, fy = 0.60, d = 0.20;
    L.push(btn('a', fx, fy + dy(d), 0.12, 'A', COL.green, B.A));
    L.push(btn('b', fx + dx(d), fy, 0.12, 'B', COL.red, B.B));
    L.push(btn('x', fx - dx(d), fy, 0.12, 'X', COL.blue, B.X));
    L.push(btn('y', fx, fy - dy(d), 0.12, 'Y', COL.yellow, B.Y));
    L.push(btn('view', 0.43, 0.38, 0.07, '', COL.dim, B.VIEW, { style: 'view' }));
    L.push(btn('menu', 0.57, 0.38, 0.07, '', COL.dim, B.MENU, { style: 'menu' }));
    L.push(btn('guide', 0.5, 0.26, 0.09, '', COL.cyan, B.GUIDE, { style: 'guide' }));
    L.push(small('l3', 0.06, 0.93, 'LS', B.L3));
    L.push(small('r3', 0.94, 0.93, 'RS', B.R3));
  }

  if (preset === 'ps5') {
    L.push(pill('l2', 0.11, 0.07, 0.40, 0.13, 'L2', COL.dim, B.LT, { analog: 'lt' }));
    L.push(pill('l1', 0.11, 0.22, 0.40, 0.12, 'L1', COL.dim, B.LB));
    L.push(pill('r2', 0.89, 0.07, 0.40, 0.13, 'R2', COL.dim, B.RT, { analog: 'rt' }));
    L.push(pill('r1', 0.89, 0.22, 0.40, 0.12, 'R1', COL.dim, B.RB));
    L.push({ id: 'tp', t: 'touchpad', x: 0.5, y: 0.16, w: 0.46, h: 0.22, name: 'Touchpad', static: true });
    L.push(dpad('dp', 0.17, 0.52, 0.16));
    L.push(stick('ls', 0.34, 0.80, 0.17, 'l'));
    L.push(stick('rs', 0.63, 0.80, 0.17, 'r'));
    const fx = 0.85, fy = 0.64, d = 0.20;
    L.push(btn('cross', fx, fy + dy(d), 0.12, '', '#8FAAC8', B.A, { glyph: 'cross', name: 'Cross' }));
    L.push(btn('circle', fx + dx(d), fy, 0.12, '', '#E0636E', B.B, { glyph: 'circle', name: 'Circle' }));
    L.push(btn('square', fx - dx(d), fy, 0.12, '', '#DCCFA0', B.X, { glyph: 'square', name: 'Square' }));
    L.push(btn('tri', fx, fy - dy(d), 0.12, '', '#5FBF9A', B.Y, { glyph: 'triangle', name: 'Triangle' }));
    L.push(btn('create', 0.30, 0.40, 0.06, 'Create', COL.dim, B.VIEW, { style: 'tiny' }));
    L.push(btn('options', 0.70, 0.40, 0.06, 'Options', COL.dim, B.MENU, { style: 'tiny' }));
    L.push(btn('ps', 0.5, 0.56, 0.08, 'PS', COL.cyan, B.GUIDE, { style: 'ps' }));
    L.push(small('l3', 0.06, 0.93, 'L3', B.L3));
    L.push(small('r3', 0.94, 0.93, 'R3', B.R3));
  }

  if (preset === 'shooter') {
    L.push({ id: 'look', t: 'look', x: 0.70, y: 0.55, w: 0.58, h: 0.88, axis: 'r', name: 'Look / aim area' });
    L.push(stick('ls', 0.16, 0.72, 0.19, 'l'));
    L.push(btn('sprint', 0.19, 0.30, 0.09, 'RUN', COL.amber, B.L3));
    L.push(btn('aim', 0.33, 0.50, 0.11, 'AIM', COL.blue, B.LT, { analog: 'lt' }));
    L.push(btn('fire', 0.89, 0.60, 0.19, 'FIRE', COL.red, B.RT, { analog: 'rt' }));
    L.push(btn('fire2', 0.06, 0.30, 0.10, 'FIRE', COL.red, B.RT, { analog: 'rt' }));
    L.push(btn('jump', 0.80, 0.86, 0.11, 'JUMP', COL.green, B.A));
    L.push(btn('reload', 0.72, 0.58, 0.10, 'R', COL.yellow, B.X));
    L.push(btn('crouch', 0.66, 0.84, 0.09, 'CRCH', COL.purple, B.B));
    L.push(btn('swap', 0.80, 0.30, 0.09, 'SWAP', COL.cyan, B.Y));
    L.push(btn('nade', 0.90, 0.28, 0.08, 'NADE', COL.amber, B.RB));
    L.push(btn('melee', 0.63, 0.34, 0.07, 'MEL', COL.dim, B.R3, { style: 'small' }));
    L.push(btn('lb', 0.33, 0.78, 0.07, 'LB', COL.dim, B.LB, { style: 'small', hidden: true }));
    L.push(btn('view', 0.44, 0.20, 0.06, '', COL.dim, B.VIEW, { style: 'view' }));
    L.push(btn('menu', 0.56, 0.20, 0.06, '', COL.dim, B.MENU, { style: 'menu' }));
    L.push(dpad('dp', 0.34, 0.86, 0.11, { hidden: true }));
  }

  if (preset === 'racing') {
    L.push(pedal('brake', 0.08, 0.64, 0.23, 0.70, 'BRAKE', COL.red, B.LT));
    L.push(pedal('gas', 0.92, 0.64, 0.23, 0.70, 'GAS', COL.green, B.RT));
    L.push({ id: 'wheel', t: 'wheel', style: 'round', x: 0.5, y: 0.61, r: 0.37, name: 'Steering wheel' });
    L.push(pill('down', 0.22, 0.19, 0.36, 0.14, 'SHIFT −', COL.dim, B.LB, { name: 'Shift down' }));
    L.push(pill('up', 0.78, 0.19, 0.36, 0.14, 'SHIFT +', COL.dim, B.RB, { name: 'Shift up' }));
    L.push(btn('hand', 0.22, 0.50, 0.11, 'HAND\nBRAKE', COL.amber, B.B));
    L.push(btn('nitro', 0.78, 0.50, 0.11, 'NITRO', COL.mag, B.X));
    L.push(btn('cam', 0.22, 0.80, 0.09, 'CAM', COL.blue, B.Y));
    L.push(btn('rev', 0.78, 0.80, 0.09, 'HORN', COL.yellow, B.A));
    L.push(btn('view', 0.45, 0.10, 0.06, '', COL.dim, B.VIEW, { style: 'view' }));
    L.push(btn('menu', 0.55, 0.10, 0.06, '', COL.dim, B.MENU, { style: 'menu' }));
    L.push({ id: 'speedo', t: 'speedo', style: 'mini', x: 0.5, y: 0.20, r: 0.14, name: 'Speedometer', hidden: true });
    L.push(dpad('dp', 0.35, 0.90, 0.08, { hidden: true }));
  }

  if (preset === 'f1') {
    L.push(pedal('brake', 0.05, 0.71, 0.17, 0.56, 'BRAKE', COL.red, B.LT));
    L.push(pedal('gas', 0.95, 0.71, 0.17, 0.56, 'GAS', COL.green, B.RT));
    L.push(pill('down', 0.045, 0.21, 0.14, 0.27, '−', COL.dim, B.LB, { name: 'Downshift paddle', paddle: true }));
    L.push(pill('up', 0.955, 0.21, 0.14, 0.27, '+', COL.dim, B.RB, { name: 'Upshift paddle', paddle: true }));
    L.push({ id: 'wheel', t: 'wheel', style: 'f1', x: 0.5, y: 0.645, r: 0.44, name: 'Steering wheel' });
    L.push({ id: 'lights', t: 'lights', x: 0.5, y: 0.045, w: 0.62, h: 0.06, name: 'Shift lights' });
    L.push({ id: 'graph', t: 'graph', x: 0.5, y: 0.20, w: 0.56, h: 0.17, name: 'Input graph' });
    // colour keys, left cluster
    const lx = 0.215, rx = 0.785, k = 0.10;
    L.push(btn('pit', lx - dx(0.12), 0.40, k, 'PIT', COL.yellow, B.L3, { name: 'Pit limiter', style: 'key' }));
    L.push(btn('ers', lx + dx(0.12), 0.40, k, 'ERS', COL.mag, B.X, { name: 'ERS overtake', style: 'key' }));
    L.push(btn('radio', lx - dx(0.12), 0.62, k, 'RADIO', COL.white, B.R3, { name: 'Radio', style: 'key' }));
    L.push(btn('mfd', lx + dx(0.12), 0.62, k, 'MFD', COL.green, B.A, { name: 'MFD / menu', style: 'key' }));
    L.push({ id: 'bias', t: 'rotary', x: lx, y: 0.83, r: 0.105, lbl: 'BIAS', cw: B.RIGHT, ccw: B.LEFT, tap: B.UP, col: COL.red, name: 'Brake bias dial' });
    // right cluster
    L.push(btn('drs', rx + dx(0.12), 0.40, k, 'DRS', COL.cyan, B.Y, { name: 'DRS', style: 'key' }));
    L.push(btn('ovt', rx - dx(0.12), 0.40, k, 'OVT', COL.purple, B.B, { name: 'Overtake', style: 'key' }));
    L.push(btn('flash', rx + dx(0.12), 0.62, k, 'FLASH', COL.amber, B.RB, { name: 'Flashback / extra', style: 'key', hidden: true }));
    L.push(btn('cam', rx - dx(0.12), 0.62, k, 'VIEW', COL.blue, B.VIEW, { name: 'Camera / view', style: 'key' }));
    L.push({ id: 'diff', t: 'rotary', x: rx, y: 0.83, r: 0.105, lbl: 'DIFF', cw: B.DOWN, ccw: B.UP, tap: B.MENU, col: COL.blue, name: 'Diff / MFD dial' });
  }
  return L;
}

// Per-preset saved tweaks: { id: {x,y,s,h,b} }
function loadSaved(preset) {
  const raw = store('cp_layout_' + preset);
  if (!raw) return {};
  try { const o = JSON.parse(raw); return o && typeof o === 'object' ? o : {}; } catch (e) { return {}; }
}
function applySaved(controls, saved) {
  for (const c of controls) {
    if (c.defX === undefined) { c.defX = c.x; c.defY = c.y; c.defHidden = !!c.hidden; c.defBind = c.bind; }
    // always start from the factory defaults, then lay the saved tweaks on top
    c.x = c.defX; c.y = c.defY; c.hidden = c.defHidden; c.bind = c.defBind; c.s = 1; c.op = 1;
    const s = saved[c.id];
    if (!s) continue;
    if (isFinite(s.x)) c.x = clamp(s.x, 0, 1);
    if (isFinite(s.y)) c.y = clamp(s.y, 0, 1);
    if (isFinite(s.s)) c.s = clamp(s.s, 0.5, 2.2);
    if (isFinite(s.o)) c.op = clamp(s.o, 0.1, 1);
    if (s.h === 1 || s.h === 0) c.hidden = s.h === 1;
    if (isFinite(s.b) && s.b >= 0 && s.b <= 16 && c.bind !== undefined) c.bind = s.b | 0;
  }
}
function serializeLayout(controls) {
  const o = {};
  for (const c of controls) {
    if (c.static) continue;
    const e = {};
    if (Math.abs(c.x - c.defX) > 1e-4) e.x = +c.x.toFixed(4);
    if (Math.abs(c.y - c.defY) > 1e-4) e.y = +c.y.toFixed(4);
    if (Math.abs(c.s - 1) > 1e-3) e.s = +c.s.toFixed(3);
    if (c.op !== undefined && Math.abs(c.op - 1) > 1e-3) e.o = +c.op.toFixed(2);
    if (!!c.hidden !== c.defHidden) e.h = c.hidden ? 1 : 0;
    if (c.bind !== undefined && c.bind !== c.defBind) e.b = c.bind;
    if (Object.keys(e).length) o[c.id] = e;
  }
  return JSON.stringify(o);
}
