#!/usr/bin/env bash
# 게임빌더 스킬 설치 — 개인 스킬로 (~/.claude/skills/) 복사.
# 설치 후 어느 폴더에서나 Claude Code에서 "게임 만들어줘 — <아이디어>" 로 사용.
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)/.claude/skills/game-builder"
DEST_DIR="$HOME/.claude/skills"
DEST="$DEST_DIR/game-builder"

if [ ! -d "$SRC" ]; then
  echo "❌ 스킬 폴더를 못 찾음: $SRC"
  echo "   이 스크립트는 repo 루트에서 실행하세요."
  exit 1
fi

mkdir -p "$DEST_DIR"
rm -rf "$DEST"
cp -r "$SRC" "$DEST"

echo "✅ 설치 완료 → $DEST"
echo ""
echo "사용법: 아무 폴더에서 Claude Code 열고"
echo "  \"게임 만들어줘 — 좀비 디펜스\"  또는  /game-builder 좀비 디펜스"
echo ""
echo "엔진은 본인 Claude 구독으로 동작합니다. 별도 키/설정 불필요."
