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
- **FHIR API documentation that describes the vendor's (g)(7)–(g)(10) API** —
  this is a *different* ONC criterion from b(10) EHI export. Many vendors have
  both a FHIR API (for app access) and a separate EHI export (for bulk file
  export). We want the EHI export docs, not the FHIR API docs. However, if the
  vendor uses FHIR Bulk Data *as* their b(10) export mechanism, then those docs
  ARE relevant — use your judgment.
- **Marketing materials** — unless they contain substantive EHI export information
- **Compliance certificates** — unless they contain technical export details
- **Unrelated regulatory documents** — real-world testing plans, SVAP notices, etc.
  unless they describe the export mechanism
- **Prose descriptions of standard FHIR resources** — if a vendor's FHIR portal
  has pages describing what Patient, Condition, etc. resources contain, skip those.
  We already know. Only download vendor-specific documentation (custom profiles,
  extensions, proprietary export formats, data dictionaries).

### Follow vendor-internal links

If the documentation page links to other pages **on the same vendor's domain**
(or clearly vendor-owned domains) that contain API docs, data dictionaries,
or technical specifications for understanding the export — follow those links
and download that content too. The goal is a self-contained archive.

For example: if the EHI page links to `docs.vendorname.com/api/bulk-export/`,
follow it and download the relevant pages. But if it links to
`hl7.org/fhir/R4/patient.html`, skip it.

### Prefer computable formats

When a document is available in multiple formats, prefer the most computable:
- JSON/YAML/XML schema over PDF description of the same schema  
- CSV/TSV data dictionary over PDF table
- HTML with structured tables over a scanned PDF
- If only PDF exists, that's fine — download it

If a ZIP contains structured files (HTML data dictionary, CSV exports, etc.),
download and extract it.

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
