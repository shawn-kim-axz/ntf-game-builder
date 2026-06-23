# Category patterns

Per-category recipe: core mechanic, game loop shape, render approach, common pitfalls. Pick the row for the classified category. Build difficulty from the taxonomy is noted.

## Arcade / Action — difficulty: medium
- **Examples**: endless runner, flappy, dodge, stacker.
- **Mechanic**: auto-scroll or constant gravity; single input (tap/space) for the one verb (jump/flap/move). Spawn obstacles on a timer; speed ramps with score.
- **Loop**: update player physics → move/spawn obstacles → collision check → score → render.
- **Render**: canvas 2D rectangles/circles, or emoji sprites. Parallax bg with two scrolling layers reads as "polished".
- **Pitfalls**: gravity/jump tuned per-frame instead of per-second (use delta time); obstacle gap too tight to clear.

## Puzzle — difficulty: low–medium
- **Examples**: 2048, match-3, sliding, sudoku, minesweeper.
- **Mechanic**: grid state + a move rule. Logic correctness matters more than animation.
- **Loop**: often turn-based, not rAF — handle input → apply rule → check win/lose → re-render grid. Animate transitions with CSS transforms if desired.
- **Render**: CSS grid or canvas cells. Numbers/colors/emoji for tiles.
- **Pitfalls**: 2048 merge edge cases (one merge per tile per move; merge then slide order); match-3 cascade resolution; off-by-one on grid bounds.

## Idle / Clicker / Merge — difficulty: low
- **Examples**: cookie clicker, incremental, merge.
- **Mechanic**: click to gain resource; buy upgrades that raise auto-income; income accrues over time.
- **Loop**: rAF or `setInterval` ticking resource by per-second rate; click adds instantly; upgrade costs scale (e.g. cost *= 1.15 each buy).
- **Render**: DOM is easiest — big number, click target (emoji), upgrade buttons with cost/owned. Format large numbers (K/M/B).
- **Pitfalls**: rate applied per frame not per second; integer overflow on huge numbers (use formatting); upgrade affordability not re-checked.

## Board / Card — difficulty: low–medium
- **Examples**: chess, solitaire, tic-tac-toe, memory, minesweeper.
- **Mechanic**: discrete board state, legal-move rules, optional simple AI opponent (minimax for tic-tac-toe; greedy/random for others).
- **Loop**: event-driven, not rAF — player move → validate → AI move → check terminal state.
- **Render**: CSS grid / DOM cells; flip animations via CSS for memory/cards.
- **Pitfalls**: AI making illegal moves; not detecting draw/stalemate; turn lock so the player can't double-move during AI turn.

## .io / Arena vs AI — difficulty: medium
- **Examples**: snake, single-player agar-style. (Single-player only — no real multiplayer; "opponents" are AI bots.)
- **Mechanic**: player entity + AI bots in a bounded/wrapping arena; grow/eat mechanic; collision = death or growth.
- **Loop**: rAF; move player toward input → step bots with simple AI (seek food / avoid bigger) → resolve collisions → render.
- **Render**: canvas 2D; camera follows player if arena > viewport.
- **Pitfalls**: snake self-collision and reversing into itself; bot AI too aggressive/passive; spatial checks O(n^2) fine for small counts.

## Shooting — difficulty: medium
- **Examples**: space invaders, brick breaker.
- **Mechanic**: player ship/paddle moves on one axis; fire projectiles; enemies/bricks in formation; clear-all to win.
- **Loop**: rAF; input → move player → spawn/move bullets → move enemies → bullet-vs-enemy and enemy-vs-player collisions → score/lives → render.
- **Render**: canvas 2D rects + emoji; flash/particle on hit reads as polish.
- **Pitfalls**: bullets not despawned offscreen (leak); brick-breaker ball angle reflection off paddle; invader edge-bounce-and-descend timing.

## 3D Casual — difficulty: high
- **Examples**: crossy-road-style, simple 3D dodge/runner. Use three.js (CDN).
- **Mechanic**: keep it casual — grid-hop or lane movement in 3D; orthographic or fixed-angle perspective camera; spawn obstacles in lanes.
- **Loop**: three.js render loop; update meshes' positions with delta time; collision via bounding-box / grid-cell comparison (not full physics).
- **Render**: `BoxGeometry`/`PlaneGeometry` + `MeshLambertMaterial`, a `DirectionalLight` + `AmbientLight`. No external models/textures — color materials only. Soft shadows optional.
- **Pitfalls**: loading three.js from a working CDN URL (pin a version); resize handler updating camera aspect + renderer size; collision in world vs grid coords mixed up; performance from too many meshes (reuse/instancing for many objects).

## Other / Custom
- Map the free idea to the nearest pattern above and adapt. If it blends two (e.g. puzzle + arcade), take the loop from the action half and the rules from the puzzle half. Stay inside the single-HTML, no-asset, no-server constraints.
