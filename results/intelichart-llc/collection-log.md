# InteliChart LLC — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 8854
- Registered URL: https://www.intelichart.com/regulatory-and-compliance-requirements
- Developer: InteliChart LLC
- Product: InteliChart Patient Portal v3.5

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.intelichart.com/regulatory-and-compliance-requirements" -H 'User-Agent: Mozilla/5.0'
```
Result: HTTP/2 200 directly (no redirects). Content-Type: text/html; charset=UTF-8. Page is hosted on HubSpot CMS behind Cloudflare CDN. Last-Modified: Thu, 12 Feb 2026 16:50:54 GMT. No anti-bot issues.

### Step 2: Page examination
```bash
curl -sL "https://www.intelichart.com/regulatory-and-compliance-requirements" -H 'User-Agent: Mozilla/5.0' -o /tmp/intelichart-page.html
wc -c /tmp/intelichart-page.html
```
Page size: 98,564 bytes. Static HubSpot-hosted page with real HTML content (not a SPA). Content is rendered server-side. The page uses a HubSpot FAQ module with accordion sections for organizing compliance documents.

### Step 3: Finding the EHI section
The page is a compliance hub titled "Regulatory and Compliance Requirements" with multiple FAQ accordion sections:
1. **General Regulatory FAQ** — link to Regulatory FAQs PDF
2. **Meaningful Use Requirements** — description of MU compliance
3. **High-Level Cost Overview: InteliChart API Fees** — API fee structure and information blocking rules
4. **B10 Documentation** — the EHI export documentation (this is the target section)
5. **Open API** — API documentation
6. **FHIR** — FHIR documentation

The EHI section is found under the accordion heading **"B10 Documentation"**. In the HTML source, this content is present in the DOM within `<div class="faqs__answer">` elements (hidden by default, expanded via JavaScript click). The content is accessible via curl by searching the HTML source directly — no browser needed.

### Step 4: Identified downloadable assets
Three PDF files linked within the "B10 Documentation" accordion:

1. **Electronic Health Information (EHI) Export Overview** (PDF)
   - URL: `https://www.intelichart.com/hubfs/Compliance%20and%20Regulatory/FINAL_Electronic%20Health%20Information%20(EHI)%20Export%20Overview.pdf`

2. **Single Patient EHI Export Data Overview and User Instructions** (PDF)
   - URL: `https://www.intelichart.com/hubfs/Compliance%20and%20Regulatory/FINAL_Single%20Patient%20EHI%20Export%20Data%20Overview%20and%20User%20Instructions.pdf`

3. **Patient Population EHI Export Data Overview and User Instructions** (PDF)
   - URL: `https://www.intelichart.com/hubfs/Compliance%20and%20Regulatory/FINAL_Patient%20Population%20EHI%20Export%20Data%20Overview%20and%20User%20Instructions.pdf`

**Missing assets:** The EHI Export Overview PDF contains a table referencing two additional "Data Format Specifications (ZIP)" files — one for Single Patient Export and one for Patient Population Export. These ZIP files are described in the overview table but are **NOT linked anywhere on the compliance page**. No ZIP file links were found on the page at all.

### Step 5: Other documents on the page (not EHI-specific)
- Regulatory FAQs PDF: `https://www.intelichart.com/hubfs/Compliance%20and%20Regulatory/FINAL_Regulatory%20FAQs.pdf`
- Compliance Certificate PDF: `https://www.intelichart.com/hubfs/Compliance%20Certificate%20InteliChart%20Patient%20Portal%203.5%20051424%20(1).pdf`
- Multiple Real World Testing (RWT) plan and results PDFs (2021-2025)

These were not downloaded as they are not EHI export documentation.

## Downloads

### ehi-export-overview.pdf (287 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/ehi-export-overview.pdf \
  'https://www.intelichart.com/hubfs/Compliance%20and%20Regulatory/FINAL_Electronic%20Health%20Information%20(EHI)%20Export%20Overview.pdf'
