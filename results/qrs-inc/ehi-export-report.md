# QRS, Inc. — EHI Export Documentation

Collected: 2025-07-14

## Source
- Registered URL: https://www.qrshs.info
- CHPL ID: 15.04.04.2838.PARA.22.01.1.221227 (listing 11142)
- Developer: QRS, Inc.
- Product: PARADIGM® version 22

## Navigation Journal

The registered URL https://www.qrshs.info serves a static HTML page titled "QRS Disclosures" directly — no redirects, no JavaScript-dependent rendering, no anti-bot measures.

```bash
# 1. Probe the URL
curl -sI -L "https://www.qrshs.info" -H 'User-Agent: Mozilla/5.0'
# → HTTP/1.1 200 OK, Content-Type: text/html, 29128 bytes, nginx/1.18.0 (Ubuntu)

# 2. Search for downloadable files
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|csv|json)' /tmp/qrs-page.html
# Found 9 PDF links in the rwtp/ directory

# 3. Identified EHI-relevant PDFs:
# - rwtp/PARADIGM EHI Export Documentation.pdf  ← primary EHI export doc
# - rwtp/PARADIGM FHIR API Documentation.pdf    ← FHIR API (g)(10) docs
# - rwtp/PARADIGM Patient API Documentation.pdf  ← Patient search + C-CDA retrieval API

# 4. Downloaded all three:
curl -sL -o PARADIGM_EHI_Export_Documentation.pdf \
  "https://www.qrshs.info/rwtp/PARADIGM%20EHI%20Export%20Documentation.pdf"
curl -sL -o PARADIGM_FHIR_API_Documentation.pdf \
  "https://www.qrshs.info/rwtp/PARADIGM%20FHIR%20API%20Documentation.pdf"
curl -sL -o PARADIGM_Patient_API_Documentation.pdf \
  "https://www.qrshs.info/rwtp/PARADIGM%20Patient%20API%20Documentation.pdf"
```

The page also links to several Real World Testing plan/result PDFs and a Privacy & Security Attestation document, but these are regulatory compliance filings, not EHI export documentation.

## What Was Found

### EHI Export Documentation (6 pages)

The "PARADIGM® ELECTRONIC HEALTH INFORMATION (EHI) EXPORT DOCUMENTATION" (v1.0, dated September 26, 2023) is a brief, 6-page PDF. Of those 6 pages:

- **Pages 1–4**: Terms and Conditions (developer account registration, legal boilerplate, indemnification, etc.) — identical to the terms in the FHIR API and Patient API docs.
- **Page 5**: "Export Details and Directory" and "Usage" — the actual EHI export technical documentation.
- **Pages 5–6**: Patient Search API and Patient C-CDA API endpoint documentation.

The substantive EHI export documentation amounts to roughly **two paragraphs**:

**Export Format:**
- Data is exported as a **ZIP file** containing:
  - **Standard C-CDA R2.1 XML** per patient (e.g., `10000.xml`)
  - **Additional data in JSON format** (e.g., `10000_invoice history.json`)
  - **Original imported files** (PDF, PNG, etc.) in a `_addt_files` subdirectory per patient (e.g., `10000_addt_files/`)

**How to trigger the export:**
- The "Data Portability module" is accessible through EHR System Reports by authorized users only.
- To include all EHI, the user must click a checkbox: "include all Electronic Healthcare Information (EHI) for each patient in the set."

**API endpoints documented:**
- `GET https://api.qrshs.com/v1/patient/search` — patient lookup by name, DOB, SSN (Basic auth)
- `GET https://api.qrshs.com/v1/patient/ccda` — retrieve C-CDA XML for a patient (Basic auth), with optional date range filtering

There is **no data dictionary**, no field-level documentation, no schema definition, no sample export files, and no description of what data fields are included in the C-CDA or the JSON files.

### FHIR API Documentation (27 pages)

The FHIR API document covers the standard (g)(10) FHIR R4 API. It documents 15 US Core resources:

1. Patient
2. AllergyIntolerance
3. CarePlan
4. CareTeam
5. Condition
6. Device
7. DiagnosticReport
8. DocumentReference
9. Goal
10. Immunization
11. MedicationRequest
12. Observation (including vital signs)
13. Procedure
14. Encounter
15. Provenance

This is the standard US Core / USCDI resource set — it's the (g)(10) API, not a (b)(10) export mechanism. The EHI export documentation references a separate "FHIR Data Portability module" that produces ZIP files with C-CDA + JSON, which is architecturally distinct from this FHIR API.

### Patient API Documentation (6 pages)

The Patient API doc is nearly identical to the EHI Export doc — same terms and conditions, same two API endpoints (`/v1/patient/search` and `/v1/patient/ccda`). It's a companion document describing how to programmatically search for patients and retrieve C-CDA documents.

## Export Coverage Assessment

### Data Domain Coverage

PARADIGM is a unified EHR + Practice Management system with a single database. Based on the product research, it stores:

**Clinical data**: demographics, allergies, conditions/problems, medications/prescriptions, immunizations, procedures, vitals, lab results, diagnostic reports, care plans, care teams, goals, implantable devices, encounters, clinical notes, scanned documents (TIF/PDF/JPG), voice recordings (.wav)

**Administrative/billing data**: scheduling, insurance information, claims (professional + UB04), payment/adjustment/refund records, electronic remittance, insurance contracts/fee schedules, referrals/authorizations, collections, patient statements, eligibility verification results

**What the export documentation tells us:**

