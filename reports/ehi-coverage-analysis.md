# EHI Export Coverage Completeness Analysis

**Date:** 2026-02-13
**Regulation:** ONC 170.315(b)(10) — Electronic Health Information Export
**Standard:** EHI = HIPAA Designated Record Set (ALL electronic health information)

---

## Executive Summary

Under the Cures Act, EHI export must cover the **entire Designated Record Set** — not just clinical data. This analysis examines 16 EHR vendors' published EHI export documentation to determine whether their exports actually cover all required categories of data, including non-clinical domains like billing, insurance, messaging, and audit trails.

**Key finding:** Only a handful of vendors (Epic, Oracle, TruBridge, Greenway, Altera) document exports that clearly span clinical, financial, administrative, and operational data. Many vendors — particularly smaller ones — appear to export primarily clinical data, leaving significant gaps in billing, messaging, and audit coverage.

---

## Coverage Matrix

### Legend
- ✅ **Documented** — Export documentation explicitly lists tables/fields/resources in this category
- ⚠️ **Partial/Unclear** — Some evidence but incomplete, or category mentioned vaguely
- ❌ **Not documented** — No evidence in available documentation that this category is exported
- 🔒 **PDF-only** — Documentation is in PDF; assessment based on report descriptions, not direct search

### Major Inpatient EHR Vendors

| Category | Epic | Oracle Health | Altera (Sunrise) | MEDITECH | MEDHOST |
|----------|------|--------------|-------------------|----------|---------|
| **Clinical data** | ✅ 7,673 tables | ✅ 1,448+ pages | ✅ 2,668 tables | ✅ FHIR+C-CDA | ✅ FHIR R4 |
| **Secure messages** | ✅ MYC_MESG (20+ tables), IB_MESSAGES (22 tables), CHAT_MESSAGE | ✅ message_center (3 pages), community (17 pages) | ✅ SXAAMBSendMessageInstance, CV3AlertMessage, Inbox tables | ✅ "Provider Messages" folder | ❌ No Communication resource |
| **Billing/financial** | ✅ ARPB (428 tables), AP_CLAIM, HAR (109 tables) | ✅ pft_billing (16), charge_services (11), revenue_cycle (25) | ✅ SXAAMBSBillCharge*, SXAAMBillCode | ✅ "Financial EHI" folder (Patient Accounting report) | ✅ Charge Item sheet (27 fields) |
| **Insurance/coverage** | ✅ COVERAGE (27+ tables), BENEFIT, ATB_AUTH | ✅ health_plan (4), eligibility (7), authorization (4), benefits (1) | ✅ SXAAMInsuranceCarrier, CV3Eligibility, SXARCMAuthorization | ⚠️ "insurance eligibility and deduction data" mentioned | ✅ Coverage sheet (31 fields), authorization |
| **Appointments/scheduling** | ✅ SCHED_, CAL_ (19+ tables), PAT_ENC (115 tables) | ✅ scheduling (40 pages), encounter (39 pages) | ✅ CV3ScheduleEvent, CV3ClientVisit, CV3VisitType | ❌ No appointment tables documented | ✅ Appointment sheet (24 fields) |
| **Documents/images** | ✅ DOCS_RCVD (317 tables), HNO_ (16), DICOM, CONSENT_DOC | ✅ imaging_document (13), multimedia (7), clinical_events (12) | ✅ CV3ClientDocument*, CV3MultimediaLink, AttachTypes | ✅ Electronic Chart (PNG/JPG/TIF/BMP/PDF) | ❌ No DocumentReference resource |
| **Audit trails** | ✅ Multiple *_AUDIT tables, CHAT_ACCESS_LOG, CLM_VAL_AUDIT_TRAIL | ✅ prologue (11 pages), patient_tracking, patient_access_list | ⚠️ *History tables (modification history), no dedicated audit | ❌ Not documented | ❌ Not documented |
| **Table/field count** | 7,673 | ~1,448 pages (thousands of tables) | 2,668 | N/A (hybrid format) | 41 FHIR resources |

