# Pre-open self-verification checklist

Run this against the generated file before opening it for the user. Fix anything that fails, then open.

## Single-file / scope integrity
- [ ] Exactly one `.html` file. No sidecar JS/CSS, no `package.json`, no build step.
- [ ] No image/audio/model/texture files referenced (no `src="...png"`, no `loader.load(...)`). Art is canvas/CSS/DOM/emoji/geometry only.
- [ ] No runtime network calls (`fetch`, `XMLHttpRequest`, websockets). Only CDN `<script>`/import-map URLs for libraries.
- [ ] No API key, no LLM/timely/Anthropic API call anywhere.

## Static sanity (re-read the file)
- [ ] Braces/parens/brackets balanced; `<script>` closed; valid HTML structure.
- [ ] Every function and variable referenced is actually defined. No leftover `TODO`, placeholder, or stubbed function.
- [ ] The game loop is actually started (rAF kicked off, or interval set) on game start.
- [ ] Input listeners attached; arrow/space `preventDefault` so the page doesn't scroll.
- [ ] If three.js: import map present, game script is `type="module"`, pinned CDN URL, resize handler updates camera aspect + renderer size.

## Optional cheap syntax check
- [ ] If quick, extract the inline script and `node --check` it, or otherwise scan for obvious runtime errors. Not a full run — just catch syntax mistakes before the user sees a blank screen.

## Playability (reason it through, even without running)
- [ ] Start → playing → game over → restart all reachable; restart fully resets state (score, entities, timers).
- [ ] Win/lose/collision logic is correct (check the category's known edge cases in `category-patterns.md`).
- [ ] Movement uses delta time, so speed is sane on a 60Hz and a 120Hz display.
- [ ] Score/lives visible (HUD); a one-line how-to-play on the start screen.
- [ ] Canvas fits the window and is readable on a laptop screen.
- [ ] First ~10 seconds are winnable; difficulty ramps after.

## Then
- [ ] Open it: `open <path>` (macOS) / `xdg-open <path>` (Linux), or print the exact command + absolute path.
- [ ] Ask for feedback in one line and iterate on the same file.
