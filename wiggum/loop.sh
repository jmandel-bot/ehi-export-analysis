#!/usr/bin/env bash
# EHI Export Documentation Collection Loop
#
# Iterates over targets.json, launching one LLM invocation per URL per phase.
# Each gets its own output directory and a filled-in prompt.
#
# Usage:
#   ./wiggum/loop.sh --phase 1               # run phase 1 (research) from beginning
#   ./wiggum/loop.sh --phase 2 --resume      # run phase 2, skip completed
#   ./wiggum/loop.sh --phase both             # run phase 1 then 2 per URL
#   ./wiggum/loop.sh --phase 1 --reverse     # iterate from end of list backwards
#   ./wiggum/loop.sh --phase 1 --index 42    # start from target index 42
#   ./wiggum/loop.sh --phase 1 --only 42     # run only target index 42
#   MAX_CONCURRENT=4 ./wiggum/loop.sh --phase 1  # run up to 4 in parallel
set -euo pipefail

export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$ROOT/wiggum"
TARGETS="$ROOT/work/targets.json"
RESULTS_DIR="$ROOT/results"
LOG_DIR="$ROOT/wiggum/logs"

MAX_CONCURRENT="${MAX_CONCURRENT:-3}"

# LLM backend: "claude" (default), "shelley", or "gemini"
LLM_BACKEND="${LLM_BACKEND:-claude}"

# Claude settings
CLAUDE_MODEL="${CLAUDE_MODEL:-opus}"

# When using "both" phases, this lists the phases to run sequentially per target
BOTH_PHASES=(1 2)

# Shelley settings
SHELLEY_PROMPT="${SHELLEY_PROMPT:-$CONFIG_DIR/shelley-prompt.ts}"
SHELLEY_SERVER="${SHELLEY_SERVER:-http://localhost:9999}"
SHELLEY_MODEL="${SHELLEY_MODEL:-claude-opus-4.6}"  # Always Opus 4.6
SHELLEY_USER="${SHELLEY_USER:-wiggum}"

# Gemini settings
GEMINI_MODEL="${GEMINI_MODEL:-gemini-3-pro-preview}"

# Phase configuration
declare -A PHASE_PROMPT
declare -A PHASE_MARKER
declare -A PHASE_NAME

PHASE_PROMPT[1]="$ROOT/wiggum/prompts/1-research.md"
PHASE_MARKER[1]="product-research.json"
PHASE_NAME[1]="research"

PHASE_PROMPT[2]="$ROOT/wiggum/prompts/2-download.md"
PHASE_MARKER[2]="download-manifest.json"
PHASE_NAME[2]="download"

# Phase 3 placeholder
# PHASE_PROMPT[3]="$ROOT/wiggum/prompts/3-analysis.md"
# PHASE_MARKER[3]="analysis.json"
# PHASE_NAME[3]="analysis"

# Run LLM — dispatches based on LLM_BACKEND.
# Prompt comes via stdin. First arg is working directory.
run_llm() {
  local cwd="$1"
  case "$LLM_BACKEND" in
    claude)
      cd "$cwd"
      claude -p --dangerously-skip-permissions \
        --model "$CLAUDE_MODEL" \
        --output-format stream-json
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
REVERSE=false
START_INDEX=0
ONLY_INDEX=""
PHASE=""
while [[ $# -gt 0 ]]; do
  case $1 in
    --phase) PHASE="$2"; shift 2 ;;
    --resume) RESUME=true; shift ;;
    --reverse) REVERSE=true; shift ;;
    --index) START_INDEX="$2"; shift 2 ;;
    --only) ONLY_INDEX="$2"; shift 2 ;;
    *) echo "Unknown arg: $1"; exit 1 ;;
  esac
done

if [[ -z "$PHASE" ]]; then
  echo "Error: --phase N is required (1=research, 2=download, both)"
  exit 1
fi

