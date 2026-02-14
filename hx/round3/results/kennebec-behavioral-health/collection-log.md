# Kennebec Behavioral Health — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10971
- Registered URL: https://support.kbhmaine.org/neo-faq/client-export
- Developer: Kennebec Behavioral Health
- Product: Neo 2.1

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://support.kbhmaine.org/neo-faq/client-export" -H 'User-Agent: Mozilla/5.0'
```
Result: SSL certificate error (exit code 60) with default curl settings. The certificate chain could not be verified with the system's CA bundle.

Retried with `-k` (skip SSL verification):
```bash
curl -sI -L -k "https://support.kbhmaine.org/neo-faq/client-export" -H 'User-Agent: Mozilla/5.0'
```
Result: HTTP/2 200. Content-Type: `text/html; charset=utf-8`. Content-Length: 56052 bytes. Server: Heroku (via heroku-router). Cookie set for `_helpjuice_session_v2` on domain `kbhmaine.org`. The page is hosted on HelpJuice (knowledge base SaaS platform).

### Step 2: Page examination
```bash
curl -sL -k "https://support.kbhmaine.org/neo-faq/client-export" -H 'User-Agent: Mozilla/5.0' -o /tmp/kbh-page.html
wc -c /tmp/kbh-page.html
```
Result: 56,051 bytes. The HTML is mostly JavaScript (New Relic monitoring, HelpJuice platform code). The actual article content is present in the HTML but wrapped in HelpJuice template markup. Extracting text via `sed` showed the page is heavy with JS (New Relic agent, HelpJuice JS framework) but does contain the article body inline.

### Step 3: Finding the EHI section
No special navigation was needed. The registered URL directly leads to the FAQ article titled "Export Client Information" with subtitle "Extract all client information." The page is a single HelpJuice knowledge base article at the path `/neo-faq/client-export`.

Breadcrumb path shown on the page: Home > Neo > FAQ > Export Client Information

### Step 4: Content of the EHI export documentation

The article is short — roughly 150 words of actual content. Full text:

> **Neo** provides many ways to export specific information about a client, but to export all of the information requires using Chart Printing. There is no charge for electronic downloads of data. If it is printed, there is a minimal fee ranging between $20-$50 above 100 pages, depending on the size of the chart.
>
> 1. First, navigate to the **Chart Printing** area of the Med Records dashboard.
> 2. Then, select the correct client and use the **Export Data** button.
>    - Security Note: Only users with Med Records and Security Administrator rights have access to this functionality. This will download an XML file containing all the background client information, such as addresses and phone numbers. It is in the same format as CDA files.
> 3. Finally, select all the document types you would like to export and click **Run Report** to download all the client documentation in PDF format. The PDFs generated within **Neo** are machine-readable, but any documentation faxed to us will be image only.
>
> *Contact IT Support if you would like to export the complete client dataset.*

No downloadable files (PDF, ZIP, CSV, etc.) are linked from this page.

The article links to one related page:
- **Chart Printing** at `/medical-records/chart-printing`

### Step 5: Following the Chart Printing link
```bash
curl -sL -k "https://support.kbhmaine.org/medical-records/chart-printing" -H 'User-Agent: Mozilla/5.0' -o chart-printing-page.html
```
This page contains even less information. Full article body:

> **Chart Printing**
> Export Neo Data
>
> Key Concept: Chart printing is the primary method of exporting Neo data.

That's it — a single sentence. No data dictionary, no list of fields or document types, no schema documentation.

### Step 6: Checking for downloadable documentation files
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/kbh-page.html
```
Result: No downloadable file links found anywhere on the page.

```bash
grep -oiE 'href="[^"]*"' /tmp/kbh-page.html | grep -iE 'ehi|export|data.dictionary|b.10|download'
```
Result: Only one match — a self-referencing link: `href="/en_US/neo-faq/client-export"`

