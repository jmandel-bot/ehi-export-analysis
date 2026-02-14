# ReportingMD, Inc. — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10692
- Registered URL: https://reportingmd.com/ehi-export-specifications/
- Developer: ReportingMD, Inc.
- Product: Total Outcomes Management (TOM) v9.8

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://reportingmd.com/ehi-export-specifications/" -H 'User-Agent: Mozilla/5.0'
```
Result:
- HTTP/2 301 → `https://www.reportingmd.com/ehi-export-specifications` (adds `www.` prefix, drops trailing slash)
- HTTP/2 200 at final URL
- Content-Type: `text/html; charset=UTF-8`
- Server: Pepyaka (Wix hosting infrastructure)
- No content-disposition header (not a direct file download)

### Step 2: Page examination
```bash
curl -sL "https://reportingmd.com/ehi-export-specifications/" -H 'User-Agent: Mozilla/5.0' -o /tmp/reportingmd-page.html
wc -c /tmp/reportingmd-page.html
```
- Page size: 732,653 bytes
- The page is a Wix-hosted site (Wix Thunderbolt framework). The HTML source is mostly JavaScript framework code with very little visible text content extractable via `sed`. The actual page content is rendered client-side.
- Stripping HTML tags from the source yields only framework initialization code, no readable page content.

### Step 3: Finding the EHI documentation
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/reportingmd-page.html
```
Found one PDF link embedded in the HTML source:
- `href="https://www.reportingmd.com/_files/ugd/92271b_95a0ae3fc4e34abeafd3659300505627.pdf"`

This is a Wix user-generated content (UGD) file URL — a PDF hosted through Wix's file storage.

Browsing to the page in a browser confirms:
- Page title: "ReportingMD EHI Export Specifications Version 1.0"
- A single clickable link labeled "EHI Export" pointing to the PDF
- Below the link, the page footer contains navigation links (Solution, Who We Serve, Programs We Support, Case Studies, Privacy Policy, ONC Certification, Real World Test Plan, ONC D13)
- An ONC Certified Health IT badge is displayed
- No accordion sections, no additional tabs, no other downloadable artifacts

### Step 4: Identified downloadable assets
Only one asset found:
1. PDF: `https://www.reportingmd.com/_files/ugd/92271b_95a0ae3fc4e34abeafd3659300505627.pdf`
   - This is the "ReportingMD EHI Export Specifications Version 1.0" document

No other EHI-related files (ZIPs, data dictionaries, schema definitions) were found on this page or linked from it.

## Downloads

### reportingmd-ehi-export-specifications.pdf (218 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/reportingmd-ehi-export-specifications.pdf \
  'https://www.reportingmd.com/_files/ugd/92271b_95a0ae3fc4e34abeafd3659300505627.pdf'
