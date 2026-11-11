'use strict';
/* Rendering for every control. Reads the shared state object G (defined in app.js). */

const FONT = '"Roboto Condensed","Arial Narrow",sans-serif-condensed,system-ui,sans-serif';
const font = (px, w) => (w || 700) + ' ' + Math.round(px) + 'px ' + FONT;

function rr(ctx, x, y, w, h, r) {
  r = Math.min(r, w / 2, h / 2);
  ctx.beginPath();
  ctx.moveTo(x + r, y);
  ctx.arcTo(x + w, y, x + w, y + h, r);
  ctx.arcTo(x + w, y + h, x, y + h, r);
  ctx.arcTo(x, y + h, x, y, r);
  ctx.arcTo(x, y, x + w, y, r);
  ctx.closePath();
}
function alpha(hex, a) {
  const n = parseInt(hex.slice(1), 16);
  return 'rgba(' + (n >> 16) + ',' + ((n >> 8) & 255) + ',' + (n & 255) + ',' + a + ')';
}
function mixc(hex, k) { // darken (k<1) or lighten (k>1)
  const n = parseInt(hex.slice(1), 16);
  const f = (v) => clamp(Math.round(v * k), 0, 255);
  return 'rgb(' + f(n >> 16) + ',' + f((n >> 8) & 255) + ',' + f(n & 255) + ')';
}
function text(ctx, s, x, y, px, col, w, align) {
  ctx.font = font(px, w);
  ctx.fillStyle = col;
  ctx.textAlign = align || 'center';
  ctx.textBaseline = 'middle';
  const lines = String(s).split('\n');
  const lh = px * 1.05;
  for (let i = 0; i < lines.length; i++) ctx.fillText(lines[i], x, y + (i - (lines.length - 1) / 2) * lh);
}

function isDown(c) { return G.down.has(c.id); }
function val(c) { return G.val[c.id] || 0; }

/* ------------------------------------------------------------------ simple controls */
function drawBtn(ctx, c) {
  const R = c.R, x = c.cx, y = c.cy, down = isDown(c) || val(c) > 0.12;
  const col = c.col || COL.dim;
  const st = c.style;

  if (st === 'key') { // F1 coloured push key
    const g = ctx.createRadialGradient(x - R * 0.3, y - R * 0.35, R * 0.1, x, y, R);
    g.addColorStop(0, down ? mixc(col, 0.95) : mixc(col, 0.55));
    g.addColorStop(1, down ? mixc(col, 0.7) : mixc(col, 0.22));
    ctx.fillStyle = g;
    ctx.beginPath(); ctx.arc(x, y, R, 0, TAU); ctx.fill();
    ctx.lineWidth = Math.max(2, R * 0.12);
    ctx.strokeStyle = down ? '#fff' : col;
    ctx.beginPath(); ctx.arc(x, y, R * 0.93, 0, TAU); ctx.stroke();
    ctx.lineWidth = 1; ctx.strokeStyle = 'rgba(255,255,255,.18)';
    ctx.beginPath(); ctx.arc(x, y, R * 0.7, 0, TAU); ctx.stroke();
    text(ctx, c.lbl, x, y + R * 0.02, R * (c.lbl.length > 4 ? 0.36 : 0.44), down ? '#000' : '#fff', 800);
    return;
  }

  // base
  const g = ctx.createRadialGradient(x - R * 0.3, y - R * 0.4, R * 0.1, x, y, R * 1.05);
  g.addColorStop(0, COL.panel2); g.addColorStop(1, COL.panel);
  ctx.fillStyle = g;
  ctx.beginPath(); ctx.arc(x, y, R, 0, TAU); ctx.fill();
  if (down) { ctx.fillStyle = alpha(col.charAt(0) === '#' ? col : COL.cyan, 0.38); ctx.beginPath(); ctx.arc(x, y, R, 0, TAU); ctx.fill(); }
  ctx.lineWidth = Math.max(2, R * 0.09);
  ctx.strokeStyle = down ? '#fff' : (st === 'small' || st === 'tiny' ? COL.edge : col);
  ctx.beginPath(); ctx.arc(x, y, R - ctx.lineWidth / 2, 0, TAU); ctx.stroke();

  if (c.glyph) { drawGlyph(ctx, c.glyph, x, y, R * 0.46, down ? '#fff' : col); return; }
  if (st === 'view') { // two overlapping squares
    ctx.strokeStyle = down ? '#fff' : COL.dim; ctx.lineWidth = Math.max(2, R * 0.1);
    const s = R * 0.34; ctx.strokeRect(x - s * 0.9, y - s * 0.6, s * 1.3, s * 1.2); ctx.strokeRect(x - s * 0.4, y - s * 0.3, s * 1.3, s * 1.2); return;
  }
  if (st === 'menu') { // three lines
    ctx.strokeStyle = down ? '#fff' : COL.dim; ctx.lineWidth = Math.max(2, R * 0.1); ctx.lineCap = 'round';
    for (let i = -1; i <= 1; i++) { ctx.beginPath(); ctx.moveTo(x - R * 0.36, y + i * R * 0.28); ctx.lineTo(x + R * 0.36, y + i * R * 0.28); ctx.stroke(); }
    ctx.lineCap = 'butt'; return;
  }
  if (st === 'guide') { // ring with cross strokes
    ctx.strokeStyle = down ? '#fff' : col; ctx.lineWidth = Math.max(2, R * 0.1);
    ctx.beginPath(); ctx.arc(x, y, R * 0.45, 0, TAU); ctx.stroke();
    ctx.beginPath(); ctx.moveTo(x - R * 0.3, y - R * 0.3); ctx.lineTo(x + R * 0.3, y + R * 0.3); ctx.moveTo(x + R * 0.3, y - R * 0.3); ctx.lineTo(x - R * 0.3, y + R * 0.3); ctx.stroke(); return;
  }
  const px = c.lbl.indexOf('\n') >= 0 ? R * 0.30 : (c.lbl.length > 3 ? R * 0.40 : (st === 'tiny' ? R * 0.42 : R * 0.62));
  text(ctx, c.lbl, x, y + R * 0.02, px, down ? '#fff' : (st === 'small' || st === 'tiny' ? COL.dim : COL.text), 800);
}

