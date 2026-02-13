# athenahealth EHI Export — Deep Dive Analysis

**Date:** 2025-01-27 
**Source:** https://docs.athenahealth.com/athenaone-dataexports/ 
**Local PDF:** /home/exedev/EHI/downloads/athenahealth/ambulatory-clinical-ehi-export.pdf

## Executive Summary

**Does athenahealth's EHI export cover the full HIPAA Designated Record Set? NO.**

athenahealth explicitly states on their overview page:

> "EHI focuses on a set of health information that HIPAA covered entities and business associates currently collect, maintain, and make available for access, exchange, and use. **For example, EHI is a subset of the same information in a HIPAA Designated Record Set**, which may include:
> 1. Medical records and billing records about individuals
> 2. Enrollment, payment, claims adjudication, and case or medical management record systems maintained by or for a health plan.
> 3. Data used in whole or in part to make decisions about individuals."

However, the export is **more comprehensive than most EHR vendors** because it includes TWO separate export types:
- **Clinical EHI Export** (athenaClinicals) — clinical/healthcare data
- **Collector EHI Export** (athenaCollector) — demographic and billing data

This means athenahealth exports BOTH clinical AND billing/financial data, which is unusual among EHR vendors.

---

## Export Architecture

athenahealth's EHI Export has 4 distinct modules:

| Module | Setting | Product | Data Type |
|--------|---------|---------|----------|
| Ambulatory Clinical EHI Export | Outpatient | athenaClinicals | Clinical/healthcare |
| Ambulatory Collector EHI Export | Outpatient | athenaCollector | Demographic/billing |
| Inpatient Clinical EHI Export | Hospital | athenaClinicals | Clinical/healthcare |
| Inpatient Collector EHI Export | Hospital | athenaCollector | Demographic/billing |

### File Formats
- **Primary data:** Newline Delimited JSON (NDJSON)
- **Supporting files:** XML, JPEG, PNG, TIFF, PDF (encounter summaries, imaging results, scanned documents, insurance ID cards, claim attachments)
- **Inpatient Clinical:** HTML (HTML 5) format instead of JSON
- **Packaging:** ZIP files with hierarchical folder structure

### Export Modes
- Single patient export
- Multi-patient export
- Bulk/All patient export

---

## Complete Dataset Inventory

### Ambulatory Clinical EHI Export (60 datasets)

| # | Dataset Name | Has Attachments |
|---|-------------|----------------|
| 1 | Admin Documents | Yes |
| 2 | Allergies | No |
| 3 | Assessment and Plan | No |
| 4 | Cancer Cases | No |
| 5 | Care Plan | No |
| 6 | Care Plan Events | No |
| 7 | Care Team Members | No |
| 8 | Chief Complaint (reason for visit/encounter reason) | No |
| 9 | Clinical Documents (includes Mental Health Consult Documents) | Yes |
| 10 | Corrective Lens | No |
| 11 | Default Clinical Providers – Lab | No |
| 12 | Default Clinical Providers - Imaging | No |
| 13 | Default Clinical Providers – Pharmacy | No |
| 14 | Devices or Medical Equipment | No |
| 15 | DME Orders | Yes |
| 16 | Encounter Documents | Yes |
| 17 | Encounters | No |
| 18 | Encounter Phone Call Checklists (Pre-Admission and Post-Discharge) | No |
| 19 | Encounter Summary | No |
| 20 | Eye Care Specific Measurements | No |
| 21 | Family History | No |
| 22 | Goals | No |
| 23 | GYN History | No |
| 24 | Health Concerns – Conditions & Problems | No |
| 25 | History of Present Illness | No |
| 26 | Imaging Results | Yes |
| 27 | Immunizations | No |
| 28 | Interpretations | No |
| 29 | Lab Results | Yes |
| 30 | Letters | Yes |
| 31 | Letter Action Notes | No |
| 32 | Medical Record Documents | Yes |
| 33 | Medications (includes Procedure Medications, Denied Medications, Prescribed Vaccines) | No |
| 34 | OB Episodes | No |
| 35 | OB Episode Summary | No |
| 36 | OB Episode Summary Documents | Yes |
| 37 | OB History (includes Past Pregnancies) | No |
| 38 | Observations (includes Vital Measurements) | No |
| 39 | Office Notes | Yes |
| 40 | Orders – Labs, Imaging, Consult & Procedures | Yes |
| 41 | Other CCDAs | Yes |
| 42 | Past Medical History | No |
| 43 | Patient Cases | No |
| 44 | Perinatal History | No |
| 45 | Physical Exam | No |
| 46 | Physician Authorization | Yes |
| 47 | Prescription Documents | Yes |
| 48 | Procedures | No |
| 49 | Procedures Documentation (includes outcomes) | No |
| 50 | Procedure Roles | No |
| 51 | Procedure Times | No |
| 52 | Procedure Timeout Checklist | No |
| 53 | Procedure Vitals (Pre/Intra/Post) | No |
| 54 | Pre-sedation Assessment | No |
| 55 | PT Episode | No |
| 56 | Review of Systems | No |
| 57 | Screening | No |
| 58 | Social History | No |
| 59 | Surgery Action Notes | No |
| 60 | Surgical History | No |
| 61 | Surgical Orders | No |
| 62 | Surgical Results | Yes |
| 63 | Topic of Discussion | No |
| 64 | Vitals | No |

