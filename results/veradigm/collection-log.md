# Veradigm — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11609, 11632, 11697, 11763
- **Products**: Veradigm EHR, Veradigm FollowMyHealth®, Veradigm View, ePrescribe
- **Registered URL**: https://veradigm.com/legal/onc-reg-compliance/

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://veradigm.com/legal/onc-reg-compliance/" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP/2 200 directly (no redirects). Content-Type: text/html, Content-Length: 250,500 bytes. Served from Amazon S3 via CloudFront CDN. No anti-bot protection encountered.

### Step 2: Page examination

```bash
curl -sL "https://veradigm.com/legal/onc-reg-compliance/" -H 'User-Agent: Mozilla/5.0' -o /tmp/veradigm_page.html
wc -c /tmp/veradigm_page.html  # 250,500 bytes
```

The page is a **static HTML compliance hub** (not a SPA). It contains real content accessible via curl — no JavaScript rendering required. Title: "ONC Regulatory Compliance | Veradigm".

The page uses a **Bootstrap accordion** pattern with 7 collapsible sections:
1. Certified Health IT Products
2. 21st Century Cures Final Rule Communications Compliance
3. File ONC Information Blocking Concern
4. ONC Health IT Certified Technology EHR API Fees
5. ONC Real World Testing Plans & Reports
6. **EHI Export Documentation** ← target section
7. Intervention Risk Management Summary - Predictive Decision Support Interventions

### Step 3: Finding the EHI section

The EHI Export Documentation is in accordion section #6 (`#onc-reg-compliance-accordion-6`). Content is in the HTML source even when collapsed (display:none via CSS), so curl + grep works without a browser.

```bash
grep -oiE 'href="[^"]*ehi[^"]*"' /tmp/veradigm_page.html
```

All EHI links found in the collapsed accordion body.

### Step 4: Identified downloadable assets

The EHI Export Documentation section contains documentation for **5 products** (4 ONC-certified + 1 non-certified):

**Veradigm EHR**
- PDF: `/img/legal/onc/VeradigmEHR_EHI_Export_output_format_documentation_v1.pdf` (v1, Nov 9 2023)

**Veradigm ePrescribe**
- PDF: `/img/legal/onc/VeradigmePrescribe_EHI_Export_Documentation_v1.pdf` (v1, Nov 27 2023)

**Veradigm FollowMyHealth**
- PDF: `/img/legal/onc/VeradigmFMH_EHI_Export_Data_Guide_v2.pdf` (v2, Feb 28 2024)
- PDF served via FHIR endpoint: `https://fhir.followmyhealth.com/documentation/EHIExportDocumentation/v1` (v1, Nov 27 2023)

**Veradigm Practice Management (non ONC certified)**
- PDF: `/img/legal/onc/EHIDataExportFile_ReferenceGuide_VeradigmPM_V2.pdf` (v2, May 7 2024)
- PDF: `/img/legal/onc/EHIDataExportFile_ReferenceGuide_VeradigmPM.pdf` (v1, Dec 21 2023)

**Veradigm View**
- HTML pages (not PDFs), with 6 versions published. Latest:
  - `/legal/veradigm-view-ehi-export-documentation/v6/index/` (V6, Jan 12 2026)
  - Each version is a multi-page HTML site with an index listing 87 TSV file definitions, each with its own subpage containing a field-level table.

## Downloads

### VeradigmEHR_EHI_Export_output_format_documentation_v1.pdf (761,262 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o VeradigmEHR_EHI_Export_output_format_documentation_v1.pdf \
  'https://veradigm.com/img/legal/onc/VeradigmEHR_EHI_Export_output_format_documentation_v1.pdf'
```
Verified: PDF document, version 1.5, 89 pages
Saved to: `downloads/VeradigmEHR_EHI_Export_output_format_documentation_v1.pdf`

### VeradigmePrescribe_EHI_Export_Documentation_v1.pdf (684,031 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o VeradigmePrescribe_EHI_Export_Documentation_v1.pdf \
  'https://veradigm.com/img/legal/onc/VeradigmePrescribe_EHI_Export_Documentation_v1.pdf'
```
Verified: PDF document, version 1.7, 22 pages
Saved to: `downloads/VeradigmePrescribe_EHI_Export_Documentation_v1.pdf`

