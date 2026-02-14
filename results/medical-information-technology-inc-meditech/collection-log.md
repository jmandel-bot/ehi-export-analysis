# Medical Information Technology, Inc. (MEDITECH) — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 9091, 9092, 9095, 9101, 9103, 9107, 9108, 9109, 9162, 9238, 9258, 9265, 10924, 10925, 10926, 10927, 10929, 10930, 10931, 10932, 10933, 10934, 10935, 10972, 10973, 10976, 10977, 10978, 10979, 10981, 10982, 10984, 10985, 10988, 10993, 10994, 10995, 11018, 11742, 11743
- Registered URL: https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm" -H 'User-Agent: Mozilla/5.0'
```
Result: HTTP/2 200 direct (no redirects). Content-Type: text/html. Server: Microsoft-IIS/10.0, proxied via Google. Content-Length: 8,964 bytes.

### Step 2: Page examination
```bash
curl -sL "https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
```
The page is static HTML (8,964 bytes), fully readable via curl — no JavaScript SPA. The page describes MEDITECH's EHI Export architecture with two configurations based on the product platform. The page contains a comparison table showing Configuration 1 vs Configuration 2 and their applicable platforms.

### Step 3: Finding the EHI documentation
The main page links to two configuration specification pages:
- **Configuration 1**: `/en/d/restapiresources/pages/ehiexportconfig1.htm` (29,280 bytes)
  - Applicable to: Expanse 2.2, Expanse 2.1, 6.15 (Acute & Ambulatory), 6.08 (Acute only), Client Server (Acute only), MAGIC (Acute only)
  - Export contains: Electronic Chart documents, US Core FHIR data, C-CDA documents, Supplemental Clinical/Administrative/Financial Reports
- **Configuration 2**: `/en/d/restapiresources/pages/ehiexportconfig2.htm` (22,780 bytes)
  - Applicable to: MPM 6.08 (Ambulatory only), Client/Server (Acute & Ambulatory), MAGIC (Acute & Ambulatory)
  - Export contains: Patient Data (CSV) files, US Core FHIR data, C-CDA documents, Supplemental Clinical/Administrative/Financial Reports/Images

A third link points to customer portal: `https://customer.meditech.com/en/d/21stcenturycuresact/pages/ehiexport.htm` — this requires SAML authentication (redirects to accounts.meditech.com login). Contains "Regulatory EHI Export Functionality Guides" — not publicly accessible.

Both configuration pages also link to `ehiexportold.htm` (27,779 bytes) — an older version of the documentation with less detail.

### Step 4: Identified downloadable assets
Config 2 page contains three PDF links with CSV data dictionary documentation:
1. `https://home.meditech.com/en/d/regulatoryresources/otherfiles/csacuteandambehiexportdrsolutionmerged.pdf` — Client/Server Acute & Ambulatory CSV table definitions
2. `https://home.meditech.com/en/d/regulatoryresources/otherfiles/mgehiexportdrsolutionmerged.pdf` — MAGIC Acute & Ambulatory CSV table definitions
3. `https://home.meditech.com/en/d/regulatoryresources/otherfiles/608ehiexportcsv.pdf` — MPM 6.08 Ambulatory CSV table definitions

## Downloads

### meditech-ehi-export-main.html (8,964 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o meditech-ehi-export-main.html 'https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm'
```
Saved to: downloads/meditech-ehi-export-main.html

### meditech-ehi-export-config1.html (29,280 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o meditech-ehi-export-config1.html 'https://home.meditech.com/en/d/restapiresources/pages/ehiexportconfig1.htm'
```
Saved to: downloads/meditech-ehi-export-config1.html

### meditech-ehi-export-config2.html (22,780 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o meditech-ehi-export-config2.html 'https://home.meditech.com/en/d/restapiresources/pages/ehiexportconfig2.htm'
```
Saved to: downloads/meditech-ehi-export-config2.html

### meditech-cs-acute-amb-ehi-export-dr.pdf (262,764 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o meditech-cs-acute-amb-ehi-export-dr.pdf 'https://home.meditech.com/en/d/regulatoryresources/otherfiles/csacuteandambehiexportdrsolutionmerged.pdf'
```
Verified: `file` → PDF document, version 1.4, 20 pages
Content: Client/Server Acute & Ambulatory EHI Export CSV table/column definitions
Last Updated: October 2023
Saved to: downloads/meditech-cs-acute-amb-ehi-export-dr.pdf