function drawGlyph(ctx, kind, x, y, s, col) {
  ctx.strokeStyle = col; ctx.lineWidth = Math.max(2.5, s * 0.34); ctx.lineCap = 'round'; ctx.lineJoin = 'round';
  ctx.beginPath();
  if (kind === 'cross') { ctx.moveTo(x - s * 0.8, y - s * 0.8); ctx.lineTo(x + s * 0.8, y + s * 0.8); ctx.moveTo(x + s * 0.8, y - s * 0.8); ctx.lineTo(x - s * 0.8, y + s * 0.8); }
  else if (kind === 'circle') { ctx.arc(x, y, s * 0.88, 0, TAU); }
  else if (kind === 'square') { ctx.rect(x - s * 0.75, y - s * 0.75, s * 1.5, s * 1.5); }
  else { ctx.moveTo(x, y - s * 0.95); ctx.lineTo(x + s * 0.92, y + s * 0.7); ctx.lineTo(x - s * 0.92, y + s * 0.7); ctx.closePath(); }
  ctx.stroke(); ctx.lineCap = 'butt';
}

function drawPill(ctx, c) {
  const w = c.W, h = c.H, x = c.cx - w / 2, y = c.cy - h / 2, down = isDown(c) || val(c) > 0.12;
  if (c.paddle) { // F1 paddle shifter
    const g = ctx.createLinearGradient(x, y, x + w, y);
    g.addColorStop(0, '#20232E'); g.addColorStop(0.5, down ? '#3C4260' : '#2C3040'); g.addColorStop(1, '#171A24');
    ctx.fillStyle = g; rr(ctx, x, y, w, h, w * 0.5); ctx.fill();
    ctx.lineWidth = 2; ctx.strokeStyle = down ? COL.cyan : COL.edge; rr(ctx, x, y, w, h, w * 0.5); ctx.stroke();
    text(ctx, c.lbl, c.cx, c.cy, w * 0.78, down ? COL.cyan : COL.text, 800);
    return;
  }
  ctx.fillStyle = down ? mixc(COL.cyan, 0.42) : COL.panel2; rr(ctx, x, y, w, h, Math.min(h * 0.5, 16)); ctx.fill();
  ctx.lineWidth = 2; ctx.strokeStyle = down ? COL.cyan : COL.edge; rr(ctx, x, y, w, h, Math.min(h * 0.5, 16)); ctx.stroke();
  text(ctx, c.lbl, c.cx, c.cy + 1, h * 0.46, down ? '#fff' : COL.dim, 800);
}