### VeradigmFMH_EHI_Export_Data_Guide_v2.pdf (539,373 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o VeradigmFMH_EHI_Export_Data_Guide_v2.pdf \
  'https://veradigm.com/img/legal/onc/VeradigmFMH_EHI_Export_Data_Guide_v2.pdf'
```
Verified: PDF document, version 1.4, 29 pages (cover page says 20 logical pages)
Saved to: `downloads/VeradigmFMH_EHI_Export_Data_Guide_v2.pdf`

### VeradigmFMH_EHI_Export_Documentation_v1.pdf (530,445 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o VeradigmFMH_EHI_Export_Documentation_v1.pdf \
  'https://fhir.followmyhealth.com/documentation/EHIExportDocumentation/v1'
```
Note: Despite the URL looking like a FHIR endpoint, it returns a raw PDF (Content-Type not checked, but `file` confirms PDF). The HEAD request returned HTTP 405 (Method Not Allowed), but GET works and delivers a 21-page PDF.
Verified: PDF document, version 1.4, 21 pages
Saved to: `downloads/VeradigmFMH_EHI_Export_Documentation_v1.pdf`

### EHIDataExportFile_ReferenceGuide_VeradigmPM_V2.pdf (323,751 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o EHIDataExportFile_ReferenceGuide_VeradigmPM_V2.pdf \
  'https://veradigm.com/img/legal/onc/EHIDataExportFile_ReferenceGuide_VeradigmPM_V2.pdf'
```
Verified: PDF document, version 1.4, 20 pages (v2, adds ambulance/drug/anesthesia/dental fields)
Saved to: `downloads/EHIDataExportFile_ReferenceGuide_VeradigmPM_V2.pdf`

### EHIDataExportFile_ReferenceGuide_VeradigmPM.pdf (467,046 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o EHIDataExportFile_ReferenceGuide_VeradigmPM.pdf \
  'https://veradigm.com/img/legal/onc/EHIDataExportFile_ReferenceGuide_VeradigmPM.pdf'
```
Verified: PDF document, version 1.4, 17 pages
Saved to: `downloads/EHIDataExportFile_ReferenceGuide_VeradigmPM.pdf`

### veradigm-view-v6-index.html (249,371 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o veradigm-view-v6-index.html \
  'https://veradigm.com/legal/veradigm-view-ehi-export-documentation/v6/index/'
```
Verified: HTML page containing index of 87 TSV file definitions organized into 8 sections (Demographics, Patient, Clinical, Billing and insurance, Medications and prescriptions, Labs, Referrals, Messaging). Each TSV file links to a subpage with a table of Field Name, Data type, and Field Description.
Saved to: `downloads/veradigm-view-v6-index.html`

## Obstacles & Notes

1. **No anti-bot protection**: All content accessible via simple curl with a User-Agent header. No Cloudflare, no CAPTCHA, no login wall.

2. **Accordion pattern**: The EHI section is in a Bootstrap collapsed accordion. Content IS in the HTML source (not lazy-loaded), so curl + grep finds everything without needing a browser. In a browser, you'd need to click the "EHI Export Documentation" header to expand it.

3. **FollowMyHealth FHIR endpoint quirk**: The v1 link at `https://fhir.followmyhealth.com/documentation/EHIExportDocumentation/v1` returns HTTP 405 for HEAD but 200 for GET, delivering a raw PDF despite the URL suggesting a FHIR documentation endpoint.

4. **Multiple products, multiple formats**: Veradigm has 5 different products with independent EHI export implementations using 3 different formats:
   - Veradigm EHR: JSON files in a ZIP with folder hierarchy
   - ePrescribe: TSV files in a ZIP
   - FollowMyHealth: FHIR R4 NDJSON bundles
   - Practice Management: Pipe-delimited text files
   - Veradigm View (formerly Practice Fusion): TSV files

5. **Veradigm View has the richest documentation**: 87 TSV files with field-level detail on individual HTML subpages, organized by data domain. The other products use PDF documentation.

6. **Practice Management is explicitly labeled "non ONC certified"** but EHI export documentation is still provided.

7. **Historical versions preserved**: Both FollowMyHealth and View maintain previous versions. View has 6 versions (V1-V6) from April 2025 to January 2026.
