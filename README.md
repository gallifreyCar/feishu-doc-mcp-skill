# Feishu Doc MCP Skill

English | [简体中文](./README.zh-CN.md) | [日本語](./README.ja.md)

This repository is a skill-first package for using Feishu cloud documents from AI agents.

Its main purpose is not the Python helper itself.
Its main purpose is to let agents install or copy a ready-to-use skill, then read and write Feishu docs with a consistent workflow.

## What this repo is

- A Codex-ready skill for Feishu document operations
- A reusable skill pattern that can be adapted to other agents later
- A bundled helper script used by the skill

## What this repo is not

- Not a local MCP server
- Not just a standalone Python utility
- Not limited to one agent forever

Feishu already provides the hosted MCP endpoint:

- `https://mcp.feishu.cn/mcp`

This repository packages the agent-side skill around that capability.

## Why a skill-first repo

Anyone can write a one-off script.
What teams usually need is something easier to adopt:

- a clear skill entrypoint
- a safe default workflow
- reusable instructions
- consistent env vars
- a bundled helper for reliability

That makes the skill more portable across teams and eventually across agents such as Codex, Claude-based environments, GitHub Copilot workflows, or internal wrappers.

## Current Focus

Today this repo ships a Codex-style skill first.

It includes:

- skill instructions
- a bundled Feishu MCP helper script
- multilingual docs

## Repository Layout

```text
.
├── README.md
├── README.zh-CN.md
├── README.ja.md
├── LICENSE
├── .gitignore
├── skill/
│   ├── SKILL.md
│   └── scripts/
│       └── feishu_mcp_doc.py
└── examples/
    └── env.example
```

## Quick Start

1. Copy or install the skill into your agent environment.
2. Set Feishu credentials through environment variables.
3. Let the agent use the skill for Feishu doc read/write tasks.

Example env vars:

```bash
export FEISHU_APP_ID="your_app_id"
export FEISHU_APP_SECRET="your_app_secret"
```

## Helper Script

The helper script is included because deterministic tool execution is useful.

But the script is not the product center.
The skill is the product center.

## Supported Workflow

- initialize Feishu MCP
- list tools
- fetch docs
- create docs
- update docs
- diagnose common permission issues

## Security Notes

- Never commit app secrets or access tokens
- Use env vars only
- Rotate any leaked secret immediately
- Read permission and write permission may differ

## Future Direction

This repository is designed so the skill can later be adapted to:

- Claude-oriented skill packs
- GitHub Copilot agent wrappers
- internal multi-agent platforms

## License

MIT
