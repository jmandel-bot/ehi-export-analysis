# Epic Systems Corporation — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11595, 11596, 11597, 11603, 11604, 11641, 11643, 11644, 11653, 11654, 11683, 11684, 11685, 11686, 11687, 11711, 11712, 11713, 11730, 11731
- **Products**: 
  - Beacon Cancer Registry Reporting
  - Beaker Reportable Labs Reporting
  - EpicCare Ambulatory Base
  - EpicCare Inpatient Base
  - Infection Control Antimicrobial Use and Resistance Reporting
- **Registered URL**: https://open.epic.com/EHITables
- **Collection Date**: February 13, 2026

## Navigation Journal

### Step 1: Initial probe

Checked what the URL returns:

```bash
curl -sI -L "https://open.epic.com/EHITables" -H 'User-Agent: Mozilla/5.0' 2>&1
```

**Result**: 
- HTTP 200 OK
- Content-Type: text/html; charset=utf-8
- Server: Microsoft-IIS/10.0 (ASP.NET MVC application)
- Content-Length: 8742 bytes
- No redirect chain, direct 200

**Conclusion**: The URL returns a static HTML page, not a direct file download.

### Step 2: Page examination

Fetched and examined the HTML content:

```bash
curl -sL "https://open.epic.com/EHITables" -H 'User-Agent: Mozilla/5.0' -o /tmp/epic-page.html
wc -c /tmp/epic-page.html
```

**Result**: 8,742 bytes

Examined content with:
```bash
cat /tmp/epic-page.html | sed 's/<[^>]*>/ /g' | tr -s ' \n' | head -100
```

**Finding**: The page contains substantive content (not a thin JS loader). Visible text includes navigation menu items like "Step-by-Step Developer Guide", "Data Sharing Playbooks", "Specifications".

### Step 3: Finding documentation links

Searched the HTML source for relevant links:

```bash
grep -oiE 'href="[^"]*"' /tmp/epic-page.html | grep -iE 'ehi|export|data|dictionary|table'
```

**Found**:
- `href="/EHITables/TechSpec"` — Technical specifications / table index
- `href="/EHITables/Download"` — Download link
- `href="../Interface/FHIR#BulkDataAccess"` — FHIR reference (not relevant)

### Step 4: Browser navigation to see the full page

Navigated to https://open.epic.com/EHITables in the browser to see the complete rendered page.

**What I saw**:
- Page title: "EHI Tables Export"
- Clear description: "EHI Export functionality allows health systems to do a manual one-time export of health data for one or more patients."
- Key statement: "The EHI Tables export contains the electronic health information available in a patient's Epic record in a **computable, tab-separated value (TSV) file format** native to Epic."
- Reference to "the EHI Tables index" (links to TechSpec page)
- Reference to "download the index as a zip file" (links to Download page)
- Notes that "Some electronic health information might not be available in a table format, such as rich text documents or images. This information might be referenced from the EHI Tables, but the actual files can be reviewed in a separate download in the export."

**Screenshot saved**: `screenshot-main-page.png` (not saved but visible in browser)

### Step 5: Exploring the table index (TechSpec)

Navigated to https://open.epic.com/EHITables/TechSpec

**What I saw**:
- Page title: "EHI Export Schema"
- Documentation timestamp: "as of 2/12/2026 at 2:10 PM CT in the current released version of February 2026"
- Alphabetical navigation (A through W)
- Long list of tables, starting with ABN_DOCUMENT_ID, ABN_FOLLOW_UP, etc.
- Tables organized alphabetically with blue hyperlinks

**Screenshot saved**: `screenshot-table-index.png`

### Step 6: Examining individual table detail

Clicked on **ACCT_COVERAGE** table to see the detail format.

**What I saw**:
- Table name: ACCT_COVERAGE
- Description: "This table contains coverage lists for every accounts receivable (EAR) record."
- **Primary Key** section showing columns and ordinal positions
- **Column Information** section with detailed field definitions:
  - Column number
  - Name (e.g., ACCOUNT_ID, LINE, COVERAGE_ID)
  - Data Type (e.g., NUMERIC, INTEGER, VARCHAR)
  - Discontinued? (Yes/No)
  - Description for each field
  - Some fields include "May contain organization-specific values: Yes"
  - Some fields include "Category Entries:" with enumerated values

**Screenshot saved**: `screenshot-table-detail.png`

### Step 7: Locating the download

From the main page, identified the download link at `/EHITables/Download`.

Tested with curl:
```bash
curl -sI -L "https://open.epic.com/EHITables/Download" -H 'User-Agent: Mozilla/5.0'
```

