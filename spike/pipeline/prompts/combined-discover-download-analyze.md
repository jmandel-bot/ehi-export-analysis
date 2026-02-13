# EHI Export Documentation: Find, Collect, and Characterize

You are collecting EHI export documentation for a batch of EHR vendors. Your
primary job is to **find the documentation, download everything, and document
exactly how you got it** so that a human or machine could reproduce the entire
collection process. Analysis comes after collection.

## Background

Under ONC's Cures Act rule 170.315(b)(10), certified EHR systems must publicly
document their Electronic Health Information (EHI) export format via a hyperlink
registered in CHPL. "All EHI" = the HIPAA Designated Record Set — clinical data,
billing, insurance, messages, documents, everything the system stores about a patient.

## Your Batch

Your batch file is at: `{{BATCH_FILE}}`

JSON array of objects:
```json
[
  {
    "url": "https://...",
    "developers": ["Vendor Name"],
    "products": ["Product Name"],
    "chpl_ids": [12345]
  }
]
```

## Part 1: Find the Documentation (Navigation Journal)

For each vendor URL, keep a detailed log of every step you take to find the
actual EHI export documentation. This is the most important part of your output.
Someone reading your log should be able to follow your exact steps and end up
at the same documents.

### Step-by-step process:

**1. Initial probe — what does the URL return?**
```bash
curl -sI -L "$URL" -H 'User-Agent: Mozilla/5.0' 2>&1
```
Record: HTTP status chain (301→302→200), final URL, Content-Type, any
content-disposition headers. If it's a direct file download, you're done
with discovery — note the file type and move to Part 2.

**2. Fetch and examine the page:**
```bash
curl -sL "$URL" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html
```
Record: page size, whether it's real HTML content or a thin JS loader.

Check if the page has substantive content or is mostly JavaScript:
```bash
# If this returns very little text, it's likely a SPA that needs a browser
cat /tmp/page.html | sed 's/<[^>]*>/ /g' | tr -s ' \n' | head -50
```

**3. Search the page for documentation links:**
```bash
# Find all downloadable file links
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html

# Find EHI-related links
grep -oiE 'href="[^"]*[^"]*"' /tmp/page.html | grep -iE 'ehi|export|data.dictionary|b.10'
```

**4. If the page is a SPA or needs JavaScript:**
- Navigate to the URL in the browser
- Wait for content to load
- Take a screenshot
- Note what you see: navigation sidebar? accordion sections? tabs?
- Record what you had to click/expand to find the EHI content

**5. If the page is a compliance/legal hub with multiple sections:**
These are common. The EHI export docs are often buried. Look for:
- Accordion/expandable sections (click to expand)
- Sections labeled "170.315(b)(10)" or "EHI Export" or "Electronic Health Information"
- Sometimes it's under "Interoperability" or "Data Export" or "ONC Compliance"
- Check the page source for hidden content in collapsed accordions

Record exactly which section you had to expand and what the section heading was.

**6. Follow links one or two levels deep:**
The landing page often isn't the documentation itself. It links to it. Record
each hop:
- "From the main page, I clicked 'EHI Export Documentation' which led to..."
- "That page contained a link to a PDF at..."
- "The PDF link was inside an accordion labeled '170.315(b)(10)'"

**7. If the URL is dead (404, domain expired, redirects to homepage):**
Don't give up immediately. Try:
- The domain root and search for EHI docs
- Common paths: `/legal/`, `/compliance/`, `/onc/`, `/ehi/`, `/interoperability/`
- Wayback Machine: `curl -s "https://web.archive.org/web/2024*/{{URL}}"` 
- Google: `site:{{domain}} EHI export documentation`

Record everything you tried, including what didn't work.

### What you'll encounter (patterns from our 16-vendor spike):

