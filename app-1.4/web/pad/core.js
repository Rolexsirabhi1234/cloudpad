'use strict';
/* CloudPad controller UI: core helpers, native bridge, state. */

const $ = (s, r) => (r || document).querySelector(s);
const clamp = (v, a, b) => (v < a ? a : v > b ? b : v);
const TAU = Math.PI * 2;

// Native bridge (Android injects window.Native). In a plain browser we use a recorder so the UI can be tested.
const N = window.Native || {
  ready() {}, state() {}, gyro() {}, pressed() {}, editing() {}, layoutSaved() {},
  settings() {}, status() {}, center() {}, preset() {}, lastPreset() { return ''; },
};

// Controller buttons (same numbering as the Bridge / Xbox layout).
const B = { A: 0, B: 1, X: 2, Y: 3, LB: 4, RB: 5, LT: 6, RT: 7, VIEW: 8, MENU: 9, L3: 10, R3: 11, UP: 12, DOWN: 13, LEFT: 14, RIGHT: 15, GUIDE: 16 };
const BTN_NAMES = ['A', 'B', 'X', 'Y', 'LB', 'RB', 'LT', 'RT', 'View', 'Menu', 'L3 (stick click)', 'R3 (stick click)', 'D-pad up', 'D-pad down', 'D-pad left', 'D-pad right', 'Guide'];

const COL = {
  bg: '#080B0A', panel: '#121614', panel2: '#1B201D', edge: '#2F3834', text: '#EEF4F0', dim: '#93A09A',
  cyan: '#34C48B', mag: '#B9A66B', lime: '#B9C86A', amber: '#D8A15A', green: '#5DBB87', red: '#D8505A',
  blue: '#7E9BBF', yellow: '#D9C46A', purple: '#A58BC4', white: '#F2F6F3',
};

// Settings that come from the phone's Settings screen (sent by Java).
const tuning = { floatingSticks: true, stickDeadzone: 0.05, stickOuterDeadzone: 0.05, analogPedals: true, pedalDeadzone: 0.05, pedalFullAt: 0.9 };

// Same maths the old native view used, so feel stays identical.
function stickMath(dx, dy, inner, outer) {
  const h = Math.hypot(dx, dy);
  const max = Math.max(0.05 + inner, 1 - outer);
  if (h <= inner || h === 0) return [0, 0];
  const m = Math.min(1, (h - inner) / (max - inner));
  return [(dx / h) * m, (dy / h) * m];
}
function pedalMath(v, dz, full) {
  return clamp((v - dz) / (Math.max(0.05 + dz, full) - dz), 0, 1);
}

function store(key, val) {
  try { if (val === undefined) return localStorage.getItem(key); if (val === null) localStorage.removeItem(key); else localStorage.setItem(key, val); } catch (e) { /* storage may be unavailable */ }
  return null;
}

/* ---- live input history + estimated telemetry ---------------------------------------------- */
const live = {
  thr: 0, brk: 0, steer: 0,           // current inputs 0..1, 0..1, -1..1
  hist: [],                           // [t, thr, brk, steer]
  speed: 0, rpm: 4000, gear: 1,       // estimated unless real telemetry arrives
  drs: false, ers: false,
  telemetryAt: -1e9,                  // last real telemetry time (ms)
  isLive() { return performance.now() - this.telemetryAt < 2500; },
};

function stepLive(dt, now) {
  if (!live.isLive()) {
    // Estimate from the player's own inputs. Clearly labelled EST in the UI.
    const v = live.speed;
    const ers = live.ers ? 1.18 : 1;
    const dv = (live.thr * 55 * ers - live.brk * 130 - 0.0005 * v * v - (v > 0 ? 3 : 0)) * dt;
    live.speed = clamp(v + dv, 0, 345);
    const g = clamp(1 + Math.floor(live.speed / 46), 1, 8);
    live.gear = live.speed < 3 && live.thr < 0.05 ? 0 : g;
    const lo = (g - 1) * 46, frac = clamp((live.speed - lo) / 46, 0, 1);
    live.rpm = 5200 + frac * 7000 + live.thr * 600;
  }
  const h = live.hist;
  if (!h.length || now - h[h.length - 1][0] >= 50) {
    h.push([now, live.thr, live.brk, live.steer]);
    while (h.length && now - h[0][0] > 8000) h.shift();
  }
}