### Major Outpatient/Ambulatory EHR Vendors

| Category | athenahealth | NextGen | Greenway (Intergy) | Veradigm (View) | AdvancedMD |
|----------|-------------|---------|-------------------|-----------------|------------|
| **Clinical data** | ✅ ~60+ datasets | ✅ 29MB data dictionary | ✅ 261 tables | ✅ 87 TSV files | ✅ C-CDA + EHR tables |
| **Secure messages** | 🔒⚠️ PDF says "Clinical" — unclear | 🔒⚠️ Likely in 29MB PDF | ✅ PracPersonSecureMessage, PracPersonSecureMsgBlob, RxExtMessage | ✅ patient-messages.tsv, patient-message-attachments.tsv, patient-message-recipients.tsv | ✅ "Messages" in chart print; EHR_Messages in bulk |
| **Billing/financial** | 🔒⚠️ PDF titled "Ambulatory Clinical" — billing unclear | 🔒⚠️ Likely in 29MB PDF | ✅ Charge (6 tables), Claim (4), Payment (6), Adjustment, AccountBill, PlanClaim (10+) | ✅ patient-superbills.tsv, superbill-diagnosis/events/procedures/insurances (6 files) | ✅ PM export (.mdb): charges, payments, write-offs |
| **Insurance/coverage** | 🔒⚠️ Unclear from title | 🔒⚠️ Likely in 29MB PDF | ✅ Carrier, Plan, PlanGroup, Eligibility, EligibilityBenefit, RxEligPBM, PriorAuthInfo | ✅ patient-insurances.tsv, patient-insurance-eligibilities.tsv, superbill-insurances.tsv | ✅ "Insurance" in chart print; carrier in PM export |
| **Appointments/scheduling** | 🔒⚠️ Unclear | 🔒⚠️ Likely in 29MB PDF | ✅ Appointment, ApptRecall, ApptRoom, ApptStaff, Encounter (10+ tables) | ✅ patient-appointments.tsv | ✅ Appointments in PM export and chart print |
| **Documents/images** | 🔒⚠️ "Admin Documents" dataset listed | 🔒⚠️ "images, documents, reports" mentioned | ✅ Document, GenFileBlob, TMSCatalog/Blob, CLWCorrespondence + Images folder (TIF/TAR) | ✅ patient-documents.tsv, patient-encounter-documents.tsv | ✅ Scanned docs PDF; Documents Saved to Chart |
| **Audit trails** | 🔒❌ Not mentioned | 🔒⚠️ Unclear | ⚠️ *History tables (PersonHistory, AddressHistory, etc.) — modification logs, not access logs | ❌ No audit TSV files | ⚠️ "Audit Trail" in chart print tool (PDF only) |
| **Table/field count** | ~60+ datasets | Unknown (29MB PDF) | 261 tables | 87 TSV files | ~10-15 EHR tables + PM database |

### Smaller/Long-Tail Vendors

