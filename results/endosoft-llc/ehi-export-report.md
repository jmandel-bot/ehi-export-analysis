# EndoSoft, LLC — EHI Export Documentation

Collected: 2025-07-14

## Source
- Registered URL: https://qlinical.com/ephi/
- CHPL IDs: 10855
- Product: Qlinical (cloud-based endoscopy-focused EHR)
- Developer: EndoSoft, LLC

## Navigation Journal

### Step 1: Probe the registered URL
```bash
curl -sI -L "https://qlinical.com/ephi/" -H 'User-Agent: Mozilla/5.0'
```
HTTP 200, Content-Type: text/html; charset=UTF-8. WordPress site (WP JSON API links in headers). Page ID 340, published 2023-12-27.

### Step 2: Fetch and examine page content
```bash
curl -sL "https://qlinical.com/ephi/" -H 'User-Agent: Mozilla/5.0' -o ephi-page.html
```
32,277 bytes. Standard WordPress page with navigation, a heading "EHI (ePHI) Export", a bulleted list of exportable data sections, two export methods described, and a link to FHIR documentation.

### Step 3: Identify all links on the page
Relevant links found:
- `https://www.endosoft.com/fhir/#_Toc120735483` — "here" link under Bulk EHI Export section
- `https://www.hl7.org/ccdasearch/` — external HL7 reference (not followed)
- `https://qlinical.com/downloads/` — Downloads page (checked: only contains foot-switch driver downloads, not EHI-related)

### Step 4: Follow the FHIR documentation link
Navigated to `https://www.endosoft.com/fhir/` (the anchor `#_Toc120735483` doesn't exist on the page — it's a simple landing page). Found a "Click Here to View FHIR API" button linking to:
```
https://www.endosoft.com/wp-content/uploads/2024/09/170.315-g10-Standardized-API-FHIR-2.pdf
```
Downloaded: 138-page PDF, 1,342,284 bytes, created 2022-12-12 by Javante Coley using Microsoft Word.

### Step 5: Examine the PDF
```bash
pdfinfo 170.315-g10-Standardized-API-FHIR-2.pdf
pdftotext 170.315-g10-Standardized-API-FHIR-2.pdf - | head -200
```
Title: "API Definition" (from header). Full FHIR API documentation for EndoVault/Qlinical SMART on FHIR service. Includes individual patient queries (pages 5–119) and **Bulk Data Access** section (pages 120–132) which directly supports the EHI bulk export.

### Step 6: Screenshots captured
- `ephi-page-top.png` — Top of EHI export page showing heading and data section list
- `ephi-page-bottom.png` — Bottom of EHI export page showing export methods and FHIR link
- `fhir-landing-page.png` — EndoSoft FHIR landing page with "Click Here to View FHIR API" button

## What Was Found

The EHI export documentation consists of two components:

### 1. EHI (ePHI) Export Page (qlinical.com/ephi/)

A single WordPress page describing the export functionality. Key content:

**Introduction:** "EHI – Electronic protected health information (ePHI) Export functionality allows Qlinical to do an export of health data for one or more patients. Qlinical supports the data export in CCD/C-CDA and ndjson formats. The C-CDA file uses stylesheets which is native to EndoSoft and provides a better user experience in viewing the patient data."

**Exportable Data Sections** (user-selectable):
1. Allergies
2. Encounter
3. Immunizations
4. Medications
5. Plan of treatment
6. Referral reason
7. Active problems
8. Reason for visit
9. Implants
10. Health concerns
11. Procedures
12. Functional status
13. Results
14. Social history
15. Vitals
16. Goals
17. Discharge instructions
18. Assessments
19. Cognitive status
20. Media
21. Diagnostic Report
22. Documents
23. Service Request

**Two Export Methods:**
1. **Single/multi patient export** — Uses HL7 C-CDA 2.1 format. Produces `*.xml` files (discrete data) and a `CDA.xsl` stylesheet. Supports both "All patient information" and "Single patient information" modes.
2. **Bulk EHI Export** — Uses FHIR APIs to export data in NDJSON format. Links to the FHIR API documentation PDF.

