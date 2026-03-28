# Feishu Doc MCP Skill

[English](#english) | [简体中文](#简体中文) | [日本語](#日本語)

---

<a name="english"></a>
## English

A **multi-agent skill package** for working with Feishu/Lark cloud documents through Feishu's hosted MCP service.

### What This Skill Does

- 📖 **Read** Feishu docs via MCP
- ✨ **Create** new docs from Markdown
- ✏️ **Update** existing docs with multiple modes
- 🔍 **Diagnose** permission issues

### Supported Agents

| Agent | Format | Install Command |
|-------|--------|-----------------|
| [Claude Code](https://claude.ai/code) | `SKILL.md` | `./install.sh claude-code` |
| [Cursor](https://cursor.com) | `.cursor/rules/*.md` | `./install.sh cursor` |
| [Roo Code](https://roocode.com) | `.roomodes` | `./install.sh roo-code` |
| [Windsurf](https://codeium.com/windsurf) | `.windsurfrules` | `./install.sh windsurf` |

### Quick Start

#### 1. Get Feishu Credentials

1. Go to [Feishu Open Platform](https://open.feishu.cn)
2. Create an app or use existing one
3. Get `App ID` and `App Secret`

#### 2. Install the Skill

```bash
# Clone or download this repo
git clone https://github.com/gallifreyCar/feishu-doc-mcp-skill.git
cd feishu-doc-mcp-skill

# Install for your agent
./install.sh claude-code    # For Claude Code
./install.sh cursor          # For Cursor
./install.sh roo-code        # For Roo Code
./install.sh windsurf        # For Windsurf
./install.sh all             # Install for all agents
```

#### 3. Set Environment Variables

```bash
export FEISHU_APP_ID="your_app_id"
export FEISHU_APP_SECRET="your_app_secret"
```

#### 4. Use in Your Agent

Just ask your AI agent to work with Feishu docs:

> "Read the Feishu document at https://www.feishu.cn/docx/xxx"

### Update Modes

| Mode | Description | Use Case |
|------|-------------|----------|
| `append` | Add to end | Add new sections |
| `replace_range` | Replace section | Update specific content |
| `insert_before` | Insert before match | Add content before section |
| `insert_after` | Insert after match | Add content after section |
| `overwrite` | Full replace | Rebuild entire doc |

### Directory Structure

```
feishu-doc-mcp-skill/
├── README.md
├── install.sh                 # Universal installer
├── skill/
│   ├── SKILL.md              # Core skill definition
│   └── scripts/
│       └── feishu_mcp_doc.py # Python helper
└── adapters/
    ├── claude-code/          # Claude Code adapter
    ├── cursor/               # Cursor adapter
    ├── roo-code/             # Roo Code adapter
    └── windsurf/             # Windsurf adapter
```

### Troubleshooting

**Q: `forbidden` error when writing**

A: Your app may lack write permission. Check:
- App has access to the target doc/wiki
- App has write permission (not just read)
- Document is not locked

**Q: How to verify connection?**

A: Run the helper script directly:
```bash
python3 scripts/feishu_mcp_doc.py init
python3 scripts/feishu_mcp_doc.py tools
```

---

<a name="简体中文"></a>
## 简体中文

一个**多 Agent 适配的 Skill 包**，用于通过飞书托管的 MCP 服务操作飞书云文档。

### 功能特性

- 📖 **读取** 飞书文档
- ✨ **创建** 新文档（支持 Markdown）
- ✏️ **更新** 现有文档（多种模式）
- 🔍 **诊断** 权限问题

### 支持的 Agent

| Agent | 格式 | 安装命令 |
|-------|------|----------|
| Claude Code | `SKILL.md` | `./install.sh claude-code` |
| Cursor | `.cursor/rules/*.md` | `./install.sh cursor` |
| Roo Code | `.roomodes` | `./install.sh roo-code` |
| Windsurf | `.windsurfrules` | `./install.sh windsurf` |

### 快速开始

#### 1. 获取飞书凭证

1. 访问 [飞书开放平台](https://open.feishu.cn)
2. 创建应用或使用现有应用
3. 获取 `App ID` 和 `App Secret`

#### 2. 安装 Skill

```bash
git clone https://github.com/gallifreyCar/feishu-doc-mcp-skill.git
cd feishu-doc-mcp-skill

# 安装到你使用的 Agent
./install.sh claude-code    # Claude Code
./install.sh cursor          # Cursor
./install.sh roo-code        # Roo Code
./install.sh windsurf        # Windsurf
```

#### 3. 设置环境变量

```bash
export FEISHU_APP_ID="your_app_id"
export FEISHU_APP_SECRET="your_app_secret"
```

#### 4. 开始使用

直接让 AI 操作飞书文档：

> "读取飞书文档 https://www.feishu.cn/docx/xxx"

### 更新模式

| 模式 | 说明 | 使用场景 |
|------|------|----------|
| `append` | 追加到末尾 | 添加新章节 |
| `replace_range` | 替换指定内容 | 更新特定部分 |
| `insert_before` | 在匹配前插入 | 在章节前添加 |
| `insert_after` | 在匹配后插入 | 在章节后添加 |
| `overwrite` | 完全覆盖 | 重建整篇文档 |

---

<a name="日本語"></a>
## 日本語

Feishu/Lark クラウドドキュメントを操作するための**マルチエージェント対応スキルパッケージ**。

### 機能

- 📖 ドキュメントの**読み取り**
- ✨ Markdown からの**新規作成**
- ✏️ 複数モードでの**更新**
- 🔍 権限問題の**診断**

### 対応エージェント

| エージェント | 形式 | インストールコマンド |
|-------------|------|---------------------|
| Claude Code | `SKILL.md` | `./install.sh claude-code` |
| Cursor | `.cursor/rules/*.md` | `./install.sh cursor` |
| Roo Code | `.roomodes` | `./install.sh roo-code` |
| Windsurf | `.windsurfrules` | `./install.sh windsurf` |

### クイックスタート

```bash
# クローン
git clone https://github.com/gallifreyCar/feishu-doc-mcp-skill.git
cd feishu-doc-mcp-skill

# インストール
./install.sh claude-code

# 環境変数設定
export FEISHU_APP_ID="your_app_id"
export FEISHU_APP_SECRET="your_app_secret"
```

---

## License

MIT License - See [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## Links

- [Feishu Open Platform](https://open.feishu.cn)
- [Feishu MCP Documentation](https://open.feishu.cn/document/client-docs/ai-tools/mcp)
- [Agent Skills Standard](https://agentskills.io)
