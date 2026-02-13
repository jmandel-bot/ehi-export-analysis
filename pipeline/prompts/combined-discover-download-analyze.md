# Combined: Discover, Download, and Analyze EHI Export Documentation

You are investigating EHI export documentation for a batch of EHR vendors.
For each vendor, you will visit their documentation URL, download all artifacts,
and perform a structured analysis.

## Background

Under ONC's Cures Act rule 170.315(b)(10), certified EHR systems must:
- Support export of ALL electronic health information (EHI) for single patients
  and patient populations
- Publicly document the export format via a hyperlink registered in CHPL

"All EHI" = the HIPAA Designated Record Set. This is NOT just clinical data.
It includes:

| Category | What to look for | Search terms |
|----------|------------------|--------------|
| Clinical | Diagnoses, meds, allergies, vitals, labs, notes, procedures | Always present |
| Secure messages | Portal messages, inbox, chat, provider-patient communications | message, inbox, communication, chat, portal, secure |
| Billing/financial | Charges, claims, payments, CPT/ICD, transactions, AR | charge, claim, payment, billing, invoice, transaction, CPT, revenue, AR |
| Insurance | Plans, eligibility, authorizations, referrals, payers | insurance, coverage, eligibility, authorization, payer, carrier, benefit, plan |
| Administrative | Appointments, scheduling, demographics, consents | appointment, schedule, encounter, consent, registration |
| Documents/images | Scanned docs, uploads, DICOM, attachments, faxes | document, image, attachment, scan, fax, DICOM, multimedia |
| Audit | Access logs, who viewed/changed records, tracking | audit, access log, tracking, viewed, history |

## What you'll encounter

From our spike of 16 vendors, documentation takes these forms:

| Pattern | Example | How to handle |
|---------|---------|---------------|
| Static HTML + ZIP download | Epic, Altera | curl the page, find ZIP link, download ZIP |
| PDF data dictionary | NextGen, Netsmart, CareCloud | curl direct PDF link, note size |
| Interactive HTML site | TruBridge, Greenway | curl pages, download key HTML files |
| Compliance page with embedded links | Oracle, Veradigm, SightView | curl page, grep for PDF/ZIP links in accordions |
| JavaScript SPA | athenahealth | Must use browser to render, find downloadable PDF |
| Marketing page with docs buried | AdvancedMD, MEDHOST | Search for EHI/export section, find PDF/XLSX links |
| Direct file link | Some small vendors | The URL IS the file, just download it |
| Dead link / 404 / redirect to homepage | Common in long tail | Try domain root, search for EHI, check Wayback |
| Login wall | Occasional | Document as non-compliant (must be publicly accessible) |

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

## For Each Vendor

### Phase 1: Discover

1. **Probe the URL:**
   ```bash
   curl -sI -L "$URL" -H 'User-Agent: Mozilla/5.0' 2>&1 | head -20
   ```
   Note status code, Content-Type, redirects.

2. **Fetch the page (if HTML):**
   ```bash
   curl -sL "$URL" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
   ```

3. **Find documentation assets.** Search the HTML for links:
   ```bash
   grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json)[^"]*"' /tmp/page.html
   grep -oiE 'href="[^"]*ehi[^"]*"' /tmp/page.html
   grep -oiE 'href="[^"]*export[^"]*"' /tmp/page.html
   grep -oiE 'href="[^"]*data.dictionary[^"]*"' /tmp/page.html
   ```

4. **If mostly empty HTML (SPA):** Use browser to navigate and find content.

5. **If compliance hub page:** Look for sections mentioning b(10), EHI export,
   or "Electronic Health Information". Follow links one level deep.

### Phase 2: Download

Create: `/home/exedev/EHI/pipeline/results/{{VENDOR_SLUG}}/downloads/`

Download every documentation artifact:
- PDFs, ZIPs, XLSX files: binary download with `curl -L -o`
- HTML documentation pages: save raw HTML
- For ZIPs: also run `unzip -l` to list contents and note file count / total size

Vendor slug = lowercase developer name, spaces to hyphens, remove special chars.

### Phase 3: Analyze

Examine what you downloaded. For searchable files (HTML, XLSX, unzipped content):

1. **Identify export format**: What does the actual patient export produce?
2. **Search for each EHI category** using the terms in the table above
3. **Assess documentation depth**: table names only? field names? data types? descriptions? examples?
4. **Check for sample exports or developer guides**
5. **Flag issues**: dead links, login walls, missing categories, PDF-only data export

