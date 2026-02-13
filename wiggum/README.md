# EHI Export Documentation Collection (Wiggum)

Automated collection and characterization of EHI export documentation from all
b(10)-certified EHR products registered in CHPL.

## How It Works

1. **Stage 0** (`00-fetch-export-urls.sh`): Fetches CHPL details for all 927
   certified products, extracts b(10) `exportDocumentation` URLs, deduplicates
   by URL → produces `work/targets.json`

2. **Loop** (`loop.sh`): Iterates over `targets.json`, launching one Claude CLI
   invocation per unique URL. Each gets:
   - Its own output directory under `results/<vendor-slug>/`
   - The prompt template (`prompt.md`) filled in with that vendor's URL, names, IDs
   - A $2 budget cap

3. Each Claude invocation produces:
   - `collection-log.md` — step-by-step reproducible navigation journal
   - `analysis.json` — structured characterization of the export docs
   - `downloads/` — all downloaded artifacts (PDFs, ZIPs, XLSX, HTML)

## Usage

```bash
# Step 0: Build the target list (fetches ~927 CHPL details, takes ~5min)
./wiggum/00-fetch-export-urls.sh

# Step 1: Run the collection loop (3 concurrent by default)
./wiggum/loop.sh

# Or resume after interruption (skips vendors with analysis.json)
./wiggum/loop.sh --resume

# Or run a single target by index
./wiggum/loop.sh --only 42

# Or start from a specific index
./wiggum/loop.sh --index 100

# Adjust concurrency
MAX_CONCURRENT=5 ./wiggum/loop.sh --resume

# Use a different model
CLAUDE_MODEL=opus ./wiggum/loop.sh --only 0
```

## Checking Progress

```bash
./wiggum/status.sh
```

Shows: completed count, running processes, per-vendor summary, failures.

## Files

```
wiggum/
  00-fetch-export-urls.sh   # Stage 0: build target list from CHPL
  loop.sh                   # Main loop: one Claude invocation per URL
  prompt.md                 # Prompt template (filled per vendor)
  status.sh                 # Check progress
  work/
    targets.json            # Deduplicated URL → vendor(s) map
    all-export-urls.jsonl   # Raw per-product URL data
  results/
    <vendor-slug>/
      collection-log.md     # Navigation journal
      analysis.json         # Structured characterization
      downloads/            # All downloaded artifacts
  logs/
    <vendor-slug>.log       # Raw Claude output
```
