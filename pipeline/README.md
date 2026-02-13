# EHI Export Documentation Pipeline

Systematic pipeline to discover, download, and analyze EHI export documentation
for all 927 b(10)-certified products (643 unique products, 477 developers).

## Pipeline Stages

1. **fetch-urls** — Fetch CHPL details for each unique product, extract exportDocumentation URLs
2. **discover** — Visit each unique URL, classify the documentation format, find downloadable assets
3. **download** — Download all documentation artifacts (PDFs, ZIPs, XLSX, HTML)
4. **analyze** — Deep analysis of each vendor's EHI export: coverage, format, completeness
5. **report** — Aggregate findings into a comprehensive cross-vendor report

## Files

- `prompts/` — Agent prompt templates for each stage
- `work/` — Working data (URL lists, batch assignments, intermediate results)
- `results/` — Per-vendor analysis results
