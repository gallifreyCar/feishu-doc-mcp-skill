# Feishu Doc MCP Skill

[English](./README.md) | 简体中文 | [日本語](./README.ja.md)

---

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
| [Claude Code](https://claude.ai/code) | `SKILL.md` | `./install.sh claude-code` |
| [Cursor](https://cursor.com) | `.cursor/rules/*.md` | `./install.sh cursor` |
| [Roo Code](https://roocode.com) | `.roomodes` | `./install.sh roo-code` |
| [Windsurf](https://codeium.com/windsurf) | `.windsurfrules` | `./install.sh windsurf` |

### 快速开始

#### 1. 获取飞书凭证

1. 访问 [飞书开放平台](https://open.feishu.cn)
2. 创建应用或使用现有应用
3. 获取 `App ID` 和 `App Secret`

#### 2. 安装 Skill

```bash
# 克隆仓库
git clone https://github.com/gallifreyCar/feishu-doc-mcp-skill.git
cd feishu-doc-mcp-skill

# 安装到你使用的 Agent
./install.sh claude-code    # Claude Code
./install.sh cursor          # Cursor
./install.sh roo-code        # Roo Code
./install.sh windsurf        # Windsurf
./install.sh all             # 安装所有 Agent
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

### 目录结构

```
feishu-doc-mcp-skill/
├── README.md
├── install.sh                 # 统一安装脚本
├── skill/
│   ├── SKILL.md              # 核心 Skill 定义
│   └── scripts/
│       └── feishu_mcp_doc.py # Python 辅助脚本
└── adapters/
    ├── claude-code/          # Claude Code 适配器
    ├── cursor/               # Cursor 适配器
    ├── roo-code/             # Roo Code 适配器
    └── windsurf/             # Windsurf 适配器
```

### 常见问题

**Q: 写入时出现 `forbidden` 错误**

A: 应用可能缺少写入权限。检查：
- 应用是否有目标文档/知识库的访问权限
- 应用是否有写入权限（不只是读取）
- 文档是否被锁定

**Q: 如何验证连接？**

A: 直接运行辅助脚本：
```bash
python3 scripts/feishu_mcp_doc.py init
python3 scripts/feishu_mcp_doc.py tools
```

---

## License

MIT License - 详情见 [LICENSE](LICENSE)

## 贡献

欢迎提交 Issue 和 Pull Request！

## 链接

- [飞书开放平台](https://open.feishu.cn)
- [飞书 MCP 文档](https://open.feishu.cn/document/client-docs/ai-tools/mcp)
- [Agent Skills 标准](https://agentskills.io)