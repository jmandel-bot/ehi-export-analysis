# Clinisys, Inc. — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 9726, 9734, 10701, 11038, 11600
- **Products**: SQ Lab, Sunquest Laboratory
- **Developer**: Clinisys, Inc.
- **Registered URL**: https://www.clinisys.com/us/en/onc-disclosure/

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.clinisys.com/us/en/onc-disclosure/" \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36'
```
**Result**: HTTP/2 200 directly (no redirects). Content-Type: `text/html; charset=UTF-8`. Server: Cloudflare. WordPress site (PHPSESSID cookie, `wp-json` link header). No content-disposition — this is an HTML page, not a direct download.

### Step 2: Page examination
```bash
curl -sL "https://www.clinisys.com/us/en/onc-disclosure/" \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o /tmp/clinisys-page.html
wc -c /tmp/clinisys-page.html
```
**Result**: 114,775 bytes. Full HTML page (WordPress), not a SPA. Content is fully rendered server-side — no JavaScript required to see the content. The page title is "Costs and Disclosures".

### Step 3: Page structure
The page is a compliance/disclosure hub covering multiple products and certification criteria. Structure:

1. **Hero section**: "Costs and Disclosures"
2. **"Delivering accuracy and reliability"** — marketing intro about Sunquest Laboratory Platform
3. **Capability and Description** — general product description
4. **ONC Disclosure** — carousel/cards showing compliance criteria:
   - 170.315(b)(10) Electronic Health Information (EHI) Export
   - 170.315(d)(1) Authentication, Access Control, Authorization
   - 170.315(d)(2) Auditable Events and Tamper-Resistance
   - 170.315(d)(3) Audit Report(s)
5. **SQ Lab v2024** — certification info + compliance certificate link (no separate b(10) section)
6. **Sunquest Laboratory v7** — certification info + b(10) EHI Export section + other criteria
7. **Sunquest Laboratory v8** — same structure as v7
8. **Sunquest Laboratory v10** — same structure as v7
9. **Sunquest Laboratory v11** — same structure as v7
10. **Individual Patient Export Specification** — link to PDF
11. **Patient Population Export Specification** — link to PDF

Each Sunquest Laboratory version's b(10) section has identical text:
> "Supports patients' access to their electronic data as well as providing all the EHI from the Clinisys certified Health IT product for export to another health IT system."
> **Associated costs/fees:** The individual patient export is included as part of the core product associated with the Sunquest Laboratory User License. The patient population export requires the use of a results interface that could incur an additional license fee.

### Step 4: Finding the EHI export documentation
The actual EHI export specification documents are at the **very bottom** of the page content, just above the footer. They are presented as two cards with "View PDF" buttons:

1. **Individual Patient Export Specification** → `Patient-Data-Export-Specification.pdf`
2. **Patient Population Export Specification** → `Patient-Population-Export-Specification.pdf`

These are shared across all product versions (not duplicated per version).

Found via:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/clinisys-page.html
```

### Step 5: Identified downloadable assets

**EHI Export Documentation (core):**
- https://www.clinisys.com/app/uploads/2023/11/Patient-Data-Export-Specification.pdf
- https://www.clinisys.com/app/uploads/2023/11/Patient-Population-Export-Specification.pdf

**Compliance Certificates (supplementary):**
- https://www.clinisys.com/app/uploads/2025/09/Compliance-Certificate-SQ-Lab-v2024-022625.pdf
- https://www.clinisys.com/app/uploads/2024/06/Compliance-Certificate-Sunquest-Laboratory-v7-060324.pdf
- https://www.clinisys.com/app/uploads/2024/06/Compliance-Certificate-Sunquest-Laboratory-v8-060324.pdf
- https://www.clinisys.com/app/uploads/2024/06/Compliance-Certificate-Sunquest-Laboratory-10.0-060324.pdf
- https://www.clinisys.com/app/uploads/2024/06/Compliance-Certificate-Sunquest-Laboratory-v11-060324.pdf

## Downloads

