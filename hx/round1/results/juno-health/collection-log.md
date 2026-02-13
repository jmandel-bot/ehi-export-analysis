# Juno Health — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 10348, 10961, 11283, 11475, 11497
- **Products**: Juno CQMsolution, Juno ConnectEHR, Juno EHR, Juno Patient Portal, RxTracker
- **Registered URL**: https://www.junohealth.com/ehiexport

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.junohealth.com/ehiexport" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP/2 200. The URL returns a valid HTML page. HubSpot-hosted site (x-hs-hub-id: 20122396). Behind Cloudflare CDN. No redirects. Content-Type: text/html; charset=UTF-8.

### Step 2: Page examination

```bash
curl -sL "https://www.junohealth.com/ehiexport" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html  # 69,715 bytes
```

The page is a standard HubSpot-hosted page with real HTML content (not a SPA). Title: "EHI Tables Export | Juno Health".

Key content extracted from page text:
- "EHI Export allows health systems to do a manual one-time export of health data for one or more patients."
- "The EHI Tables export contains the electronic health information available in a patient's record in multiple computable, comma-separated value (CSV) formatted files reflecting the native structures of Juno EHR."
- "Refer to the following links for more information about the data included in each export pertaining to the data relevant in the resulting CSV outputs."

### Step 3: Finding product-specific documentation links

The landing page has four product buttons linking to separate documentation pages. The buttons use HubSpot CTA tracking redirects (`/cs/c/?cta_guid=...&redirect_url=...`). I followed each redirect to find the actual destinations:

```bash
# Juno EHR button redirect:
curl -sI -L -H 'User-Agent: Mozilla/5.0' 'https://www.junohealth.com/cs/c/?cta_guid=46e52013-d3a3-42be-8e6d-fded34bb6972&signature=AAH58kHpLomI-V0WI1iu22DUqTQaSxlgZw&portal_id=20122396&pageId=141612672787&placement_guid=b3b31fc8-87ba-4ee1-84dc-b0c1faf4d3ac&redirect_url=APefjpGUzYxuKZasdaxrkpBu1trjQ2csFqtr_t3WAm55Jppb0YLL74VFUR3iJz-OY2VMab8WY2iUx3TsQRfn601iaFlAwyc0SKa3W7eLyyJtbmfw_Ydo3Q1VDf83T7o1Atxkd3xqkO0y' 2>&1 | grep -i location
# → https://ehiexports.junohealth.com/jehr/

# Juno RxTracker button redirect:
curl -sI -L -H 'User-Agent: Mozilla/5.0' 'https://www.junohealth.com/cs/c/?cta_guid=1e4b8cec-e20a-4075-b10a-7587b090c586&signature=AAH58kH44kUF65lH_baxszZfu5_af3KxQw&portal_id=20122396&pageId=141612672787&placement_guid=c28f0214-cc82-40e9-a291-627b54cfcacc&redirect_url=APefjpHpImT6lgqkZljIE1IdJNsmFGkngXdxKGkj4K6z7gfpcLBxNVG_Bb42o3F9I0hqctEFcGmbW25bLxQnUODy2YwG-zasNLRaOj4bgCh9h6ARAO3kY_gQSfJ0MdLOrY-XLjdZhqcZ' 2>&1 | grep -i location
# → https://ehiexports.junohealth.com/rtvx/

# Juno ConnectEHR & CQMsolution button redirect:
# → https://www.junohealth.com/ehiexport/connectehr-cqmsolution

# Juno Patient Portal button redirect:
# → https://www.junohealth.com/ehiexport/juno-patient-portal
```

**Four product-specific documentation destinations identified:**

| Product | Destination URL | Hosting |
|---------|----------------|--------|
| Juno EHR | https://ehiexports.junohealth.com/jehr/ | Azure Blob Storage (static HTML) |
| RxTracker | https://ehiexports.junohealth.com/rtvx/ | Azure Blob Storage (static HTML) |
| ConnectEHR & CQMsolution | https://www.junohealth.com/ehiexport/connectehr-cqmsolution | HubSpot |
| Patient Portal | https://www.junohealth.com/ehiexport/juno-patient-portal | HubSpot |

### Step 4: Examining each destination

#### Juno EHR (ehiexports.junohealth.com/jehr/)

```bash
curl -sI -L -H 'User-Agent: Mozilla/5.0' 'https://ehiexports.junohealth.com/jehr/' 2>&1
# HTTP/2 200, content-type: text/html, content-length: 201001
```

This is a dedicated export schema documentation site hosted on Azure Blob Storage. Title: "JunoEHR Export Schema". The index page lists **1,256 tables** organized alphabetically (A through V), each linking to a separate `.html` page on the same host (e.g., `./ALLERGY.html`).

Each individual table page contains:
- Table name and description
- Primary key columns
- Foreign key columns with referenced table names
- Full column listing with: ordinal position, column name, SQL data type (INT, NVARCHAR, DATETIME2, etc.), and description

