# Build recipe — single-HTML game

Patterns for writing the one `.html` file. Adapt; don't paste blindly. Keep everything inline.

## Skeleton

```html
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>GAME TITLE</title>
<style>
  html,body{margin:0;height:100%;background:#11131a;overflow:hidden;
    font-family:system-ui,-apple-system,"Apple SD Gothic Neo",sans-serif;color:#e8eaf0;}
  #wrap{position:fixed;inset:0;display:flex;align-items:center;justify-content:center;}
  canvas{background:#1b1e2b;border-radius:12px;box-shadow:0 10px 40px rgba(0,0,0,.5);touch-action:none;}
  .overlay{position:fixed;inset:0;display:flex;flex-direction:column;align-items:center;
    justify-content:center;gap:14px;background:rgba(10,12,18,.78);text-align:center;}
  .hidden{display:none;}
  button{font:600 16px system-ui;padding:12px 26px;border:0;border-radius:10px;
    background:#5b8cff;color:#fff;cursor:pointer;}
  #hud{position:fixed;top:14px;left:0;right:0;text-align:center;font:700 20px system-ui;
    pointer-events:none;text-shadow:0 2px 6px rgba(0,0,0,.6);}
</style>
</head>
<body>
<div id="wrap"><canvas id="game"></canvas></div>
<div id="hud"></div>
<div id="start" class="overlay">
  <h1>GAME TITLE</h1>
  <p>방향키/스페이스로 플레이</p>
  <button id="startBtn">시작</button>
</div>
<div id="over" class="overlay hidden">
  <h1>게임 오버</h1>
  <p id="finalScore"></p>
  <button id="retryBtn">다시하기</button>
</div>
<script>
/* game code here */
</script>
</body>
</html>
```

## Canvas sizing (responsive, crisp)

```js
const cv = document.getElementById('game');
const ctx = cv.getContext('2d');
let W, H, DPR = Math.min(devicePixelRatio || 1, 2);
function resize(){
  const m = Math.min(window.innerWidth, window.innerHeight) * 0.92; // square-ish; adapt
  W = m; H = m;
  cv.style.width = W + 'px'; cv.style.height = H + 'px';
  cv.width = W * DPR; cv.height = H * DPR;
  ctx.setTransform(DPR,0,0,DPR,0,0);
}
addEventListener('resize', resize); resize();
```

## Game loop (delta-time — frame-rate independent)

```js
let running = false, last = 0;
function frame(t){
  if(!running) return;
  const dt = Math.min((t - last) / 1000, 0.05); // seconds, clamp lag spikes
  last = t;
  update(dt);   // move everything by speed*dt, NOT by a fixed per-frame amount
  render();
  requestAnimationFrame(frame);
}
function start(){ running = true; last = performance.now(); requestAnimationFrame(frame); }
```
Rule: any movement is `pos += velocity * dt`. Spawning on timers: accumulate `spawnT += dt; if(spawnT > interval){ spawnT = 0; spawn(); }`.

## Input

```js
const keys = {};
addEventListener('keydown', e => {
  keys[e.code] = true;
  if(['ArrowUp','ArrowDown','ArrowLeft','ArrowRight','Space'].includes(e.code)) e.preventDefault();
});
addEventListener('keyup', e => { keys[e.code] = false; });
// pointer / touch (works on trackpad + mobile)
cv.addEventListener('pointerdown', e => { /* tap action, e.g. jump/fire */ });
```

## Collision

```js
// AABB
const hit = (a,b) => a.x < b.x+b.w && a.x+a.w > b.x && a.y < b.y+b.h && a.y+a.h > b.y;
// circle
const hitC = (a,b) => Math.hypot(a.x-b.x, a.y-b.y) < a.r + b.r;
```

## State transitions

```js
const startUI = document.getElementById('start'), overUI = document.getElementById('over');
function show(el){ el.classList.remove('hidden'); }
function hide(el){ el.classList.add('hidden'); }
document.getElementById('startBtn').onclick = () => { hide(startUI); reset(); start(); };
document.getElementById('retryBtn').onclick = () => { hide(overUI); reset(); start(); };
function gameOver(){ running = false; document.getElementById('finalScore').textContent = '점수: '+score; show(overUI); }
```

## three.js (3D only) — CDN, no asset files

Pin a version. ES module import map is the reliable single-file way:

```html
<script type="importmap">
{ "imports": { "three": "https://unpkg.com/three@0.160.0/build/three.module.js" } }
</script>
<script type="module">
import * as THREE from 'three';
const scene = new THREE.Scene();
const cam = new THREE.PerspectiveCamera(50, innerWidth/innerHeight, 0.1, 1000);
cam.position.set(0, 6, 8); cam.lookAt(0,0,0);
const renderer = new THREE.WebGLRenderer({ antialias:true });
renderer.setSize(innerWidth, innerHeight);
renderer.setPixelRatio(Math.min(devicePixelRatio,2));
document.body.appendChild(renderer.domElement);
scene.add(new THREE.AmbientLight(0xffffff, 0.6));
const dir = new THREE.DirectionalLight(0xffffff, 0.8); dir.position.set(5,10,7); scene.add(dir);
// meshes: BoxGeometry/PlaneGeometry + MeshLambertMaterial with color. No textures/models.
addEventListener('resize', () => {
  cam.aspect = innerWidth/innerHeight; cam.updateProjectionMatrix();
  renderer.setSize(innerWidth, innerHeight);
});
let last = performance.now();
function loop(t){ const dt=(t-last)/1000; last=t; /* update dt */ renderer.render(scene,cam); requestAnimationFrame(loop); }
requestAnimationFrame(loop);
</script>
```
Notes: with the import map, the game script must be `type="module"`. Test that the pinned three.js URL resolves. Keep mesh count modest; for many identical objects use `InstancedMesh`.

## Polish cheap wins
- Screen shake / flash on hit, particle burst on score, easing on UI, a 2-color gradient bg, subtle drop shadows. Small touches read as "high quality".
- Tune difficulty so the first 10 seconds are winnable; ramp after.