## Output

For each vendor, write a JSON file to:
`/home/exedev/EHI/pipeline/results/{{VENDOR_SLUG}}/analysis.json`

```json
{
  "vendor": "Vendor Name",
  "products": ["Product A"],
  "chpl_ids": [12345],
  "export_documentation_url": "https://...",
  "documentation_status": "found|dead|redirect|login_required",
  
  "export_format": {
    "primary_format": "csv|json|tsv|fhir_ndjson|ccda_xml|sql_dump|pdf|mixed|unknown",
    "file_types": ["csv", "pdf"],
    "container": "zip|folder|single_file|multiple_exports|unknown",
    "description": "Brief description of what the export looks like"
  },
  
  "documentation": {
    "format": "html|pdf|xlsx|zip_of_html|spa|mixed",
    "field_level_detail": true,
    "data_types_included": true,
    "value_sets_documented": false,
    "table_or_resource_count": 261,
    "downloadable": true,
    "requires_browser": false,
    "total_size_bytes": 12345678
  },
  
  "ehi_coverage": {
    "clinical":              {"present": true,  "detail": "high|medium|low", "evidence": "..."},
    "secure_messages":       {"present": false, "detail": "none",            "evidence": "No message tables found"},
    "billing_financial":     {"present": true,  "detail": "high",            "evidence": "Charge, Claim, Payment tables"},
    "insurance_coverage":    {"present": true,  "detail": "medium",          "evidence": "Insurance table with 12 fields"},
    "appointments_scheduling":{"present": true,  "detail": "medium",          "evidence": "Appointment table"},
    "documents_images":      {"present": true,  "detail": "high",            "evidence": "Documents folder + GenFileBlob"},
    "audit_trails":          {"present": false, "detail": "none",            "evidence": "No audit tables"}
  },
  
  "sample_exports_available": false,
  "developer_guide_available": false,
  "self_service_export": true,
  
  "issues": ["List of specific problems found"],
  "grade": "A|B|C|D|F",
  "summary": "2-3 sentence summary",
  
  "downloaded_files": [
    {
      "local_path": "/home/exedev/EHI/pipeline/results/vendor/downloads/file.pdf",
      "source_url": "https://...",
      "size_bytes": 12345,
      "type": "pdf",
      "curl_command": "curl -L -o file.pdf 'https://...'"
    }
  ]
}
```

### Grading Rubric
- **A**: Full database/comprehensive export, field-level docs, all 7 EHI categories
  evidenced, machine-readable format, self-service, downloadable documentation
- **B**: Most categories covered with evidence, field-level docs, structured format,
  minor gaps (e.g. no audit trails, or missing one non-clinical category)
- **C**: Clinical well-covered, 1-2 non-clinical categories present, adequate docs
  but gaps in billing/messages/audit
- **D**: Mainly clinical data, thin documentation, key categories missing, or
  non-computable export (PDF-only), or requires vendor assistance
- **F**: Dead link, login required, documentation absent, clearly non-compliant

Also write a brief human-readable summary to:
`/home/exedev/EHI/pipeline/results/{{VENDOR_SLUG}}/summary.md`

## Mindset

- **Be curious**: If a page looks sparse, dig deeper. Check accordions, scroll down,
  view page source, follow links. Vendors sometimes hide docs in unexpected places.

- **Be precise**: Don't mark a category as "present" unless you have specific evidence
  (table name, field name, section heading). "Probably includes billing" is not evidence.

- **Be skeptical**: A vendor claiming "full EHI export" in marketing copy means nothing.
  Look at the actual table/field list. C-CDA exports almost never include billing.

- **Be persistent**: If a URL 404s, try the domain root. If a page needs JS, use the
  browser. If a ZIP is 50MB, download it anyway. The goal is ground truth.

- **Be efficient**: Don't spend 20 minutes on one vendor. If documentation is clearly
  a single PDF, download it, note what you can determine from file size and any text
  you can extract, and move on. Depth on the interesting cases, speed on the obvious ones.

- **Don't confuse FHIR Bulk Data / SMART-on-FHIR APIs with b(10) EHI export**:
  They are different ONC criteria. b(10) is a file-based export of ALL patient data.
  However, some vendors legitimately use FHIR NDJSON as their b(10) export format.
  The key question is: does it export ALL data or just the FHIR-mappable subset?