```
Verified: `file reportingmd-ehi-export-specifications.pdf` → PDF document, version 1.7, 1 page(s)
Size: 223,431 bytes (218 KB)
Pages: 1

**Contents:** A single-page document titled "ReportingMD EHI Export Specifications Version 1.0" containing:
- A summary section stating the export format is Microsoft Excel (.xlsx)
- A table listing 24 data elements (columns B through Y), of which only 11 are actually collected
- Data elements marked with asterisk (*) as "not collected": County, Precinct, Geocodes, Fax, MRN, Health Plan Beneficiary Numbers, Account Numbers, Vehicle Identifiers, Device Identifiers, URLs, IP Addresses, Biometric Identifiers, Images

The 11 data elements actually exported are exclusively patient demographics:
- Patient ID, Patient Name, DOB, Gender, Street Address, City, ZIP Code, DOD (Date of Death), Phone Number, Email Address, SSN

## Obstacles & Notes
- The Wix-hosted page renders content via JavaScript (Wix Thunderbolt framework), but the PDF link was discoverable via grep of the raw HTML source — no browser interaction strictly required to find it.
- The PDF link uses Wix's internal UGD file path (`/_files/ugd/...`) which is not descriptive but works reliably.
- No anti-bot protection encountered; standard curl with User-Agent header worked for both the page and the PDF download.
- The page is very simple — a title, a single download link, and a footer. No complexity in navigation.

---

## Product: Total Outcomes Management (TOM)

### Product Context

**ReportingMD's Total Outcomes Management (TOM) is NOT an EHR.** It is a population health analytics and quality reporting platform. TOM sits alongside EHRs as a secondary system that aggregates data from other sources.

Key characteristics discovered from the vendor's website (https://reportingmd.com/):
- **Primary function:** Clinical data warehouse and quality measure (CQM) calculation engine
- **Data sources:** Ingests data from 50+ EMRs via configurable connectors, plus claims data, SDoH data, and ADT feeds
- **Core use case:** MIPS/quality measure reporting to CMS. ReportingMD is a CMS-designated Qualified Registry (QR)
- **Customers:** ACOs (e.g., Tufts Medicine ACO, Vermont All-Payer ACO), clinically integrated networks, medical groups, specialty practices
- **Programs supported:** ACO REACH, MIPS, MSSP, HCC Risk Adjustment, HEDIS/STARS Analytics, APCM, and others

**What TOM does NOT have** (confirmed by absence of relevant ONC criteria):
- No patient portal or messaging (criterion (e)(1) absent)
- No clinical documentation / CPOE / e-prescribing (all (a)(1)-(a)(14) criteria absent)
- No billing or scheduling modules
- No document management
- No public health reporting (criteria (f)(1)-(f)(7) absent)
- No FHIR API (criteria (g)(7)-(g)(10) absent)

**Certified criteria** are limited to: (b)(10) EHI export, (c)(2)-(c)(3) CQM calculation/export, (d) security criteria, and (g)(4)-(g)(5) quality management system. This confirms TOM is primarily a quality reporting tool, not a clinical system.

### Export Approach

The export is a simple Microsoft Excel (.xlsx) spreadsheet containing patient demographic data only. For a single patient, data appears in a single row. For a population export, data appears in multiple rows. This is essentially a patient roster dump — the demographic identifiers that TOM stores for its patient matching index.

**Not a database dump, not FHIR, not C-CDA.** This is a flat demographic table export. There are no clinical data elements, no quality measure results, no aggregated clinical data, and no analytics output in the export specification.

### EHI Coverage Assessment

| Category | Present? | Evidence |
|----------|----------|----------|
| Clinical | No | Zero clinical data elements in the export. No diagnoses, medications, labs, vitals, procedures, or any clinical content. The specification lists only demographic identifiers. |
| Secure messages | No | Not applicable — TOM does not have messaging functionality. |
| Billing/financial | No | Not present. TOM ingests claims data for analytics but does not export it. |
| Insurance/coverage | No | Not present. The specification lists "Health Plan Beneficiary Numbers" as a data element but marks it as "not collected." |
| Appointments/scheduling | No | Not applicable — TOM does not have scheduling functionality. |
| Documents/images | No | The specification lists "Images" as a data element but marks it as "not collected." |
| Audit trails | No | Not present in the export specification. |

**The export contains only patient demographics** — 11 fields covering identity (ID, name, SSN), demographics (DOB, gender), contact info (address, city, ZIP, phone, email), and date of death. This is a patient matching roster, not a clinical data export.

### Issues & Red Flags

1. **Extremely minimal export scope.** The entire EHI export is a single Excel spreadsheet with 11 demographic fields. No clinical, financial, or analytical data is included despite TOM storing substantial amounts of aggregated clinical and claims data.

2. **Missing quality measure results.** TOM calculates 40+ CQMs (clinical quality measures), HCC risk scores, and HEDIS measures. These computed results are arguably EHI — they are health information derived from patient data and stored in the system — yet they are entirely absent from the export.

3. **Missing ingested clinical data.** TOM ingests clinical data from 50+ EMRs and normalizes it into a clinical data warehouse. This aggregated clinical data (which TOM processes to calculate quality measures) is not included in the export. While this data originates from other EHRs, TOM stores a copy of it, and the b(10) requirement covers "all EHI that can be stored at the time of certification by the product."

4. **Missing claims data.** TOM ingests and stores adjudicated claims data for analytics. This data is not included in the export.

5. **The data element list appears modeled on HIPAA identifiers, not on what the system stores.** The 24 columns in the specification (Patient ID through Images) closely mirror the 18 HIPAA identifiers — suggesting the vendor designed the export around HIPAA de-identification categories rather than around the actual data stored by the product. Many columns are marked "not collected" because they are HIPAA identifiers that TOM doesn't happen to store (Vehicle Identifiers, Device Identifiers, Biometric Identifiers, etc.).

6. **Single-page documentation.** The entire export specification fits on one PDF page. Given that TOM is a data warehouse processing data from 50+ EMRs, the documentation is remarkably sparse — there are no schema details for the underlying data warehouse, no description of the analytics data model, and no explanation of what data categories are excluded or why.

7. **Excel as export format.** While Excel is functional for a small demographic roster, it raises questions about scalability for population-level exports and about machine-readability for downstream processing. The specification notes "multiple rows for a population export" but provides no detail on how large populations are handled.