### Step 7: Checking for embedded images/screenshots
Searched the HTML for article-specific images (excluding HelpJuice platform images):
```bash
grep -oiE '(img[^>]*src|data-src)="[^"]*"' /tmp/kbh-page.html
```
No article-embedded screenshots found. The only image reference is the `og:image` meta tag, which is a HelpJuice-generated social preview card showing the article title — not a product screenshot.

Also confirmed via browser JavaScript evaluation that no `<img>` elements exist within the article content area.

### Step 8: Mandatory disclosures page
```bash
curl -sL -k "https://mobile.kbhmaine.org/home/disclosure" -H 'User-Agent: Mozilla/5.0' -o /tmp/kbh-disclosure.html
```
Result: 8,419 bytes. Standard ONC mandatory disclosure page listing product name (Neo 2.1), certification date (9/6/2022), CHPL number, and certified criteria. No additional EHI export documentation or data dictionary found here.

## Downloads

### client-export-page.html (56 KB)
```bash
curl -sL -k "https://support.kbhmaine.org/neo-faq/client-export" -H 'User-Agent: Mozilla/5.0' -o client-export-page.html
```
Verified: HTML page, HelpJuice knowledge base article
Saved to: downloads/client-export-page.html

### chart-printing-page.html (55 KB)
```bash
curl -sL -k "https://support.kbhmaine.org/medical-records/chart-printing" -H 'User-Agent: Mozilla/5.0' -o chart-printing-page.html
```
Verified: HTML page, HelpJuice knowledge base article
Saved to: downloads/chart-printing-page.html

### client-export-page-screenshot.png (977 KB)
Browser screenshot of the export documentation page.
Saved to: downloads/client-export-page-screenshot.png

### chart-printing-page-screenshot.png (1.2 MB)
Browser screenshot of the chart printing page.
Saved to: downloads/chart-printing-page-screenshot.png

## Obstacles & Notes
- **SSL certificate issue**: `curl` without `-k` flag fails with exit code 60 (certificate verification failure). The site works in browsers, which suggests the cert chain may be incomplete or using a CA not in the system bundle. Required `-k` flag for all curl commands.
- **No data dictionary or schema documentation exists**: The entire EHI export "documentation" is a ~150-word FAQ article describing how to click buttons in the UI. There is no data dictionary, no field-level documentation, no schema description, and no downloadable files of any kind.
- **"Contact IT Support" for full export**: The page explicitly states users should "Contact IT Support if you would like to export the complete client dataset," suggesting the self-service export via Chart Printing may not cover everything and/or the full export requires staff intervention.
- **HelpJuice platform**: The site is a knowledge base (KBH University) powered by HelpJuice, used for internal IT support documentation. This is not a dedicated EHI documentation site — it's the organization's general IT support knowledge base.

---

## Product: Neo

### Product Context

**Neo is an internally-developed, custom-built EHR system** created by Kennebec Behavioral Health (KBH), a nonprofit community behavioral health center in central Maine. It is not a commercially sold product — it exists solely to serve KBH's own operations.

**Kennebec Behavioral Health** is a CARF-accredited, Certified Community Behavioral Health Clinic (CCBHC) serving over 200 towns in central Maine from 20+ locations. They provide mental health services (children, adults, families), substance use disorder treatment, crisis services (24/7 crisis response, Crisis Stabilization Unit), and community rehabilitation.

**Neo** was primarily developed by a single software architect (Scott Bressette, Director of Training / Principal Software Architect). It's a web-based application built with ASP.NET MVC, DevExpress, and jQuery, with a companion mobile app (Staff App) built with Xamarin.

Based on the KBH University support site and product research, Neo stores:
- **Clinical data**: DSM diagnoses, treatment plans, clinical/progress notes, crisis notes, assessments (including PHQ-9), CCBHC quality measures, care team information
- **Scheduling**: Appointments, front desk schedule, billing code integration
- **Billing/financial**: Client accounts, payor management, credit card payments, MaineCare (Medicaid) authorization management
- **Communications**: Internal "Neo Email" system, client text messaging (one-way and response-requested)
- **Documents**: Document templates, delivery, scanning (via mobile app), medical records, chart printing
- **Patient portal**: Client Portal at clientportal.kbhmaine.org (document access, treatment plan signatures, financial assistance applications)
- **Access Center**: Dashboard, search, call management

