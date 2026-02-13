# Stage 4: Analyze EHI Export Documentation

You are performing deep analysis of a vendor's EHI export documentation to assess
completeness, quality, and usability.

## Background: What is EHI Export?

Under ONC's Cures Act rule 170.315(b)(10), certified EHR systems must support:

- **Single patient export**: Export ALL electronic health information for one patient
- **Patient population export**: Export ALL EHI for all patients in the system
- **Public documentation**: Publish documentation of the export format

"All EHI" means the **HIPAA Designated Record Set** — not just clinical data. This includes:

1. **Clinical**: diagnoses, medications, allergies, vitals, labs, immunizations, procedures,
   clinical notes, assessments, care plans, family history, social history
2. **Secure messages**: patient-provider portal messages, in-basket/inbox messages,
   chat transcripts, any communication stored in the EHR
3. **Billing/financial**: charges, claims, payments, adjustments, CPT/ICD codes,
   EOBs, transaction history, write-offs, collections
4. **Insurance/coverage**: insurance plans, eligibility, authorizations, referrals,
   prior auths, payer information, benefits
5. **Administrative**: appointments, scheduling, demographics (full, not just USCDI),
   consent forms, advance directives, registration data
6. **Documents/images**: scanned documents, uploaded images, DICOM/radiology,
   attached files, faxes, correspondence
7. **Audit/access**: who accessed the record, when, what they viewed/changed
   (if stored as part of the designated record set)

## What We Learned from Our Spike (16 vendors)

### Export format patterns:
- **Full database dump** (best): Epic (TSV, 7,673 tables), Oracle (SQL, ~1,459 tables),
  TruBridge (JSON, ~465 tables), Altera (DB schema, ~2,668 tables)
- **Structured files per domain**: Greenway (CSV, 261 tables), Veradigm (TSV, 87 files),
  Nextech (JSON/XML/PDF), SightView (CSV)
- **Standards-based**: MEDITECH (FHIR+C-CDA hybrid), MEDHOST (FHIR R4 NDJSON),
  CareCloud (C-CDA XML)
- **Mixed/fragmented**: AdvancedMD (CSV + C-CDA + .mdb + .bak, requires multiple tools)

### Documentation format patterns:
- **HTML + downloadable ZIP** (most useful): Epic, Altera, Oracle, Netsmart
- **PDF data dictionary**: NextGen (29MB), Netsmart (7,492 pages), Nextech, CareCloud,
  SightView, AdvancedMD, Veradigm
- **Interactive HTML site**: TruBridge, Greenway, Veradigm View, athenahealth (SPA)
- **Single spreadsheet**: MEDHOST (XLSX with FHIR extensions only)

### Common gaps:
- **Audit trails**: Only Epic, Oracle, TruBridge clearly export these
- **Secure messages**: Often missing from smaller vendors
- **Billing**: C-CDA-based exports almost always miss this entirely
- **Sample exports**: NO vendor provides example files or test data

## Your Batch

Your batch file is at: `{{BATCH_FILE}}`

For each vendor, it includes the discovery results and paths to downloaded files.

## Task

For each vendor in your batch, examine the downloaded documentation and produce
a structured analysis.

### Step 1: Identify the export format
- What file format(s) does the actual export produce? (CSV, JSON, TSV, XML/C-CDA,
  FHIR NDJSON, SQL dump, proprietary, PDF, database backup file)
- Is there a single export or multiple separate exports needed?
- Does it produce a ZIP with a defined folder structure?
- Is there a table-of-contents or manifest file in the export?

### Step 2: Assess documentation depth
- **Schema level**: Does it define database tables/views?
- **Field level**: Does it list individual columns/fields with names, types, descriptions?
- **Value level**: Does it document code sets, enumerations, category values?
- **Relationship level**: Does it document foreign keys, table relationships?
- **Example level**: Does it provide sample data or example records?

### Step 3: Assess EHI coverage
For each of the 7 categories above, determine:
- Is it **explicitly documented** as part of the export?
- What tables/files/resources cover it?
- How detailed is the coverage?

Be rigorous. Don't assume a category is covered just because a vendor has lots of tables.
Search for specific evidence:
- Messages: look for "message", "inbox", "communication", "chat", "portal", "secure"
- Billing: look for "charge", "claim", "payment", "billing", "invoice", "transaction",
  "CPT", "revenue", "AR", "accounts receivable"
- Insurance: look for "insurance", "coverage", "eligibility", "authorization",
  "payer", "carrier", "benefit", "plan"
- Audit: look for "audit", "access log", "tracking", "who viewed"

