# Phase 2: Download EHI Export Documentation

You are downloading the EHI (Electronic Health Information) export documentation
for a certified EHR product. Your job is to find, navigate, and download
everything at the vendor's registered documentation URL — producing a complete,
reproducible archive of their export documentation.

## Your Target

**URL**: {{URL}}
**Developer(s)**: {{DEVELOPERS}}
**Product(s)**: {{PRODUCTS}}
**CHPL IDs**: {{CHPL_IDS}}

**Output directory**: {{OUTPUT_DIR}}
**Downloads directory**: {{OUTPUT_DIR}}/downloads/

**CHPL metadata**: `{{OUTPUT_DIR}}/chpl-metadata.json`

## What To Download

Everything at the registered URL that documents the EHI export. This includes:

- **Data dictionaries** — table/field definitions, schemas, column listings
- **Export format specifications** — file formats, encoding, structure
- **API documentation** that is specific to this vendor's EHI export mechanism —
  if the b(10) export itself works via an API, get those docs
- **Sample data / examples** — example export files, sample records, test data
- **Schema files** — XSD, JSON Schema, OpenAPI specs, DDL, anything machine-readable
- **Instructions / user guides** for performing the export
- **Screenshots** of export interfaces (take them yourself if the page shows one)

### What NOT to download

- **External standards documentation** — don't follow links to hl7.org, fhir.org,
  build.fhir.org, uscdi.healthit.gov, etc. We already understand those standards.
- **Marketing materials** — unless they contain substantive EHI export information
- **Compliance certificates** — unless they contain technical export details
- **Unrelated regulatory documents** — real-world testing plans, SVAP notices, etc.
  unless they describe the export mechanism

### Follow links FROM the EHI export documentation

If the EHI export documentation itself links to other resources that help you
understand the export format or contents — follow those links and download
the content. These are part of the export documentation.

For example: if the EHI data dictionary links to a page on the vendor's site
that documents their database schema, or to format specifications needed to
interpret the export files — follow it and download it.

But **don't independently explore** the vendor's broader documentation universe.
If the EHI export page lives on a certification page that also links to other
product documentation, developer portals, or regulatory filings — don't go
deep on those unless the EHI export docs specifically reference them as part
of understanding the export.

### Prefer computable formats

When a document is available in multiple formats, prefer the most computable:
- JSON/YAML/XML schema over PDF description of the same schema  
- CSV/TSV data dictionary over PDF table
- HTML with structured tables over a scanned PDF
- If only PDF exists, that's fine — download it

If a ZIP contains structured files (HTML data dictionary, CSV exports, etc.),
download and extract it.

### Always look for the underlying data

When navigating a vendor's documentation site — especially custom-built doc
portals, wikis, or SPA-based sites — don't just scrape the rendered text from
web pages. Look for ways to download the underlying structured data:

- **Downloadable files**: CSV, JSON, XML, XLSX, ZIP, YAML, XSD, OpenAPI specs
- **FHIR endpoints**: if the vendor exposes a FHIR server, grab machine-readable
  artifacts like CapabilityStatement, StructureDefinitions (custom profiles),
  ImplementationGuide packages — not prose descriptions of standard resources
- **API endpoints**: if the doc site has an API or data endpoint behind it,
  prefer that over scraping rendered HTML
- **Export/download buttons**: many doc sites have "Download as PDF", "Export
  data dictionary", or "Download ZIP" options — use those

The goal is computable artifacts, not screenshots and text extractions of
web pages. A JSON schema is worth more than a text scrape of the page that
describes the same schema.

## How To Navigate

### Step-by-step process:

**1. Initial probe — what does the URL return?**
```bash
curl -sI -L "$URL" -H 'User-Agent: Mozilla/5.0' 2>&1
```
Record: HTTP status chain, final URL, Content-Type, content-disposition headers.
If it's a direct file download, grab it and you're nearly done.

**2. Fetch and examine the page:**
```bash
curl -sL "$URL" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html
cat /tmp/page.html | sed 's/<[^>]*>/ /g' | tr -s ' \n' | head -50
```

