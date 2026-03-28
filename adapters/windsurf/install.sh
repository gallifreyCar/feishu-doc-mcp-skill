#!/bin/bash
# Install feishu-doc-mcp rules for Windsurf
# Usage: ./install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

echo "Installing feishu-doc-mcp rules for Windsurf to: $PROJECT_ROOT"

# Copy .windsurfrules to project root
cp "$SKILL_ROOT/adapters/windsurf/.windsurfrules" "$PROJECT_ROOT/"

# Copy scripts
mkdir -p "$PROJECT_ROOT/scripts"
cp "$SKILL_ROOT/skill/scripts/feishu_mcp_doc.py" "$PROJECT_ROOT/scripts/"
chmod +x "$PROJECT_ROOT/scripts/feishu_mcp_doc.py"

echo "✅ Installation complete!"
echo ""
echo "Files installed:"
echo "  - $PROJECT_ROOT/.windsurfrules"
echo "  - $PROJECT_ROOT/scripts/feishu_mcp_doc.py"
echo ""
echo "Next steps:"
echo "1. Set environment variables:"
echo "   export FEISHU_APP_ID=\"your_app_id\""
echo "   export FEISHU_APP_SECRET=\"your_app_secret\""
echo ""
echo "2. Restart Windsurf to load the new rules"
