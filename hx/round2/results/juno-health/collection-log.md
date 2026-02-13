# Juno Health — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10348, 10961, 11283, 11475, 11497
- Products: Juno CQMsolution, Juno ConnectEHR, Juno EHR, Juno Patient Portal, RxTracker
- Registered URL: https://www.junohealth.com/ehiexport

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.junohealth.com/ehiexport" -H 'User-Agent: Mozilla/5.0'
```

Result: HTTP/2 200 direct (no redirects). The page is served via Cloudflare, hosted on HubSpot (x-hs-hub-id: 20122396). Content-Type: text/html; charset=UTF-8. No content-disposition header — this is an HTML page, not a file download.

### Step 2: Page examination

```bash
curl -sL "https://www.junohealth.com/ehiexport" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html  # 69,715 bytes
```

The page is a HubSpot-hosted site page with real HTML content (not a SPA). Title: "EHI Tables Export | Juno Health". The page has a full site navigation header (Who We Are, Who We Serve, EHR Solutions, Resources, Support) and a main content area.

### Step 3: Finding the EHI section

The main content is visible directly on the page. The heading is **"EHI Tables Export"** followed by a description:

> "EHI Export allows health systems to do a manual one-time export of health data for one or more patients. The EHI Tables export contains the electronic health information available in a patient's record in multiple computable, comma-separated value (CSV) formatted files reflecting the native structures of Juno EHR."

Below the description are four CTA buttons linking to product-specific documentation:
1. **Juno EHR** 
2. **Juno RxTracker**
3. **Juno ConnectEHR & Juno CQMSolution**
4. **Juno Patient Portal**

Additional text notes that non-tabular data (images, PDFs, XML, text documents) will be exported alongside CSVs, and that export content may vary based on software version, configuration, and third-party materials.

### Step 4: Resolving CTA button destinations

The four buttons are HubSpot CTA redirects. To find the actual destinations, I resolved the redirect URLs:

```bash
curl -sI -L -H 'User-Agent: Mozilla/5.0' "https://cta-redirect.hubspot.com/cta/redirect/20122396/b3b31fc8-87ba-4ee1-84dc-b0c1faf4d3ac"
```

The `x-amz-website-redirect-location` header revealed the final destinations:

| Button | Redirect URL |
|--------|-------------|
| Juno EHR | https://ehiexports.junohealth.com/jehr/ |
| Juno RxTracker | https://ehiexports.junohealth.com/rtvx/ |
| ConnectEHR & CQMSolution | https://www.junohealth.com/ehiexport/connectehr-cqmsolution |
| Patient Portal | https://www.junohealth.com/ehiexport/juno-patient-portal |

Note: The HubSpot CTA redirect returns HTTP 200 with the redirect location in a header rather than a standard 301/302 — this is a HubSpot-specific behavior. Clicking the buttons in a browser follows the redirect correctly via JavaScript.

### Step 5: Juno EHR schema documentation (ehiexports.junohealth.com/jehr/)

```bash
curl -sL "https://ehiexports.junohealth.com/jehr/" -H 'User-Agent: Mozilla/5.0' -o /tmp/jehr.html
wc -c /tmp/jehr.html  # 201,001 bytes
```

This is a dedicated schema documentation site hosted on a separate subdomain (ehiexports.junohealth.com). The page title is **"JunoEHR Export Schema"** with the subtitle "This documentation describes each JunoEHR-released EHI table."

The page structure:
- Alphabetical index (A-Z) with clickable letters at the top
- Under each letter, a list of table names as links to individual HTML pages
- Each table name links to `./TABLENAME.html` with column-level documentation

I extracted all table names:
```bash
grep -oP 'href="\./([^"]+)\.html"' /tmp/jehr.html | sed 's/href="\.\/(.*)\.html"/\1/' | wc -l
# Result: 1,256 tables
```

### Step 6: Juno EHR individual table documentation

Each table has its own HTML page with:
- Table name and description
- Primary key columns with ordinal positions
- Foreign key columns with referenced tables
- All columns with name, data type (INT, NVARCHAR, BIT, DATE, DATETIMEOFFSET, etc.), and ordinal position

Example: `https://ehiexports.junohealth.com/jehr/PATIENT.html` (41,207 bytes)
- Description: "Demographics and other administrative information about an individual receiving care or other health-related services"
- 52 columns including BIRTHDATE, LKBIRTHSEXID, MOTHERMAIDEN, LKMARITALSTATUSID, LKRELIGIONID, LKVETERANSTATUSID, etc.
- Foreign keys to PATIENTDECEASED, LKMARITALSTATUS, LKREGCONFIDENTIALTYPE, LKRELIGION, etc.

