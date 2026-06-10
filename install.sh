#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/codexskills/skill-builder.git"
SKILL_DIR="stackforge"
DEST="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/skills/stackforge"

echo "Installing StackForge to $DEST"
git clone --depth=1 "$REPO" "$DEST" 2>/dev/null || (cd "$DEST" && git pull)
echo "Done! StackForge installed at $DEST"
echo "Restart OpenCode/Claude Code to load the skill."