function drawStick(ctx, c) {
  const act = c.pid !== undefined;
  const R = c.R;
  const ox = act ? c.ox : c.cx, oy = act ? c.oy : c.cy;
  ctx.fillStyle = alpha('#000000', 0.25); ctx.beginPath(); ctx.arc(ox, oy, R, 0, TAU); ctx.fill();
  ctx.lineWidth = Math.max(2, R * 0.05); ctx.strokeStyle = act ? alpha(COL.cyan, 0.85) : COL.edge;
  ctx.beginPath(); ctx.arc(ox, oy, R, 0, TAU); ctx.stroke();
  ctx.lineWidth = 1; ctx.strokeStyle = alpha('#ffffff', 0.08);
  ctx.beginPath(); ctx.arc(ox, oy, R * 0.62, 0, TAU); ctx.stroke();
  const kx = ox + (c.sx || 0) * R, ky = oy + (c.sy || 0) * R, kr = R * 0.46;
  const g = ctx.createRadialGradient(kx - kr * 0.3, ky - kr * 0.35, kr * 0.1, kx, ky, kr);
  g.addColorStop(0, act ? '#3A4A66' : '#2B3246'); g.addColorStop(1, act ? '#18202F' : '#141826');
  ctx.fillStyle = g; ctx.beginPath(); ctx.arc(kx, ky, kr, 0, TAU); ctx.fill();
  ctx.lineWidth = Math.max(2, R * 0.06); ctx.strokeStyle = act ? COL.cyan : COL.dim;
  ctx.beginPath(); ctx.arc(kx, ky, kr, 0, TAU); ctx.stroke();
  ctx.lineWidth = 1; ctx.strokeStyle = alpha('#ffffff', 0.12); ctx.beginPath(); ctx.arc(kx, ky, kr * 0.55, 0, TAU); ctx.stroke();
}

function drawDpad(ctx, c) {
  const R = c.R, x = c.cx, y = c.cy, m = c.mask || 0;
  const arm = R * 0.62, len = R;
  const dirs = [[0, -1, B.UP], [0, 1, B.DOWN], [-1, 0, B.LEFT], [1, 0, B.RIGHT]];
  ctx.fillStyle = COL.panel2; ctx.strokeStyle = COL.edge; ctx.lineWidth = 2;
  rr(ctx, x - len, y - arm / 2, len * 2, arm, arm * 0.28); ctx.fill(); ctx.stroke();
  rr(ctx, x - arm / 2, y - len, arm, len * 2, arm * 0.28); ctx.fill(); ctx.stroke();
  ctx.fillStyle = COL.panel2; ctx.fillRect(x - arm / 2 + 1, y - arm / 2 + 1, arm - 2, arm - 2);
  for (const d of dirs) {
    const on = (m & (1 << d[2])) !== 0;
    const ax = x + d[0] * len * 0.68, ay = y + d[1] * len * 0.68, s = arm * 0.2;
    ctx.fillStyle = on ? COL.cyan : COL.dim;
    ctx.beginPath();
    ctx.moveTo(ax + d[0] * s, ay + d[1] * s);
    ctx.lineTo(ax - d[1] * s - d[0] * s, ay + d[0] * s - d[1] * s);
    ctx.lineTo(ax + d[1] * s - d[0] * s, ay - d[0] * s - d[1] * s);
    ctx.closePath(); ctx.fill();
  }
}