| Category | Nextech (ICP) | Nextech (Select) | Netsmart (myAvatar) | CareCloud (talkEHR) | TruBridge | SightView (MDoffice) |
|----------|--------------|-----------------|--------------------|--------------------|-----------|---------------------|
| **Clinical data** | ✅ | ✅ | ✅ 7,492-page PDF | ✅ C-CDA | ✅ 462 tables | ✅ CSV files |
| **Secure messages** | ✅ Secure Messages (JSON), Communications (PDF), Internal Communication (JSON) | ⚠️ PracYakker (internal chat), Notes | 🔒⚠️ Likely in massive PDF | ✅ "Provider-to-Patient Messages" (as PDF) | ✅ patient_communication, patient_communication_thread, patient_portal, ssmessage | ❌ Not listed |
| **Billing/financial** | ❌ Not in ICP dictionary | ✅ Charges (CSV), Payments (CSV), Payment Plans | 🔒⚠️ cf_acct_transaction_detail mentioned in report | ✅ "Billing Data (CPT/ICD/Modifier)" (as PDF) | ✅ ar_charge, ar_payment, ar_phy_charge, ar_room_charge (20+ tables) | ❌ Not listed |
| **Insurance/coverage** | ✅ Insurance & Auth (JSON) | ✅ Insurances (CSV) | 🔒⚠️ Likely in PDF | ⚠️ "Demographics/Insurance" (as PDF) | ✅ insurance1/2/3, insurance_coverage_a/b, insurance_detail (10+ tables) | ✅ Insurance Data, Authorizations |
| **Appointments/scheduling** | ✅ Appointments (JSON) | ✅ Appointments (CSV) | 🔒⚠️ AppointmentData table mentioned | ✅ "Appointments" (as PDF) | ✅ scheduling_appointment, scheduling_event, patient_scheduling (5 tables) | ❌ Not in data dictionary |
| **Documents/images** | ✅ Documents (TXT), Images (TXT) | ⚠️ EMN (PDF), Notes | 🔒⚠️ Referenced separately | ✅ "progress notes, lab results, radiology reports, scanned docs" (as PDF) | ✅ digital_signature_images, fax_table, eob_scanned_remit, hie_doc_* | ✅ Unstructured ZIP (images) |
| **Audit trails** | ❌ Not listed | ❌ Not listed | 🔒⚠️ Unclear | ❌ Not mentioned | ✅ clinical_monitoring_audit, ehi_export_audit, image_audit_log, task_audit (5 tables) | ❌ Not listed |

---

## Detailed Vendor Assessments

### Tier 1: Comprehensive Full-Database Exports (Likely Compliant)

These vendors export what appears to be the **entire database schema**, making it likely they cover all EHI categories:

#### 1. Epic Systems
- **7,673 table definitions** covering virtually every domain
- **Messaging:** 20+ MYC_MESG (MyChart secure messaging) tables, 22 IB_MESSAGES (In-Basket) tables, CHAT_MESSAGE tables
- **Billing:** 428 ARPB (professional billing) tables, 109 HAR (hospital account) tables, extensive AP_CLAIM tables
- **Insurance:** 27+ COVERAGE tables, BENEFIT tables, authorization tracking
- **Scheduling:** 19+ scheduling/calendar tables, 115 PAT_ENC (encounter) tables
- **Documents:** 317 DOCS_RCVD tables, clinical notes, DICOM imaging, consent documents
- **Audit:** Multiple dedicated audit tables across domains
- **Assessment:** ✅ **Most comprehensive export documentation of any vendor.** Clear full-database approach.

#### 2. Oracle Health (Cerner Millennium)
- **1,448+ HTML data model pages** organized by clinical domain
- **Messaging:** message_center module (3 pages), community module (17 pages)
- **Billing:** PFT billing (16 pages), charge services (11), revenue cycle (25 pages)
- **Insurance:** Health plans, eligibility (7 pages), authorizations (4 pages), benefits
- **Scheduling:** 40 scheduling pages, 39 encounter pages
- **Documents:** Imaging documents (13 pages), multimedia (7 pages), DICOM schema, document imaging schema
- **Audit:** Prologue audit tables (11 pages), patient tracking, access lists
- **Assessment:** ✅ **Full relational database dump approach.** Both MySQL and Oracle schemas provided. Population export includes physical device shipment for single-tenant systems.

