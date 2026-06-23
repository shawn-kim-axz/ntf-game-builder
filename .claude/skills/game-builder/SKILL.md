---
name: game-builder
description: Build a playable browser game as a single self-contained HTML file from a plain-language idea. Use when the user wants to make, build, create, or generate a game (arcade, puzzle, idle/clicker, board/card, .io, shooter, or 3D casual), prototype a game idea, or turn a game concept into something they can play. Produces one HTML file that opens anywhere — no build step, no assets, no server.
allowed-tools: Write, Edit, Read, Bash(open *), Bash(xdg-open *), Bash(mkdir *), Bash(ls *), Bash(node *)
---

# Game Builder

Turn a game idea into ONE self-contained HTML file the user can play immediately. You are the engine — no external API, no key, no central server. Everything runs on the user's own Claude Code subscription.

Keep the conversation terminal-fast: short confirmations, not long forms. Build, open in the browser, iterate on feedback.

## Hard constraints (never violate)

- **Output = exactly one `.html` file.** No JS/CSS sidecar files, no bundler, no npm, no `package.json`, no build step.
- **No image/audio asset files.** Render all art in code: canvas drawing, CSS, DOM, emoji, gradients, simple geometry. For 3D, load `three.js` from a CDN `<script>` tag — geometry/materials only, no model/texture files.
- **No network calls at runtime** except CDN library `<script>` tags (three.js, etc.). No fetch, no backend, no analytics.
- **The file must open by double-click** (`file://`). It cannot depend on a local server.

## Step 1 — Get the idea

The user gives a free-text idea. If it is already concrete enough to build, skip straight to Step 2.

Only if genuinely ambiguous, ask **1–2 short questions max** — pick from: core mechanic, difficulty, visual tone. One line, inline. Do not interrogate.

> Example: "공룡 점프 게임 같은 거" → enough, build it. "게임 만들어줘" → ask one line: "어떤 종류로? (예: 점프 액션 / 퍼즐 / 클리커)".

## Step 2 — Classify the category

Map the idea to one category from the taxonomy and confirm in **one line**, then proceed:

- Arcade/Action (runner, flappy, dodge, stacker)
- Puzzle (2048, match-3, sliding, sudoku, minesweeper)
- Idle/Clicker/Merge (cookie clicker, incremental)
- Board/Card (chess, solitaire, tic-tac-toe, memory)
- .io/Arena vs AI (snake, single-player agar-style)
- Shooting (space invaders, brick breaker)
- 3D Casual (crossy-road-style, three.js)
- Other/Custom (free input → build closest fit)

> Confirm like: "퍼즐 게임으로 만들게요 ✓" — then keep going. Don't wait for a reply unless the user pushed back.

See `reference/category-patterns.md` for the mechanic/loop/render recipe per category. Read it when you need the pattern for the chosen category.

## Step 3 — Scope guard (filter at the door)

If the request requires any of these, it is OUT of single-HTML scope:

- **Real-time multiplayer** (needs a server/socket).
- **Large original art** (depends on image generation / many asset files).
- **Large 3D / mid-core** (Stardew-, Vampire-Survivors-scale worlds).

When out of scope: say so in one line and **offer a simplified single-HTML version** (e.g. "실시간 멀티는 서버가 필요해서 단일 HTML론 안 돼요. 대신 같은 화면 2인 플레이 or AI 상대로 만들까요?"). Build the simplified version once they pick.

## Step 4 — Generate the game

Write to `games/<slug>.html` (create `games/` if missing; slug = short kebab-case name). Quality bar: a polished single HTML like a good three.js crossy-road clone, not a stub.

Every game must have:

- A real **game loop** (`requestAnimationFrame`) with delta-time movement (frame-rate independent).
- Proper **input handling** (keyboard and/or pointer/touch; prevent default scroll on arrows/space).
- **Collision / win-lose logic** that actually works.
- **States**: start screen → playing → game over → restart, with on-screen score and a one-line how-to-play.
- **Responsive canvas** that fits the window; readable on a laptop screen.
- Self-contained: inline `<style>` and `<script>`; CDN only for libraries.

Follow `reference/build-recipe.md` for the HTML skeleton and the game-loop / input / collision patterns. Read it before writing the file.

## Step 5 — Self-verify, then hand to the player

Before opening, self-check against `reference/playtest-checklist.md`:

1. **Static sanity**: re-read the file. Confirm balanced braces, the loop is actually started, every referenced function/variable exists, listeners are attached, no leftover `TODO`/placeholder, no asset/file/fetch dependency.
2. **Optional syntax check** (cheap, do it if quick): extract the main script and run `node --check` on it, or eyeball obvious runtime errors. Fix anything obvious before opening.
3. **Open it for the user to play**:
   - macOS: `open games/<slug>.html`
   - Linux: `xdg-open games/<slug>.html`
   - If you cannot run it, print the exact command and the absolute path for the user to run.

Then ask for feedback in one line: "플레이해보고 어때요? (더 빠르게 / 적 추가 / 버그 등)".

## Step 6 — Iterate

On feedback ("too slow", "add enemies", "jump feels off", "X is broken"): edit the **same file**, re-run the Step 5 self-check, and re-open it. Repeat tightly. Don't rewrite from scratch unless the design fundamentally changed.

## Step 7 — Wrap up

Give the final absolute path. Note that sharing = just send the HTML file; it is one self-contained file and opens in any modern browser, anywhere. No install for the recipient.

## Principles

- This skill is an instruction set for Claude Code, **not an API client**. Never write code that calls an LLM/timely/Anthropic API or reads an API key — the user's own Claude Code is the engine.
- Always exactly one HTML file out. If a feature can't fit that, simplify rather than split into multiple files.
- Prefer working and fun over feature-complete. Ship something playable fast, then iterate.

## Additional resources

- `reference/category-patterns.md` — per-category mechanic/loop/render cheat sheet.
- `reference/build-recipe.md` — single-HTML skeleton + game-loop/input/collision/three.js patterns.
- `reference/playtest-checklist.md` — pre-open self-verification checklist.