function drawPedal(ctx, c) {
  const w = c.W, h = c.H, x = c.cx - w / 2, y = c.cy - h / 2, v = val(c), col = c.col;
  ctx.fillStyle = COL.panel; rr(ctx, x, y, w, h, w * 0.22); ctx.fill();
  ctx.save(); rr(ctx, x, y, w, h, w * 0.22); ctx.clip();
  if (v > 0) { const g = ctx.createLinearGradient(0, y + h, 0, y); g.addColorStop(0, alpha(col, 0.28)); g.addColorStop(1, alpha(col, 0.78)); ctx.fillStyle = g; ctx.fillRect(x, y + h * (1 - v), w, h * v); }
  ctx.strokeStyle = alpha('#ffffff', 0.07); ctx.lineWidth = Math.max(2, h * 0.012);
  for (let i = 1; i < 12; i++) { const yy = y + (h * i) / 12; ctx.beginPath(); ctx.moveTo(x + w * 0.15, yy); ctx.lineTo(x + w * 0.85, yy); ctx.stroke(); }
  ctx.restore();
  ctx.lineWidth = 2.5; ctx.strokeStyle = v > 0.05 ? col : COL.edge; rr(ctx, x, y, w, h, w * 0.22); ctx.stroke();
  text(ctx, c.lbl, c.cx, y + h * 0.09, Math.min(w * 0.22, h * 0.06), v > 0.05 ? '#fff' : COL.dim, 800);
  text(ctx, Math.round(v * 100) + '%', c.cx, y + h - h * 0.07, Math.min(w * 0.26, h * 0.06), col, 800);
}

function drawLook(ctx, c) {
  const act = c.pid !== undefined;
  if (G.edit) { ctx.setLineDash([8, 6]); ctx.strokeStyle = alpha(COL.cyan, 0.5); ctx.lineWidth = 2; rr(ctx, c.cx - c.W / 2, c.cy - c.H / 2, c.W, c.H, 18); ctx.stroke(); ctx.setLineDash([]); text(ctx, 'LOOK / AIM AREA', c.cx, c.cy, c.H * 0.06, alpha(COL.cyan, 0.7), 800); return; }
  if (act) {
    const R = c.lookR;
    ctx.strokeStyle = alpha(COL.cyan, 0.5); ctx.lineWidth = 2; ctx.beginPath(); ctx.arc(c.ox, c.oy, R, 0, TAU); ctx.stroke();
    ctx.fillStyle = alpha(COL.cyan, 0.35); ctx.beginPath(); ctx.arc(c.ox + (c.sx || 0) * R, c.oy + (c.sy || 0) * R, R * 0.35, 0, TAU); ctx.fill();
  } else if (!G.touchedLook) {
    text(ctx, 'DRAG HERE TO LOOK', c.cx - c.W * 0.16, c.cy - c.H * 0.43, c.H * 0.05, alpha(COL.dim, 0.4), 800);
  }
}

function drawTouchpad(ctx, c) {
  const w = c.W, h = c.H, x = c.cx - w / 2, y = c.cy - h / 2;
  const g = ctx.createLinearGradient(x, y, x, y + h); g.addColorStop(0, '#1C2030'); g.addColorStop(1, '#10131C');
  ctx.fillStyle = g; rr(ctx, x, y, w, h, h * 0.28); ctx.fill();
  ctx.lineWidth = 2; ctx.strokeStyle = COL.edge; rr(ctx, x, y, w, h, h * 0.28); ctx.stroke();
  ctx.fillStyle = alpha(COL.cyan, 0.5); ctx.beginPath(); ctx.arc(c.cx, y + h * 0.15, 3, 0, TAU); ctx.fill();
}

