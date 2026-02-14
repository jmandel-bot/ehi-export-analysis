# Point and Click Solutions, Inc. — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 11249
- Registered URL: https://www.pointandclicksolutions.com/fhir-record-export
- Developer: Point and Click Solutions, Inc.
- Product: PNC Suite (version 12)

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.pointandclicksolutions.com/fhir-record-export" \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```
Result: HTTP/2 200 directly. No redirects. Content-Type: `text/html; charset=UTF-8`. Server identified as Wix-hosted (Pepyaka server, parastorage.com assets, Fastly CDN). Response headers included `x-wix-request-id` and Wix-specific caching headers.

### Step 2: Page examination
```bash
curl -sL "https://www.pointandclicksolutions.com/fhir-record-export" \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' \
  -o /tmp/pnc-page.html
wc -c /tmp/pnc-page.html
```
Result: 493,217 bytes. The page is a Wix-hosted SPA (JavaScript-heavy). The raw HTML contains mostly Wix Thunderbolt framework JavaScript with minimal visible text content. However, the actual page structure and links are embedded in the HTML source.

### Step 3: Finding the EHI documentation
Searched the HTML source for downloadable file links:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/pnc-page.html
```
Found one PDF link:
- `https://www.pointandclicksolutions.com/_files/ugd/19d094_a4b0aaa6921242c6846faaff9eba322b.pdf`

Searched for EHI-related links:
```bash
grep -oiE 'href="[^"]*"' /tmp/pnc-page.html | grep -iE 'ehi|export|data.dictionary|b.10|fhir|download|record'
```
Found:
- `href="https://www.pointandclicksolutions.com/fhir-record-export"` (self-reference)
- `href="https://www.pointandclicksolutions.com/electronic-health-records-ehr"` (product page)

Also opened the page in a browser to confirm. The rendered page is simple:
- Heading: "FHIR Record Export"
- A single link labeled "ONC b.10 Criteria" pointing to the PDF
- Footer with contact information

The page has no accordion, no tabs, no multi-section layout — just a heading and one download link. Very straightforward.

### Step 4: Identified downloadable assets
| File | URL |
|------|-----|
| ONC b.10 Certification Detail (PDF) | `https://www.pointandclicksolutions.com/_files/ugd/19d094_a4b0aaa6921242c6846faaff9eba322b.pdf` |

This is the only documentation artifact. No ZIP, no data dictionary spreadsheet, no supplementary files.

## Downloads

### pnc-fhir-record-export.pdf (189 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' \
  -o downloads/pnc-fhir-record-export.pdf \
  'https://www.pointandclicksolutions.com/_files/ugd/19d094_a4b0aaa6921242c6846faaff9eba322b.pdf'
