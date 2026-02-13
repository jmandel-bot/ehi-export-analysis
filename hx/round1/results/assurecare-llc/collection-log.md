# AssureCare LLC — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 8970, 11103, 11286
- **Products**: iPatientCare 18.0, iPatientCare 22.5, iPatientCare 23.0
- **Developer**: AssureCare LLC
- **Registered URL**: https://ipatientcare.com/onc-certified-health-it/

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://ipatientcare.com/onc-certified-health-it/" -H 'User-Agent: Mozilla/5.0'
```
**Result**: HTTP/2 200 directly (no redirects). Content-Type: `text/html; charset=UTF-8`. Server: Apache. Page served with `last-modified: Thu, 12 Feb 2026 15:33:06 GMT`.

### Step 2: Page examination
```bash
curl -sL "https://ipatientcare.com/onc-certified-health-it/" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html
```
**Result**: 1,363,957 bytes (1.3 MB). Large page — WordPress/Elementor site with substantial inline CSS. Real HTML content, not a JavaScript SPA. Text content extractable via curl without browser rendering.

### Step 3: Finding the EHI section
Searched the HTML source for downloadable files:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html
```
**Result**: Found 18 PDF links. Specifically filtered for EHI:
```bash
grep -oiE 'href="[^"]*[^"]*"' /tmp/page.html | grep -iE 'ehi|export|data.dictionary|b.10|electronic.health.information'
```
**Result**: One match:
```
href="https://ipatientcare.com/wp-content/uploads/2025/04/170.315b10-Electronic-Health-Information-Export-v1.0.0.2.pdf"
```

The link is inside an `<h2>` heading element within an Elementor widget section:
```html
<h2 class="elementor-heading-title elementor-size-default">
  <a href="https://ipatientcare.com/wp-content/uploads/2025/04/170.315b10-Electronic-Health-Information-Export-v1.0.0.2.pdf" target="_blank">
    Electronic Health Information Export
  </a>
</h2>
```

### Step 4: Visual confirmation via browser
Navigated to the page in a browser. The page layout is:
1. **Header**: "ONC Certified Health IT" title
2. **Certification table**: Lists three products (iPatientCare 18.0, 22.5, 23.0) with certification IDs and cost links
3. **Document links section**: A flat list of clickable links including:
   - Real World Test Results/Plans (2022-2025)
   - **Electronic Health Information Export** ← the EHI doc
   - Multi-Factor Authentication
   - SmartOnFHIR API Documentation
   - FHIR Service URLs
   - Standards Version Advancement Process (multiple years)

No accordion, no expandable sections — just a straightforward list of linked documents. The EHI Export link is a direct link to a PDF hosted on the same WordPress site.

### Step 5: Identified downloadable assets
Only one EHI-related document found:
- `170.315b10-Electronic-Health-Information-Export-v1.0.0.2.pdf` (126,823 bytes, 3 pages)

No data dictionary, no schema, no ZIP of export samples, no additional EHI documentation.

## Downloads

### 170.315b10-Electronic-Health-Information-Export-v1.0.0.2.pdf (124 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/170.315b10-Electronic-Health-Information-Export-v1.0.0.2.pdf \
  'https://ipatientcare.com/wp-content/uploads/2025/04/170.315b10-Electronic-Health-Information-Export-v1.0.0.2.pdf'
```
**Verified**:
```
PDF document, version 1.4, 3 page(s)
126,823 bytes
```
**Saved to**: `downloads/170.315b10-Electronic-Health-Information-Export-v1.0.0.2.pdf`

## Document Content Summary

The 3-page PDF (version 1.0.0.2, last updated February 27, 2023) covers:

- **Page 1**: Cover page, revision history (3 versions: Sep 2022, Nov 2022, Feb 2023), formatting conventions, support contact info
- **Page 2**: Product name and version listing (iPatientCare 18.0, 22.5, 23.0)
- **Page 3**: The actual EHI export description — two supported formats:
  1. **C-CDA**: Bulk export of HL7 C-CDA XML files complying with USCDI v1. References HL7 CDA Release 2 specifications.
  2. **FHIR**: HL7 FHIR R4 (v4.0.1), US Core STU V3.1.1, FHIR Bulk Data Export. References SmartOnFHIR API Documentation PDF.

That's the entire document. There is **no data dictionary**, **no field-level detail**, **no table/resource listing**, and **no description of what data domains are included** in the export.

## Obstacles & Notes
- No anti-bot protection; simple curl with User-Agent works fine.
- The page is a standard WordPress/Elementor site. No JavaScript rendering needed.
- The documentation is extremely thin — 3 pages total, with the substantive content being only a few paragraphs on the final page.
- The vendor describes the EHI export as C-CDA + FHIR Bulk Data, which is essentially re-exporting standardized formats rather than dumping their actual database. This means the export is limited to whatever data maps to C-CDA and FHIR US Core resources.
- No mention of billing, insurance, secure messages, audit trails, or other "all EHI" data beyond what C-CDA/FHIR covers.
- The document explicitly says it's "intended for use of iPatientCare clients only" — though it's publicly accessible via the website.
