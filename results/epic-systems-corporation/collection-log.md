# Epic Systems Corporation — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11595, 11596, 11597, 11603, 11604, 11641, 11643, 11644, 11653, 11654, 11683, 11684, 11685, 11686, 11687, 11711, 11712, 11713, 11730, 11731
- **Registered URL**: https://open.epic.com/EHITables
- **Developer**: Epic Systems Corporation
- **Certified Modules**: Beacon Cancer Registry Reporting, Beaker Reportable Labs Reporting, EpicCare Ambulatory Base, EpicCare Inpatient Base, Infection Control Antimicrobial Use and Resistance Reporting

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://open.epic.com/EHITables" -H 'User-Agent: Mozilla/5.0'
```
**Result**: HTTP 200 OK. Direct response, no redirects. Content-Type: `text/html; charset=utf-8`. Content-Length: 8742 bytes. Server: Microsoft-IIS/10.0 with ASP.NET MVC 5.2. No anti-bot protection, no content-disposition header (not a direct download).

### Step 2: Page examination
```bash
curl -sL "https://open.epic.com/EHITables" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html  # 8742 bytes
```
**Result**: Small, clean static HTML page (8,742 bytes). Not a SPA — content is fully rendered server-side. Page title is "EHI Tables Export". The page contains:
- A clear description: "EHI Export functionality allows health systems to do a manual one-time export of health data for one or more patients."
- A statement that the export uses "tab-separated value (TSV) file format native to Epic"
- Two key links:
  1. "the EHI Tables index" → `/EHITables/TechSpec` (online browsable schema)
  2. "download the index as a zip file" → `/EHITables/Download` (ZIP download)
- A note that non-tabular data (rich text documents, images) are "referenced from the EHI Tables" but actual files are in a "separate download"
- Caveats that content varies based on the health system's Epic version, configuration, and software in use

### Step 3: Examining the online index
```bash
curl -sI -L "https://open.epic.com/EHITables/TechSpec" -H 'User-Agent: Mozilla/5.0'
```
**Result**: 302 redirect to `https://open.epic.com/EHITables/GetTable/_index.htm`. Returns 200 OK with Content-Length: 1,077,591 bytes (1 MB HTML index page). This is a large alphabetical listing of all 7,672 table names, each linking to its own detail page.

### Step 4: Examining the ZIP download
```bash
curl -sI -L "https://open.epic.com/EHITables/Download" -H 'User-Agent: Mozilla/5.0'
```
**Result**: 200 OK. Content-Type: `application/x-zip-compressed`. Content-Disposition: `attachment; filename="Epic EHI Tables.zip"`. Content-Length: 12,664,966 bytes (~12.1 MB). Direct download, no login required.

### Step 5: Identified downloadable assets
- **ZIP file**: `Epic EHI Tables.zip` (12.1 MB) at `https://open.epic.com/EHITables/Download`
  - Contains 7,674 files (1 CSS file, 1 index HTM, 7,672 table documentation HTM files)
  - Extracts to 93 MB
  - Generated 2/12/2026 at 2:10 PM CT from the February 2026 release
  - Folder name: `DocGen_su117s2p_2026-02-12_14.10.01`

## Downloads

### epic-ehi-tables.zip (12,664,966 bytes / 12.1 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o epic-ehi-tables.zip \
  'https://open.epic.com/EHITables/Download'
