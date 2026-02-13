# EHI Export Documentation Review — Major Inpatient EHR Vendors

Review date: 2026-02-13 
Certification criterion: ONC 170.315(b)(10) — Electronic Health Information Export

---

## 1. Epic Systems — EpicCare Inpatient Base

**URL:** https://open.epic.com/EHITables 
**Redirects:** None (200 OK direct)

### Documentation Format & Accessibility
- **Format:** HTML web page + downloadable ZIP file
- **Main page:** Static HTML (8.7 KB), no JavaScript required, fully curl-able
- **ZIP download:** Direct download at https://open.epic.com/EHITables/Download — no auth required
  - File: `Epic EHI Tables.zip` — **12.7 MB** (Content-Type: application/x-zip-compressed)
  - Contains **7,674 files** (HTM pages + CSS), uncompressed ~83 MB
- **Online tech spec:** https://open.epic.com/EHITables/TechSpec → redirects to an `_index.htm` page (~1 MB) that serves as a browsable table-of-contents

### Content Description
- Documents **database tables exported as TSV (tab-separated value) files** in Epic's native format
- Each HTM file in the ZIP documents one export table with:
  - Table name and description (e.g., "ACCOUNT — stores information about guarantor accounts")
  - Primary key column(s) with ordinal positions
  - **Column-level detail:** column name, data type (NUMERIC, VARCHAR, DATETIME), discontinued flag, full prose description, and category value entries where applicable
- Example: The `ACCOUNT.htm` file (77 KB) documents columns like ACCOUNT_ID, ACCOUNT_NAME, BIRTHDATE, SEX, IS_ACTIVE, CITY, STATE, ZIP, phone numbers, account type categories, etc.
- Also references non-tabular content (rich text docs, images) that may be included separately in the actual export

### Detail Level
**Very high** — individual column/field level with data types, descriptions, and enumerated category values. This is the gold standard among vendors.

### Downloadability
- ✅ Fully curl-able, no authentication, no JavaScript needed
- ✅ ZIP file downloads directly with a simple GET request
- ✅ No browser interaction required

### Notable Observations
- Export content may vary by: applications in use, software version, documentation practices, configuration, and non-Epic materials
- Epic recommends FHIR bulk data access and CDA as standards-based alternatives
- The page clearly distinguishes EHI export (manual one-time patient export) from API-based integration

---

## 2. MEDITECH — Expanse 2.2 Core HCIS

**URL:** https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm 
**Redirects:** None (200 OK direct)

### Documentation Format & Accessibility
- **Format:** HTML pages (static, curl-able) organized as a main page + two configuration sub-pages
- **Main page:** 9.0 KB — overview describing two export configurations
- **Config 1:** https://home.meditech.com/en/d/restapiresources/pages/ehiexportconfig1.htm (29 KB) — for Expanse 2.2/2.1, 6.15, 6.08 Acute, Client Server Acute, MAGIC Acute
- **Config 2:** https://home.meditech.com/en/d/restapiresources/pages/ehiexportconfig2.htm (23 KB) — for 6.08 Ambulatory, Client/Server, MAGIC (uses Medical Records/Data Repository)
- **PDFs available** (Config 2 only): CS Acute/Ambulatory and MAGIC EHI Export DR solutions, 6.08 CSV documentation

### Content Description
- Describes the **structure of the export ZIP file** rather than a database schema
- Export ZIP contains:
  - `README.txt`, `EHIEXPORTSCHEMA.txt`, `ACCOUNTS_INDEX.html/.xml`, `Table of Contents.ndjson`
  - **Electronic Chart** documents (images: PNG, JPG, TIF, BMP; PDFs) organized by account/category/subcategory
  - **FHIR Resource Bundle** — US Core STU 3.1.1, using `Patient/$everything`
  - **Structured Clinical Documents** — C-CDA format
  - **Supplemental Reports** — Clinical, Administrative & Financial (PDF format)
  - **CSV patient data files** (Config 2)
- Product-version matrix shows which sections are included per MEDITECH version
- Table of Contents uses NDJSON with DocumentReference resources conforming to the EHI Export API IG (draft)

### Detail Level
**Medium** — describes file/folder structure, section contents, and FHIR resource references. Does NOT provide column-level database schema documentation. The FHIR resources follow US Core STU 3.1.1 which is itself well-documented.

### Downloadability
- ✅ All HTML pages are fully curl-able, no auth required
- ✅ PDF supplements available for Config 2 platforms
- ⚠️ No single downloadable ZIP of the documentation itself (unlike Epic)

### Notable Observations
- Hybrid approach: combines FHIR resources, C-CDA documents, electronic chart documents, and supplemental reports
- Content varies significantly across MEDITECH platform versions (Expanse vs 6.15 vs 6.08 vs Client/Server vs MAGIC)
- References the emerging EHI Export API Implementation Guide (draft) for metadata
- Customer-facing guide also available at https://customer.meditech.com (likely requires login)

---

