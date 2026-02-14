#!/usr/bin/env python3
"""Filter claude stream-json output to show readable progress.

Reads stream-json (one JSON object per line) from stdin, emits human-readable
progress lines to stdout.  Designed to sit in a pipeline:

    claude ... --output-format stream-json 2>&1 | tee raw.log | python3 -u log-handler.py
"""
import sys
import json

MAX_RESULT = 500  # max chars for a tool result summary

def summarize_tool_result(content):
    """Extract a readable summary from a tool_result content field."""
    if isinstance(content, str):
        text = content.strip()
    elif isinstance(content, list):
        # content is an array of blocks
        parts = []
        for block in content:
            if isinstance(block, dict):
                if block.get("type") == "text":
                    parts.append(block.get("text", ""))
                elif block.get("type") == "tool_result":
                    parts.append(block.get("content", ""))
            elif isinstance(block, str):
                parts.append(block)
        text = "\n".join(parts).strip()
    else:
        text = str(content).strip()
    if len(text) > MAX_RESULT:
        text = text[:MAX_RESULT] + "..."
    return text

for line in sys.stdin:
    line = line.strip()
    if not line:
        continue
    try:
        msg = json.loads(line)
    except json.JSONDecodeError:
        continue
    t = msg.get("type")

    if t == "system" and msg.get("subtype") == "init":
        model = msg.get("model", "?")
        print(f"\n=== init model={model} ===\n", flush=True)

    elif t == "assistant" and "message" in msg:
        for block in msg["message"].get("content", []):
            if block.get("type") == "thinking":
                text = block.get("thinking", "")
                if text:
                    for tl in text.splitlines():
                        print(f"  💭 {tl}", flush=True)
            elif block.get("type") == "text":
                print(block["text"], flush=True)
            elif block.get("type") == "tool_use":
                name = block.get("name", "?")
                inp = block.get("input", {})
                if name == "Bash":
                    cmd = inp.get("command", "")
                    if len(cmd) > 120:
                        cmd = cmd[:120] + "..."
                    print(f"  -> Bash: {cmd}", flush=True)
                elif name == "Read":
                    print(f"  -> Read: {inp.get('file_path', '?')}", flush=True)
                elif name == "Write":
                    print(f"  -> Write: {inp.get('file_path', '?')}", flush=True)
                elif name == "Edit":
                    print(f"  -> Edit: {inp.get('file_path', '?')}", flush=True)
                elif name in ("Grep", "Glob"):
                    print(f"  -> {name}: {inp.get('pattern', '?')}", flush=True)
                elif name == "WebFetch":
                    print(f"  -> WebFetch: {inp.get('url', '?')}", flush=True)
                elif name == "Task":
                    print(f"  -> Task: {inp.get('description', '?')}", flush=True)
                else:
                    print(f"  -> {name}()", flush=True)

    elif t == "user" and "message" in msg:
        for block in msg["message"].get("content", []):
            if isinstance(block, dict) and block.get("type") == "tool_result":
                is_error = block.get("is_error", False)
                content = block.get("content", "")
                summary = summarize_tool_result(content)
                prefix = "  ✗ " if is_error else "  <- "
                if summary:
                    for rl in summary.splitlines():
                        print(f"{prefix}{rl}", flush=True)

    elif t == "result":
        cost = msg.get("total_cost_usd", msg.get("cost_usd", "?"))
        duration = msg.get("duration_ms", 0) / 1000
        turns = msg.get("num_turns", "?")
        status = "OK" if msg.get("subtype") == "success" else "FAIL"
        print(f"\n--- {status} turns={turns} cost=${cost} time={duration:.0f}s ---", flush=True)