function drawRotary(ctx, c) {
  const R = c.R, x = c.cx, y = c.cy, a = (G.rot[c.id] || 0);
  ctx.fillStyle = COL.panel; ctx.beginPath(); ctx.arc(x, y, R, 0, TAU); ctx.fill();
  ctx.lineWidth = Math.max(2, R * 0.1); ctx.strokeStyle = c.col; ctx.beginPath(); ctx.arc(x, y, R - ctx.lineWidth / 2, 0, TAU); ctx.stroke();
  ctx.save(); ctx.translate(x, y); ctx.rotate(a);
  const g = ctx.createRadialGradient(-R * 0.2, -R * 0.25, R * 0.05, 0, 0, R * 0.8);
  g.addColorStop(0, '#454C66'); g.addColorStop(1, '#161A27');
  ctx.fillStyle = g; ctx.beginPath(); ctx.arc(0, 0, R * 0.74, 0, TAU); ctx.fill();
  ctx.strokeStyle = alpha('#ffffff', 0.18); ctx.lineWidth = 1.5;
  for (let i = 0; i < 24; i++) { const t = (i / 24) * TAU; ctx.beginPath(); ctx.moveTo(Math.cos(t) * R * 0.66, Math.sin(t) * R * 0.66); ctx.lineTo(Math.cos(t) * R * 0.74, Math.sin(t) * R * 0.74); ctx.stroke(); }
  ctx.strokeStyle = '#fff'; ctx.lineWidth = Math.max(2.5, R * 0.1); ctx.lineCap = 'round';
  ctx.beginPath(); ctx.moveTo(0, -R * 0.2); ctx.lineTo(0, -R * 0.62); ctx.stroke(); ctx.lineCap = 'butt';
  ctx.restore();
  text(ctx, c.lbl, x, y + R * 1.32, R * 0.4, COL.dim, 800);
}

/* ------------------------------------------------------------------ gauges */
function speedText() { return Math.round(live.speed); }
function rpmFrac() { return clamp((live.rpm - 8000) / (12400 - 8000), 0, 1); }
function gearText() { return live.gear === 0 ? 'N' : String(live.gear); }

function drawGauge(ctx, cx, cy, R, big) {
  const a0 = Math.PI * 0.75, sweep = Math.PI * 1.5, max = 360, f = clamp(live.speed / max, 0, 1);
  ctx.lineCap = 'round';
  ctx.lineWidth = R * 0.12; ctx.strokeStyle = COL.panel2; ctx.beginPath(); ctx.arc(cx, cy, R * 0.86, a0, a0 + sweep); ctx.stroke();
  const g = ctx.createLinearGradient(cx - R, cy, cx + R, cy); g.addColorStop(0, COL.cyan); g.addColorStop(0.6, COL.lime); g.addColorStop(1, COL.mag);
  ctx.strokeStyle = g; ctx.beginPath(); ctx.arc(cx, cy, R * 0.86, a0, a0 + sweep * f); ctx.stroke();
  ctx.lineCap = 'butt';
  ctx.lineWidth = 1.5; ctx.strokeStyle = alpha('#ffffff', 0.35);
  for (let v = 0; v <= max; v += 40) { const t = a0 + sweep * (v / max); ctx.beginPath(); ctx.moveTo(cx + Math.cos(t) * R * 0.68, cy + Math.sin(t) * R * 0.68); ctx.lineTo(cx + Math.cos(t) * R * 0.76, cy + Math.sin(t) * R * 0.76); ctx.stroke(); }
  if (big) { ctx.fillStyle = COL.dim; for (let v = 0; v <= max; v += 80) { const t = a0 + sweep * (v / max); text(ctx, v, cx + Math.cos(t) * R * 0.56, cy + Math.sin(t) * R * 0.56, R * 0.12, COL.dim, 600); } }
  text(ctx, speedText(), cx, cy - R * 0.02, R * 0.46, '#fff', 800);
  text(ctx, 'KM/H', cx, cy + R * 0.27, R * 0.13, COL.dim, 700);
  text(ctx, gearText(), cx, cy + R * 0.55, R * 0.30, COL.cyan, 800);
  if (!live.isLive()) text(ctx, 'EST', cx + R * 0.46, cy + R * 0.55, R * 0.12, COL.amber, 800);
}

function drawSpeedo(ctx, c) {
  ctx.fillStyle = alpha('#000000', 0.35); ctx.beginPath(); ctx.arc(c.cx, c.cy, c.R, 0, TAU); ctx.fill();
  drawGauge(ctx, c.cx, c.cy, c.R, c.style !== 'mini');
}