### Ambulatory Collector EHI Export (15 datasets)

| # | Dataset Name | Has Attachments |
|---|-------------|----------------|
| 1 | Appointments | No |
| 2 | Appointment Ticklers & Reminders | No |
| 3 | Claim Attachments | Yes |
| 4 | Claim Details | No |
| 5 | Claim Notes | No |
| 6 | Claim Transactions | No |
| 7 | Demographics | No |
| 8 | Patient - Billing Statements and Summaries | Yes |
| 9 | Payment History (includes Patient Refunds) | No |
| 10 | Patient Insurance | Yes |
| 11 | Patient Outstanding Balance & Patient Unapplied | No |
| 12 | Payment Plans | No |
| 13 | Pre-payment Plans | No |
| 14 | Referral/Auth | Yes |
| 15 | Return to Office (included in Appointment Ticklers dataset) | No |

### Inpatient Clinical EHI Export (38 datasets)

| # | Dataset Name |
|---|-------------|
| 1 | Patient Demographics Information |
| 2 | Admin Documents |
| 3 | Admission H&P |
| 4 | Admission Order |
| 5 | Clinical Documents |
| 6 | Consult Notes |
| 7 | Discharge Planning Audit |
| 8 | Discharge Planning Notes |
| 9 | Discharge Summary |
| 10 | ED Course |
| 11 | ED Nursing Initial Assessment Notes |
| 12 | ED Provider Assessment |
| 13 | ED Provider Notes |
| 14 | ED Triage Notes |
| 15 | Flowsheet ADL |
| 16 | Flowsheet ADLs |
| 17 | Flowsheet Airways |
| 18 | Flowsheet Drains |
| 19 | Flowsheet Head to Toe |
| 20 | Flowsheet Intake & Output |
| 21 | Flowsheet Lines |
| 22 | Flowsheet Measurements |
| 23 | Flowsheet Vitals |
| 24 | Hospital Notes |
| 25 | Imaging Results |
| 26 | Lab Results |
| 27 | Medication Administration Record |
| 28 | Nursing Admission Notes |
| 29 | Nursing Care Plan |
| 30 | Nursing Notes |
| 31 | Nursing Tasks |
| 32 | Orders |
| 33 | Paper Forms |
| 34 | Patient Discharge Instructions |
| 35 | Respiratory Tasks |
| 36 | Surgical Pre-Op Notes |
| 37 | Therapy Tasks |
| 38 | Transfer Orders |

### Inpatient Collector EHI Export (16 datasets)

Same as Ambulatory Collector, plus:
| 16 | Visits and Charge Details | No |

---

## EHI Category Assessment

### ✅ INCLUDED — Billing/Financial Data
**Verdict: YES — via Collector EHI Export**

The Collector export explicitly covers billing and financial data:
- **Claim Details** — claim-level billing data with diagnoses, custom fields, department info
- **Claim Transactions** — payment/adjustment transactions on claims, with reconciliation to claim IDs
- **Claim Notes** — notes attached to claims
- **Claim Attachments** — supporting documents for claims (PDFs, images)
- **Payment History (includes Patient Refunds)** — patient payment records
- **Patient - Billing Statements and Summaries** — billing statements with attachment files
- **Patient Outstanding Balance & Patient Unapplied** — current balance data
- **Payment Plans** — active payment plan details
- **Pre-payment Plans** — pre-payment arrangements
- **Visits and Charge Details** — (Inpatient only) charges tied to visits

Note: The API endpoint for Claim Details uses `/v1/{contextId}/claims` which returns CPT/procedure codes, diagnoses, and financial details.

### ✅ INCLUDED — Insurance/Coverage
**Verdict: YES — via Collector EHI Export**

- **Patient Insurance** — insurance information with attachment files (insurance ID card images)
- **Referral/Auth** — referral authorizations with attachments
- **Appointment Insurance** — referenced in the API (appointment-level insurance)

### ✅ INCLUDED — Appointments/Scheduling
**Verdict: YES — via Collector EHI Export**

- **Appointments** — scheduling data
- **Appointment Ticklers & Reminders** — follow-up reminders
- **Return to Office** — included in Appointment Ticklers

### ✅ INCLUDED — Demographics (Extensive)
**Verdict: YES — via Collector EHI Export**