| Pattern | Example | What it looks like |
|---------|---------|--------------------|
| Static HTML + ZIP download | Epic open.epic.com/EHITables | Clean page with "Download" button, ZIP contains thousands of HTM files |
| Compliance hub with accordion | Oracle, Altera, Veradigm | Long legal page, EHI section buried in expandable panel with PDF/ZIP links inside |
| Dedicated doc subdomain | Greenway ehi.greenwayhealth.com, TruBridge ehi-export.plt.trubridge.com | Purpose-built HTML site with sidebar nav, table viewer, field definitions |
| JavaScript SPA | athenahealth docs.athenahealth.com | React/Angular app, blank page via curl, needs browser to see content |
| Marketing page with docs embedded | AdvancedMD, MEDHOST | Product marketing page with an "EHI Export" section mixed in among other content |
| Obfuscated URL | NextGen /sldkjljieo0935jljsrnfkl | Works but intentionally hard to find, often `x-robots-tag: noindex` |
| Direct file link | Some small vendors | The registered URL IS the PDF/ZIP, downloads immediately |
| Dead/moved | Common in long tail | 404, redirect to homepage, domain parked, requires investigation |
| Login wall | Occasional | Customer portal login, which violates the "publicly accessible" requirement |

### Anti-bot / access issues we've seen:
- **Oracle** requires a `User-Agent` header or returns an HTML redirect page instead of the PDF
- **Some WordPress sites** use lazy-loading JS (RocketLoader) that wraps real content
- **Accordion content** is often in the HTML source but hidden via CSS (`display:none`) — grep still finds it
- **Marketo-hosted PDFs** (AdvancedMD) occasionally want cookies
- **HubSpot-hosted pages** (Nextech, SightView) are generally well-behaved for curl
- **Webflow-hosted pages** (CareCloud) have content in the HTML but with lots of wrapper divs

## Part 2: Download Everything

Create: `/home/exedev/EHI/pipeline/results/{{VENDOR_SLUG}}/downloads/`

Vendor slug = lowercase developer name, spaces/special chars to hyphens.

Download every documentation artifact you found:

```bash
# Example downloads — adapt per vendor
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o /path/to/vendor/downloads/ehi-data-dictionary.pdf \
  'https://example.com/path/to/file.pdf'
```

For each file:
- Record the exact curl command (including any special headers needed)
- Verify the download: check file size, use `file` command to confirm type
- For ZIPs: `unzip -l archive.zip | tail -5` to get file count and total size
- For ZIPs: extract to a subdirectory and note the structure
- For HTML doc sites: download the index page + a representative sample of subpages
  (prefer a downloadable ZIP/PDF over scraping if one exists)

### Extraction:
For ZIP files, extract them and document the structure:
```bash
mkdir -p /path/to/vendor/downloads/extracted/
unzip -o archive.zip -d /path/to/vendor/downloads/extracted/
find /path/to/vendor/downloads/extracted/ -type f | head -20  # sample of contents
find /path/to/vendor/downloads/extracted/ -type f | wc -l     # total file count
du -sh /path/to/vendor/downloads/extracted/                   # total size
```

Note the top-level structure — folders, index files, naming conventions.

## Part 3: Characterize the Documentation

Now that you have the files, characterize what's there. This is lighter-touch
than a full analysis — you're describing what you found, not grading it.

### For each vendor, determine:

**What format does the actual patient export produce?**
(This is what a patient or provider would receive — not the documentation format)
- CSV, JSON, TSV, NDJSON, C-CDA XML, SQL dump, PDF, database backup, mixed?
- Packaged as ZIP? With folder structure? With a manifest/TOC?

**What does the documentation look like?**
- How many tables/resources/datasets are documented?
- Does it go to field level (column names, data types, descriptions)?
- Does it provide value sets / code enumerations?
- Is there a schema definition (DDL, JSON Schema, XSD) or just prose/tables?

**What data domains does it cover?**
Search the downloaded content for evidence of these categories. Use grep or
search the extracted files. Record what you find — specific table names, section
headings, field names.

| Category | Search terms |
|----------|-------------|
| Secure messages | message, inbox, communication, chat, portal, secure, correspondence |
| Billing/financial | charge, claim, payment, billing, invoice, transaction, CPT, revenue, AR, accounts.receivable |
| Insurance | insurance, coverage, eligibility, authorization, payer, carrier, benefit, plan |
| Appointments | appointment, schedule, encounter, visit, booking |
| Documents/images | document, image, attachment, scan, fax, DICOM, multimedia, blob |
| Audit | audit, access.log, tracking, who.viewed, history, prologue |

```bash
# Example: search extracted Epic ZIP for billing-related tables
ls /path/to/extracted/ | grep -iE 'bill|claim|charge|payment|AR' | head -20
```