MODE_BOTH=false
if [[ "$PHASE" == "both" ]]; then
  MODE_BOTH=true
  PHASE_LABEL="both (research+download)"
  COMPLETION_MARKER="${PHASE_MARKER[2]}"  # fully done when phase 2 marker exists
else
  if [[ -z "${PHASE_PROMPT[$PHASE]:-}" ]]; then
    echo "Error: unknown phase $PHASE"
    exit 1
  fi
  PHASE_LABEL="${PHASE_NAME[$PHASE]}"
  COMPLETION_MARKER="${PHASE_MARKER[$PHASE]}"
fi

# Only set these for single-phase mode
if [[ "$MODE_BOTH" == false ]]; then
  PROMPT_TEMPLATE="${PHASE_PROMPT[$PHASE]}"
fi

mkdir -p "$RESULTS_DIR" "$LOG_DIR"

if [[ ! -f "$TARGETS" ]]; then
  echo "No targets.json found. Run 00-fetch-export-urls.sh first."
  exit 1
fi

TOTAL=$(jq 'length' "$TARGETS")
echo "=== EHI Export Documentation Collection ==="
echo "Phase:       $PHASE ($PHASE_LABEL)"
echo "Backend:     $LLM_BACKEND"
case "$LLM_BACKEND" in
  claude)  echo "Model:       $CLAUDE_MODEL" ;;
  shelley) echo "Server:      $SHELLEY_SERVER (model: ${SHELLEY_MODEL:-default})" ;;
  gemini)  echo "Model:       $GEMINI_MODEL" ;;
esac
echo "Targets:     $TOTAL unique URLs"
echo "Direction:   $(if $REVERSE; then echo "reverse (high→low)"; else echo "forward (low→high)"; fi)"
echo "Concurrency: $MAX_CONCURRENT"
echo "Marker:      $COMPLETION_MARKER"
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

# Reap any finished jobs, return count reaped
reap_done() {
  local reaped=0
  for slug in "${!PIDS[@]}"; do
    pid=${PIDS[$slug]}
    if ! kill -0 "$pid" 2>/dev/null; then
      wait "$pid" && {
        echo "  ✓ $slug completed"
        COMPLETED=$((COMPLETED + 1))
        commit_result "$slug"
      } || {
        echo "  ✗ $slug failed (exit $?)"
        FAILED=$((FAILED + 1))
      }
      unset PIDS[$slug]
      RUNNING=$((RUNNING - 1))
      reaped=$((reaped + 1))
    fi
  done
  return $reaped
}

wait_for_slot() {
  while (( RUNNING >= MAX_CONCURRENT )); do
    reap_done || true
    if (( RUNNING >= MAX_CONCURRENT )); then
      # Block until any marker file appears in results dir
      inotifywait -r -q -e create -e moved_to "$RESULTS_DIR" \
        --include "$COMPLETION_MARKER" --timeout 300 >/dev/null 2>&1 || true
    fi
  done
}

wait_for_all() {
  while (( RUNNING > 0 )); do
    reap_done || true
    if (( RUNNING > 0 )); then
      inotifywait -r -q -e create -e moved_to "$RESULTS_DIR" \
        --include "$COMPLETION_MARKER" --timeout 300 >/dev/null 2>&1 || true
    fi
  done
}

commit_result() {
  local slug="$1"
  local result_dir="$RESULTS_DIR/$slug"
  cd "$ROOT"
  git add "$result_dir/" 2>/dev/null || true
  git commit -m "$slug: phase $PHASE ($PHASE_LABEL) complete" \
    --author="wiggum <wiggum@ehi-export-analysis>" \
    2>/dev/null || true
  git push || true
}