function drawLights(ctx, c) {
  const w = c.W, h = c.H, n = 15, lit = Math.round(rpmFrac() * n), flash = rpmFrac() > 0.985 && (Math.floor(performance.now() / 90) % 2 === 0);
  const gap = w / n, r = Math.min(gap * 0.36, h * 0.5);
  for (let i = 0; i < n; i++) {
    const col = i < 5 ? COL.green : i < 10 ? COL.red : COL.blue;
    const on = flash || i < lit;
    ctx.fillStyle = on ? col : alpha(col, 0.14);
    ctx.beginPath(); ctx.arc(c.cx - w / 2 + gap * (i + 0.5), c.cy, r, 0, TAU); ctx.fill();
    if (on) { ctx.strokeStyle = '#fff'; ctx.lineWidth = 1; ctx.globalAlpha = 0.5; ctx.stroke(); ctx.globalAlpha = 1; }
  }
}

function drawGraph(ctx, c) {
  const w = c.W, h = c.H, x = c.cx - w / 2, y = c.cy - h / 2;
  ctx.fillStyle = alpha('#05060A', 0.82); rr(ctx, x, y, w, h, 10); ctx.fill();
  ctx.lineWidth = 1.5; ctx.strokeStyle = COL.edge; rr(ctx, x, y, w, h, 10); ctx.stroke();
  const px = 8, py = 14, gw = w - px * 2, gh = h - py - 8;
  ctx.strokeStyle = alpha('#ffffff', 0.07); ctx.lineWidth = 1;
  for (let i = 0; i <= 4; i++) { const yy = y + py + (gh * i) / 4; ctx.beginPath(); ctx.moveTo(x + px, yy); ctx.lineTo(x + px + gw, yy); ctx.stroke(); }
  const now = performance.now(), span = 8000, hs = live.hist;
  const trace = (idx, col, mapFn) => {
    ctx.strokeStyle = col; ctx.lineWidth = 2; ctx.beginPath(); let started = false;
    for (let i = 0; i < hs.length; i++) {
      const px2 = x + px + gw * (1 - (now - hs[i][0]) / span); if (px2 < x + px) continue;
      const py2 = y + py + gh * (1 - mapFn(hs[i][idx]));
      if (!started) { ctx.moveTo(px2, py2); started = true; } else ctx.lineTo(px2, py2);
    }
    ctx.stroke();
  };
  trace(2, COL.red, (v) => v); trace(1, COL.green, (v) => v); trace(3, COL.cyan, (v) => (v + 1) / 2);
  const ls = Math.min(h * 0.12, 11);
  text(ctx, 'THR', x + px + 4, y + 7, ls, COL.green, 800, 'left');
  text(ctx, 'BRK', x + px + 4 + ls * 3.2, y + 7, ls, COL.red, 800, 'left');
  text(ctx, 'STEER', x + px + 4 + ls * 6.4, y + 7, ls, COL.cyan, 800, 'left');
  text(ctx, live.isLive() ? 'LIVE' : 'INPUTS · 8 s', x + w - px, y + 7, ls, live.isLive() ? COL.lime : COL.dim, 800, 'right');
}

