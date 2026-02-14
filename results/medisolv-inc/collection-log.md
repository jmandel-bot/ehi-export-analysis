# Medisolv, Inc. — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10137
- Registered URL: https://medisolv.com/certifications
- Developer: Medisolv, Inc.
- Product: ENCOR-e Version 6

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://medisolv.com/certifications" -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```
**Result:** HTTP/2 200. No redirects. Content-Type: text/html; charset=UTF-8. Page is hosted on HubSpot (x-hs-hub-id: 491484) behind Cloudflare. Last modified Thu, 12 Feb 2026 17:24:03 GMT.

### Step 2: Page examination
```bash
curl -sL "https://medisolv.com/certifications" -H 'User-Agent: Mozilla/5.0' -o /tmp/medisolv-page.html
wc -c /tmp/medisolv-page.html
```
**Result:** 153,850 bytes. Static HTML page (HubSpot CMS), content is present in the HTML — not a SPA. The page is the Medisolv certifications page containing compliance certificates, real-world testing plans/results, and an EHI export link.

### Step 3: Finding the EHI section
Searched for downloadable files and EHI-related links:
```bash
grep -oiE 'href="[^"]*"' /tmp/medisolv-page.html | grep -iE 'ehi|export|data.dictionary|b.10'
```
**Result:** Found link `href="/ehiexport?hsLang=en"` with anchor text "EHI Export Format: 170.315(b)(10)". This link appears at the bottom of the certifications page, after the Real World Testing Plans/Results section. No accordion or hidden content — it's a simple list item.

The certifications page also contains these PDF links (not EHI-specific):
- Compliance Certificate ENCOR-e Version 6 (PDF)
- Mandatory Disclosures - Costs and Technologies (PDF)
- Transparency Attestation (PDF)
- Real World Testing Plans 2022-2025 (PDFs)
- Real World Testing Results 2022-2024 (PDFs)

### Step 4: Navigating to the EHI export page
```bash
curl -sI -L "https://medisolv.com/ehiexport" -H 'User-Agent: Mozilla/5.0'
```
**Result:** HTTP/2 200. Direct page load, no redirects. Another HubSpot-hosted page.

```bash
curl -sL "https://medisolv.com/ehiexport" -H 'User-Agent: Mozilla/5.0' -o /tmp/medisolv-ehi.html
wc -c /tmp/medisolv-ehi.html
```
**Result:** 152,097 bytes. Static HTML page.

### Step 5: Examining the EHI export page content
Extracted visible text from the page. The EHI export page contains:

**Title:** "ENCOR-e Electronic Health Information Export – 170.315(b)(10)"

**Key content:**
> "Medisolv is compliant with 170.315(b)(10) via the use of QRDA-I electronic documents. QRDA-I is an electronic file format which uses XML to store structured patient data. This document outlines how to use the ENCOR-e system to export full patient records compliant with 170.315(b)(10)."

**QRDA-I specification link:**
> "The full documentation of the QRDA-I format is available from the following location: https://www.hl7.org/documentcenter/public/standards/dstu/CDAR2_IG_QRDA_I_R1_STU5.3_2021NOV_2022DEC_with_errata.zip"

**Single Patient Export:**
> "A single patient export can be achieved by using the ENCOR-e application and navigating to the patient detail page for the patient you want to export, see the screenshot below. A full patient export can be achieved by using the green 'QRDA Export (Full Record)' button shown in this screenshot."
>
> (Screenshot shows the ENCOR-e patient detail page with a "QRDA Export (Full Record)" button)

**Full System Export:**
> "To achieve a complete export of all patients, there are two options. From the user interface, a user of ENCOR-e can go to each patient record and perform the functionality of the Single Patient Export, as explained above; however, because this can be very time-consuming for systems with many patients, Medisolv also offers an automated option that can be performed upon request. Any user of ENCOR-e may contact their assigned Medisolv Clinical Quality Advisor and request that Medisolv perform a full export of all patients; upon reception of this request, Medisolv will initiate the process for exporting all patient records in the QRDA-I format, and will deliver the output to the client via a secure file transfer mechanism (the mechanism may vary based on the size of the final data output, secure E-Mail and SFTP are both natively available)."

### Step 6: Identified downloadable assets
The only downloadable file linked from the EHI export page is the QRDA-I specification from HL7:
- `https://www.hl7.org/documentcenter/public/standards/dstu/CDAR2_IG_QRDA_I_R1_STU5.3_2021NOV_2022DEC_with_errata.zip`

There is NO vendor-specific data dictionary, no proprietary export schema documentation, and no sample export files. The vendor defers entirely to the QRDA-I standard specification for documentation of the export format.

## Downloads

### medisolv-ehi-export-page.html (152 KB)
```bash
curl -sL "https://medisolv.com/ehiexport" -H 'User-Agent: Mozilla/5.0' -o medisolv-ehi-export-page.html
```
Saved the full EHI export page for archival. Content verified via text extraction.

### medisolv-ehi-export-page-screenshot.png (583 KB)
Full-page screenshot taken via browser automation of the EHI export page at https://medisolv.com/ehiexport. Shows the page layout including the embedded screenshot of the ENCOR-e patient detail interface with the QRDA Export button.

