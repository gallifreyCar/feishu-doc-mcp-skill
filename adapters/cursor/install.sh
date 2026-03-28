#!/bin/bash
# Install feishu-doc-mcp rule for Cursor
# Usage: ./install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

INSTALL_DIR="$PROJECT_ROOT/.cursor/rules"

echo "Installing feishu-doc-mcp rule for Cursor to: $INSTALL_DIR"

mkdir -p "$INSTALL_DIR"
mkdir -p "$PROJECT_ROOT/scripts"

# Copy rule file
cp "$SKILL_ROOT/adapters/cursor/feishu-doc-mcp.md" "$INSTALL_DIR/"

# Copy scripts to project root
cp "$SKILL_ROOT/skill/scripts/feishu_mcp_doc.py" "$PROJECT_ROOT/scripts/"
chmod +x "$PROJECT_ROOT/scripts/feishu_mcp_doc.py"

echo "✅ Installation complete!"
echo ""
echo "Files installed:"
echo "  - $INSTALL_DIR/feishu-doc-mcp.md"
echo "  - $PROJECT_ROOT/scripts/feishu_mcp_doc.py"
echo ""
echo "Next steps:"
echo "1. Set environment variables:"
echo "   export FEISHU_APP_ID=\"your_app_id\""
echo "   export FEISHU_APP_SECRET=\"your_app_secret\""
echo ""
echo "2. Restart Cursor to load the new rule"
