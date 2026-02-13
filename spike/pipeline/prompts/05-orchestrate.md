# Orchestration Guide

This document explains how to run the pipeline end-to-end.

## Stage 1: Fetch URLs (batch across ~643 products)

We need to call the CHPL API for each unique product to get export doc URLs.
Split into batches of ~80 products per agent (8 agents).

```
# Generate batches from the developer-product map
jq '[.[] | .products[] | {id: .id, developer: .name, product: .name}]' \
  /home/exedev/EHI/chpl-data/developer-product-map.json | \
  jq '[_nwise(80)]' > /home/exedev/EHI/pipeline/work/fetch-batches.json
```

Then for each batch, launch an agent with the Stage 1 prompt, substituting:
- `{{BATCH_FILE}}` = path to the batch slice
- `{{OUTPUT_FILE}}` = path to write results
- `{{RAW_DIR}}` = /home/exedev/EHI/chpl-data/

When all agents finish, merge results:
```
jq -s 'add' /home/exedev/EHI/pipeline/work/urls-batch-*.json \
  > /home/exedev/EHI/pipeline/work/all-export-urls.json
```

Then deduplicate by URL:
```
jq 'group_by(.export_documentation_url) | map({
  url: .[0].export_documentation_url,
  developers: [.[].developer] | unique,
  products: [.[].product] | unique,
  chpl_ids: [.[].chpl_id]
})' /home/exedev/EHI/pipeline/work/all-export-urls.json \
  > /home/exedev/EHI/pipeline/work/unique-urls.json
```

## Stage 2: Discover (batch across unique URLs)

Split unique URLs into batches of ~30 per agent. Launch with Stage 2 prompt.

## Stage 3: Download (batch per agent from Stage 2)

Each Stage 2 agent's output feeds directly into a Stage 3 agent.
Or combine stages 2+3 into one agent per batch to reduce round-trips.

## Stage 4: Analyze (batch of ~10-15 vendors per agent)

This is the most token-intensive stage. Each vendor analysis requires reading
downloaded files. Batch conservatively.

## Stage 5: Aggregate

Merge all Stage 4 JSON results into a single dataset.
Generate summary statistics, coverage matrix, and final report.

## Practical Notes

- **Stages 2+3 can be combined** into a single agent prompt per batch.
  "Visit the URL, classify it, download everything, and write the analysis."
  This avoids the round-trip of waiting for discovery before downloading.

- **Stage 4 can be combined with 2+3** for small batches. For a batch of 10
  vendors, one agent can discover, download, and analyze all of them.

- **The bottleneck is API calls in Stage 1** (~643 calls at 0.3s each = ~3 min
  per batch of 80, so ~25 min total with 8 parallel agents).

- **Check for completion by looking for output files**, not by polling agents.

- **Re-run failed batches** by checking for null URLs or error fields in output.
