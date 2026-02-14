# Extended Care Professional, LLC — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10619
- Registered URL: https://www.ecp123.com/exporting-electronic-health-information-ehi?hs_preview=FslteQVE-143661230087
- Developer: Extended Care Professional, LLC
- Product: ECP v8.0
- Certification Date: 2021-05-14
- Certified Criteria: (b)(10), (d)(12), (d)(13), (g)(4), (g)(5)

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.ecp123.com/exporting-electronic-health-information-ehi?hs_preview=FslteQVE-143661230087" -H 'User-Agent: Mozilla/5.0'
```
Result: HTTP/2 200, Content-Type: text/html;charset=utf-8, served via Cloudflare. HubSpot-hosted page (x-hs-hub-id: 9346926, x-hs-content-id: 143661230087). The `hs_preview` query parameter is a HubSpot preview token. Notable: `x-robots-tag: none` on the preview URL version.

Also confirmed the page works without the preview parameter:
```bash
curl -sI "https://www.ecp123.com/exporting-electronic-health-information-ehi" -H 'User-Agent: Mozilla/5.0'
```
Result: HTTP/2 200, same content ID (143661230087). The non-preview version has standard caching (s-maxage=36000) and no x-robots-tag.

### Step 2: Page examination
```bash
curl -sL "https://www.ecp123.com/exporting-electronic-health-information-ehi?hs_preview=FslteQVE-143661230087" -H 'User-Agent: Mozilla/5.0' -o /tmp/ecp-page.html
wc -c /tmp/ecp-page.html
```
Result: 222,959 bytes. Static HTML served by HubSpot CMS — no SPA/JavaScript-only content. Page renders fully via curl. Majority of file size is CSS, navigation menus, and HubSpot boilerplate. The actual EHI content is a relatively small section within the page body.

### Step 3: Finding the EHI section
The page content was directly accessible — no accordion expansion, tab navigation, or JavaScript interaction needed. The URL leads directly to the EHI export documentation page. The page title is "Exporting Electronic Health Information (EHI)".

The page is a simple instructional guide organized into three sections:
1. Export at the Company-Wide Level
2. Export at the Location Level
3. Export at the Resident Level

Each section contains step-by-step instructions with annotated screenshots showing the ECP user interface.

### Step 4: Identified downloadable assets
No downloadable files (PDF, ZIP, etc.) are linked from the page. The documentation consists entirely of the HTML page itself with embedded screenshot images hosted on HubSpot's CDN.

**Embedded screenshots (11 total):**
1. `home_screen_exec_menu.png` — Home screen with Executive Menu highlighted
2. `exec_reports_generator.png` — Executive Administration > Reports tab showing available reports
3. `report_generator_resident_file.png` — Report Generator Exec window listing available report types and communities
4. `report_generator_search_report.png` — Search Reporter showing field-level selection for Resident File Information
5. `report_generator_export.png` — Report results with Save to Excel / Save to PDF buttons
6. `home_screen_admin_menu.png` — Home screen with Admin Menu highlighted
7. `admin_reports_vaccines.png` — Administration > Reports tab showing available reports
8. `admin_reports_vaccines_export.png` — Vaccination & Screenings report with Export Options
9. `home_screen_resident.png` — Home screen with resident tile highlighted
10. `resident_history_vitals.png` — Resident record > History tab showing available history reports
11. `vitals_history_export.png` — Vitals History report with PDF/Excel export icons

Searched for additional links:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/ecp-page.html
# No results

grep -oiE 'href="[^"]*"' /tmp/ecp-page.html | grep -iE 'ehi|export|data.dictionary|b.10|download'
# Only result: href="https://www.ecp123.com/exporting-electronic-health-information-ehi" (self-reference)
```

### Step 5: No additional documentation found
The page contains no links to data dictionaries, schema documentation, field definitions, table listings, or export format specifications. There are no "Download" buttons for documentation files. The entirety of the EHI export documentation is the instructional web page with screenshots.

## Downloads

### ehi-export-page.html (223 KB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o downloads/ehi-export-page.html \
  'https://www.ecp123.com/exporting-electronic-health-information-ehi?hs_preview=FslteQVE-143661230087'
