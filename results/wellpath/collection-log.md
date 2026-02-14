# Wellpath — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10464
- Registered URL: https://wellpathcare.com/wp-content/uploads/2024/05/Wellpath-ERMA-Export-Format.pdf

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://wellpathcare.com/wp-content/uploads/2024/05/Wellpath-ERMA-Export-Format.pdf" \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```

Result:
```
HTTP/2 200
server: nginx
date: Sat, 14 Feb 2026 03:16:36 GMT
content-type: application/pdf
content-length: 634676
last-modified: Wed, 15 May 2024 21:16:55 GMT
etag: "66452647-9af34"
cache-control: public, max-age=31536000
vary: Accept-Encoding
access-control-allow-origin: *
accept-ranges: bytes
```

Direct PDF download. HTTP 200, no redirects, content-type: application/pdf, 634,676 bytes (~620 KB). The registered URL is the documentation itself — a direct link to a PDF hosted on Wellpath's WordPress site. Last modified May 15, 2024.

### Step 2: Page examination
Not applicable — the URL is a direct PDF link, not an HTML page. No navigation, SPA rendering, or accordion expansion required.

### Step 3: Finding the EHI section
Not applicable — the entire PDF is the EHI export documentation.

### Step 4: Identified downloadable assets
| File | URL | Type | Size |
|------|-----|------|------|
| Wellpath ERMA Export Format | https://wellpathcare.com/wp-content/uploads/2024/05/Wellpath-ERMA-Export-Format.pdf | PDF | 634,676 bytes |

## Downloads

### wellpath-erma-export-format.pdf (620 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' \
  -o downloads/wellpath-erma-export-format.pdf \
  'https://wellpathcare.com/wp-content/uploads/2024/05/Wellpath-ERMA-Export-Format.pdf'
