# Persivia — EHI Export Documentation Collection

Collected: 2025-07-14

## Source
- Registered URL: https://persivia.com/meaningful-use-certification-language/
- CHPL IDs: 10918, 11149
- Developer: Persivia
- Product: Persivia Platform (versions 3.5 and 4.0)

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://persivia.com/meaningful-use-certification-language/" -H 'User-Agent: Mozilla/5.0'
```
Result: HTTP 200 OK, Content-Type: text/html; charset=UTF-8. WordPress site (Elementor-based). No redirects. Page is 115 KB.

### Step 2: Page examination
The page is a static WordPress page titled "CERTIFIED PRODUCTS". It contains two product certification sections:
1. **Persivia Platform 4.0** (Certified: 06/22/2022, Cert ID: 15.04.04.2155.Mean.04.01.0.220622)
2. **Persivia Platform 3.5** (Certified: 12/27/2022, Cert ID: 15.04.04.2155.Pers.35.02.1.221227)

Both sections include EHI Export documentation inline, plus links to Compliance Certificates and Mandatory Disclosure Letters. A "Real World Testing" section at the bottom links to annual testing plan/results PDFs.

The page is fully server-rendered HTML (not an SPA). A sticky promotional banner at the bottom partially overlaps content but can be dismissed.

### Step 3: Examining EHI Export content

**Platform 4.0 — Electronic Health Information Export:**
> Persivia Platform 4.0 allows clients to export industry-standard information in XML format using the QRDA Cat I version by which the product was certified. Regular updates are performed to maintain compliance as specified by https://www.hl7.org/implement/standards/

**Platform 3.5 — Electronic Health Information Export:**

> **Single Patient Export:** Persivia Platform allows the export of Electronic Health Information for a single patient without any developer assistance.
>
> **Multi-Patient Export:** A user can export Electronic Health Information for the entire patient population, or all patients displayed on a single web page, or export data of specific patients by selecting checkboxes.
>
> **File Format:** Electronic Health Information is exported as a XML-based CCD file, for an individual patient and/or a group of patients. Regular updates are performed to maintain compliance as specified by https://www.hl7.org/implement/standards/

### Step 4: Searching for downloadable files
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx|yaml|yml)[^"]*"' /tmp/persivia_page.html
```
Found 12 PDF links total:
- 2 Compliance Certificates (not downloaded — certificates only, no technical details)
- 2 Mandatory Disclosure Letters (downloaded — may contain export-related disclosures)
- 8 Real-World Testing Plans/Results PDFs (not downloaded — unrelated to EHI export mechanism)

No data dictionaries, schema files, API docs, or sample export files were linked.

### Step 5: Exploring vendor site for additional EHI documentation
Checked common paths on persivia.com:
- `/ehi/` → 404
- `/ehi-export/` → 404
- `/interoperability/` → 404
- `/api/` → 404
- `/fhir/` → 301 → redirects to a small PNG logo image (116x73 px)
- `/data-export/` → 404
- `/electronic-health-information/` → 404
- `/certifications/` → 200, but contains no EHI export content
- `/electronic-test-orders-and-results/` → 200, no EHI export content

No additional EHI export documentation found anywhere on the site.

### Step 6: Downloaded Mandatory Disclosure Letters
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o '4.0-Mandatory-Disclosures-Letter.pdf' \
  'https://persivia.com/wp-content/uploads/2024/07/4.0-Mandatory-Disclosures-Letter.pdf'
curl -sL -H 'User-Agent: Mozilla/5.0' -o '3.5-Mandatory-Disclosures-Letter.pdf' \
  'https://persivia.com/wp-content/uploads/2024/07/3.5-Mandatory-Disclosures-Letter.pdf'
```
Both verified as valid PDF documents (2 pages each).

### Step 7: Saved page HTML and screenshot
Saved the full page HTML and took a full-page screenshot capturing both Platform 4.0 and 3.5 EHI sections.

## Downloads

### certified-products-page.html (113 KB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o certified-products-page.html \
  'https://persivia.com/meaningful-use-certification-language/'
```
Verified: HTML document, full page source
Saved to: downloads/certified-products-page.html
Content: Complete certified products page with inline EHI export documentation for both Platform 4.0 and 3.5

### 4.0-Mandatory-Disclosures-Letter.pdf (831 KB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o '4.0-Mandatory-Disclosures-Letter.pdf' \
  'https://persivia.com/wp-content/uploads/2024/07/4.0-Mandatory-Disclosures-Letter.pdf'
```
Verified: PDF document, 2 pages
Saved to: downloads/4.0-Mandatory-Disclosures-Letter.pdf
Content: Mandatory disclosure letter for Persivia Platform 4.0

### 3.5-Mandatory-Disclosures-Letter.pdf (844 KB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o '3.5-Mandatory-Disclosures-Letter.pdf' \
  'https://persivia.com/wp-content/uploads/2024/07/3.5-Mandatory-Disclosures-Letter.pdf'
```
Verified: PDF document, 2 pages
Saved to: downloads/3.5-Mandatory-Disclosures-Letter.pdf
Content: Mandatory disclosure letter for Persivia Platform 3.5

### screenshot-full-page.png (379 KB)
Browser screenshot of the full page showing both Platform 4.0 and 3.5 EHI export sections.
Saved to: downloads/screenshot-full-page.png

## Access Summary
- Final URL (after redirects): https://persivia.com/meaningful-use-certification-language/
- Status: found
- Required browser: no (content is server-rendered HTML)
- Navigation complexity: direct_link
- Anti-bot issues: none

## EHI Export Documentation Summary

Persivia provides **minimal** EHI export documentation. The entire EHI export specification is contained in a few paragraphs of inline text on the certified products page:

- **Platform 4.0**: Exports in XML format using QRDA Cat I.
- **Platform 3.5**: Exports as XML-based CCD files. Supports single-patient and multi-patient export. Users can export the entire patient population, patients on a displayed page, or selected patients via checkboxes.

**Notable absences:**
- No data dictionary or schema documentation
- No sample export files
- No API documentation
- No detailed file format specification beyond "XML-based CCD" and "QRDA Cat I"
- No screenshots of the export interface
- No user guide for performing exports
- No FHIR-related documentation

The documentation consists entirely of brief prose descriptions. There are no downloadable technical artifacts (schemas, data dictionaries, sample files). This is among the most minimal EHI export documentation encountered.

## Obstacles & Dead Ends
- Sticky promotional banner at bottom of page partially obscures content (dismissible)
- `/fhir/` path redirects to a tiny PNG logo, not FHIR documentation
- No additional EHI documentation found anywhere on the persivia.com domain
- Compliance certificates were not downloaded as they contain only certification details, not technical export information
- Real-world testing PDFs were not downloaded as they describe testing methodology, not the export mechanism
