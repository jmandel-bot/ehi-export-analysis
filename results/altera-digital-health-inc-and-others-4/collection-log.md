# Altera Digital Health — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11199, 11401, 11589, 11675, 11707, 11708, 11709, 11761
- **Developers**: Altera Digital Health Inc., Providers Management, Inc.
- **Products**: Altera Lab™, Integrated Providers Patient Portal, Paragon® Denali, Paragon® EHR, Sunrise Acute Care, Sunrise Acute Care for Hospital-based Providers, Sunrise Ambulatory Care, TouchWorks EHR
- **Registered URL**: https://www.alterahealth.com/legal/onc-reg-compliance/

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.alterahealth.com/legal/onc-reg-compliance/" \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36'
```
**Result**: HTTP/2 200 directly (no redirects). Content-Type: text/html; charset=UTF-8. Content-Length: 203,794 bytes. Hosted on WP Engine (WordPress). No anti-bot protection encountered.

### Step 2: Page examination
```bash
curl -sL "https://www.alterahealth.com/legal/onc-reg-compliance/" \
  -H 'User-Agent: Mozilla/5.0' -o /tmp/altera-page.html
wc -c /tmp/altera-page.html  # 203794 bytes
```
The page is a WordPress-powered compliance hub at ~204KB. The page title is "ONC Regulatory Compliance." The HTML contains substantive content directly (not a JS SPA), though the page uses accordion-style sections that are collapsed by default. Content is in the DOM and findable via grep even without JavaScript.

### Step 3: Finding the EHI section
The page has several accordion sections visible in the DOM:
- ONC Real World Testing Plans & Reports
- **EHI Export Documentation** ← target
- Archived EHI Export Documentation
- Predictive Decision Support Intervention Risk Management (IRM) Practices

The "EHI Export Documentation" accordion, when expanded, reveals subsections for each product:
- **Altera Lab** — single PDF link
- **dbMotion** — two files (XLSX data dictionary + PDF reference guide)
- **Paragon** — ZIP file containing CapabilityStatement.json and Extension-Details.xlsx
- **Sunrise** — multiple versioned ZIP files (ER diagram documentation)
- **TouchWorks** — multiple versioned ZIP files (database documentation)

### Step 4: Identified downloadable assets
All download links follow the pattern: `https://www.alterahealth.com/download/204/ehi-documentation/{id}/{filename}`

**Current/Latest versions identified:**

| Product | File | URL |
|---------|------|-----|
| Altera Lab | altera-lab-ehi-export-definition-23-2-0-0.pdf | /download/204/ehi-documentation/11976/... |
| dbMotion | ehiconsolidateddatafiles_dbmotion.xlsx | /download/204/ehi-documentation/11974/... |
| dbMotion | ehiexportreferenceguide_dbmotion.pdf | /download/204/ehi-documentation/11975/... |
| Paragon | paragon-ehr-25-1-paragon-denali-1 (ZIP) | /download/204/ehi-documentation/16995/... |
| Sunrise | ehi-weberdiagram-22-1-pr38 (ZIP) | /download/204/ehi-documentation/15816/... |
| TouchWorks | twehr-2026-1-touchworks-ehi-export-definition (ZIP) | /download/204/ehi-documentation/16825/... |

Older versions also available on the page (Sunrise PR23/PR24/PR27/PR28; TouchWorks 2025.1-2025.4; Paragon 24.1; archived TouchWorks 22.1.6/22.1.7/2024.1-2024.3).

## Downloads

### altera-lab-ehi-export-definition-23.2.0.0.pdf (571 KB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o altera-lab-ehi-export-definition-23.2.0.0.pdf \
  'https://www.alterahealth.com/download/204/ehi-documentation/11976/altera-lab-ehi-export-definition-23-2-0-0.pdf'
```
Verified: `file` → PDF document, version 1.4, 4 pages
Content: JSON field-level data dictionary for lab data export. Covers Patient, PatComment, Encounters, EntOrdComment, TestComment, PtResult, ResComment, Observation, SubResult sections.
Saved to: downloads/altera-lab-ehi-export-definition-23.2.0.0.pdf

### dbmotion-ehi-consolidated-data-files.xlsx (280 KB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o dbmotion-ehi-consolidated-data-files.xlsx \
  'https://www.alterahealth.com/download/204/ehi-documentation/11974/ehiconsolidateddatafiles_dbmotion.xlsx'
```
Verified: Microsoft Excel 2007+
Content: 19 sheets covering Master_Patient (98 fields), Encounters (120 fields), Conditions (63 fields), Medications (112 fields), Immunizations (61 fields), Measurements (77 fields), Labs and Pathology (173 fields), Documents (83 fields), Allergies (40 fields), Imaging (128 fields), Procedures (66 fields), and master/reference tables. Each sheet has Attribute, Description, Type, Length columns.
Saved to: downloads/dbmotion-ehi-consolidated-data-files.xlsx

### dbmotion-ehi-export-reference-guide.pdf (1.78 MB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o dbmotion-ehi-export-reference-guide.pdf \
  'https://www.alterahealth.com/download/204/ehi-documentation/11975/ehiexportreferenceguide_dbmotion.pdf'
```
Verified: PDF document, version 1.4, 17 pages
Content: User guide covering EHI Export overview, permissions model, Export Patient Data UI, single/population export process, file format definitions, and data dictionary summary. Published November 27, 2023.
Saved to: downloads/dbmotion-ehi-export-reference-guide.pdf

### paragon-ehr-25.1-denali-1-ehi.zip (84 KB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o paragon-ehr-25.1-denali-1-ehi.zip \
  'https://www.alterahealth.com/download/204/ehi-documentation/16995/paragon-ehr-25-1-paragon-denali-1'
```
Verified: ZIP archive. Contains 2 files:
- CapabilityStatement.json (460 KB) — FHIR R4 CapabilityStatement with 48 FHIR resources
- Extension-Details.xlsx (64 KB) — 827 rows of custom FHIR extension definitions
Extracted to: downloads/paragon-extracted/
Saved to: downloads/paragon-ehr-25.1-denali-1-ehi.zip

