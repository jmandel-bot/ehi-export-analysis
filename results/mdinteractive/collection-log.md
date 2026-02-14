# MDinteractive — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10691
- Registered URL: https://mdinteractive.com/ecqm
- Developer: MDinteractive
- Product: MDinteractive v6
- Certification Date: 2021-09-24

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://mdinteractive.com/ecqm" -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```

Result: HTTP/2 200 directly. No redirects. Content-Type: `text/html; charset=UTF-8`. Server: nginx. The page is a Drupal 10 site hosted on Pantheon. Content-Length: 47,745 bytes. Last-Modified: Sat, 14 Feb 2026.

### Step 2: Page examination

```bash
curl -sL "https://mdinteractive.com/ecqm" -H 'User-Agent: Mozilla/5.0' -o /tmp/mdinteractive-page.html
wc -c /tmp/mdinteractive-page.html
```

Result: 47,745 bytes. The page is a standard Drupal HTML page (not a SPA). It renders as a "Transparency Disclosures" page containing certified product information, Real World Testing plans/results links, and an EHI Export documentation link.

The page title is "Transparency Disclosures | MDinteractive." It is a straightforward compliance/disclosure page with all content visible in the HTML source — no accordion sections, no JavaScript-only content, no SPA rendering needed.

### Step 3: Finding the EHI section

The page contains the certification information table (product name, version, certificate number, certification date, certified criteria, CQMs) followed by a list of downloadable PDFs. The EHI export link is the last item on the page, labeled "Electronic Health Information (EHI) Export."

Search for downloadable files:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/mdinteractive-page.html
```

Result — 8 PDF links found:
1. Real-World-Testing-Plan-for-MDinteractive.pdf (2021 plan)
2. Real World Testing Results for MDinteractive 2022.pdf
3. Real-World-Testing-Plan-for-MDinteractive-2023.pdf
4. Real-World-Testing-Results-for-MDinteractive-2023.pdf
5. Real-World-Testing-Plan-for-MDinteractive-2024.pdf
6. Real-World-Testing-Results-for-MDinteractive-2024.pdf
7. Real-World-Testing-Plan-for-MDinteractive-2025.pdf
8. **Electronic-Health-Information-Export.pdf** ← This is the EHI export documentation

The EHI link was found via:
```bash
grep -oiE 'href="[^"]*"' /tmp/mdinteractive-page.html | grep -iE 'ehi|export|data.dictionary|b.10'
```
Result: `href="/sites/default/files/uploaded/file/CMS2022/Electronic-Health-Information-Export.pdf"`

### Step 4: Identified downloadable assets

Only one EHI-relevant file:
- **Electronic-Health-Information-Export.pdf** at `/sites/default/files/uploaded/file/CMS2022/Electronic-Health-Information-Export.pdf`
  Full URL: `https://mdinteractive.com/sites/default/files/uploaded/file/CMS2022/Electronic-Health-Information-Export.pdf`

## Downloads

### Electronic-Health-Information-Export.pdf (54,095 bytes / ~53 KB)

```bash
curl -L -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' \
  -o downloads/Electronic-Health-Information-Export.pdf \
  'https://mdinteractive.com/sites/default/files/uploaded/file/CMS2022/Electronic-Health-Information-Export.pdf'
```

Verified: `file downloads/Electronic-Health-Information-Export.pdf` → `PDF document, version 1.4, 2 page(s)`
Size: 54,095 bytes
Pages: 2
Saved to: downloads/Electronic-Health-Information-Export.pdf

## Obstacles & Notes

