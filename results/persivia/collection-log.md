# Persivia — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10918, 11149
- Products: Persivia Platform (versions 3.5 and 4.0)
- Registered URL: https://persivia.com/meaningful-use-certification-language/

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://persivia.com/meaningful-use-certification-language/" -H 'User-Agent: Mozilla/5.0'
```
**Result:** HTTP 200 OK. Single redirect-free response. WordPress site (Apache server). Content-Type: text/html; charset=UTF-8. WPO-Cache headers present. Page modified 2026-02-09.

### Step 2: Page examination
```bash
curl -sL "https://persivia.com/meaningful-use-certification-language/" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html  # => 115,516 bytes
```
The page is a WordPress/Elementor page ("CERTIFIED PRODUCTS"). Not a SPA — real HTML content is present in the source. No JavaScript rendering required. The page has significant CSS/JS boilerplate (analytics trackers, Elementor styles), but all content is in the DOM.

### Step 3: Finding the EHI section
Searched page source for EHI-related content:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html
```
Found 12 PDF links (certificates, mandatory disclosures, real-world testing plans/results). No ZIP, CSV, XLSX, or other data files.

```bash
grep -iE 'ehi|electronic.health.information|b\(10\)' /tmp/page.html
```
Found inline text describing the EHI export under both product sections.

Browser navigation confirmed the layout: page has a hero banner "CERTIFIED PRODUCTS", then two product sections (Platform 4.0 and 3.5), followed by a Real World Testing section with PDF links.

The EHI export documentation is **entirely inline text on the page** — there is no separate downloadable data dictionary, schema file, or detailed export specification.

### Step 4: Page structure and content

The page contains two certified product sections:

#### Persivia Platform 4.0
- Certification ID: 15.04.04.2155.Mean.04.01.0.220622
- Date Certified: 06/22/2022
- Certification Criteria: 170.315 (b)(10); (c)(1-3); (d)(1-3, 5, 12-13); (g)(4-5)
- **EHI Export section:** "Persivia Platform 4.0 allows clients to export industry-standard information in XML format using the QRDA Cat I version by which the product was certified. Regular updates are performed to maintain compliance as specified by https://www.hl7.org/implement/standards/"
- References: Certificate PDF, Mandatory Disclosure Letter PDF

#### Persivia Platform 3.5
- Certification ID: 15.04.04.2155.Pers.35.02.1.221227
- Date Certified: 12/27/2022
- Certification Criteria: 170.315 (a)(1-2, 5, 12, 14); (b)(1, 10-11); (c)(1-4); (d)(1-9, 12-13); (g)(2-7, 9); (h)(1)
- **EHI Export section with more detail:**
  - **Single Patient Export:** "Persivia Platform allows the export of Electronic Health Information for a single patient without any developer assistance."
  - **Multi-Patient Export:** "A user can export Electronic Health Information for the entire patient population, or all patients displayed on a single web page, or export data of specific patients by selecting checkboxes."
  - **File Format:** "Electronic Health Information is exported as a XML-based CCD file, for an individual patient and/or a group of patients. Regular updates are performed to maintain compliance as specified by https://www.hl7.org/implement/standards/"
- References: Certificate PDF, Mandatory Disclosure Letter PDF

#### Real World Testing Section
- Links to 8 PDFs: Plans and Results for 2022, 2023, 2024, 2025

### Step 5: Searching for additional documentation
Searched the page for data dictionary, schema, field-level documentation:
```bash
grep -iE 'data.dictionary|schema|field|column|table|csv|json|download' /tmp/page.html | grep -v 'css\|script\|style'
```
No results. The EHI export documentation is purely prose — no data dictionary, no field definitions, no schema.

Also checked the HL7 standards link referenced in both sections (https://www.hl7.org/implement/standards/) — this is a generic link to HL7's standards page, not a Persivia-specific data dictionary.

## Downloads

### page-certified-products.html (115,516 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o page-certified-products.html \
  'https://persivia.com/meaningful-use-certification-language/'
```
Verified: HTML document, 115,516 bytes

### Compliance-Certificate-Persivia-Platform-4.0.pdf (265,955 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o Compliance-Certificate-Persivia-Platform-4.0.pdf \
  'https://persivia.com/wp-content/uploads/2025/02/Compliance-Certificate-Persivia-Platform-4.0-013125_HH3-GMCS-OP40.pdf'
```
Verified: PDF document, version 1.7, 1 page. Drummond Group compliance certificate.

### 4.0-Mandatory-Disclosures-Letter.pdf (850,819 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o 4.0-Mandatory-Disclosures-Letter.pdf \
  'https://persivia.com/wp-content/uploads/2024/07/4.0-Mandatory-Disclosures-Letter.pdf'
```
Verified: PDF document, version 1.7, 2 pages. Lists (b)(10) as certified criterion. Describes costs/fees for implementation, data transformation, and data cleanup. SaaS pricing model.

### Compliance-Certificate-Persivia-Platform-3.5.pdf (266,064 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o Compliance-Certificate-Persivia-Platform-3.5.pdf \
  'https://persivia.com/wp-content/uploads/2025/02/Compliance-Certificate-Persivia-Platform-3.5-101624.pdf'
```
Verified: PDF document, version 1.7, 1 page. Drummond Group compliance certificate.

### 3.5-Mandatory-Disclosures-Letter.pdf (864,009 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o 3.5-Mandatory-Disclosures-Letter.pdf \
  'https://persivia.com/wp-content/uploads/2024/07/3.5-Mandatory-Disclosures-Letter.pdf'
```
Verified: PDF document, version 1.7, 2 pages. Lists all certified criteria including (b)(10). Similar cost/fee disclosure as 4.0.

## Obstacles & Notes

- **No anti-bot protection.** Simple curl with User-Agent worked fine for all resources.
- **No separate data dictionary or schema.** The EHI export "documentation" is entirely a few sentences of prose on the certification page. No downloadable ZIP, CSV schema, XML schema, JSON schema, or field-level documentation exists.
- **Confusing export format description for Platform 4.0:** Says "XML format using the QRDA Cat I version" — QRDA Cat I is a clinical quality reporting format, not a general EHI export format. This likely means they export clinical measures as QRDA Cat I, which is a very narrow subset of "all EHI."
- **Platform 3.5 describes CCD export:** "XML-based CCD file" — Continuity of Care Document, a C-CDA template. This is a clinical summary format. More comprehensive than QRDA Cat I but still limited to what C-CDA can represent (demographics, problems, meds, allergies, procedures, results, immunizations, vital signs, care plans).
- **Neither format covers "all EHI":** CCD/C-CDA and QRDA Cat I are standardized clinical document formats. They do NOT include billing data, insurance details, secure messages, scheduling data, audit trails, custom/specialty data, or free-text notes beyond what C-CDA supports. The documentation makes no mention of how non-clinical data is exported.
- **No data dictionary means no field-level detail:** There is no way to understand what specific data elements are included in the export without actually running it.
- **The "documentation" appears to be compliance boilerplate** rather than genuine technical documentation for developers or data consumers.