**3. Search for documentation links:**
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx|yaml|yml)[^"]*"' /tmp/page.html
grep -oiE 'href="[^"]*[^"]*"' /tmp/page.html | grep -iE 'ehi|export|data.dictionary|b.10|bulk'
```

**4. If the page is a SPA or needs JavaScript:**
- Navigate in the browser, wait for load, take a screenshot
- Note what you see and what you had to click

**5. If the page is a compliance hub with accordions/tabs:**
- Look for sections labeled "170.315(b)(10)", "EHI Export", "Electronic Health Information"
- Check page source for hidden content in collapsed sections
- Click to expand, record what heading you expanded

**6. Follow links one or two levels deep:**
Record each hop: "From the main page, I clicked X which led to Y"

**7. If the URL is dead (404, domain expired, redirects to homepage):**
Try:
- Domain root, search for EHI docs
- Common paths: /legal/, /compliance/, /onc/, /ehi/, /interoperability/
- Wayback Machine: `curl -s "https://web.archive.org/web/2024*/{{URL}}"`
- Google: `curl -s "https://www.google.com/search?q=site:DOMAIN+EHI+export"`
Record everything you tried.

### Patterns you'll encounter:

| Pattern | What to do |
|---------|------------|
| Direct file download (PDF/ZIP) | Download it, done |
| Static HTML + download links | Download all linked files |
| Compliance hub with accordion | Find and expand EHI section, download linked files |
| JavaScript SPA | Use browser, screenshot, download what you can |
| Multi-page HTML doc site | Download index + representative pages (prefer ZIP if available) |
| Dead/moved URL | Investigate alternatives, document what you tried |
| Login wall | Document it as a finding — this violates the public accessibility requirement |

### Anti-bot notes:
- Some sites need a User-Agent header
- WordPress sites may use lazy-loading JS
- Accordion content is often in HTML source but hidden via CSS
- If curl gets HTML instead of expected file, try different Accept headers

### Verify every download
- After downloading a file, confirm it's what you expected: `file filename.pdf`
  should say "PDF document", not "HTML document" or "ASCII text"
- For JSON files, check the first few hundred bytes: `head -c 500 file.json` —
  make sure it's actual data, not an error response or auth redirect
- Some servers return HTTP 200 with an error message in the body (e.g., a
  login page, a JSON error object, or a "401 Unauthorized" HTML page). Don't
  trust the status code alone — inspect the content.
- If a download requires authentication, note it in the collection log and
  don't include it in the downloads. The documentation is supposed to be
  publicly accessible.

## Output

Write `{{OUTPUT_DIR}}/collection-log.md`:

```markdown
# {{Vendor Name}} — EHI Export Documentation Collection

Collected: {{date}}

## Source
- Registered URL: {{url}}
- CHPL IDs: ...

## Navigation Journal

### Step 1: Initial probe
(curl command and result — status codes, redirects, content-type)

### Step 2: Page examination  
(what the page looks like, size, SPA vs static, content summary)

### Step 3: Finding the EHI section
(how you navigated to the actual documentation)

### Step N: ...
(continue as needed)

## Downloads

### filename.pdf (684 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o filename.pdf 'https://...'
```
Verified: PDF document, 142 pages
Saved to: downloads/filename.pdf
Content: Data dictionary covering 261 tables

### another-file.zip (2.3 MB)
...

## Access Summary
- Final URL (after redirects): ...
- Status: found | dead | redirect_to_homepage | login_required
- Required browser: yes/no
- Navigation complexity: direct_link | one_click | accordion | multi_page | spa_navigation
- Anti-bot issues: none | user-agent required | cloudflare | etc.

## Obstacles & Dead Ends
(anything that didn't work, special headers needed, etc.)
```

Also write `{{OUTPUT_DIR}}/download-manifest.json`:

```json
{
  "url": "{{URL}}",
  "final_url": "https://... (after redirects)",
  "collection_date": "2025-07-14",
  "access_status": "found|dead|redirect_to_homepage|login_required|error",
  "requires_browser": false,
  "navigation_complexity": "direct_link|one_click|accordion|multi_page|spa_navigation",
  "files": [
    {
      "local_path": "downloads/filename.pdf",
      "source_url": "https://...",
      "size_bytes": 12345,
      "type": "pdf",
      "description": "EHI Export Data Dictionary",
      "curl_command": "curl -L -H 'User-Agent: Mozilla/5.0' -o filename.pdf 'https://...'"
    }
  ],
  "notes": "anything notable about the collection process"
}
```

## Mindset

- **Reproducibility is the goal.** Someone should be able to follow your log and
  get the same files. Every curl command, every click, every expanded accordion.
- **Be persistent.** If a URL 404s, investigate. If a page looks empty, view source.
  If an accordion is collapsed, check if content is in the DOM.
- **Download generously, but stay on-topic.** Get everything that documents the
  EHI export. Skip unrelated regulatory filings.
- **Prefer computable formats.** If there's a JSON schema AND a PDF describing
  the same thing, get both but note the JSON is the primary artifact.
- **Capture obstacles.** Did you need special headers? Did Cloudflare block you?
  This information is as valuable as the docs themselves.
- **Be proportionate.** Single PDF with clean link? 2 minutes. Complex multi-page
  site with buried docs? Take the time. The difficulty is itself a finding.
- **Use subagents** if available to parallelize downloads or explore multiple paths.