**Does the vendor provide any of these?**
- Sample/example export files or test data
- Developer getting-started guide for processing exports
- Sandbox or test environment
- Source code or tools for reading the export

## Output

For each vendor, write TWO files:

### 1. Navigation & Collection Log
`/home/exedev/EHI/pipeline/results/{{VENDOR_SLUG}}/collection-log.md`

This is the reproducibility record. Format:

```markdown
# {{Vendor Name}} — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 12345, 67890
- Products: Product A, Product B
- Registered URL: https://...

## Navigation Journal

### Step 1: Initial probe
```
curl -sI -L 'https://...' -H 'User-Agent: Mozilla/5.0'
```
Result: 200 OK, Content-Type: text/html, no redirects.

### Step 2: Page examination
The page is a WordPress site with multiple compliance sections.
Page size: 204KB. Content is server-rendered HTML (not a SPA).

### Step 3: Finding the EHI section
Searched page for 'ehi' — found in an accordion section labeled
"Electronic Health Information Export" under the heading "ONC Regulatory
Compliance." The accordion was collapsed by default but the content
(including download links) was present in the HTML source.

### Step 4: Identified downloadable assets
Inside the accordion, found:
1. PDF link: https://example.com/ehi-data-dictionary.pdf (text: "EHI Export Data Dictionary")
2. ZIP link: https://example.com/ehi-export-definition-v3.zip (text: "EHI Export Schema v3")

### Step 5: No browser interaction needed
All content was accessible via curl. No JavaScript rendering required.
No anti-bot protection encountered.

## Downloads

### ehi-data-dictionary.pdf (684 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o ehi-data-dictionary.pdf \
  'https://example.com/ehi-data-dictionary.pdf'
```
Verified: `file ehi-data-dictionary.pdf` → PDF document, version 1.7
Saved to: /home/exedev/EHI/pipeline/results/vendor-name/downloads/ehi-data-dictionary.pdf

### ehi-export-definition-v3.zip (13 MB)
```bash
curl -L -o ehi-export-definition-v3.zip 'https://example.com/ehi-export-definition-v3.zip'
```
Verified: `unzip -t ehi-export-definition-v3.zip` → OK, 5,495 files
Extracted to: /home/exedev/EHI/pipeline/results/vendor-name/downloads/extracted/
Total uncompressed: 68 MB
Structure: index.html at root, table definitions in HTML files organized by schema

