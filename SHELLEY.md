# EHI Export Analysis — Setup Notes

## Project Overview

Research and download EHI (Electronic Health Information) export documentation
for all ONC-certified EHR products with 170.315(b)(10) certification.

449 unique documentation URLs covering 636 certified products.

## Data Pipeline

### 1. Fetch bulk CHPL data
```bash
bash wiggum/00-fetch-export-urls.sh
```
- Downloads `chpl-data/all-active-listings.json` (~142MB, all active ONC listings)
- Extracts b(10)-certified products, deduplicates by URL
- Produces `work/targets.json` (449 targets) and `work/all-export-urls.json`
- Generates `work/target-metadata/NNNN.json` per target from the bulk file
- **Note:** The heredoc python uses env vars (BULK_FILE, WORK_DIR), not sys.argv

### 2. Run the loop
```bash
# Both phases per URL (research then download), sequential per target:
bash wiggum/loop.sh --phase both

# Single phase:
bash wiggum/loop.sh --phase 1          # research only
bash wiggum/loop.sh --phase 2 --resume  # download only, skip done

# Control:
--resume         skip targets with completion marker
--index N        start from target index N
--only N         run only target index N
--reverse        iterate from end backwards
MAX_CONCURRENT=3 # env var, default 2 for both, 3 for single
```

### 3. Per-target output (in `results/<slug>/`)
- `chpl-metadata.json` — CHPL certification data (copied from work/target-metadata/)
- `product-research.md` + `sources.json` — Phase 1 output
- `ehi-export-report.md` + `files.json` — Phase 2 output (includes coverage assessment)
- `downloads/` — actual downloaded documentation files
- `phase1-log.txt`, `phase2-log.txt` — agent conversation logs

## Agent Configuration

- **Always use Opus 4.6** (`claude-opus-4.6`)
- Backend: Shelley server at `http://localhost:9999`
- User: `wiggum`
- Prompt templates: `wiggum/prompts/1-research.md`, `wiggum/prompts/2-download.md`
- Shelley prompt runner: `wiggum/shelley-prompt.ts` (needs bun)

## Phase Design

- **Phase 1 (research):** Investigate vendor website, product features, market
  position, data domains. Narrative report focused on what data the product
  stores. Output: `product-research.md` + `sources.json`
  Completion marker: `sources.json`

- **Phase 2 (download + analysis):** Navigate to registered URL, find and
  download EHI export docs. Then compare what was found against the product
  research — what data domains are covered, what's missing, what's ambiguous.
  Output: `ehi-export-report.md` + `files.json`
  Completion marker: `files.json`

- `--phase both` runs them sequentially per target (phase 1 finishes, then
  phase 2 starts for same target). Two separate agent conversations, but
  phase 2 can read phase 1's output files on disk.

## Subagent Pattern

Agents CAN use subagents for parallelism, but **must never message a subagent
after launching it** — that sends a new user message which interrupts and derails
the running agent. Instead:

1. Tell subagent to write output to a known file path
2. Launch with `wait: false`
3. Block with `inotifywait -e create -e moved_to DIR --include FILENAME --timeout 600`
4. Read the output file

The loop script itself uses `inotifywait` on completion markers instead of
sleep-polling.

## Dependencies

- `bun` — for running shelley-prompt.ts (`curl -fsSL https://bun.sh/install | bash`)
- `jq`, `python3`, `curl` — standard tools
- `pdftotext`, `pdfinfo`, `pdftoppm` (poppler-utils) — for PDF examination
- Shelley server running on localhost:9999

## Git

- Repo: `https://github.com/jmandel-bot/ehi-export-analysis`
- Loop auto-commits + pushes per completed target
- Auth token needed for push (set as git remote credential)