# Run a single phase for a target. Used by launch_one.
# Args: idx phase slug output_dir url developers products chpl_ids
run_single_phase() {
  local idx="$1" phase="$2" slug="$3" output_dir="$4"
  local url="$5" developers="$6" products="$7" chpl_ids="$8"

  local marker="${PHASE_MARKER[$phase]}"
  local label="${PHASE_NAME[$phase]}"
  local template="${PHASE_PROMPT[$phase]}"

  # Skip if already done
  if [[ -f "$output_dir/$marker" ]]; then
    echo "  [$idx] phase $phase ($label) — already done, skipping"
    return 0
  fi

  echo "  [$idx] phase $phase ($label) — starting..."

  local prompt
  prompt=$(sed \
    -e "s|{{URL}}|${url}|g" \
    -e "s|{{DEVELOPERS}}|${developers}|g" \
    -e "s|{{PRODUCTS}}|${products}|g" \
    -e "s|{{CHPL_IDS}}|${chpl_ids}|g" \
    -e "s|{{OUTPUT_DIR}}|${output_dir}|g" \
    "$template")

  local log_prefix="phase${phase}"
  if [[ "$LLM_BACKEND" == "claude" && -f "$CONFIG_DIR/log-handler.py" ]]; then
    run_llm "$ROOT" <<< "$prompt" \
      2>&1 | tee "$output_dir/${log_prefix}-stream.jsonl" \
      | python3 -u "$CONFIG_DIR/log-handler.py" \
      | tee "$output_dir/${log_prefix}-log.txt"
  else
    run_llm "$ROOT" <<< "$prompt" \
      2>&1 | tee "$output_dir/${log_prefix}-log.txt"
  fi
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

  # Skip if already done
  if [[ "$RESUME" == true && -f "$output_dir/$COMPLETION_MARKER" ]]; then
    echo "[$idx/$TOTAL] SKIP $slug (already has $COMPLETION_MARKER)"
    SKIPPED=$((SKIPPED + 1))
    return
  fi

  mkdir -p "$output_dir/downloads"

  # Copy CHPL metadata for this target into the output dir
  local meta_file="$ROOT/work/target-metadata/$(printf '%04d' "$idx").json"
  if [[ -f "$meta_file" ]]; then
    cp "$meta_file" "$output_dir/chpl-metadata.json"
  fi

  echo "[$idx/$TOTAL] LAUNCH $slug — $PHASE_LABEL ($LLM_BACKEND)"
  echo "  URL: $url"
  echo "  Developer(s): $developers"
  echo "  Output: $output_dir/"

  if [[ "$MODE_BOTH" == true ]]; then
    # Run phases sequentially in a subshell
    (
      for p in "${BOTH_PHASES[@]}"; do
        run_single_phase "$idx" "$p" "$slug" "$output_dir" "$url" "$developers" "$products" "$chpl_ids" || exit 1
      done
    ) &
  else
    # Single phase — original behavior
    (
      run_single_phase "$idx" "$PHASE" "$slug" "$output_dir" "$url" "$developers" "$products" "$chpl_ids"
    ) &
  fi

  PIDS[$slug]=$!
  RUNNING=$((RUNNING + 1))
}

# Main loop
if [[ -n "$ONLY_INDEX" ]]; then
  launch_one "$ONLY_INDEX"
  wait_for_all
else
  if [[ "$REVERSE" == true ]]; then
    end_idx=$(( START_INDEX > 0 ? START_INDEX : 0 ))
    for (( i=TOTAL-1; i>=end_idx; i-- )); do
      wait_for_slot
      launch_one "$i"
    done
  else
    for (( i=START_INDEX; i<TOTAL; i++ )); do
      wait_for_slot
      launch_one "$i"
    done
  fi
  echo ""
  echo "All launched. Waiting for remaining jobs..."
  wait_for_all
fi

echo ""
echo "=== Done ==="
echo "Phase:     $PHASE ($PHASE_LABEL)"
echo "Completed: $COMPLETED"
echo "Failed:    $FAILED"
echo "Skipped:   $SKIPPED"
echo "Results in: $RESULTS_DIR/"