### Step 4: Assess developer experience
- Could a developer receiving this export figure out what to do with it?
- Is there a getting-started guide?
- Are there sample files or example data?
- Is the documentation self-contained or does it reference external standards (like FHIR)
  without explanation?
- How much domain knowledge is assumed?

### Step 5: Flag issues
- Non-clinical data exported as PDF only (not machine-readable)
- Login/authentication required to view docs
- Dead links or missing pages
- Documentation clearly incomplete or outdated
- Export requires vendor assistance (not self-service)
- Significant data categories missing

## Output

Write results to: `{{OUTPUT_FILE}}`

Format: JSON object:
```json
{
  "vendor": "Vendor Name",
  "products": ["Product A", "Product B"],
  "chpl_ids": [1234, 5678],
  "export_documentation_url": "https://...",
  
  "export_format": {
    "primary_format": "csv|json|tsv|fhir_ndjson|ccda_xml|sql_dump|mixed",
    "file_types": ["csv", "pdf"],
    "container": "zip|folder|single_file|multiple_exports",
    "has_manifest": true,
    "has_folder_structure": true,
    "description": "ZIP file containing CSV tables + Documents folder with PDFs"
  },
  
  "documentation_depth": {
    "schema_level": true,
    "field_level": true,
    "data_types_included": true,
    "value_sets_documented": false,
    "relationships_documented": false,
    "examples_provided": false,
    "table_count": 261,
    "field_count_estimate": 3500,
    "documentation_format": "html|pdf|xlsx|zip_of_html",
    "documentation_size_bytes": 12345678
  },
  
  "ehi_coverage": {
    "clinical": {"present": true, "evidence": "Full clinical tables...", "detail": "high"},
    "secure_messages": {"present": true, "evidence": "PracPersonSecureMessage table", "detail": "high"},
    "billing_financial": {"present": true, "evidence": "Charge, Claim, Payment tables", "detail": "high"},
    "insurance_coverage": {"present": true, "evidence": "Carrier, Plan, Eligibility tables", "detail": "high"},
    "appointments_scheduling": {"present": true, "evidence": "Appointment table", "detail": "medium"},
    "documents_images": {"present": true, "evidence": "GenFileBlob, Images folder", "detail": "high"},
    "audit_trails": {"present": false, "evidence": "No audit tables found", "detail": "none"}
  },
  
  "developer_experience": {
    "self_service": true,
    "getting_started_guide": false,
    "sample_exports": false,
    "documentation_self_contained": true,
    "domain_knowledge_required": "moderate",
    "tools_needed": ["text editor", "CSV reader"]
  },
  
  "issues": [
    "No sample export files provided",
    "Audit trails not included in export"
  ],
  
  "overall_grade": "A|B|C|D|F",
  "summary": "Brief 2-3 sentence summary of this vendor's EHI export capability"
}
```

### Grading Rubric
- **A**: Full database export, field-level docs with types, all 7 EHI categories,
  machine-readable format, self-service
- **B**: Most categories covered, field-level docs, structured format, minor gaps
  (e.g. no audit trails)
- **C**: Clinical data well-covered but significant non-clinical gaps, or documentation
  is adequate but not field-level
- **D**: Minimal documentation, major categories missing, or non-clinical data only
  as PDF, or requires vendor assistance
- **F**: Documentation missing, dead links, login required, or clearly non-compliant

## Advice

- **Be skeptical of C-CDA-only exports**: C-CDA covers clinical data well but
  almost never includes billing, insurance details, scheduling, or audit trails.
  If a vendor only exports C-CDA, they're almost certainly missing major EHI categories.

- **FHIR is not automatically complete**: Standard FHIR R4 resources cover clinical
  data well but gaps exist in billing (Claim/ExplanationOfBenefit), messaging
  (Communication), and audit (AuditEvent). Check which specific resources are exported.

- **"Full database dump" is the gold standard**: Vendors that export their entire
  database schema inherently cover all categories. But verify the table list actually
  includes non-clinical tables.

- **Check for the hard stuff**: The easy stuff (diagnoses, medications, labs) is
  always there. The differentiator is: secure messages, billing line items with
  amounts, insurance authorizations, and audit trails.

- **Don't be fooled by table counts**: A vendor with 100 well-documented tables
  covering all categories is better than one with 5,000 tables that are all clinical.

- **PDFs as export format ≠ PDFs as documentation format**: It's fine for
  documentation to be a PDF. It's problematic for the actual export data to be PDF
  (not machine-readable). Don't confuse the two.
