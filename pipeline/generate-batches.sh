#!/bin/bash
# Generate work batches for the EHI export documentation pipeline
# Run from /home/exedev/EHI/

set -euo pipefail

BASE=/home/exedev/EHI
WORK=$BASE/pipeline/work
mkdir -p "$WORK"

echo "=== Stage 1: Generate URL fetch batches ==="

# Extract one representative listing ID per unique (developer, product) pair
# from the developer-product map we already built
jq '[
  .[] | 
  .dev = .dev as $dev |
  .products[] | 
  {id: .id, developer: $dev, product: .name}
]' $BASE/chpl-data/developer-product-map.json > $WORK/all-products.json

TOTAL=$(jq length $WORK/all-products.json)
echo "Total unique products: $TOTAL"

# Split into batches of 80
BATCH_SIZE=80
BATCH_NUM=0
jq -c "[_nwise($BATCH_SIZE)][]" $WORK/all-products.json | while read -r batch; do
  echo "$batch" | jq '.' > "$WORK/fetch-batch-$(printf '%02d' $BATCH_NUM).json"
  COUNT=$(echo "$batch" | jq length)
  echo "  Batch $BATCH_NUM: $COUNT products"
  BATCH_NUM=$((BATCH_NUM + 1))
done

echo
echo "Fetch batches written to $WORK/fetch-batch-*.json"
echo "Launch one agent per batch with pipeline/prompts/01-fetch-urls.md"
echo
echo "After all fetch agents complete, run:"
echo "  jq -s 'add' $WORK/urls-batch-*.json > $WORK/all-export-urls.json"
echo
echo "Then deduplicate URLs:"
echo "  jq 'group_by(.export_documentation_url) | map({" \\
echo '    url: .[0].export_documentation_url,' \\
echo '    developers: [.[].developer] | unique,' \\
echo '    products: [.[].product] | unique,' \\
echo '    chpl_ids: [.[].chpl_id]' \\
echo "  })' $WORK/all-export-urls.json > $WORK/unique-urls.json"
