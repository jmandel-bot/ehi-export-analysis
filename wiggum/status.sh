#!/usr/bin/env bash
# Check progress of the EHI collection loop.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RESULTS="$ROOT/results"
TARGETS="$ROOT/work/targets.json"

TOTAL=$(jq 'length' "$TARGETS" 2>/dev/null || echo 0)

# Count results
ANALYSIS=$(find "$RESULTS" -name 'analysis.json' 2>/dev/null | wc -l)
LOGS=$(find "$RESULTS" -name 'collection-log.md' 2>/dev/null | wc -l)
DOWNLOADS=$(find "$RESULTS" -path '*/downloads/*' -type f 2>/dev/null | wc -l)
DOWNLOAD_SIZE=$(du -sh "$RESULTS" 2>/dev/null | cut -f1 || echo '0')

echo "=== EHI Collection Status ==="
echo "Targets:     $TOTAL unique URLs"
echo "Analyzed:    $ANALYSIS / $TOTAL"
echo "Logs:        $LOGS"
echo "Files:       $DOWNLOADS downloaded"
echo "Total size:  $DOWNLOAD_SIZE"
echo ""

# Show running Claude processes
RUNNING=$(pgrep -f 'claude.*dangerously-skip-permissions' 2>/dev/null | wc -l)
echo "Running:     $RUNNING claude processes"

if (( ANALYSIS > 0 )); then
  echo ""
  echo "=== Completed Vendors ==="
  for f in "$RESULTS"/*/analysis.json; do
    vendor=$(jq -r '.vendor // "unknown"' "$f")
    status=$(jq -r '.access.status // "unknown"' "$f")
    tables=$(jq -r '.documentation.table_or_resource_count // "?"' "$f")
    msgs=$(jq -r '.ehi_coverage.secure_messages.present // false' "$f")
    billing=$(jq -r '.ehi_coverage.billing_financial.present // false' "$f")
    printf "  %-40s status=%-8s tables=%-6s msgs=%-5s billing=%s\n" \
      "$vendor" "$status" "$tables" "$msgs" "$billing"
  done
fi

# Show failures
FAILED_LOGS=$(grep -l 'error\|Error\|FAILED' "$ROOT/wiggum/logs/"*.log 2>/dev/null | wc -l)
if (( FAILED_LOGS > 0 )); then
  echo ""
  echo "=== Possible Failures ($FAILED_LOGS logs with errors) ==="
  for f in $(grep -l 'error\|Error\|FAILED' "$ROOT/wiggum/logs/"*.log 2>/dev/null | head -10); do
    echo "  $(basename "$f")"
  done
fi