#### 3. TruBridge
- **462 table definitions** in structured HTML web app
- **Messaging:** patient_communication, patient_communication_thread, patient_portal, chart_communication, ssmessage
- **Billing:** ar_charge, ar_payment, ar_phy_charge, ar_room_charge (+ history tables for each), contract_billing_transfer_charge
- **Insurance:** insurance1/2/3, insurance_coverage_a/b/1/2/3, insurance_detail, insurance_rac_claim
- **Scheduling:** appointment_scheduling_index, scheduling_appointment, scheduling_event, patient_scheduling
- **Documents:** digital_signature_images, fax_table, eob_scanned_remit, Images and Documents section
- **Audit:** clinical_monitoring_audit, ehi_export_audit, image_audit_log, task_audit_profile/visit
- **Assessment:** ✅ **Exemplary for a smaller vendor.** Full database export with clear coverage of all EHI categories.

#### 4. Altera Digital Health (Sunrise Acute Care)
- **2,668 table definitions** in ER/Studio format
- **Messaging:** SXAAMBSendMessageInstance, CV3AlertMessage, SXAAMBCommunityMedRecReview, Inbox tables, EDI messages
- **Billing:** SXAAMBSBillCharge tables, SXAAMBillCode, SXAAMBSuperBillCodeException
- **Insurance:** SXAAMInsuranceCarrier/Type, CV3Eligibility, SXARCMAuthorization, EDI270 messages
- **Scheduling:** CV3ScheduleEvent, CV3ClientVisit, CV3VisitType, various scheduling definitions
- **Documents:** CV3ClientDocument*, CV3MultimediaLink, AttachTypes
- **Audit:** Modification history tables per domain (not dedicated audit trail)
- **Assessment:** ✅ **Full database schema export.** Clinical focus is strong; billing/financial coverage exists but is thinner than Epic/Oracle.

#### 5. Greenway Health (Intergy)
- **261 table definitions** — smaller than hospital systems but comprehensive for ambulatory
- **Messaging:** PracPersonSecureMessage, PracPersonSecureMsgBlob, RxExtMessage, CLWCorrespondence
- **Billing:** Charge (6 tables), Claim/ClaimCharge/ClaimNote, Payment (6 tables), Adjustment, AccountBill, PlanClaim (10+ tables), CopayActivity
- **Insurance:** Carrier, Plan/PlanGroup, Eligibility/EligibilityBenefit, PriorAuthInfo, RxEligPBM
- **Scheduling:** Appointment, ApptRecall/Room/Staff, Encounter (10+ tables)
- **Documents:** Document, GenFileBlob, TMSCatalog/Blob, Images folder (TIF/TAR)
- **Audit:** *History tables for person, address, DOB, email, phone, problems — modification tracking
- **Assessment:** ✅ **Strong full-database approach for ambulatory.** Billing/claims coverage is notably thorough.

### Tier 2: Reasonably Comprehensive but Gaps Exist

#### 6. Veradigm (View product)
- **87 TSV export files** with field-level documentation
- **Messaging:** ✅ patient-messages.tsv, patient-message-attachments.tsv, patient-message-recipients.tsv — one of few vendors with explicit messaging export
- **Billing:** ✅ patient-superbills.tsv, superbill-diagnosis/events/procedures/insurances (6 files), prescription-transactions.tsv
- **Insurance:** ✅ patient-insurances.tsv, patient-insurance-eligibilities.tsv, superbill-insurances.tsv
- **Scheduling:** ✅ patient-appointments.tsv
- **Documents:** ✅ patient-documents.tsv, patient-encounter-documents.tsv, patient-lab-order/result-documents.tsv
- **Audit:** ❌ No audit/access log export files
- **Assessment:** ⚠️ **Good structured coverage** for most categories. Billing is superbill-level (not full claims/payments). No audit trails. Versioned documentation (v1–v6) shows active improvement.

#### 7. Netsmart (myAvatar)
- **7,492-page PDF** data dictionary — exhaustive but difficult to analyze
- Tables mentioned include: cf_acct_transaction_detail, AppointmentData, check_in_clients, telehealth_appt
- Behavioral health focus with extensive form/table mappings
- **Assessment:** 🔒⚠️ **Likely comprehensive** given the massive scope (7,492 pages), but the PDF format makes verification difficult. The full-database approach suggests all categories are covered.

