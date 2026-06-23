# game-builder (Claude Code skill)

Engine B — internal. Turn a plain-language game idea into ONE self-contained HTML game, using your own Claude Code as the engine. No central server, no API key, no GUI. Each person runs it on their own Claude Code subscription.

## Install

Two options.

**A) Use it as a project skill (recommended for the team).** It's already committed at `.claude/skills/game-builder/` in this repo. Open Claude Code in this repo and it's available — accept the workspace trust dialog so `allowed-tools` takes effect.

**B) Install personally (works in any project).** Copy the folder into your personal skills directory:

```bash
cp -r .claude/skills/game-builder ~/.claude/skills/game-builder
```

That's the whole install. The directory name `game-builder` becomes the command.

## Use

In Claude Code, just describe a game ("플래피 버드 같은 거 만들어줘"), or invoke it directly:

```
/game-builder 2048 퍼즐 게임 만들어줘
```

Claude classifies the category, builds `games/<slug>.html`, opens it in your browser, and iterates on your feedback ("더 빠르게", "적 추가", "버그 있어"). Output is always one HTML file — share it by sending the file; it opens in any modern browser.

## What's in here

| File | Role |
| :-- | :-- |
| `SKILL.md` | Main instructions + frontmatter (the skill itself). |
| `reference/category-patterns.md` | Per-category mechanic/loop/render cheat sheet. |
| `reference/build-recipe.md` | Single-HTML skeleton + game-loop/input/collision/three.js patterns. |
| `reference/playtest-checklist.md` | Pre-open self-verification checklist. |

## Scope

In: arcade, puzzle, idle/clicker, board/card, single-player .io, shooting, 3D casual (three.js via CDN). Out (the skill will say so and offer a simpler version): real-time multiplayer, large original art, large 3D / mid-core games.
