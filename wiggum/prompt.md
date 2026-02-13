# EHI Export Documentation: Find, Collect, and Characterize

You are collecting EHI export documentation for a single EHR vendor's registered
documentation URL. Your primary job is to **find the documentation, download
everything, and document exactly how you got it** so that a human or machine
could reproduce the entire collection process.

## Background

Under ONC's Cures Act rule 170.315(b)(10), certified EHR systems must publicly
document their Electronic Health Information (EHI) export format via a hyperlink
registered in CHPL. "All EHI" = the HIPAA Designated Record Set — clinical data,
billing, insurance, messages, documents, everything the system stores about a patient.

This is NOT the same as FHIR/US Core APIs (a different ONC criterion). EHI export
is a file-based export of ALL patient data — no terminology mapping required, no
FHIR resource constraints. The data flows as-is from the system's database.

## Your Target

**URL**: {{URL}}
**Developer(s)**: {{DEVELOPERS}}
**Product(s)**: {{PRODUCTS}}
**CHPL IDs**: {{CHPL_IDS}}

**Output directory**: {{OUTPUT_DIR}}

Put ALL output files in that directory. Create subdirectories as needed.

## Part 1: Find the Documentation (Navigation Journal)

Keep a detailed log of every step you take to find the actual EHI export
documentation. This is the most important part of your output. Someone reading
your log should be able to follow your exact steps and end up at the same
documents.

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
cat /tmp/page.html | sed 's/<[^>]*>/ /g' | tr -s ' \n' | head -50
```

**3. Search the page for documentation links:**
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html
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
- Common paths: /legal/, /compliance/, /onc/, /ehi/, /interoperability/
- Wayback Machine: `curl -s "https://web.archive.org/web/2024*/{{URL}}"`
- Google (via curl): `curl -s "https://www.google.com/search?q=site:{{domain}}+EHI+export+documentation"`

Record everything you tried, including what didn't work.

### Patterns you'll encounter:

| Pattern | Example | What it looks like |
|---------|---------|--------------------||
| Static HTML + ZIP download | Epic open.epic.com/EHITables | Clean page with "Download" button, ZIP contains thousands of HTM files |
| Compliance hub with accordion | Oracle, Altera, Veradigm | Long legal page, EHI section buried in expandable panel with PDF/ZIP links inside |
| Dedicated doc subdomain | Greenway ehi.greenwayhealth.com | Purpose-built HTML site with sidebar nav, table viewer, field definitions |
| JavaScript SPA | athenahealth docs.athenahealth.com | React/Angular app, blank page via curl, needs browser to see content |
| Marketing page with docs embedded | AdvancedMD, MEDHOST | Product marketing page with an "EHI Export" section mixed in among other content |
| Obfuscated URL | NextGen /sldkjljieo0935jljsrnfkl | Works but intentionally hard to find, often x-robots-tag: noindex |
| Direct file link | Some small vendors | The registered URL IS the PDF/ZIP, downloads immediately |
| Dead/moved | Common in long tail | 404, redirect to homepage, domain parked, requires investigation |
| Login wall | Occasional | Customer portal login (violates "publicly accessible" requirement — document it) |

### Anti-bot / access issues we've seen:
- **Oracle** requires a User-Agent header or returns an HTML redirect page
- **Some WordPress sites** use lazy-loading JS (RocketLoader) that wraps real content
- **Accordion content** is often in the HTML source but hidden via CSS (display:none) — grep still finds it
- **Marketo-hosted PDFs** occasionally want cookies
- **HubSpot-hosted pages** are generally well-behaved for curl
- **Webflow-hosted pages** have content in the HTML but with lots of wrapper divs

## Part 2: Download Everything

Create a `downloads/` subdirectory under your output directory.

Download every documentation artifact you found:

```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o {{OUTPUT_DIR}}/downloads/ehi-data-dictionary.pdf \
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
mkdir -p {{OUTPUT_DIR}}/downloads/extracted/
unzip -o archive.zip -d {{OUTPUT_DIR}}/downloads/extracted/
find {{OUTPUT_DIR}}/downloads/extracted/ -type f | head -20  # sample of contents
find {{OUTPUT_DIR}}/downloads/extracted/ -type f | wc -l     # total file count
du -sh {{OUTPUT_DIR}}/downloads/extracted/                   # total size
```

## Part 3: Characterize the Documentation

Now that you have the files, characterize what's there.

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
# Example: search extracted content for billing-related tables
find {{OUTPUT_DIR}}/downloads/ -type f | xargs grep -liE 'billing|charge|claim|payment' | head -20
```

