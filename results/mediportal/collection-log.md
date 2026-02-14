# Mediportal — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 11272
- Registered URL: https://www.mediportal.com/export/
- Developer: Mediportal, LLC.
- Product: M-Power v5

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.mediportal.com/export/" -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```
Result:
```
HTTP/1.1 200 OK
Date: Sat, 14 Feb 2026 02:50:43 GMT
Server: Apache
Link: <https://www.mediportal.com/?p=67>; rel=shortlink
Content-Type: text/html; charset=UTF-8
```
Direct 200 response, no redirects. Content-Type is HTML. The `Link` header shows this is WordPress page ID 67.

### Step 2: Page examination
```bash
curl -sL "https://www.mediportal.com/export/" -H 'User-Agent: Mozilla/5.0' -o /tmp/mediportal-page.html
wc -c /tmp/mediportal-page.html
```
Result: 23,305 bytes. Static HTML served by WordPress (not a SPA). Content is fully rendered server-side — no JavaScript required to view.

The page uses the `template-legal` WordPress template (`page-template-template-legal`). It has a `<meta name='robots' content='noindex, nofollow' />` tag, meaning it is intentionally hidden from search engine indexing.

### Step 3: Finding the EHI section
No navigation required. The page is a dedicated export documentation page with the content directly visible. The title is "Export" and the body content is immediately below.

Searched for downloadable file links:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/mediportal-page.html
```
Result: No downloadable files found. No PDF, ZIP, or other document links on the page.

Searched for EHI-related links:
```bash
grep -oiE 'href="[^"]*"' /tmp/mediportal-page.html | grep -iE 'ehi|export|data.dictionary|b.10|download|document'
```
Result: Only `href="https://www.mediportal.com/export/"` (self-referencing link in navigation).

### Step 4: Page content
The entire EHI export documentation content is contained in lines 148-160 of the HTML:

```html
<div class="entry-content container mt-3 ">
  <p>The patient EHI export contains data from the patient's chart. Multiple file
  formats are used to store this information. The electronic health information
  export will include data in the following formats:</p>
  <ul class="wp-block-list mb-3">
    <li>C-CDA or Consolidated Clinical Document Architecture</li>
    <li>PDF files (industry standard) *</li>
  </ul>
  <p class="small muted">* PDF or Portable Document Format is a file format that
  is used to present text or image based documents.</p>
  <p>The export file itself is a zip file. It contains zip files of PDFs, C-CDAs,
  and other files attached to the patient's chart.</p>
