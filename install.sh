#!/bin/bash
# Universal installer for feishu-doc-mcp skill
# Usage: ./install.sh [agent] [options]
#
# Agents:
#   claude-code    Install for Claude Code (default: global, --project for project)
#   cursor         Install for Cursor IDE
#   roo-code       Install for Roo Code (default: project, --global for global)
#   windsurf       Install for Windsurf IDE
#   all            Install for all supported agents

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_help() {
    echo "Feishu Doc MCP Skill Installer"
    echo ""
    echo "Usage: ./install.sh <agent> [options]"
    echo ""
    echo "Agents:"
    echo "  claude-code    Install for Claude Code"
    echo "  cursor         Install for Cursor IDE"
    echo "  roo-code       Install for Roo Code / Cline"
    echo "  windsurf       Install for Windsurf IDE"
    echo "  all            Install for all supported agents"
    echo ""
    echo "Options:"
    echo "  --project      Install to current project (claude-code, roo-code)"
    echo "  --global       Install globally (roo-code)"
    echo "  --help         Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./install.sh claude-code              # Install globally for Claude Code"
    echo "  ./install.sh claude-code --project    # Install to current project"
    echo "  ./install.sh cursor                   # Install for Cursor"
    echo "  ./install.sh all                      # Install for all agents"
}

install_claude_code() {
    local project_mode=""
    if [ "$1" == "--project" ]; then
        project_mode="--project"
    fi
    "$SCRIPT_DIR/adapters/claude-code/install.sh" $project_mode
}

install_cursor() {
    "$SCRIPT_DIR/adapters/cursor/install.sh"
}

install_roo_code() {
    local global_mode=""
    if [ "$1" == "--global" ]; then
        global_mode="--global"
    fi
    "$SCRIPT_DIR/adapters/roo-code/install.sh" $global_mode
}

install_windsurf() {
    "$SCRIPT_DIR/adapters/windsurf/install.sh"
}

install_all() {
    echo "Installing for all supported agents..."
    echo ""
    install_claude_code
    echo ""
    install_cursor
    echo ""
    install_roo_code
    echo ""
    install_windsurf
    echo ""
    echo "🎉 All installations complete!"
}

# Main logic
case "${1:-}" in
    claude-code)
        install_claude_code "${2:-}"
        ;;
    cursor)
        install_cursor
        ;;
    roo-code)
        install_roo_code "${2:-}"
        ;;
    windsurf)
        install_windsurf
        ;;
    all)
        install_all
        ;;
    --help|-h)
        show_help
        ;;
    *)
        echo "Error: Unknown agent '$1'"
        echo ""
        show_help
        exit 1
        ;;
esac