```
Verified: HTML document, 222,959 bytes
Saved to: downloads/ehi-export-page.html

### ehi-page-screenshot-full.png (1.4 MB)
Full-page browser screenshot of the EHI documentation page.
Captured via Chrome DevTools.
Saved to: downloads/ehi-page-screenshot-full.png

### Screenshot images from page (downloaded individually via curl)
All screenshots downloaded from HubSpot CDN URLs embedded in the page:

| File | Size | Description |
|------|------|-------------|
| exec_reports_generator.png | 154 KB | Executive Administration > Reports tab |
| report_generator_resident_file.png | 268 KB | Report Generator showing available report types |
| report_generator_search_report.png | 185 KB | Field selection UI for Resident File Information |
| report_generator_export.png | 295 KB | Report results with export buttons |
| admin_reports_vaccines.png | 180 KB | Administration > Reports tab |
| admin_reports_vaccines_export.png | 231 KB | Vaccination report with export options |
| home_screen_exec_menu.png | 464 KB | Home screen - Executive Menu |
| home_screen_admin_menu.png | 462 KB | Home screen - Admin Menu |
| home_screen_resident.png | 465 KB | Home screen - Resident tile |
| resident_history_vitals.png | 234 KB | Resident History tab |
| vitals_history_export.png | 230 KB | Vitals History export |

Example curl command:
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o downloads/report_generator_resident_file.png \
  'https://www.ecp123.com/hs-fs/hubfs/report_generator_resident_file.png?width=1578&height=2000&name=report_generator_resident_file.png'
```

## Obstacles & Notes
- No anti-bot issues. Cloudflare is present but does not block curl with a standard User-Agent.
- The `hs_preview` parameter in the registered URL suggests this page may have been registered while still in draft/preview mode. The page also works without the preview parameter at the canonical URL.
- No downloadable documentation files exist — the entire EHI export documentation is a single HTML page with screenshots.
- No data dictionary, no schema documentation, no field definitions beyond what's visible in the screenshots.

---

## Product: ECP

### Product Context
ECP (Extended Care Professional) is a specialty, vertically-integrated EHR and operational management platform built specifically for the **senior living and long-term care (LTC) industry** — particularly assisted living communities, independent living, memory care, I/DD programs, and group homes. It is NOT a general-purpose hospital or ambulatory EHR.

The product consists of five integrated modules:
1. **eMAR** — Electronic Medication Administration Record with pharmacy integration (600+ LTC pharmacies), AI-powered safety tools, controlled substance tracking
2. **EHR and Care Plans** — Assessments, automated care plan generation, task management, incident reporting, compliance automation, digital signatures
3. **Billing** — Automated charge capture, payment processing (check/ACH/credit/debit), invoice management, general ledger export, financial reporting
4. **CRM** — Lead management, pipeline tracking, calendar/email integration for sales/marketing
5. **Move-Ins** — Admissions workflow management, digital document management, family-facing tools

ECP serves 8,000+ communities with 120,000+ daily users across all 50 US states. The company has secured growth financing and is investing in AI capabilities.

The certified module name is simply "ECP" version 8.0, and the certification is very minimal — only (b)(10) EHI export, (d)(12)/(d)(13) authentication/encryption, and (g)(4)/(g)(5) quality management/accessibility. No clinical criteria (a)(1)-(a)(14), no patient portal (e)(1), no FHIR API access (g)(7)-(g)(10). This is unusual — the product clearly has clinical capabilities but only sought certification for a very limited set of criteria.

### Export Approach
ECP's EHI export is a **report-based, user-driven export** — not a database dump, not FHIR, not C-CDA. Users navigate the ECP UI to generate reports at three levels (company-wide, location, resident), select which fields to include, and export the results to Excel or PDF.

This approach has significant implications:
- **Not a bulk export**: There is no single "export all EHI" button. Users must navigate to multiple reports and export each one separately.
- **Field selection required**: The user must manually select which fields to include in each report. This creates a risk that data is missed if the user doesn't select all fields.
- **Report-by-report**: Each report type (Resident File Information, Diagnoses, Medications, etc.) must be exported separately and then combined.
- **Excel/PDF format only**: Exported data is in Excel or PDF. Excel is machine-readable; PDF is not.

**Data categories visible in the Report Generator Exec (company-wide level):**
- Apartment Information
- Employee Information
- Fall Report
- Incident Reports
- Resident Contact Information
- Resident Diagnoses
- Resident File Information
- Resident Providers and Office
- Resident Tasks / Meds (partially visible — list may extend further)

**Reports visible in Administration > Reports tab (location level):**
- Apartment Census
- Audit Log
- Infections Report
- Invoices from ECP
- Level of Care Change Report
- Rent Roll
- Report Generator
- Risk Analysis Tool
- Symptoms Report
- Vaccination & Screenings Report

**History reports visible at the Resident level:**
- Care Provided History
- Med Pass History
- Observation History
- Vitals History
- Incident Reports On File
- Medication History (MAR)
- Fall Reports On File
- Assessments On File
- Question History
- Care History (TAR)