## Obstacles & Notes
- No anti-bot protection
- Accordion was collapsed but content was in HTML source
- Also found links for 3 other products on the same page
- URL has been stable since at least 2023 (checked Wayback Machine)
```

### 2. Characterization
`/home/exedev/EHI/pipeline/results/{{VENDOR_SLUG}}/analysis.json`

```json
{
  "vendor": "Vendor Name",
  "products": ["Product A"],
  "chpl_ids": [12345],
  "export_documentation_url": "https://...",
  
  "access": {
    "status": "found|dead|redirect_to_homepage|login_required|error",
    "requires_browser": false,
    "requires_special_headers": false,
    "anti_bot_protection": "none|cloudflare|recaptcha|user_agent_required|other",
    "navigation_complexity": "direct_link|one_click|accordion|multi_page|spa_navigation",
    "final_url": "https://... (after redirects)"
  },
  
  "export_format": {
    "primary_format": "csv|json|tsv|fhir_ndjson|ccda_xml|sql_dump|pdf|mixed|unknown",
    "file_types": ["csv", "pdf"],
    "container": "zip|folder|single_file|multiple_exports|unknown",
    "description": "Brief description"
  },
  
  "documentation": {
    "format": "html|pdf|xlsx|zip_of_html|spa|mixed",
    "field_level_detail": true,
    "data_types_included": true,
    "table_or_resource_count": 261,
    "downloadable": true,
    "total_download_size_bytes": 12345678
  },
  
  "ehi_coverage": {
    "clinical":               {"present": true,  "evidence": "..."},
    "secure_messages":        {"present": false, "evidence": "searched for message/inbox/communication — not found"},
    "billing_financial":      {"present": true,  "evidence": "Charge, Claim, Payment tables found"},
    "insurance_coverage":     {"present": true,  "evidence": "Insurance table with 12 fields"},
    "appointments_scheduling":{"present": true,  "evidence": "Appointment table"},
    "documents_images":       {"present": true,  "evidence": "Documents folder + GenFileBlob"},
    "audit_trails":           {"present": false, "evidence": "searched for audit/access — not found"}
  },
  
  "sample_exports_available": false,
  "developer_guide_available": false,
  
  "downloaded_files": [
    {
      "local_path": "/home/exedev/EHI/pipeline/results/vendor/downloads/file.pdf",
      "source_url": "https://...",
      "size_bytes": 12345,
      "type": "pdf",
      "curl_command": "curl -L -H 'User-Agent: Mozilla/5.0' -o file.pdf 'https://...'"
    }
  ],
  
  "issues": ["List of specific problems found"],
  "summary": "2-3 sentence summary"
}
```

## Analytical Lens: EHI Export vs FHIR/US Core APIs

When characterizing what a vendor's EHI export contains, keep in mind why EHI
export matters beyond what's available through FHIR APIs.

**FHIR US Core** (the standard API that certified EHRs must support) looks
comprehensive on paper — USCDI is up to v7 now — but in practice it only works
as well as the customer's **terminology mapping**. A hospital using local charge
codes, homegrown problem list entries, or non-standard medication descriptions
won't surface that data through FHIR unless someone maps it to SNOMED, LOINC,
RxNorm, etc. In the real world, much of the data simply doesn't appear over the
API because the mapping hasn't been done.

**EHI export** has a fundamentally different assumption: the data just flows,
as-is, in whatever form the system stores it. No mapping required. You get local
codes, free-text fields, internal identifiers, custom form data — everything.
It's messier but far more complete.

This means EHI export is often the **only practical way** to access:
- **Billing line items with actual charge amounts** (not available in US Core)
- **Insurance authorization details** (not in US Core)
- **Patient-provider portal messages** (no standard FHIR mapping in most implementations)
- **Custom/specialty-specific data** (ophthalmology measurements, behavioral health
  assessments, nursing flowsheets, etc.)
- **Local codes and free-text** that haven't been mapped to standard terminologies
- **Administrative data** (scheduling, registration, consent tracking)
- **Audit trails** (no FHIR API for this in most implementations)
- **Historical data** that predates the FHIR implementation
- **Data from acquired/legacy systems** that was migrated but never terminology-mapped

When you see a vendor's export documentation, consider:
- What data here would be **hard or impossible to get through US Core FHIR APIs**
  as typically implemented? That's where the EHI export provides unique value.
- Is the vendor just re-exporting their FHIR resources (in which case the export
  adds little beyond what the API provides and probably has the same mapping gaps)?
- Or is the vendor dumping their actual database (in which case the export
  contains far more than FHIR could ever surface)?

This isn't about bashing FHIR — it's about understanding that EHI export and
FHIR APIs serve different purposes, and the export should capture data that
the API cannot.

## Mindset

- **Reproducibility is the goal.** Your collection log should be so detailed that
  someone could delete all downloaded files, follow your steps, and get the same
  result. Every curl command, every click, every expanded accordion.

- **Be curious and persistent.** If a URL 404s, investigate. If a page looks empty,
  view source. If an accordion is collapsed, check if content is in the DOM. If
  there's a "Download" button that needs JS, use the browser. Document everything
  you tried, including dead ends.

- **Capture the obstacles.** Did you need special headers? Did Cloudflare block you?
  Did you have to expand three accordion sections? Did the PDF link only appear
  after clicking a tab? This information is as valuable as the docs themselves.

- **Don't confuse FHIR Bulk Data APIs with b(10) EHI export.** They're different
  ONC criteria. However, some vendors legitimately use FHIR NDJSON as their b(10)
  export format — that's fine. The key question: is this the documentation for the
  file-based export of ALL patient data, or is it API docs for a FHIR endpoint?

- **Efficiency matters.** Don't spend 20 minutes on one vendor if it's a
  straightforward PDF download. Save your energy for the tricky ones. But DO
  spend the time when something is genuinely hard to find — that difficulty
  is itself a finding.

- **When in doubt, download it.** Better to have a file we don't need than to
  miss one we do. If you're not sure whether a PDF is the EHI export docs or
  something else, download it and note your uncertainty.