This is a genuine database schema export — these are the native SQL Server table structures.

#### RxTracker (ehiexports.junohealth.com/rtvx/)

```bash
curl -sI -L -H 'User-Agent: Mozilla/5.0' 'https://ehiexports.junohealth.com/rtvx/' 2>&1
# HTTP/2 200, content-type: text/html, content-length: 17002
```

Same structure as Juno EHR but smaller. Lists **66 tables** with the same field-level documentation format. Table names suggest pharmacy/medication-focused system (PRESCRIPTIONS, MEDICATION_ORDERS, HOSPITAL_MEDICATIONS, etc.).

#### ConnectEHR & CQMsolution (HubSpot page)

A prose-based page with screenshots. Key findings:
- **ConnectEHR**: Exports in **C-CDA 2.1 XML format**. Supports single-patient and bulk data export. Certified to (b)(10) under limited ePHI USCDIv1 definition.
- **CQMsolution**: Exports **QRDA I XML files** containing patient-level data. "Any QRDA I program output satisfies 170.315(b)(10) EHI Export requirements."
- Includes screenshots of the ConnectEHR admin UI showing the Data Export workflow.

#### Patient Portal (HubSpot page)

Another prose-based page. Key findings:
- Exports in **C-CDA standardized format**.
- Certified to (b)(10) under USCDIv1 definition.
- Supports single-patient and patient population exports on-demand.
- Includes screenshots of the Portal UI showing the Regulatory Reports workflow.

### Step 5: Additional notes from the landing page

The bottom of the landing page contains a disclaimer about export variability:
- "Some electronic health information might not be available in a table format; such as image files or pdf, xml and text documents. The actual files will be exported to the host directory along with the CSVs."
- Content varies based on: software applications in use, software version, documentation practices, configuration decisions, and health system materials not sourced from Juno.

## Downloads

### landing-page.html (69,715 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' 'https://www.junohealth.com/ehiexport' \
  -o /home/exedev/EHI/wiggum/results/juno-health/downloads/landing-page.html
```
Verified: HTML document, Unicode text, UTF-8 text

### jehr-ehi-tables.html (201,001 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' 'https://ehiexports.junohealth.com/jehr/' \
  -o /home/exedev/EHI/wiggum/results/juno-health/downloads/jehr-ehi-tables.html
```
Verified: HTML document, ASCII text. Index page listing 1,256 table definitions with links to individual table pages at `https://ehiexports.junohealth.com/jehr/{TABLE_NAME}.html`.

### rtvx-ehi-tables.html (17,002 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' 'https://ehiexports.junohealth.com/rtvx/' \
  -o /home/exedev/EHI/wiggum/results/juno-health/downloads/rtvx-ehi-tables.html
```
Verified: HTML document, ASCII text. Index page listing 66 table definitions.

### connectehr-cqmsolution.html (83,803 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' 'https://www.junohealth.com/ehiexport/connectehr-cqmsolution' \
  -o /home/exedev/EHI/wiggum/results/juno-health/downloads/connectehr-cqmsolution.html
```
Verified: HTML document, Unicode text, UTF-8 text

### patient-portal.html (85,086 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' 'https://www.junohealth.com/ehiexport/juno-patient-portal' \
  -o /home/exedev/EHI/wiggum/results/juno-health/downloads/patient-portal.html
```
Verified: HTML document, Unicode text, UTF-8 text

**Note**: The JEHR and RTVX index pages link to 1,322 individual table HTML pages (1,256 + 66) on the Azure-hosted `ehiexports.junohealth.com` domain. These were not bulk-downloaded since no ZIP archive is provided. The index pages themselves contain the full table listing and are the primary artifacts. A sample page (`ALLERGY.html`) was verified to contain complete field-level schema documentation.

## Obstacles & Notes

1. **HubSpot CTA tracking links**: The four product buttons on the landing page use HubSpot's CTA redirect system (`/cs/c/?cta_guid=...`). These don't work as direct links in curl without following redirects. The actual destination URLs are embedded in the `redirect_url` parameter (base64-encoded). Following the redirect with `-L` works fine.

2. **Azure Blob Storage hosting**: The `ehiexports.junohealth.com` subdomain serves static HTML from Azure. The root URL (`/`) returns 404 — only the specific paths (`/jehr/`, `/rtvx/`) work.

3. **No downloadable archive**: Unlike some vendors who provide a ZIP of all documentation, Juno's JEHR/RTVX table documentation is spread across 1,322 individual HTML pages. The index pages were downloaded but not all 1,322 individual table pages.

4. **Cookie banner**: The HubSpot pages show a cookie consent banner on first visit, but it doesn't block content access via curl.

5. **No anti-bot protection**: Standard User-Agent header was sufficient for all pages. No Cloudflare challenges or bot detection encountered.
