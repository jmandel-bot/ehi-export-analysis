#!/usr/bin/env bash
# Fetch b(10) export documentation URLs for all certified products.
# Uses the CHPL bulk download endpoint (one request) instead of per-product API calls.
# Deduplicates by URL and produces targets.json for the investigation loop.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHPL_DIR="$ROOT/chpl-data"
WORK_DIR="$ROOT/wiggum/work"
mkdir -p "$WORK_DIR" "$CHPL_DIR"

BULK_FILE="$CHPL_DIR/all-active-listings.json"

# Step 1: Download all active listings in one shot (~140MB JSON)
if [[ -f "$BULK_FILE" ]]; then
  AGE=$(( $(date +%s) - $(stat -c %Y "$BULK_FILE") ))
  echo "Bulk file exists ($(du -h "$BULK_FILE" | cut -f1), $(( AGE / 3600 ))h old)"
  if (( AGE > 86400 )); then
    echo "Older than 24h — re-downloading..."
    rm -f "$BULK_FILE"
  else
    echo "Using cached file (pass --force to re-download)"
  fi
fi

if [[ "$*" == *--force* ]]; then
  rm -f "$BULK_FILE"
fi

if [[ ! -f "$BULK_FILE" ]]; then
  echo "Downloading all active listings from CHPL bulk endpoint..."
  curl -sL 'https://chpl.healthit.gov/rest/listings/download?listingType=active&format=json' \
    -H 'api-key: 12909a978483dfb8ecd0596c98ae9094' \
    -o "$BULK_FILE" \
    -w '  %{size_download} bytes in %{time_total}s\n'
  echo "Saved to $BULK_FILE ($(du -h "$BULK_FILE" | cut -f1))"
fi

# Step 2: Extract b(10) export URLs and build targets.json
echo "Extracting b(10) export documentation URLs..."
python3 << 'PY'
import json, sys
from collections import defaultdict

bulk_file = sys.argv[1]
work_dir = sys.argv[2]

with open(bulk_file) as f:
    listings = json.load(f)

print(f"Total active listings: {len(listings)}")

results = []
for listing in listings:
    b10 = None
    for cr in listing.get('certificationResults', []):
        if cr.get('criterion', {}).get('number') == '170.315 (b)(10)':
            b10 = cr
            break
    if b10 and b10.get('success'):
        results.append({
            'id': listing['id'],
            'developer': listing.get('developer', {}).get('name', ''),
            'product': listing.get('product', {}).get('name', ''),
            'version': listing.get('version', {}).get('version', ''),
            'chpl_product_number': listing.get('chplProductNumber', ''),
            'export_url': b10.get('exportDocumentation', ''),
            'b10_success': b10.get('success'),
        })

print(f"Products with b(10) certification: {len(results)}")

# Deduplicate by URL
by_url = defaultdict(lambda: {'developers': set(), 'products': set(), 'chpl_ids': []})
no_url = 0
for r in results:
    url = r['export_url']
    if not url:
        no_url += 1
        continue
    by_url[url]['developers'].add(r['developer'])
    by_url[url]['products'].add(r['product'])
    by_url[url]['chpl_ids'].append(r['id'])

targets = []
for url, info in by_url.items():
    targets.append({
        'url': url,
        'developers': sorted(info['developers']),
        'products': sorted(info['products']),
        'chpl_ids': sorted(info['chpl_ids']),
        'product_count': len(info['chpl_ids']),
    })

targets.sort(key=lambda x: -x['product_count'])

print(f"Unique export documentation URLs: {len(targets)}")
if no_url:
    print(f"Products with no URL: {no_url}")

print(f"\nTop 15 by product count:")
for t in targets[:15]:
    print(f"  {t['product_count']:3d} products -> {t['url'][:80]}  ({t['developers'][0]})")

with open(f"{work_dir}/targets.json", 'w') as f:
    json.dump(targets, f, indent=2)

with open(f"{work_dir}/all-export-urls.json", 'w') as f:
    json.dump(results, f, indent=2)

print(f"\nSaved {work_dir}/targets.json ({len(targets)} targets)")
print(f"Saved {work_dir}/all-export-urls.json ({len(results)} products)")
PY
  "$BULK_FILE" "$WORK_DIR"
