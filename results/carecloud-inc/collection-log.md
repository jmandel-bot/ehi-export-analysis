# CareCloud, Inc. — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 8830, 9546, 10771, 11108, 11121, 11202
- **Products**: CareVue, ChartLogic EHR, ChartLogic EHR Classic, ChartLogic Patient Portal, PCG, Wellsoft EDIS
- **Developer**: CareCloud, Inc.
- **Registered URL**: https://www.medsphere.com/certifications/

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.medsphere.com/certifications/" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP/2 200. Direct hit, no redirects. WordPress site on WP Engine behind Cloudflare.
- Content-Type: text/html; charset=UTF-8
- Server: cloudflare
- x-powered-by: WP Engine
- Page last modified: 2026-01-09 (per JSON-LD structured data)

### Step 2: Page examination

```bash
curl -sL "https://www.medsphere.com/certifications/" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html  # 111,500 bytes
```

The page is a static WordPress page (no SPA) with real HTML content. Title: "Certifications | Medsphere". The page has a tab navigation bar at the top with sections: **CareVue**, **ChartLogic**, **Wellsoft**, **Micro-Office Systems**.

All content is in the HTML source — no JavaScript rendering needed. The tabs are implemented as anchor links to sections within the same page (not separate routes).

### Step 3: Finding the EHI sections

Searched the page HTML for documentation links:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html
grep -oiE 'href="[^"]*[^"]*"' /tmp/page.html | grep -iE 'ehi|export|data.dictionary|b.10'
```

Found 4 EHI-specific links:
1. `https://msc-ehi-export.medsphere.com/EHI_EXPORT.txt` — "view the EHI Export XSD file format" (CareVue)
2. `https://msc-ehi-export.medsphere.com/EHI_EXPORT.zip` — "download the EHI Export XSD file" (CareVue)
3. `https://msc-ehi-export.medsphere.com/DD_FILTERED.html` — "view the data dictionary" (CareVue)
4. `https://go.chartlogic.com/l/76372/2023-11-21/clp3t8/76372/1700602435OhJooh0K/EHI_export_with_descriptions.xlsx` — "view the data dictionary" (Wellsoft)

Also found a costs disclosure PDF:
- `http://www.medsphere.com/wp-content/uploads/2024/07/Additional-Costs-and-Disclosures-of-Certified-Health-IT-2.pdf`

### Step 4: Product-by-product EHI documentation found on the page

The page covers 6 certified products under CareCloud, Inc. Each has its own EHI Export Documentation section:

#### CareVue (v2.1, CHPL 11121)
- **Export format**: XML files, one per patient
- **File naming**: First 10 chars of last name + MRN, .xml extension
- **Documentation**: Dedicated subdomain at `msc-ehi-export.medsphere.com` with:
  - XSD schema file (viewable as text and downloadable as ZIP)
  - Data dictionary (DD_FILTERED.html) — a 4.3 MB HTML file documenting 143 VistA files with 5,553 field definitions
- This is a VistA-based system (OpenVista CareVue) — the data dictionary uses VistA file numbers (File 2 = PATIENT, etc.)

#### ChartLogic EHR V1 (v1, CHPL 10771)
- **Export format**: C-CDA (Consolidated Clinical Document Architecture) + scanned docs as PDFs
- **Documentation**: Prose description only on the page. References HL7 C-CDA spec links.
- No vendor-specific data dictionary provided.

#### ChartLogic EHR Classic (v9, CHPL 11108)
- **Export format**: C-CDA + scanned docs as PDFs
- **Documentation**: Same prose as ChartLogic EHR V1. References HL7 C-CDA spec links.
- No vendor-specific data dictionary provided.

#### ChartLogic Patient Portal (v9, CHPL 8830)
- **Export format**: C-CDA only
- **Documentation**: Brief prose description. References HL7 C-CDA spec links.
- No vendor-specific data dictionary provided.

#### Wellsoft EDIS (v11, CHPL 9546)
- **Export format**: CCDA or CSV
- **Documentation**: Prose description, plus a "view the data dictionary" link for the CSV format.
- The data dictionary link points to a Pardot tracking URL: `https://go.chartlogic.com/l/76372/2023-11-21/clp3t8/76372/1700602435OhJooh0K/EHI_export_with_descriptions.xlsx`
- **⚠️ THIS LINK IS DEAD** — returns "This content isn't available. Contact the owner of this site for help." (Pardot/Salesforce tracking link expired)

#### PCG (v3.5, CHPL 11202)
- **Export format**: C-CDA (single patient via UI, bulk export via email to support@micro-officesystems.com)
- **Documentation**: Prose description with UI workflow instructions.
- No vendor-specific data dictionary provided.
- Bulk export requires contacting support — not self-service.

### Step 5: Dedicated CareVue EHI subdomain