### sunrise-ehi-export-definition-22.1-pr38.zip (13.7 MB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o sunrise-ehi-export-definition-22.1-pr38.zip \
  'https://www.alterahealth.com/download/204/ehi-documentation/15816/ehi-weberdiagram-22-1-pr38'
```
Verified: ZIP archive. Contains 6,114 files (81 MB extracted).
Structure: "EHI WebERDiagram 22.1 PR38" folder with 4 submodels:
- **SCM** (main clinical model): 2,728 tables (including ~918 RCM/revenue cycle tables)
- **MNC**: 11 tables
- **IMG**: 7 tables (imaging binary objects/documents)
- **FS**: 1 table

Each table has an attribute-level HTML page documenting columns, data types, descriptions, and relationships. This is an ER Studio WebERDiagram export — a visual database schema documentation tool. Uses a tree navigation structure (index.htm → tree.htm → table detail pages).
Extracted to: downloads/sunrise-extracted/
Saved to: downloads/sunrise-ehi-export-definition-22.1-pr38.zip

### touchworks-ehi-export-definition-twehr-2026.1.zip (1.4 MB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o touchworks-ehi-export-definition-twehr-2026.1.zip \
  'https://www.alterahealth.com/download/204/ehi-documentation/16825/twehr-2026-1-touchworks-ehi-export-definition'
```
Verified: ZIP archive. Contains 742 files (7.1 MB extracted).
Structure: Interactive HTML documentation with tree navigation. 8 databases:
- **Works**: 516 tables (main clinical/administrative database)
- **Impact**: 22 tables (document management)
- **IntegratedScan**: 6 tables (scanning/audit)
- **AHSCharge**: 2 tables (charge/billing reference)
- **Quippe**: 2 tables (clinical content)
- **WorksArchive**: 2 tables (archive)
- **chMedcinSearch**: 1 table (clinical terminology)
- **WorksCDSAggregatorArchive**: 0 tables (empty)

Each table page shows columns, data types, max lengths, nullability, identity, defaults, and descriptions. Author noted as "Altera Digital Health Copyright 2025." Created December 22, 2025.
Extracted to: downloads/touchworks-extracted/
Saved to: downloads/touchworks-ehi-export-definition-twehr-2026.1.zip

## Product Context

Altera Digital Health (formerly Allscripts, spun off from its parent in 2022 and acquired by N. Harris Computer Corporation) is a major EHR vendor serving hospitals and ambulatory practices. The product portfolio includes:

- **Sunrise Acute Care / Sunrise Ambulatory Care**: Full-featured inpatient and outpatient EHR for large hospital systems. Includes clinical documentation, CPOE, pharmacy, and integrated financials (revenue cycle management — evidenced by 918 RCM-prefixed tables in the database). Cloud-capable on Microsoft Azure. Described as "a single patient record" platform. The presence of SXAAMBSVAppointment tables confirms scheduling, and SXAAMBSendMessageInstance/SXAGNLetterTemplateInstance confirms messaging.

- **TouchWorks EHR**: Ambulatory EHR for physician practices and outpatient settings. Database includes Charge, Payment, Insurance, Appointment, Schedule, PatientCommunication, PatientPortalUserActivity tables — indicating billing, scheduling, portal messaging, and clinical functions are all part of the product.

- **Paragon EHR / Paragon Denali**: EHR platform specifically designed for rural, critical access, and community hospitals. Newly deployed on Microsoft Azure cloud. The EHI export uses FHIR R4 format with 48 resource types.

- **Altera Lab (formerly Allscripts Lab)**: Laboratory information system (LIS). Export is JSON format covering patient demographics, encounters, test orders, results, and observations.

- **dbMotion**: Health information exchange (HIE) and clinical data aggregation platform. Aggregates data from multiple source systems into a unified patient record. Export is CSV-based with 19 data file types.

- **Integrated Providers Patient Portal**: Patient-facing portal product. Listed as a CHPL-certified product but **no separate EHI export documentation found on the compliance page**. This portal likely integrates with Sunrise/TouchWorks/Paragon.

## Obstacles & Notes

1. **No anti-bot issues**: The WordPress page served full HTML content directly with a standard User-Agent. Cookie consent banner appeared in browser but didn't block content.

2. **Accordion navigation required**: EHI docs are inside a collapsible accordion on the compliance hub page. Content is in the DOM (grep-accessible) even when collapsed.

3. **Multiple products, multiple export approaches**: This is unusual — each Altera product has its own distinct export format and documentation:
   - Sunrise: native database schema (ER diagram), database-native export
   - TouchWorks: native database schema (HTML table docs), database-native export
   - Paragon: FHIR R4 resource export
   - Altera Lab: custom JSON export
   - dbMotion: CSV file export

4. **No documentation for Integrated Providers Patient Portal**: Despite being a CHPL-listed product, there's no separate EHI export doc for it on this page.

5. **Download URLs lack file extensions**: Several download links (Paragon, newer Sunrise/TouchWorks versions) have no .zip extension in the URL but serve ZIP files. Content-type detection handles this correctly.

6. **Some product pages are 404**: The TouchWorks EHR product page (https://www.alterahealth.com/touchworks-ehr/) returns 404, suggesting the website is being restructured.