**Result**:
- HTTP 200 OK
- Content-Type: application/x-zip-compressed
- Content-Disposition: attachment; filename="Epic EHI Tables.zip"
- Content-Length: 12,664,966 bytes (~12.7 MB)

**Conclusion**: Direct ZIP file download. No JavaScript interaction needed.

## Downloads

### Epic_EHI_Tables.zip (12.7 MB)

**Download command**:
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o Epic_EHI_Tables.zip \
  'https://open.epic.com/EHITables/Download'
```

**Verification**:
```bash
file Epic_EHI_Tables.zip
# Result: Zip archive data, at least v2.0 to extract, compression method=deflate

ls -lh Epic_EHI_Tables.zip
# Result: 12,664,966 bytes (13M)
```

**Archive contents**:
```bash
unzip -l Epic_EHI_Tables.zip | tail -10
# Result: 7,674 files, 83,024,535 bytes uncompressed
```

**Extraction**:
```bash
mkdir -p extracted
unzip -q Epic_EHI_Tables.zip -d extracted/
```

**Structure**:
- Single directory: `DocGen_su117s2p_2026-02-12_14.10.01/`
- Contains 7,673 HTML files (one per table) + 1 CSS file
- Each HTML file is a standalone table schema documentation
- File naming: `TABLE_NAME.htm` (e.g., `PATIENT.htm`, `ACCT_COVERAGE.htm`)

**File count**: 7,673 tables documented

**Sample files**:
- `PATIENT.htm` — Patient demographics (85 columns)
- `AP_CLAIM.htm` — Managed care claims (133 columns)
- `ACCT_COVERAGE.htm` — Insurance coverage
- `ORDERS_COPIED_FROM.htm` — Order information
- `LAB_CASE_DB_MAIN.htm` — Laboratory results
- `CLARITY_MEDICATION.htm` — Medication data
- `DICOM_MANIFEST.htm` — Medical imaging references
- `CAL_MESSAGE_BODY.htm` — Message content

**Total extracted size**: 93 MB

**Saved to**: 
- `/home/exedev/EHI/wiggum/results/epic-systems-corporation/downloads/Epic_EHI_Tables.zip`
- `/home/exedev/EHI/wiggum/results/epic-systems-corporation/downloads/extracted/`

## Obstacles & Notes

### Positive findings:

1. **Well-designed, accessible documentation**: Epic provides a clean, well-organized HTML interface with no anti-bot measures or JavaScript requirements for basic access.

2. **No special headers required**: Standard User-Agent header works fine, though not strictly required.

3. **Direct download available**: The ZIP archive is directly downloadable without any login, captcha, or click-through agreements.

4. **Comprehensive coverage**: 7,673 tables documented is extraordinarily comprehensive — this represents Epic's entire database schema available in EHI exports.

5. **High-quality documentation**: Each table includes:
   - Clear description of purpose
   - Primary key definition
   - Full column list with data types
   - Field-level descriptions
   - Notes about organization-specific customizations
   - Enumerated value lists where applicable

6. **Current and timestamped**: Documentation clearly states it reflects "February 2026" release and was generated on "2/12/2026 at 2:10 PM CT".

### Technical notes:

- The ZIP file uses Windows-style backslashes as path separators (warning during extraction on Linux)
- HTML files are well-formed and include a shared CSS stylesheet (`CRStyleSheet.css`)
- Each HTM file is standalone and can be opened independently
- The web interface at TechSpec provides alphabetical navigation, but the ZIP contains all tables in a flat directory

### Comparison to typical vendor patterns:

**This is the gold standard**. Epic's EHI documentation is:
- **Publicly accessible** (no login required)
- **Complete** (thousands of tables, not a subset)
- **Detailed** (field-level with data types and descriptions)
- **Downloadable** (full ZIP archive provided)
- **Well-maintained** (current as of February 2026)
- **Easy to access** (no anti-bot measures, JavaScript requirements, or navigation complexity)

Most other vendors provide far less comprehensive documentation, often PDFs with summary-level information or gated behind customer portals.

## Summary

Epic Systems Corporation provides exemplary EHI export documentation through a well-designed public website at open.epic.com/EHITables. The documentation covers 7,673 database tables representing the complete Epic EHI export schema, with field-level detail including data types, descriptions, and enumerated values. The entire documentation set is downloadable as a 12.7 MB ZIP file containing individual HTML files for each table. No obstacles were encountered — the documentation is easily accessible, comprehensive, and current.