**Certified criteria** are limited (16 total) — notably (a)(15) Social/psychological/behavioral data, (b)(1) Transitions of Care, (b)(10) EHI Export, and mostly (d) security criteria. No FHIR API criteria, no clinical quality measures, no patient portal API access.

### Export Approach

The export uses a **two-part hybrid approach**:

1. **"Export Data" button** — Downloads an XML file in CDA format containing "all the background client information, such as addresses and phone numbers." This appears to be a C-CDA/CDA document covering demographic and basic clinical data.

2. **"Chart Printing" / "Run Report"** — Exports selected document types as PDF files. The user must select which document types to include. PDFs generated within Neo are machine-readable, but faxed documents are image-only.

The documentation explicitly states: "Contact IT Support if you would like to export the complete client dataset" — implying the self-service export does not cover everything.

This is essentially a **C-CDA + PDF document export** approach, which is one of the weakest patterns for EHI completeness. C-CDA captures clinical summaries but almost never includes billing line items, insurance details, portal messages, scheduling, or audit trails. PDF document exports are not machine-readable in the structured data sense.

### EHI Coverage Assessment

**Clinical data**: Likely partially present via the CDA/XML export (demographics, diagnoses, medications, etc.) and via PDF chart printing (clinical notes, treatment plans, assessments). However, no documentation specifies exactly which clinical data elements are in the XML or which document types are available for PDF export.

**Secure messages**: **Not addressed**. Neo has a "Neo Email" system and client text messaging, but the export documentation makes no mention of these. They would not be captured in a CDA document or in chart-printed PDFs.

**Billing/financial**: **Not addressed**. Neo has client accounts, payor management, and credit card payment processing, but the export documentation makes no mention of billing data. CDA format does not carry billing line items.

**Insurance/coverage**: **Not addressed**. Neo manages MaineCare (Medicaid) authorizations and payor information, but none of this is mentioned in the export documentation. CDA does not natively include insurance authorization details.

**Appointments/scheduling**: **Not addressed**. Neo has a full scheduling system, but appointment data is not mentioned in the export documentation. CDA may include encounter history but not scheduling details.

**Documents/images**: **Partially present**. The PDF "Run Report" export is specifically designed to export documents. The documentation notes that PDFs generated in Neo are machine-readable but faxed documents are image-only. However, there's no indication of what document types are available or whether all documents are included.

**Audit/access**: **Not addressed** (though this is expected — audit trails are not part of the Designated Record Set).

### Issues & Red Flags

1. **Minimal documentation**: The entire EHI export "documentation" is a ~150-word FAQ article. There is no data dictionary, no field listing, no schema documentation, and no downloadable specification. This is among the most minimal documentation we've encountered.

2. **No data dictionary whatsoever**: The b(10) requirement calls for documentation of the export content. A short FAQ describing UI clicks does not constitute meaningful documentation of what data is included in the export.

3. **CDA + PDF export approach is inherently limiting**: CDA covers clinical summaries. PDF is not machine-readable structured data. Together, these formats cannot comprehensively represent billing, insurance, scheduling, messaging, or audit data.

4. **"Contact IT Support" for full export**: The documentation explicitly directs users to contact IT support for the "complete client dataset," suggesting the self-service export is incomplete. This may mean the full export is staff-assisted (not self-service), which raises questions about accessibility.

5. **Self-developed system by a behavioral health organization**: Neo is not a commercial EHR — it's built by KBH for their own use. While this doesn't inherently mean the export is deficient, it means there's no broader customer base demanding comprehensive export functionality, and documentation may reflect internal rather than external needs.

6. **No FHIR certification**: Neo lacks g(10) FHIR API certification, so there's no alternative structured data access path for patients. The EHI export (b)(10) is the only way for patients to get their data beyond the patient portal.

7. **SSL certificate issues**: The support site has SSL certificate problems (curl fails without -k flag), suggesting infrastructure maintenance gaps.
