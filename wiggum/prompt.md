# EHI Export Documentation: Find, Collect, and Characterize

You are investigating the EHI export documentation for a single EHR vendor's
registered URL. Your job has three phases:

1. **Find and download** the documentation, recording every step so it's reproducible
2. **Research the broader product** to understand what data the system actually stores
3. **Characterize** what the export covers — and what it might be missing

## Background

Under ONC's Cures Act rule 170.315(b)(10), certified EHR systems must support
export of **all electronic health information that can be stored at the time of
certification by the product, of which the Health IT Module is a part.**

That last phrase is critical. The certified module might be called "athenaClinicals"
but the *product* is "athenaOne" — which also includes billing, patient portal
messaging, and scheduling. The export must cover data from the entire product,
not just the certified module.

"All EHI" means the HIPAA Designated Record Set — not just clinical data. It
includes:

1. **Clinical** — diagnoses, medications, allergies, vitals, labs, immunizations,
   procedures, clinical notes, assessments, care plans, family/social history,
   problem lists, nursing documentation, pathology, radiology
2. **Secure messages** — patient-provider portal messages, in-basket/inbox messages,
   chat transcripts, any stored communication between patients and providers
3. **Billing/financial** — charges, claims, payments, adjustments, CPT/ICD codes,
   EOBs, transaction history, write-offs, collections, cost estimates
4. **Insurance/coverage** — insurance plans, eligibility, authorizations, referrals,
   prior auths, payer information, benefits, copay/deductible data
5. **Administrative** — appointments, scheduling, demographics (full, not just USCDI),
   consent forms, advance directives, registration data, provider assignments
6. **Documents/images** — scanned documents, uploaded images, DICOM/radiology,
   attached files, faxes, correspondence, patient-uploaded photos
7. **Audit/access** — who accessed the record, when, what they viewed or changed
   (if stored as part of the designated record set)

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

**CHPL metadata**: `{{OUTPUT_DIR}}/chpl-metadata.json` has structured
certification data (developer website, product versions, certification dates,
all certified criteria) if you need to cross-check or debug anything.

---

## Part 1: Find the Documentation (Navigation Journal)

Keep a detailed log of every step you take. Someone reading your log should be
able to follow your exact steps and arrive at the same documents.

### Step-by-step process:

**1. Initial probe — what does the URL return?**
```bash
curl -sI -L "$URL" -H 'User-Agent: Mozilla/5.0' 2>&1
```
Record: HTTP status chain (301→302→200), final URL, Content-Type, any
content-disposition headers. If it's a direct file download, note the file type
and move to Part 2.

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

Record exactly which section you had to expand and what the heading was.

**6. Follow links one or two levels deep:**
The landing page often isn't the documentation itself. Record each hop:
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

---

## Part 2: Download Everything

Create a `downloads/` subdirectory under your output directory.

Download every EHI export documentation artifact you found. Be selective —
download data dictionaries, export specs, and schema definitions. Skip compliance
certificates, marketing brochures, and unrelated regulatory documents unless
they contain EHI export information.

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
- Name files descriptively: `vendorname-ehi-data-dictionary.pdf` not `doc1.pdf`

If a download returns HTML instead of the expected file, try adding `Accept`
headers or different User-Agent strings. Retry once with different headers
before marking as failed.

---

## Part 3: Research the Broader Product

This is critical: you must go **beyond the export documentation URL** to the
vendor's main website (and possibly other public sources). The b(10) requirement
covers "all EHI that can be stored by the product, of which the Health IT
Module is a part" — so we need to understand the full product.

The export doc URL ({{URL}}) tells you what the vendor *says* they export.
The vendor's main website tells you what the product *actually does* — and
therefore what data it probably stores. The gap between those two is the story.

### How to research:

Start from the vendor's main website (usually obvious from the export doc URL
domain, or search for "{{DEVELOPERS}} EHR"). Look at product pages, feature
lists, customer-facing documentation, press releases, screenshots.

### What to investigate:

1. **Visit the vendor's main website** — look for product pages, feature lists,
   screenshots. What does the product do? Is it a full EHR? A specialty system?
   A lab information system? A middleware platform?