```
Verified: `file wellpath-erma-export-format.pdf` → PDF document, version 1.7, 23 page(s)
Size: 634,676 bytes
Saved to: downloads/wellpath-erma-export-format.pdf

## Obstacles & Notes
- No obstacles encountered. The URL is a clean, direct PDF download with no authentication, anti-bot protection, or JavaScript requirements.
- The PDF was last modified May 15, 2024, and is hosted on Wellpath's WordPress site under `/wp-content/uploads/`.
- Wellpath also has a compliance certificate PDF at a separate URL (https://wellpathcare.com/wp-content/uploads/2024/08/Compliance-Certificate-ERMA-Version-6-081624.pdf) listed as the mandatory disclosures URL, but that is a compliance certificate, not EHI export documentation.

---

## Product: ERMA (Electronic Records Management Application)

### Product Context
Wellpath is one of the largest correctional healthcare companies in the United States, headquartered in Nashville, Tennessee. Formed in 2018 through the merger of Correct Care Solutions and Correctional Medical Group, Wellpath provides contracted healthcare services at over 315 correctional facilities in 37 states, serving approximately 200,000 patients daily. The company operates three divisions: Local Detention (~205 jails), State & Federal Correctional (~135 prisons), and Inpatient & Residential (Recovery Solutions, in 7 states).

ERMA (Electronic Records Management Application) is Wellpath's proprietary, self-developed, web-based EHR system designed exclusively for correctional healthcare settings. It is not sold externally — it is used solely within Wellpath's contracted facilities. The system is cloud-hosted (accessed via ccserma.com, the legacy Correct Care Solutions domain) and maintained by Wellpath's Clinical Product Development team.

ERMA's core capabilities include:
- **Intake screening and health assessments** at booking
- **Medical, mental health, and dental charting** — full clinical documentation
- **Sick call management** — inmate-initiated healthcare requests
- **Chronic care tracking** — diabetes, hypertension, HIV, etc.
- **Provider orders and medication management** (CPOE, drug-drug/drug-allergy checks, MAR)
- **Lab results** management
- **Appointment scheduling**
- **Patient consent forms and grievance tracking**
- **Insurance/billing data** — Medicaid, Medicare, guarantor information
- **Off-site care management** — referrals to outside hospitals/specialists
- **Integration with Jail Management Systems (JMS)** for demographic synchronization

Critically, ERMA does **not** have a patient portal. Incarcerated individuals do not have internet access, so there is no patient-facing messaging or portal system. There is also no evidence of provider-to-provider messaging features within ERMA.

ERMA's ONC certification is very narrow — only 16 criteria, focused on CPOE, drug checks, family history, EHI export, and security/audit requirements. Notably absent: no FHIR API (g)(7)-(g)(10), no patient access API (e)(1), no C-CDA transitions of care (b)(1)-(b)(9), no clinical quality measures, and no public health reporting.

Wellpath filed for Chapter 11 bankruptcy in November 2024 and emerged in May 2025.

### Export Approach
The ERMA EHI export uses **HL7 v2.5 ADT (Admit-Discharge-Transfer) message format**. This is neither a database dump nor FHIR/C-CDA — it is a legacy healthcare interoperability standard. The export produces HL7 v2 messages containing these segments:

1. **MSH** — Message Header (sending application, facility, message type, encoding)
2. **PID** — Patient Identification (demographics: name, DOB, SSN, inmate number, address, race, ethnicity, language, marital status, religion, patient account number, death info)
3. **PD1** — Patient Demographics (primary care provider, living will, HIPAA opt-in/out, handicap, student indicator)
4. **MRG** — Merge Patient Information (prior patient identifiers for merge events)
5. **NK1** — Next of Kin (emergency contacts with relationship, address, phone, employment, demographics)
6. **PV1** — Patient Visit (encounter class, location [point of service/room/bed/facility], attending/referring/consulting/admitting doctors with NPI, admission type, financial class, charge price indicator, credit rating, contract info, bad debt tracking, discharge disposition, admit/discharge dates, current patient balance, total charges/adjustments/payments)
7. **PV2** — Additional Visit Info (accommodation, admit/transfer reasons, patient valuables, expected admit/discharge dates, length of stay, visit description, referral source, visit protection indicator)
8. **AL1** — Allergies (allergy type, code, severity, reaction, identification date)
9. **DG1** — Diagnosis (coding method, ICD codes, free-text, diagnosis type/priority, DRG info, diagnosing clinician, confidential indicator)
10. **PR1** — Procedures (CPT codes, functional type [anesthesia/procedure/invasive/diagnostic], procedure minutes, surgeon, anesthesiologist, procedure practitioner, consent code, associated diagnosis, procedure modifier, DRG type, tissue type, procedure action code [add/update/delete])
11. **GT1** — Guarantor (financial responsibility: name, address, phone, DOB, SSN, employer, billing hold flag, credit rating, charge adjustment code, income, household size, death date/indicator)
12. **IN1** — Insurance Information (insurance plan, company, group, plan effective/expiration dates, authorization info, plan type, insured name/relationship/DOB/address, benefits, eligibility, billing status, policy number/deductible/limits, room rates, employment status, verification)
13. **IN2** — Insurance Additional Info (Medicare, Medicaid, CHAMPUS/TRICARE fields, payor ID, eligibility source, room/policy coverage amounts, daily deductible, copay/stop-loss limits)
14. **ACC** — Accident Information (date/time, code, location, auto accident state, job-related indicator, death indicator, police notification)

The document also references "Chapter 4 — Supported ADT Trigger Events" for allowable ADT event triggers, suggesting the export is event-based (e.g., A01=admission, A03=discharge, A08=update, A40/A44=merge).

This HL7 v2 approach is **unusual for EHI export** — most vendors use native database dumps, FHIR NDJSON, or C-CDA. HL7 v2 ADT messages are designed for real-time interface feeds between systems, not bulk data export. The format can carry a reasonable amount of clinical and administrative data, but it has structural limitations:
- It's encounter-centric (each message describes one visit/encounter)
- It doesn't naturally accommodate longitudinal data like clinical notes, care plans, or medication history as standalone entities
- Lab results, vitals, immunizations, and clinical notes are conspicuously absent from the documented segments

### EHI Coverage Assessment

**Clinical data — PARTIAL.** The export includes diagnoses (DG1 with ICD codes), procedures (PR1 with CPT codes), and allergies (AL1). However, critical clinical data categories are missing from the documented format:
- **No medications/prescriptions** — despite ERMA having CPOE (certified under (a)(1)) and medication administration records (MAR), there is no RXA, RXO, or ORC segment for medication orders or administration
- **No lab results** — despite ERMA storing lab data, there is no OBX/OBR segment for observations/results
- **No vitals** — no mechanism for vital signs
- **No clinical notes** — no NTE or TXA segment for narrative documentation
- **No immunizations** — no record of vaccinations
- **No care plans or assessments** — intake screenings, mental health assessments, chronic care tracking data all absent
- **No family health history** — despite certification under (a)(12)

**Secure messages — NOT APPLICABLE.** ERMA is a correctional health system where patients (inmates) do not have internet access. There is no patient portal and no evidence of secure messaging functionality. The absence of messaging data is expected and appropriate for this product context.

**Billing/financial — PARTIAL.** The GT1 (Guarantor) segment includes financial responsibility data: guarantor name, address, SSN, employer, billing hold flag, credit rating, charge adjustment code, income, household size. The PV1 segment includes financial class, current patient balance, total charges, total adjustments, total payments, contract code/amount, bad debt tracking. However, these are summary-level financial fields embedded in the visit record — there are no standalone charge, claim, or payment transaction segments. Individual billing line items, claim submissions, and payment posting details are not represented.

**Insurance/coverage — PRESENT.** The IN1 and IN2 segments provide extensive insurance coverage data: insurance plan/company/group, policy numbers, plan effective/expiration dates, authorization information, plan type, insured demographics, benefits coordination, eligibility reporting, billing status, policy deductible/limits, room rates, verification status, Medicare/Medicaid case numbers, CHAMPUS/TRICARE details, payor IDs, coverage amounts, copay/stop-loss limits.

**Appointments/scheduling — NOT PRESENT.** Despite ERMA having appointment scheduling as a confirmed feature, there is no scheduling segment in the export format. The PV1 segment captures encounter/visit data (admit date, discharge date, attending doctor) but not future appointment bookings.

**Documents/images — NOT PRESENT.** There is no mechanism in the documented export format for scanned documents, uploaded images, consent form content, or any binary/document data. The PR1 segment has a consent code field but not the actual consent document content.

**Audit trails — NOT PRESENT.** No audit log data in the export. This is expected — audit trails are generally excluded from the HIPAA Designated Record Set. ERMA is certified under (d)(2) Auditable Events and (d)(3) Audit Reports, so the system maintains audit logs, but their absence from the EHI export is not a compliance gap.

### Issues & Red Flags

1. **HL7 v2 ADT is a poor fit for bulk EHI export.** ADT messages are designed for real-time encounter notifications, not comprehensive data export. The format inherently limits what can be included because it follows a rigid segment structure oriented around admissions, transfers, and discharges.

2. **Major clinical data gaps despite system capabilities.** ERMA is certified for CPOE (medications), stores lab results, tracks chronic care, performs intake assessments, and manages medication administration — yet none of this data appears in the export format. The export covers demographics, encounters, diagnoses, procedures, allergies, insurance, and guarantor data, but misses medications, labs, vitals, notes, assessments, and care plans.

3. **No medication data despite CPOE certification.** ERMA is certified under 170.315(a)(1) for CPOE — the system clearly stores medication orders and administration records. The complete absence of medication data from the export is a significant gap.

4. **No lab results despite system capability.** ERMA stores lab results (confirmed by product documentation), but the export format has no OBX/OBR segments to carry observation/result data.

5. **No clinical notes or narrative documentation.** Correctional healthcare generates substantial clinical documentation — intake screenings, sick call notes, mental health assessments, chronic care visit notes. None of this appears in the export.

6. **No appointment/scheduling data.** The system has scheduling capabilities but the export doesn't include appointment data.

7. **Documentation is thin.** At 23 pages, this is a relatively brief specification for what should be an "all EHI" export. Compare to vendors with hundreds or thousands of documented tables. The HL7 v2 format specification describes 13 segments — a narrow slice of the data ERMA stores.

8. **"P" (Post-validator) designation on many fields.** Many fields are marked as "P" (Post-validator), meaning they're checked after the message is created but are not required. This suggests many fields may be empty in practice.

9. **No family health history** despite certification under 170.315(a)(12), which specifically requires the system to store and manage family health history data.

10. **Format suggests interface spec repurposed as export doc.** The HL7 v2 ADT message format, with its MSH headers, sending/receiving application fields, and ACK type fields, reads like an HL7 interface specification (for sending ADT feeds to other systems) that has been repurposed as the EHI export documentation. This raises the question of whether the "export" is actually just the HL7 interface feed dressed up as an EHI export.
