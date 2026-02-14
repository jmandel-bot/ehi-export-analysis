# AZZLY, Inc. — EHI Export Documentation Collection Log

## Source
- CHPL ID: 11073
- Registered URL: https://azzly.com/wp-content/uploads/2023/09/Data-Extraction-Instructions-AZZLY-Rize-v1.0.pdf
- Developer: AZZLY, Inc.
- Product: AZZLY Rize v1.0

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://azzly.com/wp-content/uploads/2023/09/Data-Extraction-Instructions-AZZLY-Rize-v1.0.pdf" -H 'User-Agent: Mozilla/5.0'
```

Result:
```
HTTP/2 200
server: nginx
content-type: application/pdf
content-length: 208706
last-modified: Mon, 25 Sep 2023 20:08:07 GMT
```

Direct PDF download. No redirects, no anti-bot protection, no JavaScript required. The registered URL is the PDF itself — a direct file link pattern.

### Step 2: Page examination

Not applicable — the URL returns a PDF directly, not an HTML page. Content-Type is `application/pdf`, 208,706 bytes (~204 KB).

### Step 3: Finding the EHI section

No navigation required. The registered URL is the complete documentation artifact.

### Step 4: Identified downloadable assets

| File | URL | Size |
|------|-----|------|
| Data Extraction Instructions AZZLY Rize v1.0 (PDF) | https://azzly.com/wp-content/uploads/2023/09/Data-Extraction-Instructions-AZZLY-Rize-v1.0.pdf | 208,706 bytes |

This is the only documentation artifact. There is no data dictionary, no schema reference, no supplementary documentation. The entire EHI export documentation is a 3-page PDF with step-by-step instructions for accessing an Azure Blob Storage container, plus a brief description of the folder structure.

## Downloads

### azzly-rize-data-extraction-instructions-v1.0.pdf (204 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/azzly-rize-data-extraction-instructions-v1.0.pdf \
  'https://azzly.com/wp-content/uploads/2023/09/Data-Extraction-Instructions-AZZLY-Rize-v1.0.pdf'
```
Verified: `file` → PDF document, version 1.7, 3 pages
Saved to: downloads/azzly-rize-data-extraction-instructions-v1.0.pdf

## Obstacles & Notes

- No obstacles encountered. The URL worked on first attempt with a simple curl.
- The PDF is marked "AZZLY CONFIDENTIAL" in the footer, which is somewhat contradictory given that the ONC b(10) requirement mandates publicly accessible documentation. The URL itself is publicly accessible without authentication, but the confidentiality marking is noteworthy.
- The document was last updated 9.25.2023, roughly 9 months after the certification date of 2022-12-14.

---

## Product: AZZLY Rize

### Product Context

AZZLY Rize is a cloud-based, all-in-one EHR, practice management, and revenue cycle management (RCM) platform built exclusively for **behavioral health and addiction treatment** organizations. It is developed by AZZLY, Inc. and hosted on Microsoft Azure. The product targets:

- Outpatient mental health programs
- Intensive outpatient programs (IOP)
- Residential treatment centers
- Medication-Assisted Treatment (MAT) and Opioid Treatment Programs (OTP)
- Telehealth-based behavioral health providers

**Key product capabilities** (from the vendor website):
- **Clinical documentation**: Assessments, treatment plans, progress notes, behavioral health-specific forms, outcome measurement tools (PHQ-9, GAD-7)
- **E-prescribing with EPCS**: Electronic prescribing of controlled substances, critical for MAT/OTP
- **PDMP integration**: Prescription Drug Monitoring Program access via DrFirst
- **Billing/RCM**: Integrated billing, claims submission, claims scrubbing, clearinghouse integration, 98% first-time claims pass rate claimed
- **Scheduling**: Calendar system for individual/group appointments, electronic check-in, automated reminders
- **Patient Engagement Portal (PEP)**: Portal at azzlyhealth.me with secure messaging, electronic document completion, e-signatures, profile management
- **Telehealth**: Integrated Zoom video conferencing
- **Document management**: Master library of forms, eChart single-screen chronological view
- **Bed board**: For residential/inpatient facility management
- **Withdrawal management**: Specialty module for addiction treatment

**Certification profile is notably limited**: Only certified for (a)(12) Family Health History, (a)(15) Social/Psychological/Behavioral Data, (b)(10) EHI Export, (e)(3) Patient Health Information Capture, plus security (d) and general (g) criteria. Notably absent: no core clinical criteria (a)(1)-(a)(9), no patient portal certification (e)(1), no FHIR API certification (g)(7)-(g)(10), no public health reporting (f). This suggests AZZLY pursued minimum certification necessary to maintain CHPL listing.

### Export Approach

The export is a **vendor-mediated file delivery** via Microsoft Azure Blob Storage. The process:

1. User submits an "Authorized User's Written Request" to AZZLY
2. AZZLY uploads data files to an Azure Storage Container
3. AZZLY provides the user a SAS (Shared Access Signature) URL
4. User downloads Azure Storage Explorer and connects to the blob container

The documentation says users can export "without developer assistance," but the process requires a written request to AZZLY and depends on AZZLY providing the SAS URL. This is contradictory — in practice, this appears to be a vendor-mediated process, not a self-service export.

The exported data is organized into four folders:
1. **Clinical Data Forms** — individual patient forms from their eChart (format unspecified, likely PDF or similar)
2. **Clinical Data Form Details** — a CSV listing every form for every patient with dates, times, signatures, and finalizing user name
3. **Data** — structured patient chart fields as CSV/Excel files covering: Allergies, Contact details, Diagnosis, Level of Care, Medications, Patient Communications, Patient Info, Insurance, Vitals "etc."
4. **Patients** — photos and uploaded documents

The screenshot in the PDF shows only 3 folders in the Azure blob container (Clinical Data Forms, Data, Patients), though the text describes 4. The "Clinical Data Form Details" folder is not visible in the screenshot.

Export format: CSV and Excel files for structured data; clinical forms and patient documents in their native format. This is a proprietary flat-file export — not database-native, not FHIR, not C-CDA.

### EHI Coverage Assessment

**Clinical data**: PRESENT but limited to what's described. The Data folder includes allergies, diagnoses, medications, vitals, and level of care. Clinical Data Forms include assessments, treatment plans, and progress notes from the eChart. However, there is no mention of: problem lists as a distinct entity, immunizations, procedures, lab results, family health history (despite (a)(12) certification), or social/psychological/behavioral data (despite (a)(15) certification). For a behavioral health EHR, the absence of outcome measurement data (PHQ-9, GAD-7 scores) and withdrawal management records from the export documentation is notable.

**Secure messages**: PARTIALLY PRESENT. "Patient Communications" is listed as a field in the Data folder, which suggests portal messages or communications are included. However, the documentation gives no detail on what this covers — it could be comprehensive messaging history or just communication preferences.

**Billing/financial**: NOT DOCUMENTED. Despite AZZLY Rize being a full RCM platform with integrated billing, claims submission, and payment processing, the export documentation makes no mention of billing data whatsoever. No charges, claims, payments, transactions, CPT codes, or financial records. This is a significant gap — the product clearly stores billing data, but the export appears to exclude it entirely.

**Insurance/coverage**: PRESENT. "Insurance" is listed as one of the data categories in the Data folder. No detail on what fields are included.

**Appointments/scheduling**: NOT DOCUMENTED. Despite the product having a full scheduling system with calendars, check-in, reminders, and attendance tracking, the export documentation does not mention appointment or scheduling data. This is a gap.

**Documents/images**: PRESENT. The Patients folder contains "photos and any uploaded documents." Clinical Data Forms contains forms from the eChart. No mention of scanned documents, faxes, or attachments beyond what's in these two categories.

**Audit trails**: NOT PRESENT. No mention of audit or access log data. This is expected — audit trails are generally excluded from the Designated Record Set.

### Issues & Red Flags

1. **Billing data completely absent from export**: AZZLY Rize is marketed as an all-in-one EHR + RCM platform. Billing, claims, and payment data are core product features. The EHI export documentation makes zero mention of any financial data. This is a major gap for a product that stores significant billing information.

2. **Scheduling data absent from export**: The product has a full appointment scheduling system, but no scheduling data appears in the export.

3. **Vendor-mediated process despite "self-service" claim**: The documentation states users can export "without developer assistance" but simultaneously requires an "Authorized User's Written Request" and depends on AZZLY providing a SAS URL. This is vendor-mediated in practice.

4. **Minimal documentation depth**: The entire EHI export documentation is 3 pages. There is no data dictionary, no field-level documentation, no schema definitions. The Data folder contents are described in a single sentence listing category names (Allergies, Diagnosis, etc.) with no detail about what fields each category contains. This makes it impossible to assess completeness from the documentation alone.

5. **"Etc." in data description**: The documentation describes the Data folder as containing "Allergies, Contact details, diagnosis, Level of Care, Medications, Patient Communications, Patient Info, Insurance, & vitals etc." — the trailing "etc." suggests additional categories may exist but are not documented. This is vague and unhelpful.

6. **No e-prescribing or PDMP data**: Despite EPCS and PDMP integration being key product features, prescription and controlled substance data are not explicitly mentioned in the export (though "Medications" may cover some of this).

7. **Specialty-specific data gaps**: Behavioral health-specific features like withdrawal management, bed board, outcome measurements, and telehealth session data are not mentioned in the export documentation.

8. **Document marked "CONFIDENTIAL"**: The PDF footer says "AZZLY CONFIDENTIAL" despite being publicly accessible. Minor but inconsistent with the public accessibility requirement.

9. **Documentation dated September 2023**: Last updated nearly 2.5 years ago. Product features may have changed without documentation updates.