### 2. FHIR API Documentation PDF (170.315-g10-Standardized-API-FHIR-2.pdf)

138-page document covering the EndoVault SMART on FHIR service. The **Bulk Data Access** section (pages 120–132) is directly relevant to EHI export. It documents 18 FHIR resource types available as NDJSON bulk files:

| # | Resource | Bulk Endpoint | US Core Profile? |
|---|----------|---------------|------------------|
| 1 | AllergyIntolerance | allergyintolerance-bulkfile.ndjson | No profile ref |
| 2 | CarePlan | careplan-bulkfile.ndjson | Yes (assessment/plan) |
| 3 | CareTeam | careteam-bulkfile.ndjson | Yes |
| 4 | Condition | condition-bulkfile.ndjson | No profile ref |
| 5 | Device | device-bulkfile.ndjson | No profile ref |
| 6 | DiagnosticReport | diagnosticreport-bulkfile.ndjson | Yes (note profile) |
| 7 | DocumentReference | documentreference-bulkfile.ndjson | No profile ref |
| 8 | Encounter | encounter-bulkfile.ndjson | No profile ref |
| 9 | Goal | goal-bulkfile.ndjson | Yes |
| 10 | Immunization | immunization-bulkfile.ndjson | No profile ref |
| 11 | MedicationRequest | medicationrequest-bulkfile.ndjson | Yes |
| 12 | Observation | observation-bulkfile.ndjson | No profile ref |
| 13 | Organization | organization-bulkfile.ndjson | No profile ref |
| 14 | Practitioner | practitioner-bulkfile.ndjson | Yes |
| 15 | Procedure | procedure-bulkfile.ndjson | No profile ref |
| 16 | Provenance | provenance-bulkfile.ndjson | No profile ref |
| 17 | RelatedPerson | relatedperson-bulkfile.ndjson | Yes |
| 18 | ServiceRequest | servicerequest-bulkfile.ndjson | Yes |

Each resource includes:
- HTTP verb (GET), endpoint URL syntax, authorization requirement (Bearer token)
- A sample NDJSON response with realistic test data

The base URL for bulk endpoints is `https://fhirapi.endosoft.com/bulk/`.

The individual-patient API section (pages 5–119) provides additional detail on search parameters and response structures for each resource type, including an extensive Observation section covering laboratory results, vitals (respiratory rate, heart rate, pulse oximetry, blood pressure, BMI, head circumference, body weight, body height, body temperature), social history, and smoking status.

The document also includes:
- OAuth 2.0 authorization flow (registration, token generation)
- Well-known endpoint / SMART configuration
- Capability Statement
- API rate limits (60 requests/minute default)
- Resource summary table (Table 4-1) with 15 REST resources

## Export Coverage Assessment

### Data Domain Coverage

Qlinical is an endoscopy-focused EHR serving gastroenterology and procedural specialties. The product research identifies these key data domains:

**Clearly covered in the export:**
- **Patient demographics** — Patient resource with identifiers, name, DOB, gender, address, marital status, language, race/ethnicity
- **Allergies** — AllergyIntolerance resource with clinical/verification status, category, criticality, SNOMED coding, reactions
- **Medications** — MedicationRequest resource with RxNorm coding, dosage instructions, routes
- **Conditions/Problems** — Condition resource with ICD-10 coding, severity, clinical status
- **Procedures** — Procedure resource (sample shows "Colonoscopy" — appropriate for the product's endoscopy focus)
- **Immunizations** — Full immunization records with vaccine codes, sites, routes, lot numbers
- **Vital signs** — Observation resources covering standard vital signs (BP, HR, RR, temp, SpO2, weight, height, BMI, head circumference)
- **Lab results** — Observation/Laboratory with LOINC coding
- **Encounters** — Encounter resource with type, period, participants, discharge disposition
- **Diagnostic reports** — DiagnosticReport with imaging and clinical notes
- **Documents** — DocumentReference for clinical notes ("History and physical note" in sample)
- **Care plans and goals** — CarePlan, Goal resources
- **Care teams** — CareTeam with roles and members
- **Social history and smoking status** — Observation categories
- **Implants/Devices** — Device resource with UDI, manufacturer, serial number
- **Service requests** — ServiceRequest including SDOH categories
- **Provenance** — Provenance resource tracking authorship and transmission

**Notably absent or unclear:**
- **Endoscopic images and video** — This is the core value proposition of EndoSoft products. The EHI export page lists "Media" as an exportable section, and the C-CDA export presumably handles this, but the FHIR bulk export does not include a dedicated media/image resource. DocumentReference and DiagnosticReport could carry image references, but the sample data shows text-only content. The sample DiagnosticReport includes a `media` field referencing a DocumentReference, but no actual image data. **For an endoscopy EHR, the absence of clear image/video export documentation is a significant gap.**
- **Procedure reports (detailed)** — EndoSoft's core product generates detailed endoscopy procedure reports with findings, quality metrics, and annotated images. The Procedure FHIR resource in the bulk export is minimal (just procedure code and date). The detailed report content may be in DiagnosticReport or DocumentReference, but this isn't clearly documented.
- **Nursing records (ENR)** — Qlinical has a separate Electronic Nursing Record module for pre/intra/post-procedure documentation, vital sign tracking, medication reconciliation, and nursing discharge. None of this is explicitly addressed in the export documentation as a distinct data domain.
- **Scheduling data** — Appointment/scheduling information is a core module but no Schedule or Appointment FHIR resource is in the bulk export.
- **Invoicing/billing** — Listed as a Qlinical feature, but no financial resources in the export.
- **E-prescriptions** — Mentioned as a feature; MedicationRequest covers orders but not prescription transmission records.
- **Consent forms** — Qlinical captures electronic consent with tablet signatures. No Consent resource in bulk export.
- **Image annotations and anatomical diagram mappings** — A key feature of the product with no apparent export representation.
- **Quality of care indicators/metrics** — Core to endoscopy practice; not represented in export.
- **Pathology requisitions** — Listed in the feature matrix but not in export.
- **Recalls** — Patient recall/follow-up tracking, not in export.

### Export Format & Standards

The export uses two recognized standards:

1. **C-CDA 2.1** for single/multi-patient export — This is an appropriate, widely-understood clinical document standard. The use of a custom EndoSoft XSL stylesheet for rendering is reasonable. However, no documentation of which C-CDA templates are used, what sections are populated, or how the 23 data sections map to C-CDA sections is provided.

2. **FHIR R4 (NDJSON)** for bulk export — This follows the SMART on FHIR / Bulk Data Access pattern, which is industry-standard. Resources appear to use US Core profiles in some cases (CarePlan, CareTeam, DiagnosticReport, Goal, MedicationRequest, Practitioner, RelatedPerson, ServiceRequest) but not consistently. The base URL `fhirapi.endosoft.com` suggests a shared service across EndoVault and Qlinical products.

**Format appropriateness:** FHIR R4 is a reasonable format for clinical data export from an EHR. However, for an endoscopy-focused product, the standard FHIR clinical resources may not capture the full richness of the data — endoscopic image libraries, annotated procedure findings with anatomical location mappings, and quality metric calculations are not well-represented by the standard US Core profiles.

**Reconstructability:** A third party could reconstruct a basic patient clinical record from this export — demographics, problem list, medications, allergies, encounters, vitals, and lab results. However, the detailed endoscopy procedure documentation (images, findings, quality indicators) that constitutes the unique clinical value of this EHR would likely be incomplete or absent from the export. The export appears to cover the USCDI clinical data classes but not the specialty-specific data that makes this product distinctive.

### Documentation Quality

The documentation is split between two artifacts with very different qualities:

**EHI Export Page (qlinical.com/ephi/):** Minimal — a single web page with ~250 words of prose, a bulleted list of 23 data sections, a two-row file format table, and a link to the FHIR docs. No data dictionary, no field definitions, no examples of what the C-CDA export contains, no screenshots of the export interface, no step-by-step instructions. It reads as a compliance checkbox, not user documentation.

**FHIR API PDF:** Substantially more detailed — 138 pages with endpoint specifications, sample JSON responses, and search parameter documentation for each resource. The Bulk Data Access section (13 pages) provides sample NDJSON for each of the 18 resource types. However:
- The document is titled and framed as general FHIR API documentation (primarily for (g)(10) certification), not specifically as EHI export documentation
- Sample responses contain synthetic test data (patient "Shepherd Meredith Lynn", organization "Endovault Medical Center") that helps illustrate the format
- No data dictionary beyond what the FHIR resource definitions inherently provide
- No documentation of which fields are actually populated in practice vs. which are required by the spec
- No value set documentation specific to EndoSoft (e.g., what procedure codes they use beyond SNOMED)
- The document dates to November 2022 (initial version) and may not reflect current capabilities

**Could a developer implement an import?** For the FHIR bulk export: mostly yes, since it follows standard FHIR R4 conventions and US Core profiles. A developer familiar with FHIR could consume the NDJSON files. For the C-CDA export: insufficient documentation — no sample files, no template specifications, no section mapping.

### Structure & Completeness

**Field-level granularity:** The FHIR bulk export documentation provides sample responses that implicitly document field structure, but there is no explicit field-by-field data dictionary. The sample responses serve as de facto schema documentation — a developer would need to reverse-engineer the field mapping from the examples.

**Coded fields and value sets:** Standard terminologies are used (SNOMED CT, LOINC, ICD-10, RxNorm, HL7 code systems), which is appropriate. No vendor-specific value sets are documented. The Procedure resource sample uses "COLON" as a SNOMED code for "Colonoscopy" — this appears to be a vendor-specific code rather than an actual SNOMED CT code, which raises data quality questions.

**Relationships between entities:** FHIR reference fields link resources (Patient → Encounter → Procedure → DiagnosticReport), and these are visible in the sample data. But there is no documentation of the overall data model or entity relationship diagram.

**Versioning:** The PDF has a two-row change history (initial check-in 11/25/2022, API details added 11/30/2022). The PDF was uploaded to the website in September 2024 but its content dates to late 2022. No indication of ongoing maintenance.

## Access Summary
- Final URL (after redirects): https://qlinical.com/ephi/ (no redirect)
- Status: found
- Required browser: no (page is static HTML; browser used for screenshots but curl sufficient for content)
- Navigation complexity: one_click (main page → FHIR PDF requires following one link)
- Anti-bot issues: none

## Obstacles & Dead Ends

1. **WordPress JSON API returned empty content** for page 340 — the page uses a theme/page builder that doesn't populate the standard `content.rendered` field. Had to parse the raw HTML.

2. **FHIR page anchor `#_Toc120735483` doesn't exist** — The EHI export page links to `https://www.endosoft.com/fhir/#_Toc120735483` but that anchor is not present on the FHIR landing page. This was likely meant to link to a specific section (possibly Bulk Data Access) in an earlier version of the page or in the PDF. The Toc number format suggests it was a Word-generated heading anchor.

3. **No C-CDA documentation** — The single/multi-patient C-CDA export is described in one sentence on the EHI page with a two-row table. There is no sample C-CDA file, no template documentation, no section mapping, and no link to further documentation. The XSL stylesheet (`CDA.xsl`) is mentioned but not available for download.

4. **Downloads page irrelevant** — `qlinical.com/downloads/` only contains foot-switch driver software (FootSwitch-V6.6.zip, FootSwitchV7.0.4.zip), nothing related to EHI export.

5. **Shared documentation across products** — The FHIR API PDF is titled for "EndoVault" and hosted on endosoft.com, not qlinical.com. It appears to be shared documentation for both products, with Qlinical's EHI export page linking into it. This creates ambiguity about whether all documented capabilities apply equally to Qlinical.