### Step 7: RxTracker schema documentation (ehiexports.junohealth.com/rtvx/)

```bash
curl -sL "https://ehiexports.junohealth.com/rtvx/" -H 'User-Agent: Mozilla/5.0' -o /tmp/rtvx.html
wc -c /tmp/rtvx.html  # 17,002 bytes
```

Same structure as Juno EHR but much smaller: **66 tables**. Title: "RxTracker Export Schema". Tables are pharmacy/medication-focused: PRESCRIPTIONS, HOSPITAL_MEDICATIONS, INPATIENT_MEDICATIONS, OUTPATIENT_MEDICATIONS, MEDICATION_ORDERS, etc.

### Step 8: ConnectEHR & CQMSolution page

```bash
curl -sL "https://www.junohealth.com/ehiexport/connectehr-cqmsolution" -H 'User-Agent: Mozilla/5.0' -o /tmp/connectehr.html
wc -c /tmp/connectehr.html  # 83,803 bytes
```

This is a HubSpot page (same site template) with procedural documentation — no schema. Key details:

- **ConnectEHR**: Exports in **C-CDA 2.1 XML format**. Certified to b(10) under "limited ePHI USCDIv1 definition". Users navigate to Administration > Data Export > Data Export, select patients, and download batches.
- **CQMSolution**: Exports **QRDA I XML files** containing patient-level data. "Any QRDA I program output satisfies 170.315(b)(10) EHI Export requirements." The QRDA I output is described as containing "all EHI stored in Juno CQMsolution for each patient."

### Step 9: Patient Portal page

```bash
curl -sL "https://www.junohealth.com/ehiexport/juno-patient-portal" -H 'User-Agent: Mozilla/5.0' -o /tmp/patientportal.html
wc -c /tmp/patientportal.html  # 85,086 bytes
```

Another HubSpot page with procedural instructions. Key details:
- Exports in **C-CDA standardized format**
- Certified to b(10) under "USCDIv1 definition"
- Users navigate to Organization > Reports > Regulatory Reports, select "Electronic Health Information Request", enter a 30-day report period, select patients, and process the report.

### Step 10: Identified downloadable assets

All documentation is HTML-based (no PDF or ZIP downloads). The key assets are:
1. Landing page: https://www.junohealth.com/ehiexport
2. Juno EHR schema index: https://ehiexports.junohealth.com/jehr/ (1,256 table links)
3. RxTracker schema index: https://ehiexports.junohealth.com/rtvx/ (66 table links)
4. ConnectEHR & CQMSolution instructions: https://www.junohealth.com/ehiexport/connectehr-cqmsolution
5. Patient Portal instructions: https://www.junohealth.com/ehiexport/juno-patient-portal

## Downloads

### ehiexport-landing-page.html (69,715 bytes)
```bash
curl -sL "https://www.junohealth.com/ehiexport" -H 'User-Agent: Mozilla/5.0' -o downloads/ehiexport-landing-page.html
```
Verified: HTML document. Main EHI export landing page with links to four product-specific documentation pages.

### juno-ehr-export-schema.html (201,001 bytes)
```bash
curl -sL "https://ehiexports.junohealth.com/jehr/" -H 'User-Agent: Mozilla/5.0' -o downloads/juno-ehr-export-schema.html
```
Verified: HTML document. Complete index of 1,256 EHI export tables for Juno EHR, with alphabetical navigation and links to individual table documentation pages.