```
Verified: `file pnc-fhir-record-export.pdf` → PDF document, version 1.4, 7 pages
Size: 193,162 bytes
Saved to: downloads/pnc-fhir-record-export.pdf

Contents: "ONC b.10 Certification Detail" document revised 01/20/2026. Seven pages covering:
- What is the ONC b.10 criteria (page 1)
- FHIR R4 JSON export format explanation (page 1)
- What is included/excluded from the export (pages 2-4, with HIPAA definitions)
- Table mapping PNC data to FHIR resources (page 5)
- Data exclusions: sequestered charts and "Hidden" records (page 6)
- How to create the export (page 6-7)

## Obstacles & Notes
- The website is Wix-hosted, which means the page is a JavaScript SPA. However, the PDF link was present in the HTML source and downloadable via curl without issue.
- The Wix file URL uses an obfuscated path (`_files/ugd/19d094_a4b0aaa6921242c6846faaff9eba322b.pdf`) typical of Wix-hosted file uploads.
- No anti-bot protection encountered. No special headers required beyond a standard User-Agent.
- The documentation is a single 7-page PDF — no supplementary data dictionary, schema documentation, or field-level detail beyond the FHIR resource mapping table.

---

## Product: PNC Suite

### Product Context
PNC Suite is a comprehensive, purpose-built Electronic Health Records / Practice Management System designed specifically for **college and university student health and counseling centers**. Founded in 1990 by David Tan, Point and Click Solutions has been serving higher education health services for over 25 years, with 350+ university sites and 10,000+ users internationally (U.S., Canada, Australia). The company was acquired by Banyan Software in August 2025.

PNC Suite is far more than the minimal ONC certification suggests. The product includes:

**Clinical (EHR):** Over 300 clinical templates designed for college health, 50+ online pre-visit questionnaires, e-prescribing, lab interfaces, EKG interfaces, voice/handwriting recognition, batch immunization administration, image scanning. Separate secure charts for Counseling, Athletics, Disability Services, and Occupational Health with firewalled access.

**Patient Web Portal:** 24-hour access for students to book appointments, complete pre-visit questionnaires and entrance medical forms, exchange secure messages with providers, view lab results, and print walkout statements.

**Practice Management — Registration:** Optimized for college environments with integration to campus systems (Banner SCT, PeopleSoft), academic fields (graduation date, term code, credit hours), health center and counseling center eligibility tracking, immunization compliance tracking.

**Practice Management — Scheduling:** Drag-and-drop scheduling, workshop attendance, multi-provider appointments, urgent care workflow, clinical whiteboard, email appointment reminders, automated self check-in, wait lists, satellite clinic support.

**Practice Management — Billing:** Cashiering, bursar billing (university account charges), courtesy billing, insurance billing, electronic claims submission and remittance, interfaces to student health insurance companies (Aetna, UHC), bursar upload interface, multiple fee schedules, capitated plan support, automatic charge capture from note writing/order entry.

**Counseling Solutions:** Advanced template-driven case note writer, DSM-5/ICD-10 coding, firewalled counseling charts, group appointments, surveys module (PHQ9, CCAPS, custom instruments), counseling-specific scheduling, client web portal with pre/post-session surveys and secure messaging.

**Reporting:** Drag-and-drop graphical report writer with built-in schema and database field documentation, SQL-based developer reports, export to Excel.

The ONC certification (CHPL #11249) covers only (b)(10) EHI export and security/privacy criteria (d)(1)-(d)(7), (d)(12), (d)(13), (g)(4), (g)(5). Notably absent: no clinical criteria (a)(1)-(a)(14), no patient portal (e)(1), no API access (g)(7)-(g)(10). This minimal certification footprint is likely because PNC Suite's niche market (college health) has little overlap with Medicare/Medicaid Promoting Interoperability incentive programs.

### Export Approach
PNC Suite uses a **FHIR R4 resource export** approach. Patient data is mapped from PNC's native database fields to FHIR R4 resources and exported as JSON files. The export uses the Patient/$everything operation pattern.

The export requires an API interface service to be configured (at a potential cost). Customers must submit a support ticket to request the connection. Once configured, single-patient exports can be done without further PNC assistance via the PncChart/Facility view hamburger menu ("Export Patient Documents"). Population-level exports are also supported. Files are exported to a designated file folder.

PNC explicitly acknowledges that "data fields from PNC do not always match one to one with the FHIR format resources" and that "mapping challenges were especially true for the financial data." They note plans to upgrade to FHIR R5 for improved data mapping.

The FHIR approach means the export is constrained to what FHIR R4 can represent. Many PNC data types are exported as generic DocumentReference resources (encounter notes, lab reports, letters, messages, surveys, scanned documents, photos, advance directives, transcriptions, compliance forms, consent forms, discharge summaries/CCDs). This is not inherently problematic — DocumentReference can carry embedded or referenced content — but it means the structural detail of these records may be flattened into document blobs rather than preserving their native structured fields.

### EHI Coverage Assessment

**Clinical (present):** Diagnoses (Condition), medications (MedicationRequest, MedicationStatement), allergies (AllergyIntolerance), vitals (Observation), immunizations (Immunization), procedures (Procedure), family history (FamilyMemberHistory), care plans (CarePlan), care team (CareTeam). Encounter notes, lab reports, and radiology reports included as DocumentReference. This is comprehensive clinical coverage.

**Secure messages (present, as DocumentReference):** "Messages" is listed in the export table, mapped to DocumentReference. PNC Suite has extensive messaging through both the patient web portal and counseling client portal. The export appears to include messages, though the level of structural detail (sender, recipient, timestamps, threading) may be limited by the DocumentReference format.

**Billing/financial (present, with caveats):** "Financial Statements" is listed, mapped to the FHIR Invoice resource. However, PNC explicitly acknowledges that "mapping challenges were especially true for the financial data" in FHIR R4. PNC Suite has rich billing capabilities (cashiering, bursar billing, insurance billing, claims, remittance, multiple fee schedules, charge capture). The single "Financial Statements" → Invoice mapping likely captures summary-level financial information but may not include the full granularity of charge line items, payment transactions, claim adjudication details, and adjustments that the system stores. PNC acknowledges this gap and says R5 will improve it.

**Insurance/coverage (unclear/likely incomplete):** No explicit insurance/coverage/eligibility resource is listed in the export table. PNC Suite stores insurance information (insurance billing, student health insurance plans, eligibility tracking, capitated plans, benefits management). The Registration → Patient resource may include some insurance identifiers, and Financial Statements → Invoice may reference payers, but dedicated insurance plan/coverage/authorization data does not appear to have a mapped export resource.

**Appointments/scheduling (present):** Appointments are listed, mapped to the FHIR Appointment resource. PNC Suite has extensive scheduling capabilities and this appears to be directly addressed.

**Documents/images (present):** Multiple document types are mapped to DocumentReference: scanned documents, photos, ECG/PFT, letters, outside notes, transcriptions, compliance forms, consent forms, advance directives, discharge summaries/CCDs. This is comprehensive document coverage.

**Audit (not present, not expected):** No audit trail data is listed in the export. This is not a gap per the Designated Record Set definition, as audit trails are generally excluded.

### Issues & Red Flags

1. **"Hidden" records excluded from export — potentially non-compliant.** PNC developed a "Hidden" flag system to prevent certain records (notes, lab results, radiology results) from displaying in the patient portal. They explicitly exclude these Hidden records from the b.10 export, stating they "were hidden from the patient/client for a specific reason." This conflates portal visibility with EHI export obligations. The b.10 requirement covers the full Designated Record Set, not just what's visible on the portal. A note hidden from the patient portal (e.g., a sensitive lab result) is still part of the medical record. This exclusion is a significant compliance concern.

2. **Sequestered charts excluded.** Charts flagged as "Sequestered" (involved in legal proceedings) are excluded from export. While HIPAA does allow exclusion of "information compiled in reasonable anticipation of... a civil, criminal, or administrative action or proceeding," this exception applies to the compiled litigation materials, not the underlying medical record. PNC's approach of excluding the entire chart (rather than just litigation-specific compilations) may be overbroad.

3. **API connection required at potential cost.** Customers must submit a support ticket and may incur costs to establish the API connection for export. While the b.10 standard allows "reasonable time" for setup, the cost barrier and support ticket requirement raise accessibility concerns.

4. **Financial data mapping acknowledged as incomplete.** PNC explicitly states that FHIR R4 mapping was especially challenging for financial data. The single "Financial Statements" → Invoice mapping likely under-represents the rich billing data PNC Suite stores (charges, claims, payments, adjustments, bursar billing, insurance billing).

5. **Insurance/coverage data appears absent.** Despite PNC Suite having comprehensive insurance and eligibility tracking, no dedicated Coverage, InsurancePlan, or similar resource appears in the export mapping.

6. **Counseling-specific data — unclear coverage.** PNC Suite has extensive counseling features (DSM-5 coding, surveys/instruments like PHQ9/CCAPS, group notes, third-party contact notes). The export includes "Surveys" and "Encounter Notes" as DocumentReference, but it's unclear whether counseling-specific structured data (survey scores, DSM-5 axes, treatment plans) is captured with structural fidelity or flattened into document blobs. The firewalled counseling charts raise questions about whether they're included at all — they're not mentioned in the export documentation.

7. **No field-level documentation.** The documentation maps PNC data categories to FHIR resource types but provides no field-level detail — no description of which PNC fields map to which FHIR elements, no data types, no value sets, no examples. This makes it impossible to assess the completeness of the mapping from the documentation alone.
