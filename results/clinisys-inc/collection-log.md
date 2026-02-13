# Clinisys, Inc. — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 9726, 9734, 10701, 11038, 11600
- Products: SQ Lab, Sunquest Laboratory (v7, v8, v10, v11, v2024)
- Registered URL: https://www.clinisys.com/us/en/onc-disclosure/

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.clinisys.com/us/en/onc-disclosure/" \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36'
```
- HTTP/2 200 — direct success, no redirects
- Content-Type: text/html; charset=UTF-8
- Server: Cloudflare (cf-ray header present)
- WordPress site (detected via `link: <https://www.clinisys.com/wp-json/>` header and `PHPSESSID` cookie)
- Last-Modified: Wed, 17 Sep 2025 18:40:02 GMT
- Kinsta hosting (ki-cache-type, ki-edge headers)

### Step 2: Page examination
```bash
curl -sL "https://www.clinisys.com/us/en/onc-disclosure/" \
  -H 'User-Agent: Mozilla/5.0' -o /tmp/clinisys-page.html
wc -c /tmp/clinisys-page.html
```
- Page size: 114,775 bytes
- Static HTML rendered by WordPress — not a SPA. Content fully present in the HTML source.
- Page title: "ONC Disclosure - Clinisys"
- Cookie consent banner (OneTrust) overlays but does not block content access

### Step 3: Finding the EHI section
The page is a long-form "Costs and Disclosures" compliance page. Structure:
1. **Header section** — "Delivering accuracy and reliability" with a description of the Sunquest Laboratory Platform
2. **ONC Disclosure section** — States "Sunquest Laboratory™ v7, v8, v10 and v11 are certified health IT modules" with ONC Certified HealthIT and Drummond logos
3. **Product sections** — Individual sections for each certified version (SQ Lab v2024, Sunquest Laboratory v7, v8, v10, v11), each showing:
   - Product name, developer name, certification date, unique certification number
   - Link to compliance certificate PDF
   - Horizontally-scrolling cards for certification criteria including 170.315(b)(10), (d)(1), (d)(2), (d)(3), (d)(7), (f)(3)
4. **v7-v11 ONC Compliance certificates** — Links to individual compliance certificate PDFs
5. **Export specification links** — At the bottom of the page, two cards:
   - "Individual Patient Export Specification" → View PDF
   - "Patient Population Export Specification" → View PDF

The EHI export information was visible by scrolling down; no accordions or expanding sections were needed. The b(10) description reads: "Supports patients' access to their electronic data as well as providing all the EHI from the Clinisys certified Health IT product for export to another health IT system."

Associated costs note: "The individual patient export is included as part of the core product associated with the Sunquest Laboratory User License. The patient population export requires the use of a results interface that could incur an additional license fee."

### Step 4: Identified downloadable assets
From grep of page HTML:
```
href="https://www.clinisys.com/app/uploads/2023/11/Patient-Data-Export-Specification.pdf"
href="https://www.clinisys.com/app/uploads/2023/11/Patient-Population-Export-Specification.pdf"
href="https://www.clinisys.com/app/uploads/2025/09/Compliance-Certificate-SQ-Lab-v2024-022625.pdf"
href="https://www.clinisys.com/app/uploads/2024/06/Compliance-Certificate-Sunquest-Laboratory-v7-060324.pdf"
href="https://www.clinisys.com/app/uploads/2024/06/Compliance-Certificate-Sunquest-Laboratory-v8-060324.pdf"
href="https://www.clinisys.com/app/uploads/2024/06/Compliance-Certificate-Sunquest-Laboratory-10.0-060324.pdf"
href="https://www.clinisys.com/app/uploads/2024/06/Compliance-Certificate-Sunquest-Laboratory-v11-060324.pdf"
```

Only the first two are EHI export documentation; the remaining five are compliance certificates (not downloaded as they don't contain EHI export details).

## Downloads

### Patient-Data-Export-Specification.pdf (85 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36' \
  -o downloads/Patient-Data-Export-Specification.pdf \
  'https://www.clinisys.com/app/uploads/2023/11/Patient-Data-Export-Specification.pdf'
```
Verified: `file` → PDF document, version 1.7, 5 pages
Size: 87,155 bytes
Saved to: downloads/Patient-Data-Export-Specification.pdf

Content: Defines the pipe-delimited flat file format for individual patient data export. Covers record types 0–66 across patient demographics, blood bank data, lab ordering data, accession data, order codes, test components, blood bank reactions, historical results, and susceptibility data. Version 1.0, authored by J. Bradshaw, November 2023.

### Patient-Population-Export-Specification.pdf (329 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36' \
  -o downloads/Patient-Population-Export-Specification.pdf \
  'https://www.clinisys.com/app/uploads/2023/11/Patient-Population-Export-Specification.pdf'
```
Verified: `file` → PDF document, version 1.7, 14 pages
Size: 337,133 bytes
Saved to: downloads/Patient-Population-Export-Specification.pdf

Content: HL7 v2.3/v2.5.1-based interface specification for population-level historical lab data export. This is an interface configuration document — it describes how to set up a TCP/IP connection to send historical lab results as HL7 messages from SQ Lab to an external system. It includes CPU hardware setup, SAM configuration, date range selection, and signoff procedures. Most of the document is a fill-in-the-blank implementation worksheet, not a data dictionary.

## Product Context

Clinisys (formerly Sunquest Information Systems, Inc.) is a **laboratory information system (LIS)** vendor — not an EHR. Their product portfolio is entirely lab-focused:

- **Clinisys SQ Lab** — the core certified LIS, managing clinical lab workflows, specimen tracking, result reporting
- **Clinisys SQ Blood Bank** — blood bank management module
- **Clinisys PowerPath / CoPathPlus** — anatomic pathology
- **Clinisys Orchard Enterprise/Harvest** — additional LIS products (from Orchard Software acquisition)
- **Clinisys Atlas** — middleware for lab instrument integration
- **Clinisys Laboratory Solution (CLS)** — newer cloud-based LIMS/LIS for scientific and healthcare labs

The product **does NOT include**: patient portal, billing/revenue cycle management, appointment scheduling, clinical documentation, medication management, or any full-EHR functionality. SQ Lab integrates with external HIS/EHR systems via HL7 interfaces. It is a departmental system for the clinical laboratory.

This means the scope of "all EHI that can be stored by the product" is legitimately narrower than a full EHR — it's primarily lab orders, lab results, blood bank data, and patient demographics (as stored in the LIS context). The absence of billing, messaging, scheduling, etc. is not a gap in the export — the product genuinely doesn't store that data.

## Obstacles & Notes

- **No anti-bot issues.** The page loaded cleanly via curl and in the browser. Cloudflare was present but did not challenge.
- **Cookie consent overlay** (OneTrust) appears in the browser but doesn't block content access.
- **PDF upload dates are 2023-11** for both specs, suggesting these were created when the b(10) requirement took effect. The page was last modified September 2025 (to add SQ Lab v2024 certification).
- **Population export costs extra.** The page notes: "The patient population export requires the use of a results interface that could incur an additional license fee." This is a potential compliance concern — additional fees for exporting all EHI.
- **Population export is an HL7 interface, not a file export.** The specification describes sending HL7 messages over TCP/IP to an external system, not generating a downloadable file. This requires infrastructure setup (VPN tunnel, TCP/IP ports, receiving system) and is operationally very different from a simple file export.
