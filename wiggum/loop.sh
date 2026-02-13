#!/usr/bin/env bash
# EHI Export Documentation Collection Loop
#
# Iterates over targets.json, launching one Claude CLI invocation per URL.
# Each gets its own output directory and a filled-in prompt.
#
# Usage:
#   ./wiggum/loop.sh                  # start from the beginning
#   ./wiggum/loop.sh --resume         # skip already-completed targets
#   ./wiggum/loop.sh --index 42       # start from target index 42
#   ./wiggum/loop.sh --only 42        # run only target index 42
#   MAX_CONCURRENT=4 ./wiggum/loop.sh # run up to 4 in parallel (default: 3)
set -euo pipefail

export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$ROOT/wiggum"
TARGETS="$ROOT/wiggum/work/targets.json"
PROMPT_TEMPLATE="$ROOT/wiggum/prompt.md"
RESULTS_DIR="$ROOT/wiggum/results"
LOG_DIR="$ROOT/wiggum/logs"

MAX_CONCURRENT="${MAX_CONCURRENT:-3}"

# LLM backend: "claude" (default), "shelley", or "gemini"
LLM_BACKEND="${LLM_BACKEND:-claude}"

# Claude settings
CLAUDE_MODEL="${CLAUDE_MODEL:-sonnet}"
CLAUDE_BUDGET="${CLAUDE_BUDGET:-2.00}"

# Shelley settings
SHELLEY_PROMPT="${SHELLEY_PROMPT:-$CONFIG_DIR/shelley-prompt.ts}"
SHELLEY_SERVER="${SHELLEY_SERVER:-http://localhost:9999}"
SHELLEY_MODEL="${SHELLEY_MODEL:-}"
SHELLEY_USER="${SHELLEY_USER:-wiggum}"

# Gemini settings
GEMINI_MODEL="${GEMINI_MODEL:-gemini-3-pro-preview}"

# Run LLM — dispatches based on LLM_BACKEND.
# Prompt comes via stdin. First arg is working directory.
run_llm() {
  local cwd="$1"
  case "$LLM_BACKEND" in
    claude)
      cd "$cwd"
      claude -p --dangerously-skip-permissions \
        --model "$CLAUDE_MODEL" \
        --max-budget-usd "$CLAUDE_BUDGET"
      ;;
    shelley)
      local args=("$SHELLEY_PROMPT" -server "$SHELLEY_SERVER" -cwd "$cwd" -user "$SHELLEY_USER" -v)
      if [[ -n "$SHELLEY_MODEL" ]]; then
        args+=(-model "$SHELLEY_MODEL")
      fi
      "${args[@]}"
      ;;
    gemini)
      cd "$cwd"
      gemini -p "" --yolo --output-format text --model "$GEMINI_MODEL"
      ;;
    *)
      echo "Unknown LLM_BACKEND: $LLM_BACKEND" >&2
      return 1
      ;;
  esac
}

# Parse args
RESUME=false
START_INDEX=0
ONLY_INDEX=""
while [[ $# -gt 0 ]]; do
  case $1 in
    --resume) RESUME=true; shift ;;
    --index) START_INDEX="$2"; shift 2 ;;
    --only) ONLY_INDEX="$2"; shift 2 ;;
    *) echo "Unknown arg: $1"; exit 1 ;;
  esac
done

mkdir -p "$RESULTS_DIR" "$LOG_DIR"

if [[ ! -f "$TARGETS" ]]; then
  echo "No targets.json found. Run 00-fetch-export-urls.sh first."
  exit 1
fi

TOTAL=$(jq 'length' "$TARGETS")
echo "=== EHI Export Documentation Collection ==="
echo "Backend:     $LLM_BACKEND"
case "$LLM_BACKEND" in
  claude)  echo "Model:       $CLAUDE_MODEL (budget \$$CLAUDE_BUDGET)" ;;
  shelley) echo "Server:      $SHELLEY_SERVER (model: ${SHELLEY_MODEL:-default})" ;;
  gemini)  echo "Model:       $GEMINI_MODEL" ;;
esac
echo "Targets:     $TOTAL unique URLs"
echo "Concurrency: $MAX_CONCURRENT"
echo "Results:     $RESULTS_DIR/"
echo ""