## Obstacles & Notes
- No anti-bot issues. HubSpot pages served cleanly via curl.
- No accordion navigation needed — the EHI link is a simple list item on the certifications page.
- The documentation is remarkably thin: a single web page with a few paragraphs of text and a link to the QRDA-I standard. No vendor-specific data dictionary, field definitions, or export schema.
- Full system export requires contacting Medisolv's Clinical Quality Advisor — not fully self-service.
- No downloadable vendor-specific documentation artifacts (no PDF data dictionary, no ZIP with schema).

---

## Product: ENCOR-e

### Product Context

ENCOR-e is **NOT a full Electronic Health Record (EHR)**. It is a specialized **clinical quality measure (eCQM) reporting and quality management platform**. Medisolv describes it as "Electronic Measures software designed to assist hospitals and clinicians in monitoring, improving and reporting their eCQMs to CMS and other regulatory bodies."

ENCOR-e is a secondary/downstream system that:
1. **Ingests** clinical data from a customer's primary EHR (Epic, Cerner, MEDITECH, Allscripts, etc.) via nightly incremental data loads
2. **Computes** quality measures against the ingested data
3. **Reports** results to CMS, The Joint Commission, and other regulatory bodies
4. **Provides** dashboards for quality performance monitoring

The CHPL certification profile confirms this narrow scope: it is certified only for (b)(10) EHI export, (c)(1)-(c)(3) clinical quality measures, and security/privacy criteria (d-series). It has **no certifications** for:
- Clinical data capture (a)(1)-(a)(14) — no CPOE, no demographics entry, no vitals, no problem lists
- Patient portal (e)(1) — no patient-facing features
- Public health reporting (f)(1)-(f)(7)
- FHIR APIs (g)(7)-(g)(10)

The data ENCOR-e stores is limited to **quality-measure-relevant clinical data elements** extracted from the upstream EHR: patient demographics, encounter data, diagnoses, procedures, medications, lab results — specifically the data elements needed to evaluate ~500+ quality measures. It does NOT store billing data, insurance information, patient messages, scheduling data, scanned documents, or audit trails.

The broader Medisolv product suite includes ENCOR modules for hospital and clinician measures (both electronic and abstracted), ACO reporting, and the QualityIQ performance analytics dashboard. None of these add clinical, billing, or administrative data beyond what's needed for quality reporting.

**Product URL:** https://medisolv.com/products/encor-quality-reporting-software/

### Export Approach

ENCOR-e exports EHI as **QRDA-I (Quality Reporting Document Architecture - Category I)** XML documents. QRDA-I is an HL7 CDA R2 standard designed specifically for quality measure reporting. Each QRDA-I document contains:
- Patient demographics
- Clinical data elements relevant to quality measures
- Coded diagnoses, procedures, medications, lab results
- Encounter information (dates, types)

This is a **standard-format export** — not a native database dump. The vendor provides no proprietary data dictionary; they point to the HL7 QRDA-I specification as the format documentation.

**Export mechanism:**
- Single patient: UI button ("QRDA Export (Full Record)") on the patient detail page
- Bulk export: Must contact Medisolv Clinical Quality Advisor, who initiates the process and delivers via secure email or SFTP

### EHI Coverage Assessment

Given that ENCOR-e is a quality reporting tool (not a full EHR), the EHI it stores is inherently limited to quality-measure-relevant clinical data. The QRDA-I export format further constrains what can be exported.

**Clinical:** Present, but limited to quality measure data elements. QRDA-I contains diagnoses, procedures, medications, lab results, and encounter information — but only the subset relevant to eCQM computation. This is not a comprehensive clinical record.

**Secure messages:** Not applicable. ENCOR-e has no messaging or patient portal functionality. It does not store any patient-provider communications.

**Billing/financial:** Not present. ENCOR-e does not store billing, claims, charges, or financial data. This is not a gap per se — the product simply doesn't manage billing data.

**Insurance/coverage:** Not present. ENCOR-e does not store insurance or coverage information.

**Appointments/scheduling:** Not present. ENCOR-e does not store scheduling data.

**Documents/images:** Not present. ENCOR-e does not store scanned documents, images, or attachments.

**Audit:** Not addressed in the export documentation. ENCOR-e is certified for (d)(2) auditable events and (d)(3) audit reports, so it does maintain audit logs, but these are not mentioned as part of the EHI export. (Audit trails are generally excluded from the HIPAA Designated Record Set, so this is not a gap.)

### Issues & Red Flags

1. **QRDA-I is a quality reporting format, not a comprehensive EHI export format.** While QRDA-I is well-structured XML, it was designed for quality measure reporting, not for exporting all patient data. It captures a limited subset of clinical data elements relevant to eCQMs.

2. **No vendor-specific data dictionary.** The only format documentation provided is a link to the HL7 QRDA-I standard specification. There is no vendor-specific mapping showing what ENCOR-e data fields map to which QRDA-I elements, or what data may be lost in the export.

3. **Full system export is not self-service.** Users must contact a Medisolv Clinical Quality Advisor to request a bulk export. This creates a dependency on vendor availability and responsiveness.

4. **Documentation is minimal.** The entire EHI export documentation is a single web page with a few paragraphs. There is no data dictionary, no field-level documentation, no sample files, and no detailed technical specification beyond pointing to the QRDA-I standard.

5. **The product's narrow scope limits the significance of EHI gaps.** Since ENCOR-e is a quality reporting tool (not a full EHR), the absence of billing, messaging, scheduling, and document data is expected — the product simply doesn't store that data. The EHI export covers what the product stores, but what the product stores is a small subset of all EHI. The export is likely complete relative to the product's scope, but the product's scope is narrow.