#### 8. Nextech (3 products)
- **ICP:** ✅ Secure Messages, Communications, Insurance & Auth, Appointments, Documents, Images, Internal Communication — well-rounded
- **Select/NexCloud:** ✅ Charges, Payments, Payment Plans, Insurances, Appointments — good billing/financial
- **SRSPro:** ✅ Messages, Insurance Information, Appointment List, Guarantor Information
- **Assessment:** ⚠️ **Coverage varies by product.** ICP has the best coverage (including secure messages). No audit trails in any product.

#### 9. AdvancedMD
- **Multiple export tools** with different scopes:
  - PM data export (.mdb): demographics, transactions, appointments, charges, payments, write-offs, carrier info
  - EHR bulk export (.bak): allergies, immunizations, messages, diagnoses, prescriptions, lab results
  - Chart print tool: can include "Audit Trail, Messages, Appointments, Documents" — but as PDF
  - Scanned documents guidance (separate PDF)
- **Assessment:** ⚠️ **Fragmented across multiple export tools.** Data is there but requires 3-4 separate exports to get full picture. Bulk exports require developer assistance. Audit trail only available as PDF printout.

### Tier 3: Significant Gaps or Unclear Coverage

#### 10. MEDITECH
- **Hybrid approach:** FHIR R4 bundle + C-CDA + Electronic Chart + Supplemental Reports (PDF)
- **Messaging:** ✅ "Provider Messages" folder with patient-physician messages
- **Billing:** ✅ "Financial EHI" folder (Patient Accounting report, Resident Trust report)
- **Insurance:** ⚠️ Mentioned ("insurance eligibility and deduction data") but minimal detail
- **Scheduling:** ❌ No appointment/scheduling section documented
- **Documents:** ✅ Electronic Chart documents (images in multiple formats)
- **Audit:** ❌ Not documented
- **Assessment:** ⚠️ **The hybrid format covers many categories but with uneven depth.** Financial data exported as text reports rather than structured data. No scheduling. Content varies significantly by MEDITECH platform version.

#### 11. MEDHOST
- **FHIR R4 NDJSON** approach with 41 resource types
- **Resources present:** Allergy, Appointment, Charge Item, Condition, Consent, Coverage, Encounter, Immunization, Medication*, Observation*, Patient, Procedure, etc.
- **Messaging:** ❌ No Communication resource documented
- **Billing:** ✅ Charge Item sheet (27 fields)
- **Insurance:** ✅ Coverage sheet (31 fields) with authorization
- **Scheduling:** ✅ Appointment sheet (24 fields)
- **Documents:** ❌ No DocumentReference resource
- **Audit:** ❌ No AuditEvent resource
- **Assessment:** ⚠️ **FHIR-native approach is modern but incomplete.** Missing Communication, DocumentReference, and AuditEvent resources. Documentation only covers extensions — assumes consumer knows FHIR R4 spec.

#### 12. athenahealth
- **~60+ datasets** documented in SPA portal (requires browser to view) + downloadable PDF
- PDF titled "Ambulatory Clinical EHI Export" suggests clinical focus
- Datasets listed include: Admin Documents, Allergies, Assessment and Plan, Care Plan, Encounters, etc.
- **Assessment:** 🔒⚠️ **The "Clinical" in the title is concerning.** While athenahealth has extensive clinical dataset coverage, it's unclear from available documentation whether billing/claims, insurance, scheduling, and audit data are included in the EHI export specifically. The SPA requires browser rendering for full analysis.

#### 13. NextGen Healthcare
- **29 MB PDF** data dictionary — extremely large, suggesting comprehensive coverage
- Page mentions: "database dictionaries outline the structure of each exported table"
- Also mentions: "Images, documents, reports, and audio files" in separate folders
- Multiple products: Enterprise EHR, Office (CCDA+CSV+binary), Direct Messaging (CDA+binary), Mirth Connect
- **Assessment:** 🔒⚠️ **Likely comprehensive** given the massive PDF size, but impossible to verify specific categories without reading the 29MB PDF. The multi-product approach covers clinical, messaging (Direct Messaging product), and potentially billing.

