# Oracle Health — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10594, 11505, 11519, 11520, 11522, 11667, 11668, 11669, 11670, 11674
- Registered URL: https://www.oracle.com/health/regulatory/certified-health-it/
- Products: Oracle Health Millennium (CQMs), Oracle Health Millennium (Clinical), Oracle Health Millennium (Health Care Surveys), Oracle Health Millennium (Immunizations), Oracle Health Patient Portal, Oracle Health PowerChart Touch

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.oracle.com/health/regulatory/certified-health-it/" \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```
**Result:** HTTP 301 redirect from `/health/regulatory/certified-health-it/` → `/health/certified-health-it/`, then HTTP 200. The registered URL has been reorganized (dropped "regulatory" from path) but Oracle's server handles the redirect transparently. Final URL: `https://www.oracle.com/health/certified-health-it/`. Content-Type: text/html; charset=UTF-8. Note: Oracle requires a User-Agent header or returns redirect pages.

### Step 2: Page examination
```bash
curl -sL "https://www.oracle.com/health/regulatory/certified-health-it/" \
  -H 'User-Agent: Mozilla/5.0' -o /tmp/oracle-page.html
wc -c /tmp/oracle-page.html
```
**Result:** 68,166 bytes. Real HTML content (not a JS SPA). Page title: "Certified Health IT | Oracle Health". The page description references Cerner's legacy: "Cerner offers products certified under the Office of the National Coordinator for Health Information Technology (ONC) Health IT Certification Program." Page last updated: 2026-01-02.

### Step 3: Finding the EHI section
The page is a compliance hub with a table of contents sidebar containing these sections:
- ASTP/ONC Certified Health IT
- Costs and fees information
- Certified API technology fees
- Artificial Intelligence and Machine Learning Development Practices
- **Electronic Health Information (EHI) Export** ← target section
- Real World Testing
- Standards Version Advancement Process
- Multifactor authentication use cases
- Where to find more information about the Oracle Health certifications

The EHI Export section (id: `ehi-export-lnk`) is inside an accordion labeled **"Read more about EHI Export"** (collapsed by default, `aria-expanded="false"`). However, the content is present in the HTML DOM (just hidden via CSS), so curl retrieves it without needing JavaScript.

The section header text reads: *"Oracle Health's certified health IT modules which store electronic health information (EHI) support the ability to export that EHI in an electronic and computable format. This includes both a single patient export capability intended for fulfilling a patient's right of access request and a patient population export intended for the purpose of facilitating data transitions when providers switch health IT systems."*

### Step 4: Identified downloadable assets

Inside the accordion, there are two sub-sections with tables:

**Oracle Health EHR and Millennium Platform** — covers Oracle Health EHR, Oracle Health Millennium (Clinical), Oracle Health Millennium (CQMs), Oracle Health Millennium (Health Care Surveys), Oracle Health Millennium (Immunizations), Oracle Health PowerChart Touch, Oracle Health Patient Portal:

| EHI Export Type | Data Overview PDF | Data Format Specifications |
|---|---|---|
| Single Patient Export | [PDF](https://www.oracle.com/a/ocom/docs/industries/healthcare/cerner-corp-single-patient-ehi-export-data-overview.pdf) | [ZIP](https://www.oracle.com/a/ocom/docs/industries/healthcare/single-patient-ehi-export-data-format-specifications.zip) |
| Patient Population Export | [PDF](https://www.oracle.com/a/ocom/docs/industries/healthcare/cerner-corp-patient-population-ehi-export-data-overview.pdf) | [ZIP](https://www.oracle.com/a/ocom/docs/industries/healthcare/patient-population-ehi-export-data-format-specifications.zip) |

**Oracle Health Data Intelligence (HDI)** — covers the Oracle Health Data Intelligence: eCQMs certified health IT module:

| EHI Export Type | Data Overview PDF | Data Format Specifications |
|---|---|---|
| Single Patient and Patient Population Exports | [PDF](https://www.oracle.com/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-overview-user-instructions.pdf) | [PDF](https://www.oracle.com/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-format-specifications.pdf) |

Note: HDI is a separate product (population health/analytics platform) with its own CHPL entries not in our target list. We include it for completeness since it was on the same page, but our primary analysis focuses on the Millennium platform products.

## Downloads

### single-patient-ehi-export-data-overview.pdf (151 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o single-patient-ehi-export-data-overview.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/cerner-corp-single-patient-ehi-export-data-overview.pdf'
```
Verified: `file` → PDF document, version 1.7, 4 pages.
Content: User instructions for consuming single-patient EHI export. Describes the ZIP structure: v500/schema (DDL), v500/activity (data), v500/reference (reference data), camm/ (multimedia), dicom/ (DICOM images), cdi/ (document imaging).
Saved to: downloads/single-patient-ehi-export-data-overview.pdf

### single-patient-ehi-export-data-format-specifications.zip (7.3 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o single-patient-ehi-export-data-format-specifications.zip \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/single-patient-ehi-export-data-format-specifications.zip'
```
Verified: ZIP archive. Contains 3 files:
- `EHI MYSQL DATA MODEL 2025401.zip` — nested ZIP with 1,459 files (HTML data model reports for MySQL schema), version 2025.4.01
- `Longitudinal Plan EHI Export - Single Patient.pdf` — care plan export specs (health concerns, goals, activities, strengths, care plans)

The MySQL data model ZIP was extracted to `mysql-data-model/`. Contains:
- `start_cerner_millennium_data_model_reports.html` — main index
- `html/dm_a.html` through `html/dm_z.html` — alphabetical table indexes
- `html/dms_*.html` — detailed schema pages organized by module (e.g., `dms_pft_billing1.html`, `dms_scheduling1.html`)
- `images/` — ERD diagrams
- **6,604 unique table names** extracted across the data model

### patient-population-ehi-export-data-overview.pdf (447 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o patient-population-ehi-export-data-overview.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/cerner-corp-patient-population-ehi-export-data-overview.pdf'
```
Verified: PDF document, version 1.7, 23 pages.
Content: Comprehensive user instructions for patient population EHI export. Describes four independent storage locations:
1. Core Millennium EHR Data (SQL database)
2. Oracle Health Multimedia Storage (DICOM and non-DICOM files)
3. Oracle Health Document Imaging (scanned documents, binary files)
4. Oracle Health Longitudinal Plan (One Plan) Data (care plans as CSV)

Distinguishes between multi-tenant systems (SQL files) and single-tenant systems (full database copy on encrypted device).

### patient-population-ehi-export-data-format-specifications.zip (14.9 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o patient-population-ehi-export-data-format-specifications.zip \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/patient-population-ehi-export-data-format-specifications.zip'
```
Verified: ZIP archive. Contains 8 files:
- `EHI MYSQL DATA MODEL 2025401.zip` — same as in single patient ZIP
- `EHI ORACLE DATA MODEL 2025401.zip` — Oracle database variant (1,459 files, identical structure)
- `Longitudinal Plan EHI Export - Patient Population.pdf` — care plan export specs
- `Oracle Health Document Imaging AxAnnotations.xsd` — XSD for document annotations
- `Oracle Health Document Imaging Content Management Database Schema.pdf` — schema for AE_ADEFS, AE_DT#, AE_DL#, AE_RH# tables
- `Oracle Health Multimedia Storage DICOM Data Structure and Definitions.pdf` — XML/JSON structure for DICOM data
- `Oracle Health Multimedia Storage Non-DICOM Data Column Definitions.pdf` — CSV column definitions for non-DICOM multimedia

### hdi-ehi-export-data-overview-user-instructions.pdf (168 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o hdi-ehi-export-data-overview-user-instructions.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-overview-user-instructions.pdf'
```
Verified: PDF document, version 1.7, 3 pages.
Content: Instructions for HDI Longitudinal Record Bulk Extract API (REST API-based). Not directly relevant to the Millennium platform CHPL entries.

### hdi-ehi-export-data-format-specifications.pdf (5.7 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o hdi-ehi-export-data-format-specifications.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-format-specifications.pdf'
```
Verified: PDF document, version 1.3, 8 pages (but very long — 124 unique Avro entity types documented).
Content: Avro schema definitions for the HDI Longitudinal Record poprecord entities (Actor, Address, Allergy, Appointment, BenefitPlan, Claim, Condition, Encounter, Immunization, Medication, Procedure, etc.).

## Obstacles & Notes

1. **URL redirect**: The registered URL `/health/regulatory/certified-health-it/` redirects to `/health/certified-health-it/`. The redirect is transparent (301) and works reliably.
2. **Accordion pattern**: The EHI documentation is inside a collapsed accordion section. Content is present in DOM but hidden via `aria-hidden="true"`. No JavaScript needed — curl captures everything.
3. **User-Agent required**: Oracle's Akamai CDN may return redirect/challenge pages without a browser-like User-Agent header.
4. **Legacy Cerner naming**: File URLs still use `cerner-corp-` prefix. The data model reports header says "Cerner Millennium" reflecting the product's history (Cerner was acquired by Oracle in 2022).
5. **Nested ZIP structure**: The format specifications ZIPs contain nested ZIPs (MySQL/Oracle data model ZIPs inside the outer ZIP). Two levels of extraction needed.
6. **Dual database format**: Both MySQL and Oracle database schemas are provided — customers may be on either platform.

---

## Product: Oracle Health Millennium

### Product Context

Oracle Health Millennium (formerly Cerner Millennium) is one of the largest enterprise EHR platforms globally, deployed at thousands of hospitals and health systems. Oracle acquired Cerner Corporation in 2022 for $28.3 billion. The Millennium platform is a comprehensive health information system that spans:

- **Clinical**: PowerChart (physician documentation), PowerChart Touch (mobile), nursing documentation, flowsheets, dynamic documentation, physician orders (CPOE), pharmacy (PharmNet), laboratory (PathNet), radiology (RadNet), surgery (SurgiNet), oncology, behavioral health, women's health
- **Patient Portal**: Oracle Health Patient Portal (certified module) — patient-facing portal for health record access, appointment scheduling, messaging, bill pay
- **Revenue Cycle**: Billing (PFT — Patient Financial Transaction), claims, collections, charge services, revenue cycle configuration, benefits verification, eligibility
- **Scheduling**: Comprehensive scheduling system (SCH_ tables, 189 tables), appointment management, resource scheduling
- **Document Management**: Oracle Health Document Imaging (CDI), multimedia storage (DICOM, audio, video, images), scanned documents, faxes
- **Care Coordination**: Care planning (Longitudinal Plan/One Plan), care management, referrals, authorizations, prior authorizations
- **Population Health**: Health Data Intelligence (HDI) platform for analytics and population health management
- **Interoperability**: Open Engine interfaces, FHIR APIs, interoperability hub

The certified modules (Millennium Clinical, CQMs, Immunizations, Health Care Surveys, PowerChart Touch, Patient Portal) are all components of the broader Millennium platform. The EHI export covers data from the entire Millennium database — not just the certified module's scope.

Product URL: https://www.oracle.com/health/clinical-suite/

### Export Approach

This is a **native database export** — the gold standard approach. Oracle Health exports the actual Millennium production database in its native relational schema. The export consists of four data sources:

1. **Core Millennium EHR Database** — the primary relational database (MySQL or Oracle) with 6,604 documented tables. Exported as SQL DDL + INSERT statements. For single-tenant systems, a full database copy is provided on an encrypted device.
2. **Oracle Health Multimedia Storage** — DICOM images and non-DICOM multimedia files in their native formats (tar.gz archives of XML/JSON/binary files)
3. **Oracle Health Document Imaging** — scanned documents and binary files in native format (.bin files with TIFF, JPEG, PDF, etc.)
4. **Oracle Health Longitudinal Plan (One Plan)** — care planning data as CSV files or JSON via HealtheIntent APIs

The data model documentation is version 2025.4.01 (dated November 2025), organized as HTML table reports with full column definitions, data types, and relationship diagrams. The 242 schema modules cover every major functional area of the Millennium platform.

For the single patient export: SQL files uploaded into an empty MySQL database. For population export: either SQL files (multi-tenant) or full database copy on encrypted hardware (single-tenant).

### EHI Coverage Assessment

**Clinical data** — Comprehensively covered. The data model includes extensive clinical tables: CLINICAL_EVENT and 30+ CE_* tables (results, blobs, coded results, date results), ALLERGY (4 tables), DIAGNOSIS (10+ tables), ORDERS/ORDER_* (extensive ordering system), MEDICATION tables, IMMUNIZATION (6 tables), PROBLEM (7 tables), PROCEDURE (12+ tables), vital signs, lab results (PATHNET modules), radiology (RADNET modules), surgery (SURGINET modules), oncology, behavioral health, women's health, nursing/charting documentation, dynamic documentation, PowerForms, and care planning.

**Secure Messages / Communications** — Present but nuanced. The data model includes `dms_message_center` (11 tables: MSG_FYI_ASSIGNMENT, MSG_FYI_FILTER, TASK_ACTIVITY, TASK_INTENDED_RECIPIENT, TASK_PUBLISH_QUEUE, etc.), `dms_msvc_messaging` (13 tables: MESSAGING_AUDIT, MESSAGING_FAVORITES, MESSAGING_NOTIFY, SUBSCRIPTION, etc.), and various notification tables. The TASK_ACTIVITY system is Millennium's inbox/message center for clinician-to-clinician communications. Portal messaging data is less clearly documented — the PP_AUDIT_EVENT and PERSON_PORTAL_INVITE tables exist but dedicated patient-to-provider message content tables may be stored in the portal application layer rather than the core Millennium database. However, since the full database is exported, any message data stored in the database would be included.

**Billing/Financial** — Extremely comprehensive. 145 PFT_* (Patient Financial Transaction) tables cover account management, billing, posting, transactions, claims, payments, adjustments, AR, bad debt, collections, dunning. Plus CHARGE/CHARGE_EVENT tables (13 tables), CLAIM tables, and full revenue cycle schemas (dms_revenue_cycle_core, dms_revenue_cycle_config, dms_encounter___revenue, dms_collections, dms_scm_accounting, dms_scm_contract, dms_scm_purchasing). Dollar amounts, CPT codes, insurance billing details are all present.

**Insurance/Coverage** — Thoroughly covered. HEALTH_PLAN (5 tables), PERSON_PLAN_* (8 tables for patient-plan relationships, authorizations, profiles), ENCNTR_PLAN_* (14 tables for encounter-level plan data, eligibility, benefits, COB), dms_benefits schema, dms_authorization schema (4 pages), dms_enterprise_eligibili schema, dms_electronic_prior_aut schema. Full insurance lifecycle from eligibility verification through authorization and claims.

**Appointments/Scheduling** — Extensively covered. 189 SCH_* tables comprising the full scheduling system: SCH_APPT (appointments), SCH_BOOKING, SCH_ACTION, SCH_ACTIVITY, SCH_RESOURCE, SCH_SLOT, SCH_TEMPLATE, and extensive build/configuration tables. Plus ENCOUNTER (100+ ENCNTR_* tables) with visit/encounter data.

**Documents/Images** — Comprehensively covered across three storage systems:
- Core database: BLOB_REFERENCE, CE_BLOB/CE_BLOB_RESULT, CDI_* document imaging tables (30+ tables)
- Oracle Health Document Imaging: Separate content management database (AE_ADEFS, AE_DT#, AE_DL#, AE_RH# tables) with binary files in native format
- Oracle Health Multimedia Storage: DICOM images (XML/JSON metadata + pixel data), non-DICOM multimedia (CSV-structured with native file content)
- DMS_MEDIA_IDENTIFIER table links multimedia to the core database

**Audit Trails** — Well represented. 65+ audit-related tables including AUDIT_EVENT, CE_AUDIT_LOG, PP_AUDIT_EVENT, MESSAGING_AUDIT, TRACKING_AUDIT, CHART_REQUEST_AUDIT, IMMUNIZATION_AUDIT, VISITCODING_AUDIT, and many module-specific audit tables. The dms_prologue schema specifically handles audit/logging infrastructure. Various _HISTORY tables (40+) track changes over time.

### Issues & Red Flags

1. **Patient Portal messaging ambiguity**: While the Patient Portal is a certified module, dedicated patient-provider message content tables are not clearly identifiable in the data model. The TASK_ACTIVITY system covers clinician inbox/messaging, and MESSAGING_* tables cover subscriptions/notifications, but patient-initiated secure messages via the portal may be stored in a different subsystem. Since the export dumps the full database, this data should be present if it's in the database — but it's not clearly labeled.

2. **Documentation complexity**: The 6,604-table data model is documented via HTML reports with table/column definitions and ERDs, but without a comprehensive mapping guide explaining which tables serve which clinical functions. A receiving system would need significant domain expertise to interpret the data.

3. **Export process complexity**: The population export for single-tenant systems requires Oracle-licensed software for database restoration, customer-supplied encrypted hardware, and physical shipping. This is operationally complex compared to a simple file download.

4. **Legacy naming**: URLs and internal naming still reference "Cerner" heavily, suggesting the documentation may not have been fully updated since Oracle's acquisition.

---

## Product: Oracle Health Data Intelligence (HDI)

### Product Context

Oracle Health Data Intelligence (formerly HealtheIntent) is a separate population health management and analytics platform. It aggregates data from multiple sources (including Millennium EHR) into a "Longitudinal Record" for each patient. It's primarily used for population health analytics, quality measures, and care management.

The HDI product has its own CHPL entries (not among our 10 target CHPL IDs) but its EHI export documentation appears on the same page. The HDI Longitudinal Record represents a derived/aggregated view of patient data rather than the source-of-truth clinical data.

### Export Approach

HDI uses an **API-based export** via the Longitudinal Record Bulk Extract API and Data Syndication API. The export produces JSON files in Avro schema format containing 124 entity types (Actor, Address, Allergy, Appointment, BenefitPlan, Claim, Condition, Consent, Device, Encounter, Goal, Immunization, Medication, Procedure, Result, etc.).

Authentication requires OAuth 1.0a or bearer token. The API must be enabled by Oracle Health for each tenant. Exports are available for download for 21 days.

### EHI Coverage Assessment

The HDI export covers clinical data comprehensively through its Avro entities but is a derived/aggregated view rather than a raw database dump. It includes Claim and BenefitPlan entities for billing/insurance. However, as a population health analytics platform, it may not contain the full granularity of billing line items, document images, or audit trails that the source Millennium system stores.

This is supplementary to the Millennium export and not the primary EHI export for the certified modules in our target list.

### Issues & Red Flags

1. **Requires API enablement by Oracle**: Customers must contact Oracle to enable the Bulk Extract API, which adds a dependency on vendor cooperation.
2. **Derived data**: The Longitudinal Record is an aggregated view, not the source-of-truth database.
3. **Not applicable to our CHPL IDs**: The HDI CHPL entries are separate from the 10 Millennium-focused entries we're analyzing.