```
Verified: `file ehi-export-overview.pdf` → PDF document, version 1.3, 1 page
Content: Overview of EHI export capability, table listing export types and data formats, mentions FHIR Bulk Data Access backed on HL7 R4.0.1. Last updated 4/30/2024.

### single-patient-ehi-export.pdf (296 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/single-patient-ehi-export.pdf \
  'https://www.intelichart.com/hubfs/Compliance%20and%20Regulatory/FINAL_Single%20Patient%20EHI%20Export%20Data%20Overview%20and%20User%20Instructions.pdf'
```
Verified: `file single-patient-ehi-export.pdf` → PDF document, version 1.3, 2 pages
Content: Instructions for single patient export. Describes export as CCD/C-CDA XML + encounter PDFs + patient document PDFs. Data elements: Demographics, Clinical Notes, Vital Signs, Laboratory, Procedures. Last updated 4/30/2024.

### patient-population-ehi-export.pdf (283 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/patient-population-ehi-export.pdf \
  'https://www.intelichart.com/hubfs/Compliance%20and%20Regulatory/FINAL_Patient%20Population%20EHI%20Export%20Data%20Overview%20and%20User%20Instructions.pdf'
```
Verified: `file patient-population-ehi-export.pdf` → PDF document, version 1.3, 2 pages
Content: Instructions for patient population export. Nearly identical to single-patient doc. Same export structure: C-CDA XML + encounter PDFs + patient document PDFs. Adds CSV data files for population export. Last updated 4/30/2024.

## Obstacles & Notes

- **No ZIP data format specifications found.** The overview PDF's table lists "Data Format Specifications (ZIP)" for both single and population exports, but these files are not linked on the compliance page. This means the most detailed technical specifications (the actual schema/format definitions) are referenced but not publicly available.
- **HubSpot FAQ accordion.** The EHI content is inside an accordion labeled "B10 Documentation" which requires a click to expand, but the HTML content is present in the source and accessible via curl.
- **No anti-bot issues.** Standard curl with a User-Agent header works fine. Cloudflare did not block requests.
- **All three PDFs are very short** (1-2 pages each) and provide high-level overviews rather than detailed data dictionaries or schema documentation.

---

## Product: InteliChart Patient Portal

### Product Context
InteliChart Patient Portal is **not an EHR system** — it is an EHR-agnostic patient engagement platform that integrates with 40+ EHR systems via API. The certified product (Patient Portal v3.5) is part of a broader suite called **"Healthy Outcomes"** which includes eight modules:

1. **Patient Portal** — centralized hub for patients to access health records
2. **Patient Schedule** — online self-scheduling (24/7, no login required)
3. **Patient Intake** — digital registration, consent forms, insurance card capture via OCR
4. **Patient Notify** — automated appointment reminders (phone, text, email)
5. **Family Portal** — long-term care/SNF family communication with gatekeeper approval
6. **Patient Survey** — satisfaction surveys, patient-reported outcomes (PHQ-9, HOOS, KOOS)
7. **Patient Activate** — automated population health campaigns, care plan reminders
8. **Patient eHealth** — telehealth/virtual visit platform

The product integrates with EHR systems like athenahealth, Cerner, Allscripts, Meditech, NextGen, Nextech, Netsmart, Greenway, PointClickCare, and others. It receives clinical data from these EHRs and also generates its own portal-native data (messages, intake forms, survey responses, scheduling data, campaign records).

Key data the product stores:
- **Secure messages** between patients and providers (bidirectional)
- **Appointment scheduling** data and booking history
- **Intake forms** (digital registration, consent forms, questionnaires)
- **Insurance card images** captured via OCR
- **Bill payment** records and payment plans
- **Survey responses** (PHQ-9, satisfaction surveys, PROMs)
- **Campaign/outreach records** from population health campaigns
- **Telehealth session** metadata and records
- **Family portal messages** (threaded family-staff communications)
- **Clinical data passthrough** from connected EHR (demographics, notes, vitals, labs, medications, procedures)

### Export Approach
InteliChart's EHI export is primarily **C-CDA/document-based** with some FHIR and CSV components:

**Single Patient Export** produces a ZIP containing:
- `Lastname_FirstName_ccda.xml` — C-CDA conformant to USCDI v1
- `Encounters/` subfolder — visit notes as PDF or HTML files
- `Patient Documents/` subfolder — other documents as PDF or ZIP files

**Patient Population Export** uses the same per-patient structure plus:
- Patient data files as CSV
- US Core FHIR data
- C-CDA documents
- "Clinical, Administrative and Financial reports/images"

The overview PDF mentions FHIR Bulk Data Access (HL7 R4.0.1), but the actual export structure described in the detailed PDFs is centered on C-CDA documents and PDF/HTML files for encounters and documents.

The method of export is described as "CCDs through the Practice Portal" and "CCDs through the Practice Portal in bulk." This is essentially a C-CDA export with document attachments — not a database dump.

### EHI Coverage Assessment

**Clinical data: Present (via C-CDA)**
The C-CDA export covers the standard clinical summary: demographics, clinical notes, vital signs, laboratory results, procedures. Medications, allergies, and problem lists are implicitly included via USCDI v1 C-CDA, though only the five data elements above are explicitly listed. Encounter notes are also exported as separate PDF/HTML files.

**Secure messages: Not documented**
InteliChart's portal supports bidirectional secure messaging between patients and providers, plus Family Portal messaging for long-term care facilities. None of the three documentation PDFs mention messages, inbox, or communications as part of the export. C-CDA does not have a standard mechanism for portal messaging threads. This is a **significant gap** — the portal generates and stores messaging data that is not included in the export.

**Billing/financial: Partially claimed, unclear scope**
The overview PDF mentions "Clinical, Administrative and Financial reports" as part of the population export, but provides no specifics. The product has bill payment capabilities and copay collection. No billing tables, charge records, payment details, or financial data structures are documented. The mention of "financial reports" may refer to summary reports rather than transactional billing data.

**Insurance/coverage: Not documented**
The Patient Intake module captures insurance card images via OCR and collects insurance information. None of the export documents mention insurance data, eligibility, or coverage information. The OCR-captured insurance card images are unlikely to be included in the C-CDA export.

**Appointments/scheduling: Not documented**
The Patient Schedule module provides full self-scheduling with two-way EHR integration. No appointment or scheduling data is mentioned in the export documentation. Scheduling history, appointment types, and booking records are not included in standard C-CDA content.

**Documents/images: Present (as PDF/HTML files)**
The export includes encounter notes as PDF or HTML files and patient documents as PDF or ZIP files in dedicated subfolders. This covers documents that exist in the portal, including scanned/uploaded files. However, OCR-captured insurance cards and IDs from Patient Intake are not specifically mentioned.

### Issues & Red Flags

1. **C-CDA as primary export format severely limits coverage.** The export is fundamentally a C-CDA clinical summary with document attachments. This format cannot capture the portal-native data that InteliChart generates and stores: secure messages, intake forms, survey responses, scheduling data, campaign records, telehealth sessions, and family communications.

2. **Missing ZIP "Data Format Specifications" files.** The overview PDF references specification ZIP files that are not publicly accessible on the compliance page. This means the detailed schema documentation is either not published or not linked.

3. **Extremely thin documentation.** Three PDFs totaling 5 pages (1+2+2) with high-level overviews. No data dictionary, no field-level documentation, no schema definitions, no table/resource lists. The single and population export PDFs are nearly identical.

4. **"May include where applicable" qualifier.** The overview uses the phrasing "data may include where applicable" for all export content, hedging on what is actually included. This creates ambiguity about what a patient actually receives.

5. **Portal-native data likely excluded.** As a patient engagement platform, InteliChart generates substantial data beyond what it receives from EHRs — messages, forms, surveys, scheduling, campaigns, telehealth. The C-CDA-centered export approach almost certainly excludes this portal-native data, which is arguably the most important data InteliChart uniquely stores.

6. **Data elements list is narrow.** Only five data elements are explicitly listed: Demographics, Clinical Notes, Vital Signs, Laboratory, Procedures. Standard C-CDA includes more (medications, allergies, problem lists), but the documentation doesn't mention them explicitly. Non-clinical data categories are absent.

7. **USCDI v1 reference is outdated.** The documentation references USCDI v1 (July 2020), while USCDI v4 was current as of late 2024. This suggests the export specification has not been updated.