2. **Identify the relationship between the certified module and the broader product** —
   Is the certified module the whole product, or a component? For example:
   - Epic's certified module "EpicCare Ambulatory Base" is part of the Epic EHR
   - athenahealth's certified module "athenaClinicals" is part of "athenaOne"
   - Clinisys's certified module is a laboratory information system
   - Imprivata's certified module is an identity/audit tool

3. **Determine what data the product stores** — Does it have:
   - A patient portal with messaging?
   - Billing/revenue cycle management?
   - Appointment scheduling?
   - Document management/scanning?
   - Specialty-specific modules (ophthalmology, behavioral health, oncology)?

4. **Compare product capabilities to export coverage** — If the product has a
   patient portal with messaging, but the export doesn't include messages, that's
   a significant gap. Document what you find.

Don't over-research this — a few minutes on the vendor's website is enough.
The goal is context, not an exhaustive product review.

---

## Part 4: Characterize the Documentation

Now that you have the files and product context, characterize what's there.

### Export approach

This is one of the most important things to understand. How does the vendor
approach the export? The approach has huge implications for completeness:

- **Native database export** — vendor dumps their actual database tables (Epic's
  7,673 TSV tables, Oracle's SQL schemas, eClinicalWorks' table-per-file HTML docs).
  This is the gold standard because the database inherently contains everything.
  The documentation describes internal table structures.

- **FHIR resource export** — vendor exports standard FHIR R4 resources as NDJSON
  or JSON bundles (MEDHOST, Azalea, some Darena products). This is clean but
  limited to what FHIR R4 can represent. Standard FHIR has gaps in billing detail,
  messaging, audit trails, and specialty-specific data.

- **C-CDA/CCD document export** — vendor generates clinical document architecture
  XML (AssureCare, some Dynamic Health IT products). **Be skeptical here.** C-CDA
  covers clinical summaries well but almost never includes billing line items,
  insurance authorization details, portal messages, scheduling, or audit trails.
  If a vendor's only export is C-CDA, they are almost certainly missing major
  EHI categories.

- **Hybrid/mixed** — some combination of the above (MEDITECH uses FHIR + C-CDA +
  native text files; Veradigm uses native JSON + FHIR depending on the product).

Describe what you see in narrative, then tag it.

### Documentation depth

How detailed is the documentation? Look for these levels:
- **Schema level** — does it define database tables, FHIR resources, or file structures?
- **Field level** — does it list individual columns/fields with names and data types?
- **Value level** — does it document code sets, enumerations, allowed values?
- **Relationship level** — does it document foreign keys, references between tables?
- **Example level** — does it provide sample records or example data?

A vendor with 100 well-documented tables covering all categories is more valuable
than one with 5,000 tables that are all clinical. Don't be fooled by table counts.

### EHI coverage analysis

Search the downloaded content for evidence of the 7 categories. Use grep or
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

**Check for the hard stuff.** The easy categories (diagnoses, medications, labs)
are always present. The differentiator is: secure messages, billing line items
with actual dollar amounts, insurance authorization details, and audit trails.
These are the categories most likely to be missing, and the ones that matter
most for assessing completeness.

### Important distinction: PDF as documentation vs PDF as export

It's perfectly fine for **documentation** to be a PDF (a data dictionary PDF
is normal). It's problematic for the actual **export data** to be PDF — that's
not machine-readable. Don't confuse the two. If the vendor exports patient data
as PDF rather than structured data (CSV, JSON, etc.), flag that as an issue.

---

## Part 5: Why EHI Export Matters Beyond FHIR

When characterizing what a vendor's export contains, keep this context in mind:

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

---

## Output Files

Write these files to {{OUTPUT_DIR}}:

### 1. `collection-log.md` — Navigation & Collection Log

The reproducibility record. Structure:

```markdown
# {{Vendor Name}} — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 12345, 12346
- Registered URL: https://...

## Navigation Journal

### Step 1: Initial probe
(curl command and full result)

### Step 2: Page examination
(what the page looks like, size, SPA vs static)

### Step 3: Finding the EHI section
(how you navigated to the actual docs)

### Step 4: Identified downloadable assets
(list of files found with URLs)

## Downloads

### filename.pdf (684 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o filename.pdf 'https://...'
```
Verified: `file filename.pdf` → PDF document, version 1.7
Pages: 142 (from pdfinfo)
Saved to: downloads/filename.pdf

## Obstacles & Notes
(anti-bot issues, special headers, dead ends, anything notable)

---

## Product: {{Product Name A}} (e.g., "MEDITECH Expanse")

### Product Context
(what you learned about this product from the vendor's website — what it does,
who uses it, what data it stores, patient portal, billing, messaging, etc.)

### Export Approach
(how this product's export works — database dump, FHIR, C-CDA, etc.
which downloaded files apply to this product)

### EHI Coverage Assessment
(narrative walkthrough of the 7 categories — what's present, what's missing,
what's suspicious. connect the product context to the export: if the product
has messaging but the export doesn't include it, say so and explain why it matters)

### Issues & Red Flags
(specific concerns for this product)

---

## Product: {{Product Name B}} (e.g., "MEDITECH MAGIC")

(same structure — repeat for each distinct product at this URL)
```

### 2. `analysis.json` — Structured Characterization

The JSON below shows the target schema. Follow these rules:
- **Narrative first, then structure.** For complex assessments, write a
  `description` field with your full analysis, then provide structured fields
  that summarize it. This ensures nuance isn't lost in categorization.
- **Use the standard 7 EHI categories only.** Don't add extra categories.
  Specialty-specific data goes in the `evidence` of the most relevant category.
- **`present` must be a boolean** (true/false). Use `evidence` to explain
  nuance like "partial" or "only for some products."
- **Don't add ad-hoc top-level keys.** If you have extra information, put it
  in the `notes` field of the relevant section, or in the top-level `notes`.
- **Tags are freeform strings.** Use them to capture concepts that don't fit
  neatly into the schema. Be specific and descriptive.

**Important: multiple distinct products at one URL.** Many URLs document
several related but distinct products (e.g., MEDITECH Expanse vs MEDITECH 6.x
vs MEDITECH MAGIC — same URL, different platforms with different export
approaches). When this happens, produce a **separate entry in the `products`
array** for each distinct product. Don't try to squash different products into
one analysis — the differences matter.

Group by distinct product, not by every CHPL version. MEDITECH Expanse 2.1
and Expanse 2.2 are the same product; MEDITECH Expanse and MEDITECH MAGIC are
not. Use your judgment.

```json
{
  "vendor": "Vendor Name",
  "export_documentation_url": "https://...",
  "collection_date": "2026-02-13",

  "access": {
    "description": "Narrative of how you accessed the documentation — redirects,
      accordion navigation, browser requirements, anti-bot issues, etc.",
    "final_url": "https://... (after redirects, if different from registered URL)",
    "status": "found|dead|redirect_to_homepage|login_required|error",
    "requires_browser": false,
    "anti_bot_protection": "none",
    "navigation_complexity": "direct_link|one_click|accordion|multi_page|spa_navigation"
  },

  "products": [
    {
      "name": "Product Name (e.g., 'MEDITECH Expanse' not 'MEDITECH Expanse 2.2 Core HCIS')",
      "chpl_ids": [12345, 12346],
      "certified_module_names": ["MEDITECH Expanse 2.1 Core HCIS", "MEDITECH Expanse 2.2 Core HCIS"],

      "product_context": {
        "description": "Narrative description of this specific product. What is it?
          Who uses it? What does it do? Is the certified module the whole product
          or a component of something larger? What data does the broader product
          store that might be relevant to EHI export completeness?",
        "tags": ["full-ehr", "ambulatory", "has-patient-portal", "has-billing",
                 "has-scheduling"],
        "broader_product_name": "athenaOne",
        "product_url": "https://www.athenahealth.com/..."
      },

      "export_approach": {
        "description": "Narrative description of how this product's EHI export works.
          Do they dump native database tables? Export FHIR resources? Generate C-CDA?
          Some combination? How does this affect completeness?",
        "tags": ["database-native", "tsv-format", "single-zip-export", "7673-tables"],
        "primary_format": "tsv",
        "file_types": ["tsv", "pdf", "png"],
        "container": "zip"
      },

      "documentation_quality": {
        "description": "Narrative assessment of the documentation for this product.",
        "tags": ["field-level-detail", "includes-data-types"],
        "schema_documented": true,
        "field_level_detail": true,
        "value_sets_documented": false,
        "relationships_documented": false,
        "examples_provided": false,
        "table_or_resource_count": 261,
        "documentation_format": "html",
        "documentation_version": "v3.2 (if visible)",
        "documentation_last_updated": "2025-09-24 (if visible)"
      },

      "ehi_coverage": {
        "overall_assessment": "Narrative assessment of how completely this product's
          export covers the full EHI / Designated Record Set. What's strong?
          What's missing? Given what the broader product does, are there
          capabilities whose data appears absent from the export?",
        "clinical": {
          "present": true,
          "evidence": "Full clinical tables including diagnoses, medications, labs..."
        },
        "secure_messages": {
          "present": false,
          "evidence": "Searched for message/inbox/communication — not found.
            The product has a patient portal (verified on vendor website) so
            messaging data likely exists but is not included in the export."
        },
        "billing_financial": {
          "present": true,
          "evidence": "Charge, Claim, Payment tables with dollar amounts..."
        },
        "insurance_coverage": {
          "present": true,
          "evidence": "Insurance table with plan, eligibility, authorization fields..."
        },
        "appointments_scheduling": {
          "present": true,
          "evidence": "Appointment table with date, time, status, provider..."
        },
        "documents_images": {
          "present": true,
          "evidence": "Documents folder with scanned images, uploaded files..."
        },
        "audit_trails": {
          "present": false,
          "evidence": "No audit tables found in export documentation."
        }
      },

      "issues": [
        "Describe specific problems, red flags, or compliance concerns for this product."
      ],

      "summary": "2-3 sentence summary of this product's EHI export capability."
    }
  ],

  "downloaded_files": [
    {
      "local_path": "downloads/file.pdf",
      "source_url": "https://...",
      "size_bytes": 12345,
      "type": "pdf",
      "is_ehi_documentation": true,
      "description": "EHI Export Data Dictionary covering all 261 tables",
      "curl_command": "curl -L -H 'User-Agent: Mozilla/5.0' -o file.pdf 'https://...'"
    }
  ],

  "summary": "2-4 sentence vendor-level summary covering the overall picture
    across all products at this URL.",

  "notes": "Any additional observations that don't fit elsewhere."
}
```

### Red flags to watch for:
- C-CDA or QRDA as the only export format (almost certainly missing billing, messages, audit)
- Export requires contacting vendor support (not self-service)
- Documentation behind a login wall (violates public accessibility requirement)
- Obfuscated URLs with noindex/nofollow (intentionally hiding docs)
- Product clearly has capabilities (portal, billing) whose data is absent from the export
- Non-clinical data exported as PDF only (not machine-readable)
- Documentation clearly outdated or incomplete
- "Contact us for details" instead of actual documentation

---

## Mindset

- **Use subagents to parallelize.** If you have the subagent tool available,
  use it. For example: kick off a subagent to research the vendor's website
  and product capabilities while you download and examine the export docs.
  Or when multiple distinct products need analysis, farm them out in parallel.
  This is especially valuable for multi-product URLs.

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

- **Be proportionate with your time.** If a vendor has a single PDF download with
  a clean link, spend 2 minutes and move on. Save your investigative energy for
  vendors with complex multi-page sites, accordion-buried docs, or missing links.
  But DO spend the time when something is genuinely hard to find — that difficulty
  is itself a finding.

- **When in doubt, download it.** Better to have a file we don't need than to
  miss one we do. But mark non-EHI files (compliance certificates, screenshots)
  with `is_ehi_documentation: false` so we can distinguish them.

- **Show your understanding.** The narrative description fields are where you
  demonstrate insight. Don't just list facts — interpret them. What does the
  export approach tell you about completeness? What does the product context
  tell you about potential gaps? Connect the dots.
