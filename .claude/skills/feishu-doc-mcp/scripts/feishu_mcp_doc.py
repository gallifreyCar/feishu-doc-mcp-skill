#!/usr/bin/env python3
import argparse
import json
import os
import sys
import urllib.error
import urllib.request
from typing import Any, Dict, Optional


FEISHU_TOKEN_URL = "https://open.feishu.cn/open-apis/auth/v3/tenant_access_token/internal"
FEISHU_MCP_URL = "https://mcp.feishu.cn/mcp"
DEFAULT_ALLOWED_TOOLS = "create-doc,fetch-doc,update-doc,list-docs"


class FeishuMCPError(RuntimeError):
    pass


def get_env(name: str) -> str:
    value = os.environ.get(name)
    if not value:
        raise FeishuMCPError(f"missing required env var: {name}")
    return value


def http_post_json(url: str, data: Dict[str, Any], headers: Dict[str, str]) -> Dict[str, Any]:
    body = json.dumps(data).encode("utf-8")
    req = urllib.request.Request(url, data=body, headers=headers)
    try:
        with urllib.request.urlopen(req, timeout=30) as resp:
            return json.loads(resp.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        payload = e.read().decode("utf-8", errors="replace")
        raise FeishuMCPError(f"http {e.code}: {payload}") from e


def get_tenant_access_token() -> str:
    app_id = get_env("FEISHU_APP_ID")
    app_secret = get_env("FEISHU_APP_SECRET")
    result = http_post_json(
        FEISHU_TOKEN_URL,
        {"app_id": app_id, "app_secret": app_secret},
        {"Content-Type": "application/json"},
    )
    if result.get("code") != 0:
        raise FeishuMCPError(f"get token failed: {json.dumps(result, ensure_ascii=False)}")
    token = result.get("tenant_access_token")
    if not token:
        raise FeishuMCPError("tenant_access_token missing in response")
    return token


def mcp_call(
    method: str,
    params: Optional[Dict[str, Any]] = None,
    allowed_tools: str = DEFAULT_ALLOWED_TOOLS,
    request_id: int = 1,
) -> Dict[str, Any]:
    tat = os.environ.get("FEISHU_TENANT_ACCESS_TOKEN") or get_tenant_access_token()
    payload: Dict[str, Any] = {"jsonrpc": "2.0", "id": request_id, "method": method}
    if params is not None:
        payload["params"] = params
    result = http_post_json(
        FEISHU_MCP_URL,
        payload,
        {
            "Content-Type": "application/json",
            "X-Lark-MCP-TAT": tat,
            "X-Lark-MCP-Allowed-Tools": allowed_tools,
        },
    )
    if "error" in result:
        raise FeishuMCPError(f"mcp error: {json.dumps(result['error'], ensure_ascii=False)}")
    return result


def tool_call(name: str, arguments: Dict[str, Any], request_id: int = 2) -> Dict[str, Any]:
    return mcp_call(
        "tools/call",
        {"name": name, "arguments": arguments},
        request_id=request_id,
    )


def print_json(data: Any) -> None:
    print(json.dumps(data, ensure_ascii=False, indent=2))


def cmd_init(_: argparse.Namespace) -> None:
    print_json(mcp_call("initialize"))


def cmd_tools(_: argparse.Namespace) -> None:
    print_json(mcp_call("tools/list"))


def cmd_create(args: argparse.Namespace) -> None:
    payload: Dict[str, Any] = {"title": args.title, "markdown": args.markdown}
    if args.folder_token:
        payload["folder_token"] = args.folder_token
    if args.wiki_node:
        payload["wiki_node"] = args.wiki_node
    if args.wiki_space:
        payload["wiki_space"] = args.wiki_space
    print_json(tool_call("create-doc", payload))


def cmd_fetch(args: argparse.Namespace) -> None:
    payload: Dict[str, Any] = {"doc_id": args.doc_id}
    if args.limit is not None:
        payload["limit"] = args.limit
    if args.offset is not None:
        payload["offset"] = args.offset
    print_json(tool_call("fetch-doc", payload))


def cmd_update(args: argparse.Namespace) -> None:
    payload: Dict[str, Any] = {"doc_id": args.doc_id, "mode": args.mode}
    if args.markdown is not None:
        payload["markdown"] = args.markdown
    if args.new_title:
        payload["new_title"] = args.new_title
    if args.selection_by_title:
        payload["selection_by_title"] = args.selection_by_title
    if args.selection_with_ellipsis:
        payload["selection_with_ellipsis"] = args.selection_with_ellipsis
    print_json(tool_call("update-doc", payload))


def cmd_list_docs(args: argparse.Namespace) -> None:
    payload: Dict[str, Any] = {"my_library": args.my_library}
    if args.doc_id:
        payload["doc_id"] = args.doc_id
    if args.page_size is not None:
        payload["page_size"] = args.page_size
    if args.page_token:
        payload["page_token"] = args.page_token
    print_json(tool_call("list-docs", payload))


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="Minimal Feishu MCP doc client")
    subparsers = parser.add_subparsers(dest="command", required=True)

    init_parser = subparsers.add_parser("init", help="Initialize MCP session")
    init_parser.set_defaults(func=cmd_init)

    tools_parser = subparsers.add_parser("tools", help="List enabled tools")
    tools_parser.set_defaults(func=cmd_tools)

    create_parser = subparsers.add_parser("create", help="Create a Feishu doc")
    create_parser.add_argument("--title", required=True)
    create_parser.add_argument("--markdown", required=True)
    create_parser.add_argument("--folder-token")
    create_parser.add_argument("--wiki-node")
    create_parser.add_argument("--wiki-space")
    create_parser.set_defaults(func=cmd_create)

    fetch_parser = subparsers.add_parser("fetch", help="Fetch a Feishu doc")
    fetch_parser.add_argument("--doc-id", required=True)
    fetch_parser.add_argument("--limit", type=int)
    fetch_parser.add_argument("--offset", type=int)
    fetch_parser.set_defaults(func=cmd_fetch)

    update_parser = subparsers.add_parser("update", help="Update a Feishu doc")
    update_parser.add_argument("--doc-id", required=True)
    update_parser.add_argument(
        "--mode",
        required=True,
        choices=[
            "overwrite",
            "append",
            "replace_range",
            "replace_all",
            "insert_before",
            "insert_after",
            "delete_range",
        ],
    )
    update_parser.add_argument("--markdown")
    update_parser.add_argument("--new-title")
    update_parser.add_argument("--selection-by-title")
    update_parser.add_argument("--selection-with-ellipsis")
    update_parser.set_defaults(func=cmd_update)

    list_parser = subparsers.add_parser("list-docs", help="List Feishu docs")
    list_parser.add_argument("--my-library", action="store_true")
    list_parser.add_argument("--doc-id")
    list_parser.add_argument("--page-size", type=int)
    list_parser.add_argument("--page-token")
    list_parser.set_defaults(func=cmd_list_docs)

    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    try:
        args.func(args)
        return 0
    except FeishuMCPError as e:
        print(str(e), file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
