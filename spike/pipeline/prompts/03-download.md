# Stage 3: Download EHI Export Documentation Artifacts

You are downloading all EHI export documentation files identified in the discovery stage.

## Context

The discovery stage identified downloadable assets (PDFs, ZIPs, XLSX files, HTML pages)
for each vendor's EHI export documentation. Your job is to download them all,
organize them, and create a reproducible manifest.

## Your Batch

Your batch file is at: `{{BATCH_FILE}}`

It contains the discovery results JSON with `downloadable_assets` and
`html_documentation_urls` for each vendor.

## Task

For each vendor in your batch:

1. Create directory: `/home/exedev/EHI/pipeline/results/{{VENDOR_SLUG}}/downloads/`

2. Download each asset using curl:
   - Always use `-L` (follow redirects)
   - Always use `-H 'User-Agent: Mozilla/5.0'` (some servers block curl)
   - Use `-o` with a descriptive filename
   - For HTML pages, save the raw HTML
   - For ZIPs, save the binary and also list contents with `unzip -l`

3. Verify downloads:
   - Check file size > 0
   - Check Content-Type matches expected type
   - For PDFs, verify with `file` command
   - For ZIPs, verify with `unzip -t`

4. For HTML documentation sites with multiple pages:
   - Download the index/main page
   - Download key subpages (table of contents, a sample of detail pages)
   - If there's a downloadable ZIP or PDF version, prefer that over scraping HTML

## Output

Write manifest to: `{{OUTPUT_FILE}}`

Format: Markdown file with per-vendor sections:
```markdown
## Vendor Name

### file1.pdf (234 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o file1.pdf 'https://example.com/file1.pdf'
```
Saved to: `/home/exedev/EHI/pipeline/results/vendor-name/downloads/file1.pdf`

### file2.zip (12 MB)
```bash
curl -L -o file2.zip 'https://example.com/file2.zip'
```
Saved to: `/home/exedev/EHI/pipeline/results/vendor-name/downloads/file2.zip`
Contents: 1,234 files (45 MB uncompressed)
```

## Tips

- Some CDNs (Oracle, Marketo) require specific headers. If a download returns HTML
  instead of the expected file, try adding `Accept` headers or cookie handling.
- If a download is very large (>50MB), note it but still download it.
- If a download fails, retry once with different headers before marking as failed.
- Name files descriptively: `vendorname-ehi-export-data-dictionary.pdf` not `doc1.pdf`