### Patient-Data-Export-Specification.pdf (85 KB, 5 pages)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o downloads/Patient-Data-Export-Specification.pdf \
  'https://www.clinisys.com/app/uploads/2023/11/Patient-Data-Export-Specification.pdf'
```
Verified: `PDF document, version 1.7, 5 page(s)` (87,155 bytes)
Saved to: `downloads/Patient-Data-Export-Specification.pdf`

### Patient-Population-Export-Specification.pdf (329 KB, 14 pages)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o downloads/Patient-Population-Export-Specification.pdf \
  'https://www.clinisys.com/app/uploads/2023/11/Patient-Population-Export-Specification.pdf'
```
Verified: `PDF document, version 1.7, 14 page(s)` (337,133 bytes)
Saved to: `downloads/Patient-Population-Export-Specification.pdf`

### Compliance-Certificate-SQ-Lab-v2024.pdf (260 KB, 1 page)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o downloads/Compliance-Certificate-SQ-Lab-v2024.pdf \
  'https://www.clinisys.com/app/uploads/2025/09/Compliance-Certificate-SQ-Lab-v2024-022625.pdf'
```
Verified: `PDF document, version 1.7, 1 page(s)` (265,743 bytes)

### Compliance-Certificate-Sunquest-Laboratory-v7.pdf (260 KB, 1 page)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o downloads/Compliance-Certificate-Sunquest-Laboratory-v7.pdf \
  'https://www.clinisys.com/app/uploads/2024/06/Compliance-Certificate-Sunquest-Laboratory-v7-060324.pdf'
```
Verified: `PDF document, version 1.7, 1 page(s)` (265,803 bytes)

### Compliance-Certificate-Sunquest-Laboratory-v8.pdf (260 KB, 1 page)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o downloads/Compliance-Certificate-Sunquest-Laboratory-v8.pdf \
  'https://www.clinisys.com/app/uploads/2024/06/Compliance-Certificate-Sunquest-Laboratory-v8-060324.pdf'
```
Verified: `PDF document, version 1.7, 1 page(s)` (265,809 bytes)

### Compliance-Certificate-Sunquest-Laboratory-v10.pdf (260 KB, 1 page)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o downloads/Compliance-Certificate-Sunquest-Laboratory-v10.pdf \
  'https://www.clinisys.com/app/uploads/2024/06/Compliance-Certificate-Sunquest-Laboratory-10.0-060324.pdf'
```
Verified: `PDF document, version 1.7, 1 page(s)` (265,812 bytes)

### Compliance-Certificate-Sunquest-Laboratory-v11.pdf (260 KB, 1 page)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o downloads/Compliance-Certificate-Sunquest-Laboratory-v11.pdf \
  'https://www.clinisys.com/app/uploads/2024/06/Compliance-Certificate-Sunquest-Laboratory-v11-060324.pdf'
```
Verified: `PDF document, version 1.7, 1 page(s)` (265,827 bytes)

## Obstacles & Notes

- **No anti-bot protection encountered.** Cloudflare was transparent; no challenges or CAPTCHAs. Standard User-Agent header was sufficient.
- **No JavaScript required.** The page is server-rendered WordPress. All content and links are present in the HTML source. `curl` works fine.
- **Page is a multi-product compliance hub.** The EHI export specifications are shared across all product versions and placed at the bottom of the page, below the per-version sections. You have to scroll past all the version-specific compliance info to find them.
- **No login wall.** All content is publicly accessible.
- **Documentation is minimal.** The Individual Patient Export Spec is only 5 pages. The Population Export Spec is 14 pages but is mostly an HL7 interface configuration/signoff template, not a data dictionary.
- **Clinisys is a laboratory information system (LIS) vendor**, not a full EHR. The scope of EHI is limited to laboratory data: orders, accessions, test results, specimen info, blood bank data, and basic patient demographics. This is expected given the product domain.
- **The uploads directory timestamp is `2023/11`**, suggesting these specs were created in November 2023 (version 1.0 per the Individual Export Spec changelog).