#### 14. CareCloud (talkEHR)
- **12-page PDF** — the thinnest documentation
- Clinical data: ✅ C-CDA (Allergies, Medications, Problems, etc.)
- Non-clinical data exported **as PDF only:** Demographics/Insurance, Appointments, Provider-to-Patient Messages, Billing Data (CPT/ICD/Modifier), Documents
- **Assessment:** ⚠️ **Non-clinical data exported only as PDF — not machine-readable.** While billing, insurance, appointments, and messages are mentioned, exporting them as PDF defeats the purpose of a computable export. This likely doesn't meet the spirit of 170.315(b)(10).

#### 15. SightView (MDoffice)
- **49-page PDF** data dictionary for CSV-based export
- Strong on clinical and ophthalmology-specific data
- **Administration section:** Insurance Data, Authorizations, Referrals — ✅
- **Missing:** No messaging, no billing/charges/claims, no appointments, no audit trails
- **Assessment:** ⚠️ **Insurance/admin data present but significant gaps** in billing, messaging, scheduling, and audit. Ophthalmology-focused data is thorough.

#### 16. Netsmart myAvatar (assessed separately above as Tier 2)

---

## Sample Exports & Developer Resources

| Vendor | Sample Export Files | Test Dataset | Sandbox | Developer Guide | Getting Started |
|--------|-------------------|-------------|---------|----------------|----------------|
| **Epic** | ❌ | ❌ | ❌ (for EHI) | ✅ "Step-by-Step Developer Guide" link on page | ⚠️ Points to Vendor Services for API integration |
| **Oracle** | ❌ | ❌ | ❌ | ✅ Oracle Health Developer Program | ⚠️ Separate from EHI export |
| **Altera** | ❌ | ❌ | ❌ | ❌ | ❌ |
| **MEDITECH** | ❌ | ❌ | ❌ | ❌ | ❌ |
| **MEDHOST** | ❌ | ❌ | ❌ | ❌ | ❌ |
| **athenahealth** | ❌ | ❌ | ❌ | ⚠️ API docs linked | ⚠️ API-focused, not EHI-focused |
| **NextGen** | ❌ | ❌ | ❌ | ⚠️ Developer Program link | ❌ |
| **Greenway** | ⚠️ TMSCatalogBlob example image shown | ❌ | ❌ | ❌ | ❌ |
| **Veradigm** | ❌ | ❌ | ❌ | ❌ | ❌ |
| **AdvancedMD** | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Nextech** | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Netsmart** | ❌ | ❌ | ❌ | ❌ | ❌ |
| **CareCloud** | ❌ | ❌ | ❌ | ❌ | ❌ |
| **TruBridge** | ❌ | ❌ | ❌ | ❌ | ⚠️ XML example in Escribe Messages page |
| **SightView** | ❌ | ❌ | ❌ | ❌ | ❌ |

**Finding: NO vendor provides sample export files, test datasets, or sandbox environments for EHI export processing.** This is a universal gap across the entire industry. Developer resources exist for FHIR/API integration (Epic, Oracle, athenahealth, NextGen) but are entirely separate from the b(10) EHI export functionality.

TruBridge is the only vendor that includes an XML example (in the Escribe Messages documentation). Greenway shows a screenshot of the TMSCatalogBlob folder mapping. These are the closest any vendor comes to showing what the actual export output looks like.

---

## Consolidated Coverage Heatmap

