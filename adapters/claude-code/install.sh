#!/bin/bash
# Install feishu-doc-mcp skill for Claude Code
# Usage: ./install.sh [--project]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

if [ "$1" == "--project" ]; then
    # Install to current project
    INSTALL_DIR=".claude/skills/feishu-doc-mcp"
else
    # Install to user global skills
    INSTALL_DIR="$HOME/.claude/skills/feishu-doc-mcp"
fi

echo "Installing feishu-doc-mcp skill to: $INSTALL_DIR"

mkdir -p "$INSTALL_DIR/scripts"

# Copy SKILL.md
cp "$SKILL_ROOT/skill/SKILL.md" "$INSTALL_DIR/"

# Copy scripts
cp "$SKILL_ROOT/skill/scripts/feishu_mcp_doc.py" "$INSTALL_DIR/scripts/"
chmod +x "$INSTALL_DIR/scripts/feishu_mcp_doc.py"

echo "✅ Installation complete!"
echo ""
echo "Next steps:"
echo "1. Set environment variables:"
echo "   export FEISHU_APP_ID=\"your_app_id\""
echo "   export FEISHU_APP_SECRET=\"your_app_secret\""
echo ""
echo "2. Test the skill in Claude Code:"
echo "   /feishu-doc-mcp"