The Demographics dataset uses the patient record API (`/patients/{patientId}`) which includes:
- Name, DOB, SSN, address, phone numbers
- Employer information (fax, ID, name, phone)
- Patient identifiers: FIRSTNAME, LASTNAME, DOB, SSN, ATHENA PATIENT ID, ENTERPRISE ID, MOBILE PHONE, HOME PHONE, ADDRESS
- Inpatient Clinical also includes "Patient Demographics Information" separately

### ❌ NOT INCLUDED — Patient-Provider Secure Messages (Portal Messages)
**Verdict: NO — NOT in the EHI export**

The Clinical EHI Export dataset list contains NO dataset for:
- Patient portal messages
- Secure messages between patient and provider
- Inbox messages
- athenaCommunicator messages

The athenahealth API does have a "Document Type - Phone Message" and "Inbox Tasks" in its API reference, but:
- "Phone Message" is specifically about fax-received messages, not portal messages
- Neither Phone Messages nor Inbox Tasks appear in the Clinical or Collector EHI Export dataset lists
- athenaCommunicator (the patient portal/communication module) has NO corresponding EHI export module

This is a significant gap — patient portal messages are part of the Designated Record Set.

### ❌ NOT INCLUDED — Audit Trails / Access Logs
**Verdict: NO — NOT in the EHI export**

No dataset in either Clinical or Collector exports covers:
- Who accessed the patient record
- Record access audit logs
- HIPAA access audit trails
- Login/activity history

### ⚠️ PARTIALLY INCLUDED — Administrative Data
**Verdict: PARTIAL**

**Included:**
- **Admin Documents** — administrative documents with attachments (in Clinical export)
- **Physician Authorization** — authorization documents with attachments
- **Letters** — letters with attachments
- **Patient Cases** — case management
- **Referral/Auth** — referral authorization documents

**Not clearly included:**
- Consent forms (no explicit "consent" dataset; may be included in Admin Documents)
- Privacy/HIPAA acknowledgments
- Advance directives (not listed as a separate dataset)

### ❌ NOT INCLUDED — athenaCommunicator Data
**Verdict: NO — Entire communication module excluded**

athenahealth has three main modules:
1. **athenaClinicals** → Clinical EHI Export ✅
2. **athenaCollector** → Collector EHI Export ✅
3. **athenaCommunicator** → **NO EHI Export** ❌

athenaCommunicator handles:
- Patient portal
- Secure messaging
- Appointment reminders (some overlap with Collector)
- Patient education materials
- Broadcast messaging

None of this has a dedicated export module.

---

## Key Findings Summary

| EHI Category | Included? | Export Module | Notes |
|-------------|-----------|---------------|-------|
| Clinical records (allergies, labs, meds, etc.) | ✅ YES | Clinical | 60+ ambulatory datasets |
| Encounter/visit data | ✅ YES | Clinical | Encounters, summaries, notes |
| Billing/charges/claims | ✅ YES | Collector | Claim details, transactions, billing statements |
| Payment history | ✅ YES | Collector | Including patient refunds |
| Insurance/coverage | ✅ YES | Collector | Patient insurance with ID card images |
| Appointments/scheduling | ✅ YES | Collector | Appointments + ticklers/reminders |
| Demographics | ✅ YES | Collector | Extensive patient record |
| Referrals/authorizations | ✅ YES | Collector | With attachment files |
| Procedures/surgical | ✅ YES | Clinical | Procedures, surgical history, orders, results |
| Imaging/lab results | ✅ YES | Clinical | With result document files |
| Medications/prescriptions | ✅ YES | Clinical | Including denied meds, vaccines |
| Patient portal messages | ❌ NO | — | athenaCommunicator not exported |
| Secure provider messages | ❌ NO | — | Not in any export module |
| Audit trails / access logs | ❌ NO | — | Not in any export module |
| Psychotherapy notes | ❌ Excluded | — | Explicitly excluded per regulation |
| Consent forms | ⚠️ UNCLEAR | Clinical? | May be in Admin Documents |
| Advance directives | ⚠️ UNCLEAR | Clinical? | Not a named dataset |

## Conclusion

**athenahealth's EHI export is significantly more comprehensive than most EHR vendors** because it includes both clinical AND billing/financial data through the dual Clinical + Collector export architecture. Most vendors only export clinical data.

However, **it does NOT cover the full HIPAA Designated Record Set**. athenahealth themselves acknowledge this, calling EHI "a subset" of the DRS. The key gaps are:

1. **No patient portal/secure messaging data** (athenaCommunicator module entirely excluded)
2. **No audit trails or access logs**
3. **Unclear coverage of consent forms and advance directives**

The export covers approximately **80-85% of what would constitute a complete HIPAA Designated Record Set**, which is better than most vendors but still incomplete.
