# Feishu Doc MCP Skill

[English](./README.md) | [简体中文](./README.zh-CN.md) | 日本語

これは Feishu クラウドドキュメントを AI Agent から扱うための、Skill 中心のリポジトリです。

主役は Python スクリプト単体ではありません。
主役は、すぐに導入して使える Skill です。

## これは何か

- Codex ですぐ使える Feishu ドキュメント Skill
- 将来的に他の Agent にも移植しやすい Skill パッケージ
- Skill に同梱された Feishu MCP helper スクリプト

## これは何ではないか

- ローカル MCP サーバーではありません
- 単なる Python ツール集ではありません
- 一つの Agent だけに縛られるものでもありません

Feishu はすでにホスト型 MCP を提供しています:

- `https://mcp.feishu.cn/mcp`

このリポジトリは、その上で使う Agent 側の Skill をまとめたものです。

## なぜ Skill 優先なのか

スクリプト自体は誰でも書けます。
でも現場で再利用しやすいのは次のようなものです。

- 明確な Skill の入口
- 安全なデフォルト手順
- 再利用しやすい説明
- 統一された環境変数
- Agent がそのまま使える構成

## 現在のフォーカス

今は Codex 向け Skill を最初の形として提供します。

含まれるもの:

- Skill 説明
- Feishu MCP helper スクリプト
- 多言語ドキュメント

## 構成

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

## クイックスタート

1. Skill を Agent 環境に導入する
2. Feishu の環境変数を設定する
3. Feishu ドキュメント操作時に Agent からこの Skill を使う

```bash
export FEISHU_APP_ID="your_app_id"
export FEISHU_APP_SECRET="your_app_secret"
```

## スクリプトについて

helper スクリプトは Skill の実行を安定させるために同梱されています。

ただし主役はスクリプトではありません。
主役は Skill です。

## License

MIT