```
Verified: `file epic-ehi-tables.zip` → Zip archive data, at least v2.0 to extract, compression method=deflate
Contents: 7,674 files totaling 83,024,535 bytes uncompressed
Extracted to: `downloads/epic-ehi-tables/DocGen_su117s2p_2026-02-12_14.10.01/`

Structure:
- `_index.htm` — 1,071,083 bytes, alphabetical index of all tables with links
- `CRStyleSheet.css` — 4,900 bytes, shared stylesheet
- 7,672 individual `TABLE_NAME.htm` files, one per database table/view

## Obstacles & Notes
- **None.** This is a model of EHI documentation accessibility. Direct URL, no login, no anti-bot, no JavaScript required, clean HTML, immediate ZIP download. The page loads fully via server-side rendering and works with curl.
- The online index at `/EHITables/TechSpec` serves each table's documentation individually via `/EHITables/GetTable/TABLE_NAME.htm`, but the ZIP contains all files — no scraping needed.

---

## Product: Epic EHR (EpicCare Ambulatory + EpicCare Inpatient + Modules)

### Product Context

Epic Systems Corporation is the dominant EHR vendor in the US, with ~38% market share in the hospital segment and a significantly larger share of covered patient lives. The Epic EHR is a comprehensive, integrated health information system — not a modular best-of-breed product. When a health system runs "Epic," they're typically running the entire platform.

The five certified modules listed under these CHPL IDs — **EpicCare Ambulatory Base**, **EpicCare Inpatient Base**, **Beaker Reportable Labs Reporting**, **Beacon Cancer Registry Reporting**, and **Infection Control Antimicrobial Use and Resistance Reporting** — are components of the broader Epic EHR platform. The quarterly version releases (February 2025 through November 2025) are routine certification updates; they all point to the same EHI export documentation.

The broader Epic platform includes:
- **EpicCare Ambulatory** — outpatient/clinic EHR
- **EpicCare Inpatient** — hospital/inpatient EHR
- **MyChart** — patient portal with secure messaging, appointment scheduling, test results, bill pay
- **Cadence** — scheduling and appointment management
- **Resolute** — revenue cycle / billing (professional and hospital billing)
- **Beaker** — laboratory information system
- **Radiant** — radiology information system
- **Beacon** — oncology-specific module
- **OpTime** — surgical/perioperative management
- **Prelude** — registration and ADT
- **Grand Central** — bed management
- **Tapestry** — managed care / health plan administration
- **Healthy Planet** — population health management
- **Bugsy** — pediatric-specific features
- **Stork** — obstetrics

All of these modules share a common database (Caché/InterSystems IRIS, transitioning to some Postgres-based architectures for reporting). The EHI export reflects the underlying database tables across all these modules.

### Export Approach

**Native database export — the gold standard.**

Epic's EHI export dumps the actual underlying database tables as TSV (tab-separated values) files. The documentation describes 7,672 distinct tables/views from their Clarity reporting database (the relational reporting layer over their Chronicles operational database). This is not a FHIR export or C-CDA generation — it's a direct dump of the system's native data structures.

Key characteristics:
- **Format**: TSV (tab-separated values) per table
- **Container**: ZIP archive
- **Scale**: 7,672 documented tables
- **Documentation generation date**: February 12, 2026 (current released version: February 2026)
- **Schema documentation**: Each table has its own HTML file with description, primary key, column names, data types, column descriptions, and category values
- **Non-tabular data**: Rich text documents and images are acknowledged as separate downloads outside the TSV tables (referenced by ID from the tables)
- **EHI-specific views**: Epic created 89 dedicated `V_EHI_*` views specifically for the EHI export, supplementing existing Clarity tables with audit trails, billing details, and coverage history

This is precisely the approach that maximizes completeness. By exporting native database tables, everything the system stores is inherently available — there's no translation layer or standard to constrain what can be included.

### EHI Coverage Assessment

**All 7 EHI categories are present with extensive coverage.** Epic's export is the benchmark against which other vendors should be measured.

#### 1. Clinical ✅ — Comprehensive
Hundreds of clinical tables covering:
- **Diagnoses**: ACCUM_CLAIM_DIAGNOSES, ACCUM_SERVICE_DIAGNOSES, DIAGNOSIS_REVIEW, PROBLEM_LIST, PROBLEM_LIST_ALL, PAT_PROBLEM_LIST (22+ PROBLEM_* tables)
- **Medications**: CLARITY_MEDICATION, ORDER_MED through ORDER_MED_8, ORDER_MED_SIG, RX_* tables (20+)
- **Allergies**: ALLERGY, ALLERGY_FLAG, ALLERGY_REACTIONS, PAT_ALLERGIES
- **Labs**: LAB_CASE_*, CLARITY_COMPONENT, ORDER_RESULTS, ORDER_RESULT_DOCUMENTS
- **Vitals/Flowsheets**: IP_FLWSHT_MEAS, IP_FLWSHT_REC, IP_FLOWSHEET_ROWS, V_EHI_FLO_MEAS_VALUE, V_EHI_FLO_MEAS_EDITED (17+)
- **Immunizations**: CLARITY_IMMUNZATN, IMMUNE, IMMUNE_HISTORY, PAT_IMMUNIZATIONS (8)
- **Clinical Notes**: HNO_INFO, HNO_PLAIN_TEXT, HNO_ORDERS, HNO_SMARTFORM_LINK (16+)
- **Orders**: ORDER_PROC, ORDER_COMMENT, ORDER_DX (158+ ORDER_* tables)
- **Surgery**: OR_CASE, OR_LOG, OR_CASE_ALL_PROC (179 OR_CASE_* tables)
- **Oncology**: Extensive BEACON_* and CANCER_* tables
- **Social/Family History**: SOCIAL_HX_*, FAMILY_HX_*

#### 2. Secure Messages ✅ — Comprehensive
71+ tables covering all messaging channels:
- **MyChart patient-provider messages**: MYC_MESG (28+ sub-tables) — messages sent to/from patients via the portal, with attachments, RTF text, recipients
- **MyChart conversations**: MYC_CONVO, MYC_CONVO_MSGS, MYC_CONVO_FUTURE_MSGS — threaded conversation views
- **In Basket (provider-to-provider)**: IB_MESSAGES through IB_MESSAGES_5 — internal messaging system
- **Secure Chat**: CHAT_MESSAGE, CHAT_MESSAGE_CONTENT, CHAT_MESSAGE_EDITS, CHAT_CONVERSATIONS, CHAT_PARTICIPANT (18 CHAT_* tables) — real-time chat with message types including text, images, system messages
- **Message metadata**: MSG_TXT, MESSAGE_METADATA, IB_MESSAGE_THREAD
- **Received document messages**: DOCS_RCVD_PAT_IB_MSG, DOCS_RCVD_PAT_MYC_MSG

#### 3. Billing/Financial ✅ — Comprehensive
776+ tables — the largest category, reflecting Epic's Resolute billing module:
- **Claims**: AP_CLAIM and 377 AP_CLAIM_* sub-tables — claim ID, status (New/Pending/Denied/Clean/Void), total billed amount, patient portion, net payable
- **Professional billing transactions**: ARPB_TRANSACTIONS through ARPB_TRANSACTIONS_4, plus 51 ARPB_* tables
- **Hospital accounts**: HSP_ACCOUNT through HSP_ACCOUNT_5, plus 108 HSP_ACCT_* sub-tables — charges, DRGs, CPT codes, billing notes
- **Account transactions**: ACCT_TX
- **Scheduled payments**: BILL_SCHED_PMT and 12 sub-tables
- **EHI-specific billing views**: V_EHI_PAX_PB_ACCT_TX, V_EHI_PBA_PB_ACCT, V_EHI_PBI_PB_INVOICE (18+ V_EHI_* billing views)

#### 4. Insurance/Coverage ✅ — Comprehensive
327+ tables:
- **Coverage records**: COVERAGE through COVERAGE_5, COVERAGE_BENEFITS, COVERAGE_MEMBER_LIST, COVERAGE_STATUS, COVERAGE_STATUS_HX (51 COVERAGE/CVG_* tables)
- **Authorizations**: AUTHORIZATIONS, AUTHORIZATIONS_2, AUTHORIZATION_COMMENT, AUTHORIZATION_TYPE
- **Benefits**: BENEFITS, BENEFITS_TEMPLATE, BENEFIT_EVALUATOR, BENEFIT_SVC_TYPE
- **Carrier master**: CLARITY_CARRIER
- **Referrals**: REFERRAL_* tables, ASSOCIATED_REFERRALS, AUTH_FULL_REFERRAL
- **EHI-specific views**: V_EHI_COVERAGE_SUBS, V_EHI_CVG_BEN_ACCUM_AT, V_EHI_CVG_COVERAGE_HIST_ALL, V_EHI_CVG_COVERAGE_HIST_MEM

#### 5. Appointments/Scheduling ✅ — Comprehensive
249+ tables:
- **Patient encounters**: PAT_ENC through PAT_ENC_8 and 115 PAT_ENC_* sub-tables — the core encounter record covering appointments, office visits, telephone encounters, with dates, providers, financial class
- **Appointment-specific**: APPT_REQUEST, APPT_SELF_CHECKIN_INFO, CANCELED_APPTS_EDI
- **MyChart appointment data**: MYC_APPT_QNR_DATA
- **Surgical scheduling**: OR_CASE and 179 sub-tables
- **Home health**: HH_PAT_ENC

#### 6. Documents/Images ✅ — Present (with caveats)
54+ tables for document metadata:
- **DICOM imaging**: 8 DICOM_* tables (definitions, manifests, instances, series, slices, window info)
- **Scanned documents**: SCAN_IMAGE, REQ_SCAN, RES_SCAN_FILES
- **Document signatures**: DOCUMENT_SIG_DATA, DOCUMENT_SMARTFORM_LIST, DOCUMENT_STAMPS
- **Order-linked documents**: ORDER_DOCUMENTS, ORDER_RESULT_DOCUMENTS, ORDER_IMAGE_URL
- **Claim attachments**: AP_CLAIM_ATTACHMENTS, AP_CLAIM_PROC_ATTACHMENTS, REFERRAL_ATTACHMENTS
- **Image metadata**: FINDING_IMAGES_METADATA, LINKED_IMAGES, SPEC_IMAGE_MARKING
- **Guarantor scanned docs**: GUARANTOR_SCANNED_DOCS, FIN_ASST_CASE_DOCUMENTS

Note: The main EHI landing page states that non-tabular data (rich text, images) are referenced from the tables but provided as "a separate download in the export." The TSV tables contain metadata and references; the actual binary files are in a companion download.

#### 7. Audit Trails ✅ — Comprehensive (purpose-built for EHI)
197+ tables, many purpose-built:
- **EHI-specific audit views**: 29 `V_EHI_AUDIT_*` views covering patient records (EPT), encounters (EPT_ENC), hospital accounts (HAR), claims (CLM), coverage (CVG), benefits (BEN), referrals (RFL), orders, therapy, and more. The V_EHI_AUDIT_EPT description explicitly states: "This view contains audit information for patient records for the purpose of Electronic Health Information (EHI) export."
  - Columns include: PAT_ID, CHANGE_TIME, CHANGED_DATA_ELEMENT, NEW_VALUE_EXTERNAL, OLD_VALUE_EXTERNAL, USER_ID — tracking who changed what, when, and the before/after values
- **Registration item audits**: 18 `V_EHI_REG_ITEM_AUDIT_*` views for benefits, claims, coverage, patient, financial records
- **Domain-specific audits**: ORDER_AUDIT_TRL, ORDER_RES_AUDIT, RESULT_AUDIT, CHAT_ACCESS_LOG, CHAT_ACTION_LOG, MYC_CONVO_EXPORT_AUDIT
- **Application audits**: ANTICOAG_AUDIT, BLOOD_REQTS_VALS_AUDIT, CONSENT_LINK_AUDIT, DEMOG_AUTH_AUDIT, ED_DISPO_AUDIT, INFUSION_DOC_AUDIT, RX_FILL_PROCESS_AUDITS, etc.

### Issues & Red Flags

**None of significance.** This is the gold standard for EHI export documentation:

1. **No access barriers**: Direct URL, no login, no anti-bot, works with curl.
2. **Native database export**: 7,672 tables/views from the actual database, not a filtered or translated representation.
3. **All 7 categories covered**: Clinical, messages, billing, insurance, scheduling, documents, and audit trails are all extensively documented.
4. **EHI-specific enhancements**: Epic created 89 dedicated `V_EHI_*` views specifically for the export, including purpose-built audit trails — demonstrating intentional investment in completeness.
5. **Documentation quality**: Each table has description, primary key, column names, data types, column descriptions, and enumerated category values.
6. **Regularly updated**: Documentation is version-stamped and regenerated with each release (current: February 2026).

The only minor caveats:
- Content varies by health system's installed applications, version, and configuration (noted on the landing page). This is inherent to Epic's modular architecture and is a factual disclaimer, not a gap.
- Non-tabular data (images, rich text) are in a separate download, not the TSV tables. The tables contain references/metadata.
- The documentation describes the "current released version" — a specific health system may be on an older version with fewer tables.

---

## All Products Share One Export

Unlike some vendors that have distinct products with different export approaches, all 5 certified Epic modules (EpicCare Ambulatory Base, EpicCare Inpatient Base, Beaker Reportable Labs Reporting, Beacon Cancer Registry Reporting, Infection Control Antimicrobial Use and Resistance Reporting) share the same underlying database and the same EHI export mechanism. The 20 CHPL IDs represent quarterly version releases (February/May/August/November 2025) of these 5 modules, but the EHI documentation URL is identical for all of them.

This is correct and expected: these are all components of one integrated Epic EHR platform, and the EHI export covers the entire platform's data store.
