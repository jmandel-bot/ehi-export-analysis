# EHI Export Analysis — Controller Guide

This file is for a Claude instance acting as the **controller** of the wiggum
collection loop. Load it explicitly when you need to manage the loop:

    claude -p "$(cat controller/CLAUDE.md) <your instruction>"

## Project Overview

Automated collection and characterization of EHI (Electronic Health
Information) export documentation from all ~448 ONC-certified EHR products
listed in CHPL. Each target URL gets its own Claude agent that downloads docs,
researches the vendor, and produces structured analysis.

## Key Directories

```
work/targets.json              # 448 targets sorted by product_count desc
work/target-metadata/NNNN.json # Per-target CHPL metadata (enriched)
results/<slug>/                # Per-vendor output
  analysis.json                # Structured characterization (completion marker)
  collection-log.md            # Navigation journal
  downloads/                   # Downloaded artifacts
  stream.jsonl                 # Raw Claude stream-json log
  log.txt                      # Filtered human-readable log
chpl-data/all-active-listings.json  # CHPL bulk download (~148MB)
wiggum/
  loop.sh                      # Main orchestration loop
  prompt.md                    # Prompt template for each agent
  log-handler.py               # Stream-json → readable filter
  watch-results.sh             # inotifywait watcher, git commits on completion
  00-fetch-export-urls.sh      # Stage 0: build targets.json from CHPL
  status.sh                    # Quick progress check
```

## Setup From Scratch

### 1. Download CHPL bulk data (if missing)

```bash
ls chpl-data/all-active-listings.json 2>/dev/null || \
  (mkdir -p chpl-data && curl -sL \
    'https://chpl.healthit.gov/rest/listings/download?listingType=active&format=json' \
    -H 'api-key: 12909a978483dfb8ecd0596c98ae9094' \
    -o chpl-data/all-active-listings.json)
```

This is ~148MB. It caches locally and is used to generate targets and metadata.

### 2. Generate targets and metadata

```bash
./wiggum/00-fetch-export-urls.sh
```

This produces `work/targets.json` (448 targets) and `work/all-export-urls.json`.

Then regenerate enriched per-target metadata from the bulk file:

```python
python3 << 'PY'
import json, os
from datetime import datetime, timezone

bulk_file = "chpl-data/all-active-listings.json"
meta_dir = "work/target-metadata"
targets_file = "work/targets.json"

with open(bulk_file) as f:
    listings = json.load(f)
by_id = {l['id']: l for l in listings}

with open(targets_file) as f:
    targets = json.load(f)

os.makedirs(meta_dir, exist_ok=True)

def fmt_date(val):
    if isinstance(val, (int, float)):
        return datetime.fromtimestamp(val / 1000, tz=timezone.utc).strftime('%Y-%m-%d')
    if isinstance(val, str) and val:
        return val[:10]
    return None

def get_status(listing):
    for key in ['currentStatus', 'certificationStatus']:
        cs = listing.get(key)
        if isinstance(cs, dict) and cs.get('name'):
            return cs['name']
        if isinstance(cs, str) and cs:
            return cs
    return 'Active'

for idx, target in enumerate(targets):
    products = []
    for chpl_id in target['chpl_ids']:
        listing = by_id.get(chpl_id)
        if not listing:
            continue
        criteria = sorted([
            cr['criterion']['number']
            for cr in listing.get('certificationResults', [])
            if cr.get('success') and cr.get('criterion', {}).get('number')
        ])
        products.append({
            'chpl_id': listing['id'],
            'chpl_product_number': listing.get('chplProductNumber', ''),
            'product_name': listing.get('product', {}).get('name', ''),
            'version': listing.get('version', {}).get('version', ''),
            'certification_date': fmt_date(listing.get('certificationDate')),
            'certification_status': get_status(listing),
            'practice_type': (listing.get('practiceType') or {}).get('name'),
            'certified_criteria': criteria,
        })
    first = by_id.get(target['chpl_ids'][0], {})
    dev = first.get('developer', {})
    contact = dev.get('contact') or {}
    meta = {
        'url': target['url'],
        'developer': {
            'name': dev.get('name', ''),
            'website': dev.get('website', ''),
            'contact_name': contact.get('fullName', ''),
            'contact_email': contact.get('email', ''),
            'contact_phone': contact.get('phoneNumber', ''),
        },
        'sed_intended_user_description': first.get('sedIntendedUserDescription') or '',
        'mandatory_disclosures_url': first.get('mandatoryDisclosures') or '',
        'products': products,
    }
    with open(os.path.join(meta_dir, f"{idx:04d}.json"), 'w') as f:
        json.dump(meta, f, indent=2)

print(f"Wrote {len(targets)} metadata files")
PY
```

### 3. Start the collection loop

**Forward (big vendors first):**
```bash
MAX_CONCURRENT=1 ./wiggum/loop.sh --resume
```

**Reverse (small vendors first):**
```bash
MAX_CONCURRENT=1 ./wiggum/loop.sh --reverse --resume
```

**Single target:**
```bash
./wiggum/loop.sh --only 42
```

### 4. (Optional) Start the watcher for real-time alerts

```bash
./wiggum/watch-results.sh &
```

The loop itself handles git commits after each successful completion.
The watcher is optional — it provides real-time terminal alerts via `inotifywait`.

## Monitoring

**Live filtered log for current target:**
```bash
# If running in background task:
tail -f /tmp/claude-1001/-home-jmandel-hobby-ehi-export-analysis/tasks/<task-id>.output

# Or from the raw stream-json:
tail -f results/<slug>/stream.jsonl | python3 -u wiggum/log-handler.py
```

**Quick status:**
```bash
./wiggum/status.sh
```

**Count completed:**
```bash
find results -name 'analysis.json' | wc -l
```

## Killing and Restarting

**Kill everything:**
```bash
pkill -9 -f 'wiggum/loop.sh'
sleep 1
pkill -9 -f 'claude -p --dangerously'
pkill -f 'watch-results'
pkill -f inotifywait
```

**Clean up incomplete results before restarting:**
```bash
for d in results/*/; do
  if [ ! -f "$d/analysis.json" ]; then
    echo "removing incomplete: $(basename $d)"
    rm -rf "$d"
  fi
done
```

Then restart with `--resume` — it skips any target whose `results/<slug>/analysis.json` exists.

## Key Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `MAX_CONCURRENT` | 3 | Parallel agents |
| `CLAUDE_MODEL` | opus | Model to use |
| `LLM_BACKEND` | claude | Backend: claude, shelley, gemini |

## How the Pipeline Works

1. `loop.sh` reads `work/targets.json` (448 URLs sorted by product count)
2. For each target, it copies `work/target-metadata/NNNN.json` → `results/<slug>/chpl-metadata.json`
3. It renders `wiggum/prompt.md` with target details and pipes to `claude -p`
4. Claude output streams as JSON → `tee` to `results/<slug>/stream.jsonl` → `log-handler.py` → `tee` to `results/<slug>/log.txt`
5. The agent produces `collection-log.md` and `analysis.json` in `results/<slug>/`
6. The loop git-commits the results after each successful completion

## Prompt Template

`wiggum/prompt.md` tells each agent to:
1. Read `chpl-metadata.json` FIRST for product context (don't query CHPL API)
2. Probe the target URL, download all documentation
3. Research the vendor's broader product capabilities
4. Characterize documentation quality and EHI coverage
5. Write `collection-log.md` and `analysis.json`