/* ------------------------------------------------------------------ steering wheels */
function drawWheel(ctx, c) {
  const R = c.R, ang = G.wheelVis;
  ctx.save(); ctx.translate(c.cx, c.cy);
  const wheelMode = G.steerMode === 'wheel';
  const touching = c.pid !== undefined;

  if (c.style === 'round') {
    ctx.rotate(ang);
    ctx.fillStyle = alpha('#000', 0.25); ctx.beginPath(); ctx.arc(0, 0, R, 0, TAU); ctx.fill();
    // rim
    const rg = ctx.createLinearGradient(-R, -R, R, R); rg.addColorStop(0, '#3A4056'); rg.addColorStop(0.5, '#1A1E2C'); rg.addColorStop(1, '#2E3348');
    ctx.lineWidth = R * 0.17; ctx.strokeStyle = rg; ctx.beginPath(); ctx.arc(0, 0, R * 0.9, 0, TAU); ctx.stroke();
    ctx.lineWidth = 1.5; ctx.strokeStyle = touching ? COL.cyan : alpha('#ffffff', 0.15); ctx.beginPath(); ctx.arc(0, 0, R * 0.99, 0, TAU); ctx.stroke(); ctx.beginPath(); ctx.arc(0, 0, R * 0.81, 0, TAU); ctx.stroke();
    // spokes
    ctx.lineCap = 'round'; ctx.strokeStyle = '#262B3C'; ctx.lineWidth = R * 0.15;
    ctx.beginPath(); ctx.moveTo(-R * 0.8, 0); ctx.lineTo(R * 0.8, 0); ctx.moveTo(0, 0); ctx.lineTo(0, R * 0.8); ctx.stroke(); ctx.lineCap = 'butt';
    ctx.fillStyle = '#1B1F2D'; ctx.beginPath(); ctx.arc(0, 0, R * 0.28, 0, TAU); ctx.fill();
    ctx.lineWidth = 2; ctx.strokeStyle = COL.cyan; ctx.beginPath(); ctx.arc(0, 0, R * 0.28, 0, TAU); ctx.stroke();
    text(ctx, 'CP', 0, 0, R * 0.2, COL.cyan, 800);
    // 12 o'clock marker
    ctx.fillStyle = COL.amber; rr(ctx, -R * 0.045, -R * 0.99, R * 0.09, R * 0.2, R * 0.03); ctx.fill();
    ctx.rotate(-ang);
  } else { // F1 wheel
    ctx.rotate(ang);
    drawF1Wheel(ctx, R, touching);
    ctx.rotate(-ang);
  }
  // mode hint (not rotated)
  const hint = wheelMode ? (touching ? '' : 'DRAG TO STEER') : (G.steeringAvailable ? 'TILT PHONE TO STEER' : 'NO TILT SENSOR');
  if (hint && c.style === 'round') text(ctx, hint, 0, -R * 0.5, Math.max(11, R * 0.095), alpha(COL.dim, 0.8), 800);
  ctx.restore();
}

