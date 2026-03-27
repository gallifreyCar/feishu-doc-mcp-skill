# Feishu Doc MCP Skill

[English](./README.md) | 简体中文 | [日本語](./README.ja.md)

这是一个以 Skill 为中心的仓库，用来让 AI Agent 直接读写飞书云文档。

这个仓库的重点不是某个 Python 程序本身。
重点是：让大家安装或复制一个现成可用的 Skill，然后用统一方式接入飞书文档能力。

## 这是什么

- 一个可直接给 Codex 使用的飞书文档 Skill
- 一个以后可以迁移到其他 Agent 的 Skill 方案
- 一个作为 Skill 内置 helper 的 Feishu MCP 脚本

## 这不是什么

- 不是本地 MCP Server
- 不是“只是一个 Python 小工具”
- 不是只给某一个 Agent 永久绑定

飞书官方已经提供了托管的 MCP 服务：

- `https://mcp.feishu.cn/mcp`

这个仓库做的事情，是把 Agent 侧真正需要复用的 Skill 封装出来。

## 为什么要做成 Skill 优先

程序谁都能写，但真正难复用的点通常不是代码，而是：

- 有没有统一入口
- 有没有稳定的使用方式
- 有没有安全默认值
- 有没有清晰的环境变量约定
- 能不能被 Agent 直接拿来用

所以这个仓库把重点放在：

- Skill 说明
- Skill 工作流
- Skill 内置 helper
- 可迁移到其他 Agent 的组织方式

## 当前定位

当前版本先以 Codex Skill 为第一落点。

仓库里包括：

- Skill 说明文件
- Feishu MCP helper 脚本
- 多语言说明文档

## 仓库结构

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

## 快速开始

1. 把 Skill 安装或复制到 Agent 环境里
2. 配置飞书环境变量
3. 让 Agent 在处理飞书文档任务时调用这个 Skill

示例环境变量：

```bash
export FEISHU_APP_ID="your_app_id"
export FEISHU_APP_SECRET="your_app_secret"
```

## 关于脚本

仓库里保留 helper 脚本，是为了让 Skill 在执行时更稳定、更可复用。

但脚本不是这个仓库的主角。
Skill 才是这个仓库的主角。

## 当前支持的能力

- 初始化 Feishu MCP
- 列出工具
- 读取文档
- 创建文档
- 更新文档
- 排查常见权限问题

## 安全说明

- 不要把 app secret 或 access token 提交到仓库
- 一律通过环境变量传入
- 一旦泄露，立即轮换
- 能读不代表能写

## 后续方向

这个仓库后面可以继续扩展到：

- Claude 系 Agent Skill
- GitHub Copilot Agent 包装层
- 内部多 Agent 平台

## License

MIT