- The C-CDA component would cover standard clinical data (demographics, problems, medications, allergies, immunizations, vitals, procedures, results, encounters, notes) — this is the C-CDA CCD standard scope.
- The mention of `invoice history.json` as an additional JSON file is a **positive signal** — it suggests the export goes beyond clinical data to include billing/financial information. This is one of the few vendors that explicitly mentions financial data in its EHI export.
- Imported files (PDF, PNG, etc.) in `_addt_files` would capture scanned documents.

**What appears to be missing or undocumented:**

- **Scheduling data** — no mention of appointment history in the export
- **Insurance information** — no mention beyond the invoice history
- **Claims detail** — the "invoice history" JSON is ambiguous; it's unclear whether it includes full claims data (CPT/ICD codes, payer responses, ERA detail) or just a billing summary
- **Referrals and authorizations** — not mentioned
- **Collections data** — not mentioned
- **Patient statements** — not mentioned
- **Eligibility verification results** — not mentioned
- **Insurance contract/fee schedule data** — not mentioned
- **Voice recordings (.wav files)** — not mentioned (the _addt_files directory only says "files imported into the EHR" — it's unclear if system-generated files like voice recordings are included)
- **Audit logs / provenance** — not mentioned
- **Specialty-specific data** (radiology, allergy, anesthesia, chiropractic, DME modules) — not mentioned

The fundamental problem is that the documentation is too sparse to assess. The phrase "include all Electronic Healthcare Information (EHI) for each patient in the set" checkbox is encouraging — it implies the system can export more than the default clinical data. But the documentation doesn't describe what "all EHI" actually includes.

### Export Format & Standards

- **C-CDA R2.1 XML**: A recognized clinical document standard. Good for clinical data, but inherently limited to the C-CDA document types (CCD, Discharge Summary, etc.). C-CDA does not naturally represent billing, claims, scheduling, or administrative data.
- **JSON**: Used for additional data like "invoice history." The JSON format is completely undocumented — no schema, no field definitions, no examples. A third party receiving this file would have to reverse-engineer its structure.
- **Original files**: PDF, PNG, etc. retained in original format. Reasonable approach for scanned documents.
- **ZIP packaging**: Sensible for bundling multiple file types.

The format is a pragmatic hybrid: use the standard where it fits (clinical data → C-CDA), use JSON for data that doesn't fit C-CDA (billing), and include original files as-is. This is a better approach than many vendors that try to shoehorn everything into FHIR or C-CDA. However, the JSON component is a black box without documentation.

A third party could parse the C-CDA (it's a standard), but could not reliably interpret the JSON files without the schema, and would have no way to understand the relationships between clinical, billing, and document data.

### Documentation Quality

The documentation is **minimal**. Out of a 6-page PDF, 4 pages are legal terms and conditions. The actual technical content is:

- Two paragraphs describing the export format and directory structure
- One sentence about triggering the export
- Two API endpoint specifications (patient search and C-CDA retrieval)

There is no:
- Data dictionary
- Field-level documentation
- JSON schema or example JSON output
- Sample C-CDA document
- Sample export ZIP
- Description of what data domains are included
- Mapping between PARADIGM data and export elements
- Documentation of the "invoice history" JSON structure
- Description of what the "include all EHI" checkbox adds vs. the default export

A developer could not implement an import of this data based solely on this documentation. The C-CDA portion would be parseable (it's a standard), but the JSON portion — which is presumably where the non-clinical data lives — is entirely undocumented.

### Structure & Completeness

- **Granularity**: No field-level documentation at all. The export format description is at the file/directory level only.
- **Coded fields**: Not documented.
- **Relationships**: Not documented.
- **Value sets**: Not documented.
- **Versioning**: Document is v1.0, dated September 2023. No change history.

This documentation reads as a compliance minimum — enough to say "we have EHI export documentation" but not enough for anyone to actually understand or consume the export. The contrast between the very brief EHI export doc and the more detailed 27-page FHIR API documentation is telling: significantly more effort went into the (g)(10) API documentation than the (b)(10) export documentation.

### Overall Assessment

QRS, Inc. has taken a structurally sound approach to EHI export: a ZIP file containing C-CDA for clinical data, JSON for additional data (at minimum billing/invoice history), and original files for imported documents. The "include all EHI" checkbox suggests awareness of the (b)(10) distinction from (g)(10). The mention of invoice history as a JSON export is a positive signal — most vendors don't acknowledge billing data in their EHI export at all.

However, the documentation is woefully inadequate. The JSON format is completely undocumented, meaning the billing/financial data — arguably the most distinctive part of the export — cannot be interpreted by a third party. There's no data dictionary, no schema, no examples. The documentation is 67% legal boilerplate by page count.

For a small vendor (~30+ years in business, serving small ambulatory practices), this is consistent with a company that built a functional export mechanism but invested minimal effort in documenting it. The export itself may be more complete than the documentation suggests — the product's unified single-database architecture and the "all EHI" checkbox hint at broader coverage — but without documentation, that's speculation.

## Access Summary
- Final URL (after redirects): https://www.qrshs.info (no redirects)
- Status: found
- Required browser: no
- Navigation complexity: one_click (PDFs linked directly from the disclosure page)
- Anti-bot issues: none

## Obstacles & Dead Ends
- None. The site is a simple static HTML page served by nginx with direct PDF links. No JavaScript, no accordions, no authentication required.
- The `index-5.html` page linked from the navigation returned 404.
- The site uses HTTP for some internal references (favicon, images) but HTTPS works fine for all document downloads.