### meditech-magic-ehi-export-dr.pdf (363,475 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o meditech-magic-ehi-export-dr.pdf 'https://home.meditech.com/en/d/regulatoryresources/otherfiles/mgehiexportdrsolutionmerged.pdf'
```
Verified: `file` → PDF document, version 1.4, 20 pages
Content: MAGIC Acute & Ambulatory EHI Export CSV table/column definitions
Last Updated: October 2023
Saved to: downloads/meditech-magic-ehi-export-dr.pdf

### meditech-608-ehi-export-csv.pdf (251,431 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o meditech-608-ehi-export-csv.pdf 'https://home.meditech.com/en/d/regulatoryresources/otherfiles/608ehiexportcsv.pdf'
```
Verified: `file` → PDF document, version 1.4, 19 pages
Content: MPM 6.08 Ambulatory EHI Export CSV table/column definitions
Last Updated: October 2023
Saved to: downloads/meditech-608-ehi-export-csv.pdf

## Obstacles & Notes
- No anti-bot protection. Static HTML, all content accessible via curl.
- The "Regulatory EHI Export Functionality Guides" link on both config pages points to `https://customer.meditech.com/en/d/21stcenturycuresact/pages/ehiexport.htm`, which requires SAML authentication. This is noted but not a violation since the main docs are public.
- The CSV data dictionary PDFs are only linked from the Configuration 2 page. Configuration 1 (Expanse, 6.15) does not provide equivalent downloadable data dictionaries — its documentation is entirely inline in the HTML spec page.
- All three PDFs are dated October 2023. This is notably old for documentation that should cover current system capabilities.

---

## Product: MEDITECH Expanse

