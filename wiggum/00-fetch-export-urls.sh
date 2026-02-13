#!/usr/bin/env bash
# Fetch b(10) export documentation URLs for all 927 certified products.
# Deduplicates by URL and produces a targets.json for the investigation loop.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHPL_DIR="$ROOT/chpl-data"
WORK_DIR="$ROOT/wiggum/work"
mkdir -p "$WORK_DIR" "$CHPL_DIR/details"

API_KEY="12909a978483dfb8ecd0596c98ae9094"
BASE="https://chpl.healthit.gov/rest"

# Step 1: Collect all product IDs from search pages
echo "Collecting product IDs from search pages..."
ALL_IDS=$(jq -r '.results[].id' "$CHPL_DIR"/b10-search-p*.json | sort -un)
TOTAL=$(echo "$ALL_IDS" | wc -l)
echo "Found $TOTAL unique product IDs"

# Step 2: Fetch details for each, extract b(10) export URL
OUTPUT="$WORK_DIR/all-export-urls.jsonl"
> "$OUTPUT"

i=0
for ID in $ALL_IDS; do
  i=$((i + 1))
  CACHE="$CHPL_DIR/details/${ID}.json"

  # Use cached if available
  if [[ ! -f "$CACHE" || ! -s "$CACHE" ]]; then
    echo "[$i/$TOTAL] Fetching $ID..."
    curl -sf "${BASE}/certified_products/${ID}/details" \
      -H 'accept: application/json' \
      -H "api-key: ${API_KEY}" \
      -o "$CACHE" || {
        echo "  FAILED to fetch $ID"
        echo "{\"id\":$ID,\"error\":\"fetch_failed\"}" >> "$OUTPUT"
        continue
      }
    sleep 0.3
  else
    echo "[$i/$TOTAL] Cached $ID"
  fi

  # Extract the b(10) info
  jq -c '{
    id: .id,
    developer: .developer.name,
    product: .product.name,
    version: .version.version,
    chpl_product_number: .chplProductNumber,
    certification_status: .certificationStatusEvents[-1].status.name,
    export_url: ([.certificationResults[] | select(.criterion.number == "170.315 (b)(10)")][0] // {}).exportDocumentation,
    b10_success: ([.certificationResults[] | select(.criterion.number == "170.315 (b)(10)")][0] // {}).success
  }' "$CACHE" >> "$OUTPUT" 2>/dev/null || {
    echo "  FAILED to parse $ID"
    echo "{\"id\":$ID,\"error\":\"parse_failed\"}" >> "$OUTPUT"
  }
done

echo ""
echo "Fetched $TOTAL products. Building deduplicated target list..."

# Step 3: Deduplicate by URL, group products per URL
jq -s '
  [.[] | select(.export_url != null and .export_url != "")] |
  group_by(.export_url) |
  map({
    url: .[0].export_url,
    developers: [.[].developer] | unique,
    products: [.[].product] | unique,
    chpl_ids: [.[].id],
    product_count: length
  }) |
  sort_by(-.product_count)
' "$OUTPUT" > "$WORK_DIR/targets.json"

TARGET_COUNT=$(jq 'length' "$WORK_DIR/targets.json")
echo "Deduplicated to $TARGET_COUNT unique export documentation URLs"
echo "Saved to $WORK_DIR/targets.json"

# Summary stats
echo ""
echo "Top 20 URLs by product count:"
jq -r '.[:20][] | "  \(.product_count) products → \(.url) (\(.developers[0]))"' "$WORK_DIR/targets.json"

# Also save products with no URL
jq -s '[.[] | select(.export_url == null or .export_url == "")] | length' "$OUTPUT" | \
  xargs -I{} echo "{} products had no export documentation URL"