### rxtracker-export-schema.html (17,002 bytes)
```bash
curl -sL "https://ehiexports.junohealth.com/rtvx/" -H 'User-Agent: Mozilla/5.0' -o downloads/rxtracker-export-schema.html
```
Verified: HTML document. Index of 66 EHI export tables for RxTracker.

### connectehr-cqmsolution-export.html (83,803 bytes)
```bash
curl -sL "https://www.junohealth.com/ehiexport/connectehr-cqmsolution" -H 'User-Agent: Mozilla/5.0' -o downloads/connectehr-cqmsolution-export.html
```
Verified: HTML document. Procedural documentation for ConnectEHR (C-CDA 2.1) and CQMSolution (QRDA I) exports.

### patient-portal-export.html (85,086 bytes)
```bash
curl -sL "https://www.junohealth.com/ehiexport/juno-patient-portal" -H 'User-Agent: Mozilla/5.0' -o downloads/patient-portal-export.html
```
Verified: HTML document. Procedural documentation for Patient Portal C-CDA export.

### jehr-sample-tables/ (9 sample table pages)
```bash
for table in PATIENT ENCOUNTER COVERAGE RCM1500CLAIM SCHEDULE OBSERVATION MEDICATIONREQUEST DOCUMENTREFERENCE NOTE; do
  curl -sL "https://ehiexports.junohealth.com/jehr/${table}.html" -H 'User-Agent: Mozilla/5.0' \
    -o "downloads/jehr-sample-tables/${table}.html"
done
```
Verified: 9 HTML files totaling ~345 KB. Representative sample of individual table documentation showing column-level detail (names, data types, foreign keys).

## Product Context

Juno Health (formerly DSS Inc.) develops healthcare software primarily for **critical access and rural hospitals, behavioral health facilities, public health organizations, and state mental health agencies**. They were ranked #1 EHR vendor for rural hospitals by Black Book Market Research in 2025.

The product family includes:
- **Juno EHR**: Full acute care EHR with clinical modules (Clinical Content Builder, ProDash, Clinical Action Center), pharmacy (including VA-style pharmacy — AU_PRESCRIPTION tables suggest VistA/CPRS heritage), laboratory, imaging, nutrition, surgery, scheduling, billing/RCM, document management, and care planning.
- **RxTracker**: A pharmacy/medication management system focused on medication reconciliation, prescriptions, and medication tracking across care settings.
- **Juno ConnectEHR**: An interoperability/HIE module for data exchange and clinical quality reporting.
- **Juno CQMSolution**: Clinical Quality Measures calculation and reporting tool.
- **Juno Patient Portal**: Patient-facing portal for accessing health records.

The table naming conventions in Juno EHR (AU_PRESCRIPTION, AU_PHARMACY_PATIENT, etc.) strongly suggest VistA/CPRS heritage — "AU" likely refers to automated pharmacy utilities from the VA's VistA system. This is consistent with Juno Health's origins as DSS Inc., which built products on top of the VA's VistA EHR for non-VA healthcare facilities.

## Obstacles & Notes

1. **HubSpot CTA redirect quirk**: The product-specific buttons use HubSpot CTA tracking redirects that don't follow standard HTTP redirect patterns. The destination URL is in the `x-amz-website-redirect-location` header, which requires JavaScript to follow in a browser. curl follows this correctly with `-L`.

2. **Separate documentation subdomain**: The Juno EHR and RxTracker schema docs live on `ehiexports.junohealth.com`, a separate subdomain from the main site. This is a purpose-built documentation host, not part of the HubSpot CMS.

3. **No downloadable archive**: Unlike some vendors that provide a ZIP download of all documentation, Juno Health's schema docs are served as individual HTML pages (1,256+ pages for Juno EHR alone). Downloading the complete set would require scraping all individual table pages.

4. **Four separate products, four different export approaches**: Juno EHR exports native database CSV files (1,256 tables), RxTracker exports native database CSV files (66 tables), ConnectEHR exports C-CDA 2.1 XML, CQMSolution exports QRDA I XML, and Patient Portal exports C-CDA. This is an unusually fragmented approach.