**Resident record also shows tabs for:** Face Sheet, Physician Order Sheet, Life Story, Provide Services, Resident, Care Plan, History, Addt. Reports

**Fields visible in the "Resident File Information" Search Reporter:**
First Name, Middle Initial, Last Name, Nickname, Suffix, Marital Status, Birthday, Gender, Race, Language, Religion, Social Security Number, Medicare, Medicaid, Residency Start/End, Apartment Number, Phone, Task Rating, Hospital Preference, Funeral Home Pref, Pharmacy Preference, Pharmacy Phone, Code Status, Health Care Power of Attorney, Health Care POA Status/Name, State Appointed Guardian, Guardian Name...

### EHI Coverage Assessment

**Clinical data: LIKELY PRESENT (partial)**
The screenshots show clinical reports including: Resident Diagnoses, Medication History (MAR), Med Pass History, Vitals History, Assessments On File, Care History (TAR), Care Provided History, Observation History, Physician Order Sheet. This covers core clinical categories for a long-term care setting. However, we only see report names — there is no documentation of what fields each report contains or how comprehensive the data is.

**Secure messages: NOT DOCUMENTED**
No evidence of messaging, inbox, communication, or patient/family portal messaging in any of the screenshots or documentation. ECP does not appear to have a patient portal (no (e)(1) certification), though the Move-Ins module does have family-facing digital document tools. If any messaging capability exists, it is not represented in the export documentation.

**Billing/financial: PARTIALLY PRESENT**
"Invoices from ECP" and "Rent Roll" appear in the Administration reports. The Executive Administration shows "Petty Cash Report" and "Service Summary Report." The Billing module is a core product feature with charge capture, payment processing, and invoice management — but the export documentation doesn't show these billing-specific reports as clearly exportable. The Report Generator at the executive level doesn't list billing-specific report types.

**Insurance/coverage: NOT DOCUMENTED**
The Resident File Information fields show Medicare and Medicaid numbers but no insurance plan details, eligibility, authorization, or coverage information. For a long-term care setting, this would include Medicaid/Medicare coverage details, long-term care insurance, and level-of-care authorization data.

**Appointments/scheduling: NOT APPLICABLE / NOT DOCUMENTED**
Long-term care facilities typically don't have appointment scheduling in the same way as ambulatory settings. ECP does not appear to have scheduling functionality. The Residency Start/End dates serve as the equivalent of admission/discharge. Level of Care Change Report serves as a care transition record.

**Documents/images: NOT DOCUMENTED**
No document management, scanned documents, or image export visible in the documentation. The Move-Ins module mentions families can "upload files" and the CRM has "digital signatures," but no export mechanism for these documents is shown.

**Audit trails: PRESENT**
An "Audit Log" report is visible in the Administration > Reports tab. This is notable — many vendors don't include audit data. However, no details are provided about what the audit log contains or how comprehensive it is.

### Issues & Red Flags

1. **No data dictionary or schema documentation**: The EHI export documentation is just a user guide showing how to navigate the UI to generate reports. There is no documentation of what data fields are available in each report, what data types they use, or how the reports relate to each other. This is a significant documentation gap.

2. **Manual, report-by-report export**: The export approach requires users to navigate to multiple different parts of the UI and export each report type separately. There is no single "export all EHI" mechanism. This makes it impractical to export a complete patient record and creates risk of missing data categories.

3. **User must select fields**: For at least some reports (the Report Generator), users must manually select which fields to include. If a user doesn't select all fields, data will be missing from the export.

4. **PDF as an export format**: While Excel is also offered, PDF is one of the two export options. PDF is not machine-readable. The documentation doesn't recommend one format over the other.

5. **Incomplete report list**: The Report Generator Exec screenshot is cut off at "Resident Tasks / Meds" — the full list of available report types is not documented.

6. **Billing gap**: ECP has a full Billing module (charges, payments, invoices, GL export) but the export documentation doesn't clearly show how billing data is exported. "Invoices from ECP" and "Rent Roll" appear in Admin reports but no billing detail reports are visible in the Report Generator.

7. **CRM/Move-Ins data**: The CRM and Move-Ins modules store lead information, family contacts, admissions documents, and signed forms. None of this data appears in the export documentation.

8. **Preview URL**: The registered URL contains `hs_preview=FslteQVE-143661230087`, a HubSpot preview token. This suggests the page may have been registered while still in draft/preview mode, though it does also work at the canonical URL without the preview parameter.

9. **Minimal certification scope**: ECP is only certified for (b)(10), (d)(12), (d)(13), (g)(4), (g)(5) — no clinical criteria, no API access, no patient portal. This is unusual for a product with clinical EHR capabilities and suggests a minimal certification strategy.