</div>
```

That is the complete documentation — 5 sentences total. No data dictionary. No field-level detail. No table definitions. No links to additional documentation.

### Step 5: Checked disclosures page for additional info
```bash
curl -sL "https://www.mediportal.com/disclosures/" -H 'User-Agent: Mozilla/5.0' -o /tmp/mediportal-disclosures.html
```
Result: 28,993 bytes. Contains ONC certification information listing 21 certified criteria (more than the CHPL metadata's 11). Includes:
- 170.315 (b)(1) Transitions of Care
- 170.315 (b)(10) Electronic Health Information Export
- 170.315 (c)(1)-(c)(3) CQMs
- 170.315 (d)(1)-(d)(3), (d)(5)-(d)(9), (d)(12)-(d)(13) Security/privacy criteria
- 170.315 (g)(2), (g)(4)-(g)(6) QMS/accessibility/CDA
- 170.315 (g)(9) Application Access - All Data Request
- 170.315 (g)(10) Standardized API for Patient and Population Services

Also lists 16 eCQMs (CMS measures for diabetes, cancer screening, HIV, blood pressure, etc.).

No additional EHI export documentation, data dictionaries, or export specifications found on the disclosures page.

## Downloads

### mediportal-export-page.html (23,305 bytes)
```bash
curl -sL "https://www.mediportal.com/export/" -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' -o downloads/mediportal-export-page.html
```
Verified: `file mediportal-export-page.html` → HTML document, Unicode text, UTF-8 text
Saved to: downloads/mediportal-export-page.html

### mediportal-disclosures-page.html (28,993 bytes)
```bash
curl -sL "https://www.mediportal.com/disclosures/" -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' -o downloads/mediportal-disclosures-page.html
```
Verified: `file mediportal-disclosures-page.html` → HTML document, Unicode text, UTF-8 text
Saved to: downloads/mediportal-disclosures-page.html

## Obstacles & Notes
- **No downloadable artifacts**: Unlike most vendors, Mediportal provides no PDF, ZIP, or other downloadable documentation file. The entire EHI export documentation is 5 sentences on a single HTML page.
- **noindex/nofollow**: The export page has `<meta name='robots' content='noindex, nofollow' />`, intentionally hiding it from search engines.
- **No anti-bot issues**: The page loads cleanly with a standard User-Agent via curl. No JavaScript required.
- **Disclosures page lists more criteria than CHPL**: The mandatory disclosures page at /disclosures/ lists 21 certified criteria, while the CHPL metadata only shows 11 (b(10) plus d-series and g(4)/g(5)). The additional criteria (including g(9), g(10) for FHIR APIs, b(1) for Transitions of Care, and c(1)-(c)(3) for CQMs) appear on the vendor's own disclosures page.

---

## Product: M-Power

### Product Context
Mediportal's M-Power is a cloud-based EHR platform offered in three configurations:

1. **M-Power EMR** ($249/month per provider): A standalone electronic medical records system with telemedicine, scheduling, SOAP note documentation, e-prescribing, secure messaging, patient portal, remote patient monitoring (RPM), digital registration/intake forms, and analytics. This is the core clinical product.

2. **M-Power MIE** (Medical Information Exchange, custom pricing): A data aggregation/interoperability platform that consolidates data from legacy EHR systems and interfaces using FHIR, HL7, and APIs. Uses "SyncAI" for data ingestion, normalization, and transformation.

3. **M-Power Ecosystem** (custom pricing): An enterprise-level customizable solution with dedicated support and hosted deployment options (Azure, AWS, or private data center).

The product targets diverse healthcare settings: solo practices, provider organizations, ACOs, hospitals, health systems, and diagnostic labs. It has mobile apps ("Mediportal Care") on both iOS (App Store) and Android (Google Play), indicating a patient-facing portal.

Key features confirmed from the vendor's website:
- SOAP note documentation with custom templates
- Appointment scheduling with automated reminders
- E-prescribing
- Secure messaging between patients and providers
- Patient portal (mobile and web)
- Telemedicine
- Remote Patient Monitoring (RPM)
- Digital registration and intake forms
- Lab results integration
- Imaging reports access
- Analytics
- Real-time health information exchange (HL7, FHIR)

**Notably absent from website marketing**: No mention of billing, revenue cycle management, claims processing, charge capture, or insurance management features. The product appears to be primarily a clinical EHR without integrated billing/RCM.

### Export Approach
The EHI export uses a **C-CDA + PDF hybrid approach**. According to the documentation:
- The export is a ZIP file
- It contains ZIP files of PDFs, C-CDAs, and "other files attached to the patient's chart"
- Two explicit formats: C-CDA (clinical data) and PDF (documents/images)

This is a document-based export, not a database-native export. C-CDA captures clinical summary data (diagnoses, medications, allergies, labs, vitals, procedures, etc.) but has well-known limitations for non-clinical data. PDFs capture rendered documents but are not machine-readable structured data.

The "other files attached to the patient's chart" language suggests the export also includes uploaded attachments (scanned documents, images, etc.), which is positive.

### EHI Coverage Assessment

**Clinical data**: Likely present via C-CDA. C-CDA covers diagnoses, medications, allergies, vitals, labs, immunizations, procedures, clinical notes, and care plans reasonably well. However, C-CDA is a clinical summary format — it may not capture the full granularity of the EHR's internal data (e.g., all historical versions, audit details, free-text notes that don't map to C-CDA sections).

**Secure messages**: Almost certainly missing. C-CDA has no standard section for patient-provider portal messages. The product has secure messaging (confirmed on the EMR features page and patient portal mobile apps), but neither C-CDA nor PDF would naturally capture message threads. This is a significant gap — the product stores messaging data that the export likely does not include.

**Billing/financial**: Not applicable based on current evidence. The product does not appear to have billing/RCM capabilities based on its website (no mention of billing, claims, charges, or insurance anywhere in marketing materials). If the product genuinely does not store billing data, its absence from the export is not a gap.

**Insurance/coverage**: Similar to billing — no evidence the product stores insurance data beyond basic demographics. If patient insurance information is captured during registration/intake, it may or may not be included in the C-CDA's payer section.

**Appointments/scheduling**: Likely missing or minimal. C-CDA does not have a standard section for appointment/scheduling data. The product has scheduling with automated reminders (confirmed on features page), but this data is unlikely to appear in a C-CDA export. The "encounters" section of C-CDA captures past encounters but not future appointments or scheduling metadata.

**Documents/images**: Likely present. The export explicitly includes PDFs and "other files attached to the patient's chart," suggesting scanned documents, uploaded images, and other attachments are included. However, exporting documents as PDF means the content is not machine-readable structured data.

**Audit trails**: Not expected in EHI export (not part of Designated Record Set). No evidence of inclusion.

### Issues & Red Flags
1. **Extremely minimal documentation**: The entire EHI export documentation is 5 sentences. No data dictionary, no field definitions, no table structures, no sample data, no version information. This is among the least detailed EHI documentation encountered.
2. **C-CDA as primary clinical export format**: C-CDA is a clinical summary standard, not a comprehensive database export. It inherently cannot represent all EHI categories (billing, messaging, scheduling, audit) and may lose granularity in clinical data.
3. **PDF as an export format for patient data**: While PDFs capture document content, they are not machine-readable. Exporting clinical notes, intake forms, or other structured data as PDF rather than structured formats (JSON, CSV, XML) reduces the utility of the export.
4. **No mention of scheduling data in export**: The product has scheduling but the export format (C-CDA + PDF) has no mechanism to capture appointment data.
5. **No mention of secure message data in export**: The product has patient-provider messaging but the export format has no mechanism to capture message threads.
6. **noindex/nofollow meta tag**: The export documentation page is intentionally hidden from search engines, making it harder for patients and providers to discover.
7. **No documentation versioning**: No indication of when the documentation was last updated or what version it corresponds to.
