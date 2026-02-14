#!/usr/bin/env bash
# Watch for new analysis.json files, report completions, and git commit.
# Uses inotifywait to avoid polling. The git commit triggers a notification
# to any parent process watching for commits.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RESULTS="$ROOT/results"
LOG_DIR="$ROOT/wiggum/logs"

cd "$ROOT"

echo "=== Watching for completed analyses in $RESULTS ==="
echo "Existing: $(find "$RESULTS" -name 'analysis.json' 2>/dev/null | wc -l) completed"
echo ""

inotifywait -m -r -e close_write --format '%w%f' "$RESULTS" 2>/dev/null | while read -r filepath; do
  if [[ "$filepath" == */analysis.json ]]; then
    vendor_dir=$(dirname "$filepath")
    slug=$(basename "$vendor_dir")
    vendor=$(jq -r '.vendor // .developers[0] // "unknown"' "$filepath" 2>/dev/null)
    tables=$(jq -r '.documentation.table_or_resource_count // "?"' "$filepath" 2>/dev/null)
    status=$(jq -r '.access.status // "?"' "$filepath" 2>/dev/null)
    total=$(find "$RESULTS" -name 'analysis.json' 2>/dev/null | wc -l)

    # Print summary
    echo "$(date '+%H:%M:%S') DONE [$total/448] $vendor (status=$status tables=$tables)"

    # Check cost from log
    logfile="$LOG_DIR/${slug}.log"
    if [[ -f "$logfile" ]]; then
      cost_line=$(grep '^\[done\]' "$logfile" 2>/dev/null | tail -1)
      if [[ -n "$cost_line" ]]; then
        echo "  $cost_line"
      fi
    fi

    # Git commit the completed result so watchers get notified
    git add "$vendor_dir/" 2>/dev/null || true
    git commit -m "$slug: collection and analysis complete" \
      --author="wiggum <wiggum@ehi-export-analysis>" \
      2>/dev/null || true

    echo ""
  fi
done