# Slug-ify a vendor name
slugify() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]\+/-/g' | sed 's/^-\|-$//g' | cut -c1-60
}

# Track running jobs
declare -A PIDS
RUNNING=0
COMPLETED=0
FAILED=0
SKIPPED=0

wait_for_slot() {
  while (( RUNNING >= MAX_CONCURRENT )); do
    for slug in "${!PIDS[@]}"; do
      pid=${PIDS[$slug]}
      if ! kill -0 "$pid" 2>/dev/null; then
        wait "$pid" && {
          echo "  ✓ $slug completed"
          COMPLETED=$((COMPLETED + 1))
        } || {
          echo "  ✗ $slug failed (exit $?)"
          FAILED=$((FAILED + 1))
        }
        unset PIDS[$slug]
        RUNNING=$((RUNNING - 1))
      fi
    done
    if (( RUNNING >= MAX_CONCURRENT )); then
      sleep 5
    fi
  done
}

wait_for_all() {
  for slug in "${!PIDS[@]}"; do
    pid=${PIDS[$slug]}
    wait "$pid" && {
      echo "  ✓ $slug completed"
      COMPLETED=$((COMPLETED + 1))
    } || {
      echo "  ✗ $slug failed (exit $?)"
      FAILED=$((FAILED + 1))
    }
    unset PIDS[$slug]
    RUNNING=$((RUNNING - 1))
  done
}

launch_one() {
  local idx="$1"
  local target
  target=$(jq -c ".[${idx}]" "$TARGETS")

  local url developers products chpl_ids slug output_dir
  url=$(echo "$target" | jq -r '.url')
  developers=$(echo "$target" | jq -r '.developers | join(", ")')
  products=$(echo "$target" | jq -r '.products | join(", ")')
  chpl_ids=$(echo "$target" | jq -r '.chpl_ids | map(tostring) | join(", ")')
  slug=$(slugify "$(echo "$target" | jq -r '.developers[0]')")

  # If multiple vendors share the same URL, include index to avoid collision
  local dev_count
  dev_count=$(echo "$target" | jq '.developers | length')
  if (( dev_count > 1 )); then
    slug="${slug}-and-others-${idx}"
  fi

  output_dir="$RESULTS_DIR/$slug"

  # Skip if already done (has analysis.json)
  if [[ "$RESUME" == true && -f "$output_dir/analysis.json" ]]; then
    echo "[$idx/$TOTAL] SKIP $slug (already has analysis.json)"
    SKIPPED=$((SKIPPED + 1))
    return
  fi

  mkdir -p "$output_dir/downloads"

  # Build prompt from template
  local prompt
  prompt=$(sed \
    -e "s|{{URL}}|${url}|g" \
    -e "s|{{DEVELOPERS}}|${developers}|g" \
    -e "s|{{PRODUCTS}}|${products}|g" \
    -e "s|{{CHPL_IDS}}|${chpl_ids}|g" \
    -e "s|{{OUTPUT_DIR}}|${output_dir}|g" \
    "$PROMPT_TEMPLATE")

  echo "[$idx/$TOTAL] LAUNCH $slug ($LLM_BACKEND)"
  echo "  URL: $url"
  echo "  Developer(s): $developers"
  echo "  Output: $output_dir/"

  # Launch LLM in background — prompt via stdin
  run_llm "$ROOT" <<< "$prompt" \
    > "$LOG_DIR/${slug}.log" 2>&1 &

  PIDS[$slug]=$!
  RUNNING=$((RUNNING + 1))
}

# Main loop
if [[ -n "$ONLY_INDEX" ]]; then
  launch_one "$ONLY_INDEX"
  wait_for_all
else
  for (( i=START_INDEX; i<TOTAL; i++ )); do
    wait_for_slot
    launch_one "$i"
  done
  echo ""
  echo "All launched. Waiting for remaining jobs..."
  wait_for_all
fi

echo ""
echo "=== Done ==="
echo "Completed: $COMPLETED"
echo "Failed:    $FAILED"
echo "Skipped:   $SKIPPED"
echo "Results in: $RESULTS_DIR/"