## 3. Oracle Health (formerly Cerner) — Millennium Clinical

**URL:** https://www.oracle.com/health/regulatory/certified-health-it/ 
**Redirects:** From `/health/regulatory/certified-health-it/` → `/health/certified-health-it/` (301 redirect)

### Documentation Format & Accessibility
- **Format:** HTML landing page (68 KB) with links to multiple PDFs and ZIP files
- **Available downloads (all direct, curl-able with User-Agent header):**

| Document | Type | Size |
|----------|------|------|
| Single Patient EHI Export Data Overview and User Instructions | PDF (4 pages) | 152 KB |
| Single Patient EHI Export Data Format Specifications | ZIP | 7.4 MB |
| Patient Population EHI Export Data Overview and User Instructions | PDF (23 pages) | 447 KB |
| Patient Population EHI Export Data Format Specifications | ZIP | 15 MB |
| Oracle Health Data Intelligence EHI Export Data Overview and User Instructions | PDF | — |
| Oracle Health Data Intelligence EHI Export Data Format Specifications | PDF | — |

### Content Description
- **Single Patient export:** Extracts ALL data for one patient from Millennium into SQL files
  - Core EHR data → MySQL DDL schema files + SQL INSERT statements, loadable into an empty MySQL database
  - Multimedia content (DICOM, audio/video, images) stored as files
  - Ancillary storage system data included
- **Patient Population export:** Full database extraction for all patients
  - Single-tenant systems: full Millennium database copy delivered via encrypted physical device
  - Multi-tenant systems (CommunityWorks, Ambulatory ASP): SQL files like single-patient
  - Additional appendices: DICOM data structure, non-DICOM column definitions, Document Imaging schema, Longitudinal Plan
- **Data Model ZIP** (nested inside specs ZIPs): `EHI MYSQL DATA MODEL 2025401.zip` — **1,459 files** (~55 MB uncompressed)
  - Interactive HTML data model reports organized alphabetically (dm_a.html through dm_z.html)
  - Tables indexed by name with clickable navigation
  - Example tables: ABN_CROSS_REFERENCE, ABSTRACTING, ACCESSION, ACCOUNT, ALLERGY, etc.

### Detail Level
**Very high** — full relational database schema with table definitions, column names, data types, and relationships. The data model reports are comprehensive and browsable. Population export also includes multimedia storage schemas (DICOM, document imaging).

