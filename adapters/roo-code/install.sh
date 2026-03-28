#!/bin/bash
# Install feishu-doc-mcp mode for Roo Code
# Usage: ./install.sh [--global]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

if [ "$1" == "--global" ]; then
    # Install to global settings
    CONFIG_DIR="$HOME/.roo"
    echo "Installing feishu-doc-mcp mode globally to: $CONFIG_DIR"
    mkdir -p "$CONFIG_DIR"
    
    # For global mode, we need to merge with existing custom_modes.yaml
    if [ -f "$CONFIG_DIR/custom_modes.yaml" ]; then
        echo "Warning: $CONFIG_DIR/custom_modes.yaml already exists."
        echo "Please manually merge the mode definition from:"
        echo "  $SKILL_ROOT/adapters/roo-code/.roomodes"
    else
        cp "$SKILL_ROOT/adapters/roo-code/.roomodes" "$CONFIG_DIR/custom_modes.yaml"
    fi
else
    # Install to current project
    PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
    echo "Installing feishu-doc-mcp mode to project: $PROJECT_ROOT"
    
    # Copy .roomodes to project root
    cp "$SKILL_ROOT/adapters/roo-code/.roomodes" "$PROJECT_ROOT/.roomodes"
    
    # Copy scripts
    mkdir -p "$PROJECT_ROOT/scripts"
    cp "$SKILL_ROOT/skill/scripts/feishu_mcp_doc.py" "$PROJECT_ROOT/scripts/"
    chmod +x "$PROJECT_ROOT/scripts/feishu_mcp_doc.py"
fi

echo "✅ Installation complete!"
echo ""
echo "Next steps:"
echo "1. Set environment variables:"
echo "   export FEISHU_APP_ID=\"your_app_id\""
echo "   export FEISHU_APP_SECRET=\"your_app_secret\""
echo ""
echo "2. Switch to feishu-doc-mcp mode in Roo Code"
