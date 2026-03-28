# Feishu Doc MCP Skill

[English](./README.md) | [简体中文](./README.zh-CN.md) | 日本語

---

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
| [Claude Code](https://claude.ai/code) | `SKILL.md` | `./install.sh claude-code` |
| [Cursor](https://cursor.com) | `.cursor/rules/*.md` | `./install.sh cursor` |
| [Roo Code](https://roocode.com) | `.roomodes` | `./install.sh roo-code` |
| [Windsurf](https://codeium.com/windsurf) | `.windsurfrules` | `./install.sh windsurf` |

### クイックスタート

#### 1. Feishu認証情報の取得

1. [Feishu Open Platform](https://open.feishu.cn) にアクセス
2. アプリを作成または既存のアプリを使用
3. `App ID` と `App Secret` を取得

#### 2. スキルのインストール

```bash
# リポジトリをクローン
git clone https://github.com/gallifreyCar/feishu-doc-mcp-skill.git
cd feishu-doc-mcp-skill

# エージェントを選択してインストール
./install.sh claude-code    # Claude Code
./install.sh cursor          # Cursor
./install.sh roo-code        # Roo Code
./install.sh windsurf        # Windsurf
./install.sh all             # 全エージェントにインストール
```

#### 3. 環境変数の設定

```bash
export FEISHU_APP_ID="your_app_id"
export FEISHU_APP_SECRET="your_app_secret"
```

#### 4. 使用方法

AIエージェントにFeishuドキュメントの操作を指示：

> "Feishuドキュメント https://www.feishu.cn/docx/xxx を読んで"

### 更新モード

| モード | 説明 | 使用ケース |
|--------|------|------------|
| `append` | 末尾に追加 | 新しいセクションの追加 |
| `replace_range` | セクションを置換 | 特定部分の更新 |
| `insert_before` | マッチ前に挿入 | セクション前に追加 |
| `insert_after` | マッチ後に挿入 | セクション後に追加 |
| `overwrite` | 完全置換 | ドキュメント全体を再構築 |

### ディレクトリ構成

```
feishu-doc-mcp-skill/
├── README.md
├── install.sh                 # 統合インストーラー
├── skill/
│   ├── SKILL.md              # コアスキル定義
│   └── scripts/
│       └── feishu_mcp_doc.py # Pythonヘルパー
└── adapters/
    ├── claude-code/          # Claude Codeアダプター
    ├── cursor/               # Cursorアダプター
    ├── roo-code/             # Roo Codeアダプター
    └── windsurf/             # Windsurfアダプター
```

### トラブルシューティング

**Q: 書き込み時に `forbidden` エラー**

A: アプリに書き込み権限がない可能性。確認：
- アプリが対象ドキュメント/Wikiにアクセス可能か
- アプリに書き込み権限があるか（読み取りだけではない）
- ドキュメントがロックされていないか

**Q: 接続確認方法**

A: ヘルパースクリプトを直接実行：
```bash
python3 scripts/feishu_mcp_doc.py init
python3 scripts/feishu_mcp_doc.py tools
```

---

## License

MIT License - [LICENSE](LICENSE) を参照

## コントリビュート

IssueやPull Requestをお待ちしています！

## リンク

- [Feishu Open Platform](https://open.feishu.cn)
- [Feishu MCP Documentation](https://open.feishu.cn/document/client-docs/ai-tools/mcp)
- [Agent Skills Standard](https://agentskills.io)