### Product Context
MEDITECH Expanse is MEDITECH's flagship, modern EHR platform marketed as the "Intelligent EHR." It is a comprehensive health information system used by hundreds of hospitals and thousands of ambulatory care sites. The product includes:
- **Full acute and ambulatory EHR** with physician and nursing documentation
- **Revenue Cycle Management** with charge capture, claim submission, payment processing, denial management, patient billing (MEDITECH ranked #1 in 2025 KLAS for Patient Accounting: Small)
- **Patient Connect** (patient engagement platform with secure messaging/texting)
- **MyHealth patient portal** (certified separately as CHPL 10988) with portal messaging
- **Scheduling** for appointments across acute and ambulatory settings
- **Emergency Department Management** (certified separately)
- **Oncology** module (certified separately)
- **Pharmacy, Lab, Radiology, Pathology** departments
- **Surgical Services** (OR scheduling and case management)
- **Population Health, Surveillance, Analytics**
- **Interoperability** via Traverse Exchange

The certified modules "Expanse 2.1 Core HCIS" and "Expanse 2.2 Core HCIS" are parts of the broader Expanse platform. The MyHealth Portal is separately certified.

### Export Approach
Expanse uses **Configuration 1**: a hybrid approach combining:
1. **Electronic Chart documents** — scanned/archived documents from HIM (Health Information Management) and Scanning/eChart modules, organized in category/subcategory folders. File formats include images (png, jpg, tif, bmp) and PDF.
2. **US Core FHIR Resources** — a FHIR R4 JSON bundle (`US Core FHIR Resources.json`) using US Core STU 3.1.1, generated via Patient `$everything`.
3. **C-CDA documents** — all Consolidated-CDA documents previously created (C-CDA R2.1 or R1.1).
4. **Supplemental reports** — structured text/PDF reports for specific data areas:
   - Financial Reports (`FinancialEHI.txt` with patient accounting transactions, `ResidentTrustEHI.txt`, `CostEstimation.txt`)
   - Authorization & Referral Management Reports (auth/referral data as PDF, insurance eligibility/copay/deductible data as PDF)
   - Ambulatory Results (PDFs)
   - Immunization History (PDF)
   - Population Health (PDF)
   - Utilization Review (PDF)
   - Historical Ambulatory Data (migrated docs)

The export is packaged as a ZIP file with a `Table of Contents.ndjson` manifest using FHIR DocumentReference resources, plus `README.txt`, `EHIEXPORTSCHEMA.txt`, and `ACCOUNTS_INDEX.html/xml` for navigation.

This is NOT a native database dump. It's a curated export of documents and reports plus FHIR resources. The Electronic Chart section captures document images, but the structured clinical data relies on the FHIR bundle. Financial data comes as supplemental text reports rather than structured database tables.

### EHI Coverage Assessment

**Clinical**: Present via FHIR bundle (US Core resources including conditions, medications, allergies, labs, vitals, procedures, encounters, immunizations, care plans) and C-CDA documents. Also includes Electronic Chart scanned documents, nursing documentation, pathology reports, radiology. Clinical coverage is strong but filtered through FHIR US Core's constraints.

**Secure Messages**: Not explicitly present. The main page notes Configuration 1 is "configured for use with Patient and Consumer Health Portal (PHM) *Not Required." There is no dedicated "Messages" section in the Expanse/Config 1 export. The FHIR bundle may not include portal messages as a standard US Core resource. This is a significant gap given MEDITECH has both MyHealth patient portal and Patient Connect with secure messaging/texting.

**Billing/Financial**: Partially present. `FinancialEHI.txt` contains "a Patient Accounting report that includes financial transactions," `ResidentTrustEHI.txt` for resident trust, and `CostEstimation.txt` for cost estimates. However, these are **text reports** — likely rendered printouts rather than structured database tables. Compare to Configuration 2's PDFs which show detailed tables like `PbrAccountClaims`, `PbrAccountTransactions`, `PbrAccountTxnPymntDistribution` with individual fields. Expanse financial data appears less granular.

**Insurance/Coverage**: Partially present. Authorization & Referral Management Reports include `ARMEHI-InsEligCopayDeductData.pdf` (insurance eligibility and deduction data) and `ARMEHI-ArmAuthData.pdf` (authorizations and referrals). Again, these are PDF reports rather than structured data. Insurance demographics would be in the FHIR bundle (Coverage resource if supported).

**Appointments/Scheduling**: Present via FHIR Encounter resources in the bundle. However, there's no dedicated scheduling export with appointment-specific fields (status, type, booking details) comparable to the `SchAppointments` table in Config 2's CSV exports.

**Documents/Images**: Strong coverage. The Electronic Chart section is the centerpiece of Config 1, containing all scanned/archived documents organized by account → category → subcategory. File formats include images (png, jpg, tif, bmp) and PDFs. Also includes historical ambulatory data (migrated documents).

**Audit Trails**: Not present. No audit section in any export configuration.

### Issues & Red Flags
1. **No data dictionary for Config 1**: Unlike Config 2 which has detailed CSV table/column PDFs, Config 1 (Expanse) has no downloadable data dictionary. The export is document-based and FHIR-based, so individual field documentation doesn't apply the same way, but the lack of specificity about what FHIR resources are included is a gap.
2. **Financial data as text reports, not structured data**: `FinancialEHI.txt` is a text report, not CSV/JSON structured data. This may limit machine readability.
3. **Insurance/auth data as PDF**: The Authorization & Referral Management reports are PDFs — not machine-readable structured data.
4. **Portal messages likely missing**: MEDITECH's MyHealth portal and Patient Connect both support messaging, but Config 1 has no messages section.
5. **Patient portal integration marked "Not Required"**: Configuration 1 lists PHM (Patient and Consumer Health Portal) as optional. If not configured, portal-related data would be absent.

---

## Product: MEDITECH 6.x (6.08, 6.15)

### Product Context
MEDITECH 6.x represents the prior generation of MEDITECH's EHR platform, with 6.08 and 6.15 being specific versions. Like Expanse, these are comprehensive hospital information systems with clinical, financial, and administrative modules. MEDITECH 6.15 is the most feature-rich 6.x version with both acute and ambulatory capabilities, while 6.08 has split coverage (acute in Config 1, ambulatory in Config 2).

The 6.x platform includes the same core modules as Expanse (revenue cycle, patient portal, scheduling, pharmacy, lab, radiology) though with older interfaces.

### Export Approach
MEDITECH 6.x uses a **split approach**:
- **6.15 (Acute & Ambulatory)**: Configuration 1 — same as Expanse (Electronic Chart + FHIR + C-CDA + supplemental reports). Includes all sections except Population Health and Historical Ambulatory Data.
- **6.08 Acute**: Configuration 1 — reduced section set (Electronic Chart, C-CDA, FHIR, Financial Reports, Immunization History, Ambulatory Order Summary, Patient Notices).
- **6.08 Ambulatory**: Configuration 2 — CSV-based export with structured patient data files plus FHIR + C-CDA + supplemental reports.

For the 6.08 Ambulatory CSV export, the data dictionary PDF documents ~384 unique field/table names across tables including:
- `AdmVisits`, `AdmEmployers`, `AdmInsuredData` (demographics, insurance)
- `AprEnc*` (ambulatory encounters, vitals, messages, tasks)
- `AprRes*`, `AprResMic*` (lab/micro results)
- `ArmAuths` (authorizations)
- `MriPatients`, `MriPatientInsurances` (patient master)
- `PbrAccountClaims`, `PbrAccountTransactions`, `PbrAccountStatements` (billing)
- `RxmOrds`, `RxmRxs` (pharmacy orders/prescriptions)
- `SchAppointments` (scheduling)

### EHI Coverage Assessment
See Expanse assessment for Config 1 platforms. For 6.08 Ambulatory (Config 2):

**Clinical**: Present in CSV tables (AprEnc encounters, AprRes lab results, AprResMic microbiology, problems, family/social history, vitals) plus FHIR bundle and C-CDA.

**Secure Messages**: `AprEncMessages` and `AprEncMessagesLines` tables in the 6.08 CSV export contain encounter-level messages with `MessageUserID` field. These appear to be clinical encounter messages rather than patient portal messages.

**Billing/Financial**: Present. `PbrAccountClaims`, `PbrAccountClaimsDetail` (with ClaimNumber, TransactionUrn, amounts), `PbrAccountTransactions`, `PbrAccountStatements`, `PbrAccountTxnPymntDistribution`, `PbrAccountInsurance`, `PbrAccountInsuranceCopayTypes` — comprehensive billing tables with structured data.

**Insurance/Coverage**: Present. `AdmInsuredData` (TreatmentAuthorizationNumber, ElectronicCheck), `MriPatientInsurances`, `ArmAuths` (authorizations with InsuranceID, service units).

**Appointments/Scheduling**: Present. `SchAppointments` with `ApptDate`, `ApptTime`, `ApptStatus`, `AppointmentTypeID`, `AppointmentID`.

**Documents/Images**: Limited in CSV; supplemental reports/images section in Config 2 covers external documents and scanned items.

**Audit Trails**: Not present.

### Issues & Red Flags
1. The 6.08 Ambulatory CSV export has significantly more structured data than the Config 1 approach for Expanse/6.15.
2. Financial data as structured CSV tables (6.08 Amb) vs text report (6.15/Expanse) is a meaningful difference in machine readability.

---

## Product: MEDITECH Client/Server

### Product Context
MEDITECH Client/Server (v5.67) is an older generation platform preceding the 6.x line. Despite its age, many hospitals still run it. It supports both acute and ambulatory care, with the same general module set (clinical, financial, scheduling, pharmacy, lab, radiology, pathology, surgical services).

### Export Approach
Client/Server has **split coverage across both configurations**:
- **C/S Acute only**: Configuration 1 — Electronic Chart + FHIR + C-CDA + Financial Reports + Provider Messages + Implantable Devices + Immunizations
- **C/S Acute & Ambulatory**: Configuration 2 — CSV patient data + FHIR + C-CDA + clinical reports/documents + provider/patient messages + financial reports + external documents/images + scanned documents

The CSV data dictionary PDF for C/S documents ~923 unique field/table identifiers, the most comprehensive of the three PDFs. Key table groups include:
- **Admissions/Demographics**: `AdmVisits`, `AdmDischargeInfo`, `AdmEmployers`, `AdmGuarantors`, `AdmInsurances`, `AdmInsuredInfo`, `AdmVisitDiagnoses`, `AdmVisitNextOfKin`, `AdmVisitPersonToNotify`
- **Ambulatory/Encounters**: `AprEnc*` (encounters, messages, vitals, tasks, health maintenance)
- **Lab/Micro/Pathology**: `LabSpecimens`, `LabSpecimenTests`, `MicSpecimens`, `MicSpecimenOrganisms`, `PthSpecimens`, `PthSpecimenHistologies`, `PthSpecimenPictures`
- **Radiology**: `ItsOrder*` (imaging orders, exams, findings, impressions, radiation dose)
- **Pharmacy**: `PhaRx*` (60+ tables covering prescriptions, administrations, IV therapy, allergies/ADRs, dose calculations)
- **Nursing**: `NurPatientPoc*` (plan of care), `NurPatientSoc*` (standards of care), `NurPlanOfCareTd*` (images/annotations)
- **Surgical**: `SchOrPatCase*` (OR cases, complications, medications, vital signs, devices, implants)
- **Blood Bank**: `BbkSpecimens`, `BbkUnits`, `BbkHistoryTransfusions`
- **Orders**: `OeOrders`, `OeOrderEdits`, `OeOrderPhas`, `OeOrderQueries`
- **Billing**: `PbrAccountClaims`, `PbrAccountClaimsDetail`, `PbrAccountTransactions`, `PbrAccountStatements`, `PbrAccountTxnPymntDistribution`
- **Auth/Referral**: `ArmAuths`, `ArmAuthServices`, `ArmAuthReferNoteHistories`
- **Problems**: `HubPatientProblems*` (problem list with qualifiers, codes, descriptions, family histories)
- **Care Teams**: `MriPatientCareTeams`, `MriVisitCareTeams`
- **Scheduling**: `SchAppointments`
- **Prescription Management**: `RxmOrds`, `RxmRxs`, `RxmRxPriorAuthorization`, `RxmRxMedReconciliationActions`

Config 2 also includes:
- **Provider and Patient Messages**: `Provider Messages.pdf` — contains provider-to-provider and provider-to-patient messaging
- **External Documents/Images**: scanned/imported ambulatory documents in various formats
- **Point of Contact Scanned Documents**: additional scanned documents
- **Clinical Reports/Documents**: physician documentation, radiology reports, pathology reports, nursing image documentation

### EHI Coverage Assessment
**Clinical**: Comprehensive. 60+ pharmacy tables, full lab/micro/pathology, radiology, nursing care plans, surgical case data, blood bank, orders, problems — this is effectively a native database dump.

**Secure Messages**: Present. Both "Provider Messages.pdf" in Config 2 and `AprEncMessages`/`AprEncMessagesLines` in CSV. These include provider-to-provider and provider-to-patient messaging. However, patient portal (MyHealth) messages may not be fully represented.

**Billing/Financial**: Present with structured data. `PbrAccountClaims`, `PbrAccountClaimsDetail`, `PbrAccountTransactions`, `PbrAccountStatements`, `PbrAccountTxnPymntDistribution`, `PbrAcctTxnDxs` — with fields for amounts, claim numbers, transaction IDs, payment distributions.

**Insurance/Coverage**: Present. `AdmInsurances` (insurance ID, address, benefit plan, other name), `AdmInsuredInfo`, `MriPatientInsurances`, `ArmAuths`, `ArmAuthServices`, `ArmAuthReferNoteHistories`.

**Appointments/Scheduling**: Present. `SchAppointments` with date, time, status, type. Also extensive surgical scheduling via `SchOrPatCase*` tables.

**Documents/Images**: Strong. External documents/images section, point of contact scans, clinical reports with physician docs, radiology reports, pathology reports with images, nursing image documentation.

**Audit Trails**: Minimal. `PhaRxAuditDetailText` in pharmacy suggests some audit tracking exists. No general audit trail export.

### Issues & Red Flags
1. C/S Config 2 is the most complete export across all MEDITECH platforms — it comes closest to a true database dump.
2. Provider Messages are included as PDF rather than structured data.
3. The C/S Acute-only Config 1 export is much more limited than the Config 2 Acute & Ambulatory export.

---

## Product: MEDITECH MAGIC

### Product Context
MEDITECH MAGIC (v5.67) is the oldest supported MEDITECH platform, with a character-based interface dating to the 1990s. Despite this, many hospitals continue to operate on MAGIC. It includes the same general module set as newer platforms. MAGIC HCA is a variant used at HCA Healthcare facilities (without PatientKeeper).

### Export Approach
Similar split to Client/Server:
- **MAGIC Acute only**: Configuration 1 — Electronic Chart + FHIR + C-CDA + Financial Reports + Provider Messages + Implantable Devices (no Immunizations compared to C/S)
- **MAGIC Acute & Ambulatory**: Configuration 2 — CSV patient data + FHIR + C-CDA + clinical reports + provider/patient messages + financial reports + external documents + scanned documents

The MAGIC CSV data dictionary PDF documents ~891 unique field/table identifiers. MAGIC has notably more table groups than C/S in some areas:
- **Emergency Dept**: `EdmPatientDocuments`, `EdmPatientDocumentSigHistory`, `EdmPatientDocumentText`, `EdmPatientCallMngmnt`, `EdmPatientDepartRefers`, `EdmPatientNotes`, `EdmReminders`
- **Family History**: `EpsFamilyHistory*` (detailed family history with problems, relations, comments)
- **Problems**: `EpsProblems*` (problem list with qualifiers, codes, descriptions, visits)
- **Radiology**: `RadExams*` (16+ tables covering exams, findings, mammography, staff, tech queries, film repeats, followups)
- **Ambulatory Visits**: `PbrMpiVisVisits*` (ambulatory visit data with vitals, messages, problems, health maintenance)
- **Visit Messages**: `PbrMpiVisVisitsMessagesText` — contains "New Message" field

### EHI Coverage Assessment
**Clinical**: Comprehensive. Similar scope to C/S with additional ED-specific tables (`Edm*`), family history detail (`Eps*`), and ambulatory visit data (`PbrMpiVis*`). Radiology coverage is particularly strong with `RadExams*` tables.

**Secure Messages**: Present. `PbrMpiVisVisitsMessagesText` in CSV (visit-level messages), Provider Messages as text files, and `EdmPatientNoteText` (ED notes). Provider Messages section includes "Provider to Provider and Provider to Patient messaging" with embedded images.

**Billing/Financial**: Present. `PbrAccountClaims`, `PbrAccountClaimDetail`, `PbrAccountTransactions`, `PbrAccountStatements`, `PbrAccountTxnPymntDistribution`, `PbrAccountTransactionDiagnoses`, `PbrAccountDemographics` — slightly different table names from C/S but equivalent coverage. Also `BilledAmt`, `BilledBadDebtAmt` fields.

**Insurance/Coverage**: Present. `AdmInsuranceOtherType`, `AdmInsuredData` (PolicyNumber, GroupNumber, GroupName, TreatmentAuthorizationNumber, InsuranceElecCheck), `MriPatientInsurances`, `ArmAuths`, `ArmAuthServices`, `ArmAuthInpatientDays`.

**Appointments/Scheduling**: Present. `SchAppointments` plus extensive surgical scheduling (`SchOrPatCase*` tables).

**Documents/Images**: Strong. ED documents (`EdmPatientDocuments`, `EdmPatientDocumentText`), ambulatory documents with text and images, pathology images, radiology reports, external scanned documents.

**Audit Trails**: Minimal evidence. `PbrMpiVisHlthMntItemsAudit` exists (health maintenance audit), `EdmPatientDocumentSigHistory` (document signature history), `PthSpecimenSignoutAuds` (pathology signout audits). These are domain-specific audit trails, not comprehensive access logs.

### Issues & Red Flags
1. MAGIC is the oldest platform but ironically has some of the most detailed CSV documentation.
2. MAGIC HCA variant is separately certified (CHPL 11018) — unclear if export differs.
3. The `PbrMpiVisVisitsMessagesText` table name suggests visit messages but scope of messaging data is unclear.

---

## Cross-Platform Summary

MEDITECH's EHI export architecture splits into two fundamentally different approaches:

| Aspect | Config 1 (Expanse, 6.x, some C/S & MAGIC) | Config 2 (C/S, MAGIC, 6.08 Amb) |
|--------|-------------------------------------------|-----------------------------------|
| Core data format | Document images + FHIR JSON + C-CDA | CSV structured tables + FHIR JSON + C-CDA |
| Financial data | Text report (FinancialEHI.txt) | Structured CSV tables (PbrAccount*) |
| Insurance data | PDF report (ARM reports) | Structured CSV columns |
| Messages | Not explicitly included | Provider Messages file + CSV tables |
| Documentation depth | Inline HTML descriptions only | PDF data dictionaries with table/column definitions |
| Machine readability | Mixed (documents + FHIR + text) | Strong (CSV + FHIR + documents) |

The modern platform (Expanse) paradoxically has a less structured export than the legacy platforms (C/S, MAGIC). This likely reflects Expanse's reliance on the HIM/Scanning module for document archival vs. the older platforms' Data Repository approach with direct database extracts.