### Downloadability
- ⚠️ PDFs and ZIPs require a browser-style User-Agent header (plain curl gets text/html redirect page)
- ✅ With proper User-Agent header, all files download directly — no authentication needed
- ✅ No JavaScript required to find links (they're in static HTML)

### Notable Observations
- Offers both single-patient and full-population export — most comprehensive scope
- Physical device shipment option for large single-tenant exports is unique
- Still references "Cerner" in some filenames (e.g., `cerner-corp-single-patient-ehi-export-data-overview.pdf`)
- Data model version: 2025.4.01
- MySQL AND Oracle database models provided for population export

---

## 4. Altera Digital Health (formerly Allscripts) — Sunrise Acute Care

**URL:** https://www.alterahealth.com/legal/onc-reg-compliance/ 
**Redirects:** None (200 OK direct)

### Documentation Format & Accessibility
- **Format:** WordPress HTML page (204 KB) with expandable accordion sections; EHI export docs are downloadable ZIPs
- **Sunrise Acute Care EHI downloads (multiple versioned releases):**
  - Sunrise EHI Export Definition 22.1 PR23 (ZIP)
  - Sunrise EHI Export Definition 22.1 PR24 (ZIP)
  - Sunrise EHI Export Definition 22.1 PR27 (ZIP) — **13 MB**, 5,495 files, ~68 MB uncompressed
  - Sunrise EHI Export Definition 22.1 PR28 (ZIP)
  - Sunrise EHI Export Definition 22.1 PR38 (ZIP)
  - Plus corresponding "WebER Diagram" ZIPs for some versions
- **Other products also documented:** Altera Lab, dbMotion, Paragon/Denali, TouchWorks

### Content Description
- ZIPs contain **ER/Studio Intranet Documentation** — a frameset-based HTML web application
  - Generated by IDERA ER/Studio data modeling tool
  - Displays database entity-relationship diagrams and table documentation
  - Each table has its own HTM file (e.g., `Tbl_<guid>.htm`) with:
    - Table name, definition/description
    - Column name, domain, SQL datatype, nullable flag, full prose definition
    - Build version tracking, audit columns (TouchedBy, TouchedWhenUTC, CreatedBy, etc.)
  - **~2,668 table definitions** in the PR27 export
  - Example: `SXARCMDictionaryDetail` table with columns like Build (int), TouchedBy (varchar), DictionaryDetailID (int PK), etc.
- Instructions: extract ZIP → open `index.html` in a browser to navigate the ER diagram

### Detail Level
**Very high** — full database schema with column-level definitions, data types, nullable flags, foreign key references, and descriptive text. ER diagrams provide visual relationship context.

### Downloadability
- ✅ ZIP files download directly via curl with no authentication
- ✅ Multiple version releases available simultaneously
- ⚠️ The EHI section is inside an expandable accordion — links are in the HTML but the section heading says "Expand"

### Notable Observations
- Uses ER/Studio tool output — provides both visual ER diagrams and tabular documentation
- Covers multiple products on one page with per-product instructions
- Also offers a `capabilitystatement.json` and `extension-details.xlsx` download
- Version-specific releases (PR23 through PR38) allow tracking schema changes over time

---

## 5. MEDHOST — Enterprise Clinicals

**URL:** https://www.medhost.com/ehr/interoperability/ 
**Redirects:** None (200 OK direct)

### Documentation Format & Accessibility
- **Format:** WordPress HTML page (198 KB) — primarily a marketing/interoperability landing page with an EHI Export section embedded
- **Only downloadable documentation:** A single Excel file for FHIR extension fields
  - URL: https://www.medhost.com/fhir/extensions/MEDHOST-FHIR-Extension-Fields.xlsx
  - Size: **136 KB**
  - Format: Microsoft Excel 2007+ (XLSX)

### Content Description
- The page explains that MEDHOST uses **FHIR R4 v4.0.1** as the structure for EHI exports
- Export produces **multiple NDJSON files per patient** delivered as a compressed ZIP
- Supports single-patient (via YourCare® Universe patient portal or admin-initiated) and system-wide exports
- The Excel file documents **FHIR extension fields** (fields MEDHOST adds beyond standard FHIR R4):
  - **41 resource-specific sheets** covering: Allergy, Ancillary Order, Appointment, Charge Item, Condition, Consent, Coverage, Detected Issue, Diagnostic Report, Encounter (103 extensions), Patient (60 extensions), Procedure (104 extensions), Observation Labs, Immunization, Medication Administration, MedicationRequest variants, and more
  - Each extension field has: Field Name, Version, FHIR Field Type, Max Field Length, Field Description, and internal database table/column references (for Enterprise, EDIS, and Y databases)
  - ~**776 extension fields** total across all resources
- **No documentation of the base FHIR resources themselves** — relies on the FHIR R4 spec for that

### Detail Level
**Medium** — documents only the *extensions* beyond standard FHIR R4, not the full export schema. The extensions are field-level with types and descriptions, but the core FHIR resource content is not documented locally (user must reference hl7.org/fhir/R4).

### Downloadability
- ✅ Excel file downloads directly via curl, no authentication
- ⚠️ Only one file — no comprehensive schema documentation, ZIP, or PDF
- ⚠️ The EHI section is embedded within a broader interoperability marketing page

### Notable Observations
- Simplest/most minimal documentation of all five vendors
- FHIR-native approach (NDJSON files) is the most standards-based export format
- Extension documentation includes internal database column mappings — useful for understanding data provenance
- No separate data dictionary for the full export — relies on FHIR R4 spec as implicit documentation
- Page is heavily marketing-oriented with embedded videos and infographics alongside the EHI content

---

## Comparative Summary

| Vendor | Format | Export Type | Detail Level | # Tables/Resources | Directly Downloadable? |
|--------|--------|-------------|-------------|-------------------|----------------------|
| **Epic** | HTML + ZIP (7,674 HTM files) | Proprietary TSV tables | Very High (column-level) | ~7,673 tables | ✅ Yes |
| **MEDITECH** | HTML pages (2 configs) | Hybrid: FHIR + C-CDA + eChart + CSV | Medium (section/file-level) | N/A (FHIR bundles) | ✅ Yes (HTML) |
| **Oracle Health** | PDFs + ZIPs (nested, 1,459 files) | MySQL/Oracle SQL dumps | Very High (column-level) | ~1,459 tables | ✅ Yes (needs User-Agent) |
| **Altera** | ZIPs (ER/Studio HTML, 5,495 files) | Proprietary DB schema | Very High (column-level) | ~2,668 tables | ✅ Yes |
| **MEDHOST** | Single XLSX (136 KB) | FHIR R4 NDJSON | Medium (extension fields only) | 41 FHIR resources | ✅ Yes |

### Key Takeaways

1. **Epic** provides the most accessible and well-structured documentation — a single ZIP with self-contained HTML documentation for every table and column.

2. **Oracle Health** is the most comprehensive in scope, offering both single-patient and population-level exports with full relational database models, multimedia schemas, and physical delivery options.

3. **Altera** provides professional ER/Studio-generated documentation with visual ER diagrams — good for understanding table relationships, but requires extracting and opening in a browser.

4. **MEDITECH** takes a unique hybrid approach combining FHIR resources, C-CDA documents, and proprietary formats — well-documented at the structural level but less granular on individual fields.

5. **MEDHOST** has the most minimal documentation — a single Excel file covering only FHIR extensions. The FHIR-native approach means the FHIR R4 spec serves as implicit documentation for the base export, but this puts the burden on the consumer to understand FHIR.