**Does the vendor provide any of these?**
- Sample/example export files or test data
- Developer getting-started guide for processing exports
- Sandbox or test environment
- Source code or tools for reading the export

## Part 4: EHI Export vs FHIR APIs — Why This Matters

When characterizing what a vendor's EHI export contains, keep this in mind:

**FHIR US Core** looks comprehensive on paper — USCDI is up to v7 — but in
practice it only works as well as the customer's terminology mapping. A hospital
using local charge codes, homegrown problem list entries, or non-standard medication
descriptions won't surface that data through FHIR unless someone maps it. Much
of the data simply doesn't appear over the API because the mapping hasn't been done.

**EHI export** has a fundamentally different assumption: the data flows as-is, in
whatever form the system stores it. No mapping. You get local codes, free-text
fields, internal identifiers, custom form data — everything. Messier but far
more complete.

So EHI export is often the **only practical way** to access:
- Billing line items with actual charge amounts
- Insurance authorization details
- Patient-provider portal messages
- Custom/specialty-specific data
- Local codes and free-text that hasn't been terminology-mapped
- Administrative data (scheduling, registration, consent tracking)
- Audit trails
- Historical data predating the FHIR implementation

When you see a vendor's docs, ask: is this vendor just re-exporting FHIR
resources (adds little beyond the API), or dumping their actual database
(contains far more than FHIR could surface)?

## Output Files

Write these files to {{OUTPUT_DIR}}:

### 1. `collection-log.md` — Navigation & Collection Log

The reproducibility record. Example structure:

```markdown
# {{Vendor Name}} — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 12345
- Products: Product A
- Registered URL: https://...

## Navigation Journal

### Step 1: Initial probe
(curl command and result)

### Step 2: Page examination
(what the page looks like, size, SPA vs static)

### Step 3: Finding the EHI section
(how you navigated to the actual docs)

### Step 4: Identified downloadable assets
(list of files found)

## Downloads

### filename.pdf (684 KB)
(curl command)
Verified: (file command output)
Saved to: (local path)

## Obstacles & Notes
(anti-bot, special headers, dead ends, anything notable)
```

### 2. `analysis.json` — Structured characterization

```json
{
  "vendor": "Vendor Name",
  "products": ["Product A"],
  "chpl_ids": [12345],
  "export_documentation_url": "https://...",
  "access": {
    "status": "found|dead|redirect_to_homepage|login_required|error",
    "requires_browser": false,
    "anti_bot_protection": "none|cloudflare|user_agent_required|other",
    "navigation_complexity": "direct_link|one_click|accordion|multi_page|spa_navigation"
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
    "clinical":                {"present": true,  "evidence": "..."},
    "secure_messages":         {"present": false, "evidence": "searched for message/inbox — not found"},
    "billing_financial":       {"present": true,  "evidence": "Charge, Claim, Payment tables"},
    "insurance_coverage":      {"present": true,  "evidence": "Insurance table with 12 fields"},
    "appointments_scheduling": {"present": true,  "evidence": "Appointment table"},
    "documents_images":        {"present": true,  "evidence": "Documents folder"},
    "audit_trails":            {"present": false, "evidence": "searched for audit/access — not found"}
  },
  "sample_exports_available": false,
  "developer_guide_available": false,
  "downloaded_files": [
    {
      "local_path": "downloads/file.pdf",
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

- **When in doubt, download it.** Better to have a file we don't need than to
  miss one we do.

- **Stay focused on this one vendor.** Do it thoroughly and move on.