function drawF1Wheel(ctx, R, touching) {
  // carbon fibre pattern
  if (!G.carbon) {
    const p = document.createElement('canvas'); p.width = p.height = 8; const q = p.getContext('2d');
    q.fillStyle = '#10131B'; q.fillRect(0, 0, 8, 8); q.fillStyle = '#181C27'; q.fillRect(0, 0, 4, 4); q.fillRect(4, 4, 4, 4);
    G.carbon = ctx.createPattern(p, 'repeat');
  }
  const body = () => {
    ctx.beginPath();
    ctx.moveTo(-R * 0.62, -R * 0.52);
    ctx.lineTo(R * 0.62, -R * 0.52);
    ctx.quadraticCurveTo(R * 0.8, -R * 0.5, R * 0.86, -R * 0.3);
    ctx.lineTo(R * 1.0, R * 0.34);
    ctx.quadraticCurveTo(R * 1.04, R * 0.62, R * 0.84, R * 0.66);
    ctx.lineTo(R * 0.46, R * 0.66);
    ctx.quadraticCurveTo(R * 0.36, R * 0.52, R * 0.24, R * 0.52);
    ctx.lineTo(-R * 0.24, R * 0.52);
    ctx.quadraticCurveTo(-R * 0.36, R * 0.52, -R * 0.46, R * 0.66);
    ctx.lineTo(-R * 0.84, R * 0.66);
    ctx.quadraticCurveTo(-R * 1.04, R * 0.62, -R * 1.0, R * 0.34);
    ctx.lineTo(-R * 0.86, -R * 0.3);
    ctx.quadraticCurveTo(-R * 0.8, -R * 0.5, -R * 0.62, -R * 0.52);
    ctx.closePath();
  };
  ctx.save(); ctx.translate(0, 0);
  body(); ctx.fillStyle = G.carbon; ctx.fill();
  ctx.lineWidth = R * 0.03; ctx.strokeStyle = touching ? COL.cyan : '#3A4160'; ctx.stroke();
  // grip pads
  for (const s of [-1, 1]) {
    ctx.save(); ctx.scale(s, 1);
    ctx.fillStyle = '#0B0D13'; rr(ctx, R * 0.78, -R * 0.12, R * 0.2, R * 0.66, R * 0.09); ctx.fill();
    ctx.strokeStyle = alpha('#ffffff', 0.08); ctx.lineWidth = 1;
    for (let i = 0; i < 7; i++) { const yy = -R * 0.06 + i * R * 0.085; ctx.beginPath(); ctx.moveTo(R * 0.8, yy); ctx.lineTo(R * 0.96, yy); ctx.stroke(); }
    ctx.restore();
  }
  // accent stripes
  ctx.lineWidth = R * 0.022; ctx.lineCap = 'round';
  ctx.strokeStyle = COL.mag; ctx.beginPath(); ctx.moveTo(-R * 0.74, -R * 0.44); ctx.lineTo(-R * 0.5, -R * 0.44); ctx.stroke();
  ctx.strokeStyle = COL.cyan; ctx.beginPath(); ctx.moveTo(R * 0.5, -R * 0.44); ctx.lineTo(R * 0.74, -R * 0.44); ctx.stroke();
  ctx.lineCap = 'butt';
  // LCD screen
  const sx = -R * 0.5, sy = -R * 0.42, sw = R * 1.0, sh = R * 0.78;
  ctx.fillStyle = '#04060A'; rr(ctx, sx, sy, sw, sh, R * 0.06); ctx.fill();
  ctx.lineWidth = 2; ctx.strokeStyle = alpha(COL.cyan, 0.55); rr(ctx, sx, sy, sw, sh, R * 0.06); ctx.stroke();
  // speed
  text(ctx, speedText(), 0, sy + sh * 0.34, R * 0.235, '#fff', 800);
  text(ctx, 'KM/H', 0, sy + sh * 0.56, R * 0.08, COL.dim, 700);
  // gear box
  ctx.fillStyle = alpha(COL.cyan, 0.16); rr(ctx, sx + sw * 0.04, sy + sh * 0.1, sw * 0.2, sh * 0.34, R * 0.04); ctx.fill();
  text(ctx, gearText(), sx + sw * 0.14, sy + sh * 0.26, R * 0.2, COL.cyan, 800);
  text(ctx, 'GEAR', sx + sw * 0.14, sy + sh * 0.53, R * 0.06, COL.dim, 700);
  // DRS / ERS indicators
  const ind = (lbl, on, col, ox) => { ctx.fillStyle = on ? col : alpha(col, 0.15); rr(ctx, sx + sw * ox, sy + sh * 0.1, sw * 0.2, sh * 0.34, R * 0.04); ctx.fill(); text(ctx, lbl, sx + sw * (ox + 0.1), sy + sh * 0.27, R * 0.085, on ? '#000' : alpha(col, 0.6), 800); };
  ind('DRS', G.drsOn, COL.cyan, 0.76);
  // rev bar
  const bw = sw * 0.9, bx = sx + sw * 0.05, by = sy + sh * 0.76;
  ctx.fillStyle = alpha('#fff', 0.08); rr(ctx, bx, by, bw, sh * 0.1, sh * 0.05); ctx.fill();
  const rg = ctx.createLinearGradient(bx, 0, bx + bw, 0); rg.addColorStop(0, COL.green); rg.addColorStop(0.65, COL.red); rg.addColorStop(1, COL.blue);
  ctx.fillStyle = rg; rr(ctx, bx, by, Math.max(2, bw * clamp((live.rpm - 4000) / 8800, 0, 1)), sh * 0.1, sh * 0.05); ctx.fill();
  text(ctx, Math.round(live.rpm / 100) * 100 + ' RPM', 0, sy + sh * 0.955, R * 0.07, COL.dim, 700);
  if (!live.isLive()) text(ctx, 'EST', sx + sw * 0.86, sy + sh * 0.56, R * 0.07, COL.amber, 800);
  // top centre marker
  ctx.fillStyle = COL.yellow; rr(ctx, -R * 0.05, -R * 0.62, R * 0.1, R * 0.14, R * 0.03); ctx.fill();
  ctx.restore();
}