Explored the msc-ehi-export.medsphere.com subdomain:

```bash
curl -sL 'https://msc-ehi-export.medsphere.com/' -H 'User-Agent: Mozilla/5.0'
```

This is an S3-hosted static site (via CloudFront) with:
- index.html — landing page titled "Medsphere CareVue EHI Export - 170.315(b)(10)"
- EHI_EXPORT.txt — the XSD schema rendered as text
- EHI_EXPORT.zip — the XSD file in a ZIP
- DD_FILTERED.html — the full data dictionary

The subdomain has the same 3 files linked from the main certifications page. No additional files found.

### Step 6: Attempting to recover dead ChartLogic/Wellsoft data dictionary

The Pardot-hosted xlsx was the data dictionary for Wellsoft's CSV export format.

**Tried**:
1. Direct curl with redirect following — returns 72 bytes of error text
2. Browser navigation — confirms "This content isn't available"
3. Wayback Machine CDX search for `go.chartlogic.com/*EHI*` — no captures of this specific Pardot tracking URL
4. Wayback Machine for the xlsx via direct URL — returns the same error (Pardot serves error, Wayback captured the error)

The xlsx was never archived. It is unrecoverable.

## Downloads

### carevue-EHI_EXPORT.txt (6,899 bytes)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o carevue-EHI_EXPORT.txt 'https://msc-ehi-export.medsphere.com/EHI_EXPORT.txt'
```
Verified: XML 1.0 document, ASCII text. This is the XSD schema defining the CareVue XML export format.

### carevue-EHI_EXPORT.zip (1,174 bytes)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o carevue-EHI_EXPORT.zip 'https://msc-ehi-export.medsphere.com/EHI_EXPORT.zip'
```
Verified: Zip archive data. Contains 1 file: `EHI_EXPORT.xsd` (6,899 bytes, dated 2023-09-14).
Extracted to: `downloads/extracted/carevue-xsd/EHI_EXPORT.xsd`

### carevue-DD_FILTERED.html (4,433,117 bytes / 4.3 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o carevue-DD_FILTERED.html 'https://msc-ehi-export.medsphere.com/DD_FILTERED.html'
```
Verified: HTML document, ASCII text. VistA data dictionary with 143 file definitions and 5,553 field entries.

### carevue-ehi-export-index.html (2,139 bytes)
```bash
curl -sL 'https://msc-ehi-export.medsphere.com/' -H 'User-Agent: Mozilla/5.0' -o carevue-ehi-export-index.html
```
Verified: HTML document. The landing page of the CareVue EHI export subdomain.

### chartlogic-EHI_export_with_descriptions.xlsx (72 bytes — DEAD LINK)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o chartlogic-EHI_export_with_descriptions.xlsx 'https://go.chartlogic.com/l/76372/2023-11-21/clp3t8/76372/1700602435OhJooh0K/EHI_export_with_descriptions.xlsx'
```
Verified: Unicode text (error message). Content: "This content isn't available. Contact the owner of this site for help." Pardot tracking link expired.

### certifications-page.html (111,500 bytes)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o certifications-page.html 'https://www.medsphere.com/certifications/'
```
Verified: HTML/JavaScript source. The full certifications page with all product sections.

### Additional-Costs-and-Disclosures.pdf (171,943 bytes)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o Additional-Costs-and-Disclosures.pdf 'http://www.medsphere.com/wp-content/uploads/2024/07/Additional-Costs-and-Disclosures-of-Certified-Health-IT-2.pdf'
```
Verified: PDF document, version 1.7, 5 pages. Cost disclosures for certified Health IT.

## Obstacles & Notes

1. **Dead Pardot link**: The ChartLogic/Wellsoft data dictionary xlsx is hosted via a Pardot (Salesforce marketing automation) tracking URL that has expired. This is the ONLY data dictionary for the Wellsoft CSV export format. Without it, there is no field-level documentation for Wellsoft's CSV export. This is a compliance gap.

2. **Multiple products, different approaches**: This single certifications page covers 6 products with 3 different EHI export approaches:
   - CareVue: Custom XML with XSD + extensive VistA data dictionary (best documented)
   - ChartLogic products: C-CDA only, no vendor-specific documentation beyond HL7 spec references
   - Wellsoft: CCDA or CSV, data dictionary link is dead
   - PCG: C-CDA only, bulk export requires email to support

3. **VistA heritage**: CareVue is based on OpenVista (open-source VistA). The data dictionary uses VistA file numbers and structure (File 2 = PATIENT, etc.). The XML export schema maps VistA's hierarchical file/field structure into XML.

4. **No anti-bot protection issues**: All resources loaded cleanly via curl with a User-Agent header. Cloudflare was present but didn't block.

5. **PCG bulk export requires email**: Not self-service. Users must email support@micro-officesystems.com to get a bulk export of zipped CCD-A files.
