# Stage 2: Discover and Classify EHI Export Documentation

You are visiting EHI export documentation URLs to understand what each vendor
provides and how to download it.

## Context

Under 170.315(b)(10), EHR vendors must publicly document their EHI export format.
These URLs were extracted from CHPL certification listings. The documentation
varies enormously across vendors:

**What you'll encounter (from our exploratory spike of 16 vendors):**

- **Dedicated documentation sites** (best case): Static HTML with table/field
  definitions, downloadable ZIPs/PDFs. Examples: Epic's open.epic.com/EHITables,
  TruBridge's ehi-export.plt.trubridge.com, Greenway's ehi.greenwayhealth.com

- **Compliance/legal landing pages**: A page listing multiple ONC requirements
  with the EHI export docs buried in an accordion or section. Links to PDFs or
  ZIPs from there. Examples: Oracle, Altera, Veradigm, SightView

- **JavaScript SPAs**: Modern doc portals that require browser rendering.
  Example: athenahealth's docs.athenahealth.com/athenaone-dataexports/

- **Obfuscated URLs**: Intentionally hard-to-find paths that work but are hidden
  from search engines. Example: NextGen's /sldkjljieo0935jljsrnfkl

- **Marketing pages with docs embedded**: Product pages that happen to contain
  EHI export documentation links. Example: AdvancedMD, MEDHOST

- **Direct PDF/ZIP links**: The URL itself is the downloadable file

- **Dead links / redirects / login walls**: Some URLs may be broken, redirect to
  a homepage, or require authentication. Document these failures precisely.

## Your Batch

Your batch file is at: `{{BATCH_FILE}}`

It contains a JSON array of objects with:
```json
{
  "url": "https://...",
  "developers": ["Vendor A", "Vendor B"],
  "products": ["Product X", "Product Y"],
  "chpl_ids": [1234, 5678]
}
```

(Multiple products may share the same URL.)

## Task

For each unique URL:

### Step 1: Initial probe with curl
```bash
curl -sI -L "$URL" -H 'User-Agent: Mozilla/5.0' 2>&1 | head -30
```
Check: HTTP status, Content-Type, redirects, content-disposition.

If it's a direct file download (PDF, ZIP, XLSX), note that and skip to classification.

### Step 2: Fetch the page content
```bash
curl -sL "$URL" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
```
Examine the HTML. Search for:
- Links to PDFs, ZIPs, XLSX files (href containing .pdf, .zip, .xlsx)
- Links with text containing "EHI", "export", "data dictionary", "documentation"
- Accordion/expandable sections (look for common patterns: aria-expanded, collapse, accordion)
- If the page is mostly JavaScript with minimal HTML content, flag as SPA (needs browser)

### Step 3: If SPA, use the browser
Navigate to the URL, wait for rendering, then:
- Get all links on page
- Look for navigation/sidebar elements
- Screenshot for reference
- Extract text content

### Step 4: Follow links to find actual documentation
The landing page often isn't the documentation itself. Look for:
- "EHI Export" or "Electronic Health Information" sections
- "Data Dictionary" links
- "Export Documentation" links
- "170.315(b)(10)" references

Follow ONE level deep. If a link leads to another page with the actual docs, follow it.

### Step 5: Classify what you found

## Output

Write results to: `{{OUTPUT_FILE}}`

Format: JSON array of objects:
```json
[
  {
    "url": "https://...",
    "developers": ["Vendor A"],
    "products": ["Product X"],
    "status": "found|dead|redirect_to_homepage|login_required|error",
    "documentation_type": "html_site|pdf|zip|xlsx|spa|mixed",
    "requires_browser": false,
    "downloadable_assets": [
      {
        "url": "https://full/url/to/file.pdf",
        "type": "pdf",
        "description": "EHI Export Data Dictionary",
        "size_bytes": 12345,
        "curl_command": "curl -L -o file.pdf 'https://...'"
      }
    ],
    "html_documentation_urls": ["https://...page1", "https://...page2"],
    "notes": "Free text about anything notable",
    "ehi_specific": true,
    "shares_page_with_other_compliance": true
  }
]
```

## Advice for Tough Cases

- **If you hit a redirect to a homepage**: The vendor may have moved or removed
  their docs. Try searching the site for "EHI" or "b10" or "export documentation".
  Check the Wayback Machine: `https://web.archive.org/web/*/{{URL}}`

- **If the page requires login**: Note it. Some vendors gate their docs behind
  customer portals, which may violate the "publicly accessible" requirement.

- **If you find multiple products on one page**: Document all downloadable assets
  and note which product each belongs to.

- **If the URL returns 404**: Try the domain root and search for EHI docs.
  Also try common paths: /legal/, /compliance/, /onc/, /ehi/, /interoperability/

- **If it's a massive page with lots of compliance info**: The EHI export section
  is often labeled "170.315(b)(10)" or "Electronic Health Information Export" or
  just "EHI Export". Use Ctrl+F equivalent (grep) for these terms.

- **Don't confuse FHIR API docs with EHI export docs**: FHIR Bulk Data and
  SMART-on-FHIR are separate capabilities (different criteria). The EHI export is
  170.315(b)(10) — a file-based export of ALL patient data, not an API.
  However, some vendors (like MEDHOST) legitimately use FHIR NDJSON as their
  export format — that's fine, it's the output format of the b(10) export.

- **Be relentless**: Some vendors make their docs hard to find. That itself is a
  finding worth documenting. But try hard before giving up — check accordions,
  scroll to the bottom, expand all sections, look in page source for hidden links.