- No obstacles encountered. The page is standard HTML, no JavaScript rendering required, no anti-bot protection, no login wall.
- The registered URL (https://mdinteractive.com/ecqm) is the transparency disclosures page, not a direct link to the EHI documentation. The EHI PDF link is one click from this page.
- The PDF is stored in a `/CMS2022/` directory, suggesting it was created for the 2022 compliance cycle and has not been updated since (document dated November 15, 2022).
- The documentation is extremely brief — only 2 pages, with page 1 being a cover page and page 2 containing the actual content.

---

## Product: MDinteractive

### Product Context

MDinteractive is **not a full EHR**. It is a **CMS Qualified Registry and MIPS quality reporting platform**. It has been a CMS Qualified Registry since 2010 and describes itself as "the MIPS extension of your EHR" — a complement to an existing EHR, not a replacement.

The product helps healthcare providers report quality measure data to CMS for programs like MIPS (Merit-based Incentive Payment System), ACO/APM Performance Pathway (APP), Primary Care First (PCF), and Making Care Primary (MCP).

**Key capabilities:**
- MIPS quality measure tracking and submission to CMS
- Promoting Interoperability attestation
- Improvement Activities attestation
- ACO/APM registry reporting
- Clinical Data Registry (accepts QRDA Cat I/III files from EHRs)
- MIPS eligibility checking
- Benchmark comparisons and score estimation

**What it does NOT have:**
- No patient portal
- No billing/revenue cycle management
- No appointment scheduling
- No clinical documentation (notes, orders, prescriptions)
- No document management
- No messaging/communication
- No clinical decision support

**Data ingestion methods:** (1) manual patient-by-patient data entry, (2) Excel template upload, (3) QRDA III file upload from a certified EHR.

The certification profile confirms this narrow scope: certified only for (b)(10) EHI export, (c)(1)-(c)(4) clinical quality measures, (d) security/privacy, and (g)(4)-(g)(5) quality management. It has **none** of the (a) clinical criteria, no (e)(1) patient portal, and no (f) public health criteria.

**Pricing:** $389–$499/clinician/year for MIPS reporting; $199/clinician/year for Clinical Data Registry.

**Users:** All specialties (47+ listed), from individual clinicians to large medical groups and ACOs.

### Export Approach

The export produces a single **Excel file** containing all patient data stored in the system. The export supports both single-patient and bulk (all patients) export.

The exported Excel file contains exactly 13 fields organized in three sections:

**Provider information (4 fields):** Provider Last Name, Provider First Name, Individual NPI, TIN

**Patient demographics (6 fields):** Last Name, First Name, MI, DOB, Gender, MRN

**Quality action fields (3 fields):** Visit/procedure/surgery date, Numerator action, Denominator — all based on MIPS CQM specifications.

This is a **native database export** in the sense that it exports all data the system actually stores. The export format (Excel) is appropriate given the extremely small and flat data model. There is no need for database table dumps, FHIR resources, or C-CDA documents because the system's entire data model fits in a single spreadsheet.

### EHI Coverage Assessment

Because MDinteractive is a quality reporting registry and not an EHR, the standard 7-category EHI assessment must be interpreted in context. The product simply does not store most categories of health information.

**Clinical:** Partially present. The export includes visit/procedure dates and quality measure numerator/denominator flags, which are derived from clinical data but are not clinical data themselves. No diagnoses, medications, allergies, vitals, labs, immunizations, procedures, notes, or any other standard clinical data is stored or exported.

**Secure messages:** Not applicable. The product has no patient portal or messaging capability.

**Billing/financial:** Not applicable. The product does not process claims or billing. It tracks quality performance which affects MIPS payment adjustments, but does not store actual billing/financial data.

**Insurance/coverage:** Not applicable. The product does not store insurance or coverage data.

**Appointments/scheduling:** Not applicable. The product stores visit dates as part of quality measure data, but has no scheduling functionality.

**Documents/images:** Not applicable. The product accepts QRDA files for data ingestion but does not store clinical documents or images as patient records.

**Audit trails:** Not documented in the export. The product likely logs user access internally, but the EHI export documentation does not mention audit data.

### Issues & Red Flags

1. **Extremely minimal documentation** — The entire EHI export specification is 1 page of content (plus a cover page). While this is proportionate to the product's minimal data model, there is no detail about data types, value formats, or how the export is triggered.

2. **No audit trail in export** — Even a minimal system should export access logs if it stores them. The documentation does not address whether audit data is included.

3. **Excel as export format** — While acceptable for this small dataset, Excel has limitations for machine readability compared to CSV or JSON. However, for 13 fields this is a minor concern.

4. **Documentation dated 2022** — The document version is 1.0, last updated November 15, 2022. It has not been updated in over 3 years, though the product's data model is unlikely to have changed significantly.

5. **Quality measure specification references are outdated** — The PDF links to `https://mdinteractive.com/2022-mips-quality-measures` for CQM specifications, which are the 2022 measures. CMS updates quality measures annually.