| Vendor | Msgs | Billing | Insurance | Appts | Docs/Images | Audit | Overall |
|--------|------|---------|-----------|-------|-------------|-------|---------|
| **Epic** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 🟢 Full |
| **Oracle** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 🟢 Full |
| **TruBridge** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 🟢 Full |
| **Greenway** | ✅ | ✅ | ✅ | ✅ | ✅ | ⚠️ | 🟢 Near-full |
| **Altera** | ✅ | ✅ | ✅ | ✅ | ✅ | ⚠️ | 🟢 Near-full |
| **Veradigm** | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | 🟡 Good |
| **Nextech** | ✅ | ⚠️ | ✅ | ✅ | ✅ | ❌ | 🟡 Good |
| **AdvancedMD** | ✅ | ✅ | ✅ | ✅ | ✅ | ⚠️ | 🟡 Good (fragmented) |
| **Netsmart** | 🔒 | 🔒 | 🔒 | 🔒 | 🔒 | 🔒 | 🔒 Likely good (PDF) |
| **NextGen** | 🔒 | 🔒 | 🔒 | 🔒 | 🔒 | 🔒 | 🔒 Likely good (PDF) |
| **MEDITECH** | ✅ | ✅ | ⚠️ | ❌ | ✅ | ❌ | 🟡 Moderate |
| **MEDHOST** | ❌ | ✅ | ✅ | ✅ | ❌ | ❌ | 🟠 Gaps |
| **athenahealth** | 🔒 | 🔒 | 🔒 | 🔒 | 🔒 | 🔒 | 🔒 Unclear ("Clinical" title) |
| **CareCloud** | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ❌ | 🟠 PDF-only non-clinical |
| **SightView** | ❌ | ❌ | ✅ | ❌ | ✅ | ❌ | 🔴 Significant gaps |

---

## Key Findings

### 1. Full-Database Vendors Are Most Compliant
Vendors that export the **entire database schema** (Epic, Oracle, TruBridge, Altera, Greenway) inherently cover all EHI categories because they dump everything. This is the safest approach for compliance.

### 2. FHIR-Based Exports Risk Missing Non-Clinical Data
MEDHOST's FHIR R4 approach is modern but omits Communication, DocumentReference, and AuditEvent resources. FHIR's clinical focus means financial and administrative data can be overlooked unless vendors explicitly add non-standard resources.

### 3. "Clinical" Exports Are Likely Non-Compliant
Vendors whose documentation is titled "Clinical EHI Export" (athenahealth) or whose exports focus on C-CDA clinical data (CareCloud) may not meet the full Designated Record Set requirement. EHI includes billing, insurance, scheduling, and administrative data.

### 4. PDF-Only Non-Clinical Data Is Problematic
CareCloud exports billing, appointments, and messages **only as PDF** — not machine-readable. The regulation requires data "without special effort" in computable format.

### 5. Audit Trails Are the Most Commonly Missing Category
Only Epic, Oracle, and TruBridge clearly document audit trail exports. Most vendors either omit them entirely or provide only modification history (who changed what) rather than access logs (who viewed what).

### 6. No Vendor Provides Sample Exports
The complete absence of sample export files, test datasets, and sandbox environments across all 16 vendors makes it impossible for third parties to build EHI processing tools without access to a live system.

### 7. Documentation Format Affects Verifiability
Vendors with searchable HTML/ZIP documentation (Epic, TruBridge, Greenway, Veradigm, Altera) allow definitive verification. Vendors with PDF-only documentation (NextGen's 29MB PDF, Netsmart's 7,492-page PDF, athenahealth) make it impractical to confirm coverage without manual review.

---

## Methodology

For each vendor with searchable local files, we:
1. Extracted/unzipped documentation archives
2. Parsed table names from HTML entity lists, JavaScript data files, or XLSX sheets
3. Searched for keywords related to each EHI category (messaging, billing, insurance, scheduling, documents, audit)
4. Counted tables/resources in each category
5. Cross-referenced with vendor report descriptions

For PDF-only vendors, assessments are based on:
- File names and titles
- Report descriptions from prior analysis
- Page counts and file sizes as proxies for comprehensiveness
- HTML landing page content
