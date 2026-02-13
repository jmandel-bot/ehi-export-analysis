# MEDITECH — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 9091, 9092, 9095, 9101, 9103, 9107, 9108, 9109, 9162, 9238, 9258, 9265, 10924, 10925, 10926, 10927, 10929, 10930, 10931, 10932, 10933, 10934, 10935, 10972, 10973, 10976, 10977, 10978, 10979, 10981, 10982, 10984, 10985, 10988, 10993, 10994, 10995, 11018, 11742, 11743
- **Products**: MEDITECH 6.0 Electronic Health Record Core HCIS, MEDITECH 6.0 Emergency Department Management, MEDITECH 6.1 Ambulatory Electronic Health Record, MEDITECH 6.1 Electronic Health Record Core HCIS, MEDITECH 6.1 Emergency Department Management, MEDITECH 6.1 Oncology, MEDITECH Cancer Case Reporting, MEDITECH Client/Server Electronic Health Record Core HCIS, MEDITECH Client/Server Emergency Department Management, MEDITECH Client/Server Oncology, MEDITECH Continuity of Care Interface (CCD), MEDITECH Expanse 2.1 Ambulatory, MEDITECH Expanse 2.1 Core HCIS, MEDITECH Expanse 2.1 Oncology, MEDITECH Expanse 2.2 Ambulatory, MEDITECH Expanse 2.2 Core HCIS, MEDITECH Expanse 2.2 Emergency Department Management, MEDITECH Expanse 2.2 Oncology, MEDITECH Expanse Emergency Department Management, MEDITECH MAGIC Electronic Health Record Core HCIS, MEDITECH MAGIC Emergency Department Management, MEDITECH MAGIC HCA Electronic Health Record Core HCIS (without PatientKeeper), MEDITECH MAGIC Oncology, MEDITECH MyHealth Portal, MEDITECH Public Health Interface Electronic Case Reporting, MEDITECH Public Health Interface Transmission to Immunization Registries, MEDITECH Public Health Interface for Syndromic Surveillance, MEDITECH Transmission of Reportable Laboratory Test and Values/Results
- **Registered URL**: https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm" -H 'User-Agent: Mozilla/5.0' 2>&1
```

**Result**: 
- HTTP/2 200 (no redirects)
- Content-Type: text/html
- Content-Length: 8964 bytes
- Server: Microsoft-IIS/10.0

**Conclusion**: The URL returns a valid HTML page, not a direct file download.

### Step 2: Page examination

```bash
curl -sL "https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm" -H 'User-Agent: Mozilla/5.0' -o /tmp/meditech_page.html
wc -c /tmp/meditech_page.html
```

**Result**: 8,964 bytes of HTML content

**Content inspection**: The page contains substantive HTML (not a JavaScript SPA loader). The text content describes "MEDITECH's EHI Export capabilities" and references ONC §170.315(b)(10).

### Step 3: Finding the EHI section

The landing page is well-structured and immediately presents the EHI Export documentation. Key findings:

**Main structure**: MEDITECH provides TWO distinct configurations for EHI export, based on platform version:

1. **Configuration 1**: For newer platforms
   - Expanse 2.2, Expanse 2.1, 6.15, 6.08 (Acute only), Client Server (Acute only), MAGIC (Acute only)
   - Configured with: Health Information Management (HIM), Scanning and Archiving with eChart (SCN), Patient Portal (PHM)
   - Export contains: Electronic Chart documents, US Core FHIR data, C-CDA documents, Supplemental Reports
   - Link: `/en/d/restapiresources/pages/ehiexportconfig1.htm`

2. **Configuration 2**: For older/different platforms
   - 6.08 (Ambulatory only), Client Server (Acute & Ambulatory), MAGIC (Acute & Ambulatory)
   - Configured with: Medical Records (MRI), Data Repository (DR)
   - Export contains: **Patient Data Files as CSV**, US Core FHIR data, C-CDA documents, Supplemental Reports
   - Link: `/en/d/restapiresources/pages/ehiexportconfig2.htm`

### Step 4: Identified downloadable assets

**Configuration 1** (`ehiexportconfig1.htm`):
- This page is the documentation itself (HTML format)
- No separate downloadable files - the specifications are embedded in the web page
- Describes the export package structure, folder hierarchy, file naming conventions
- Lists sections by product version (Expanse 2.2, 2.1, 6.15, 6.08, Client/Server, MAGIC)
- Includes JSON schema for the Table of Contents.ndjson file

**Configuration 2** (`ehiexportconfig2.htm`):
- This page also serves as HTML documentation
- Contains THREE downloadable CSV data dictionary PDFs:
  1. Client/Server Acute & Ambulatory: `/en/d/regulatoryresources/otherfiles/csacuteandambehiexportdrsolutionmerged.pdf`
  2. MAGIC Acute & Ambulatory: `/en/d/regulatoryresources/otherfiles/mgehiexportdrsolutionmerged.pdf`
  3. MPM 6.08 Ambulatory: `/en/d/regulatoryresources/otherfiles/608ehiexportcsv.pdf`

These PDFs document the CSV tables/columns included in the export for each platform.

### Step 5: Browser verification

Used browser to navigate to both configuration pages to verify:
- No hidden accordion sections or collapsed content
- No JavaScript-loaded content
- All documentation is visible in the static HTML
- The PDF links are clearly labeled in a table under "Patient Data (CSV) Files" section

## Downloads

### ehiexport_main.html (8,964 bytes)
```bash
curl -sL "https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm" \
  -H 'User-Agent: Mozilla/5.0' \
  -o ehiexport_main.html
```
**Verified**: HTML document
**Saved to**: `downloads/ehiexport_main.html`

### ehiexportconfig1.html (29,280 bytes)
```bash
curl -sL "https://home.meditech.com/en/d/restapiresources/pages/ehiexportconfig1.htm" \
  -H 'User-Agent: Mozilla/5.0' \
  -o ehiexportconfig1.html
```
**Verified**: HTML document
**Saved to**: `downloads/ehiexportconfig1.html`

### ehiexportconfig2.html (22,780 bytes)
```bash
curl -sL "https://home.meditech.com/en/d/restapiresources/pages/ehiexportconfig2.htm" \
  -H 'User-Agent: Mozilla/5.0' \
  -o ehiexportconfig2.html
```
**Verified**: HTML document
**Saved to**: `downloads/ehiexportconfig2.html`

### config2_cs_acute_ambulatory_csv.pdf (257 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o config2_cs_acute_ambulatory_csv.pdf \
  'https://home.meditech.com/en/d/regulatoryresources/otherfiles/csacuteandambehiexportdrsolutionmerged.pdf'
```
**Verified**: PDF document, version 1.4, 20 pages
**Content**: CSV data dictionary for Client/Server Acute & Ambulatory platform
**Saved to**: `downloads/config2_cs_acute_ambulatory_csv.pdf`

### config2_magic_acute_ambulatory_csv.pdf (355 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o config2_magic_acute_ambulatory_csv.pdf \
  'https://home.meditech.com/en/d/regulatoryresources/otherfiles/mgehiexportdrsolutionmerged.pdf'
```
**Verified**: PDF document, version 1.4, 20 pages
**Content**: CSV data dictionary for MAGIC Acute & Ambulatory platform
**Saved to**: `downloads/config2_magic_acute_ambulatory_csv.pdf`

### config2_mpm608_ambulatory_csv.pdf (246 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o config2_mpm608_ambulatory_csv.pdf \
  'https://home.meditech.com/en/d/regulatoryresources/otherfiles/608ehiexportcsv.pdf'
```
**Verified**: PDF document, version 1.4, 19 pages
**Content**: CSV data dictionary for MPM 6.08 Ambulatory platform
**Saved to**: `downloads/config2_mpm608_ambulatory_csv.pdf`

## CSV Data Dictionary Analysis

Extracted table counts from the PDFs:

**MPM 6.08 Ambulatory**: 106 tables documented
- Sample tables: AdmEmployers, AdmInsuredData, AdmVisits, AprEncMessages, SchAppointments, MriPatients, PbrAccountClaims

**Client/Server Acute & Ambulatory**: 196 tables documented
- Sample tables: AdmInsurances, AdmVisits, AprEncMessages, PbrAccountClaims, PbrAccountTransactions, SchAppointments

**MAGIC Acute & Ambulatory**: (similar structure, different table set)

Each PDF uses a three-column format:
- **Field**: Human-readable field name
- **Table**: Database table name (PascalCase)
- **Column**: Actual column name in the CSV file

## Obstacles & Notes

### Access Notes
- **No authentication required**: All documentation is publicly accessible
- **No anti-bot protection**: Standard curl with User-Agent header works fine
- **No JavaScript requirements**: All content is in static HTML
- **Well-organized**: Clear navigation, no hidden or collapsed sections

### Documentation Quality
- **Very comprehensive**: Two distinct configurations properly documented
- **Version-specific**: Clear mapping of which platforms use which configuration
- **Field-level detail**: CSV data dictionaries provide table, column, and field name mappings
- **Export format examples**: HTML pages describe the folder structure and file naming conventions

### Notable Observations

1. **Dual export approach**: MEDITECH offers two fundamentally different export configurations:
   - Config 1: Document-centric (Electronic Chart with images/PDFs)
   - Config 2: Database-centric (CSV files with structured data)

2. **Platform coverage**: The documentation spans a wide range of MEDITECH versions from older MAGIC systems to modern Expanse 2.2, reflecting MEDITECH's large installed base.

3. **Beyond FHIR**: While both configurations include "US Core FHIR Resources", the CSV-based Config 2 clearly provides far more granular data than what would be available via FHIR APIs alone.

4. **Clear regulatory compliance**: Documentation explicitly references ONC §170.315(b)(10) and the 2015 Edition Cures Update Certification Criteria.

5. **Metadata included**: Config 1 exports include a "Table of Contents.ndjson" file with FHIR DocumentReference resources for machine readability.

## Reproducibility

To reproduce this collection:

1. Start at: `https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm`
2. Read the main page to understand the two configuration types
3. Navigate to Configuration 1: Click the "Configuration 1" link in the table
4. Save the Configuration 1 HTML page
5. Navigate back and click "Configuration 2"
6. Save the Configuration 2 HTML page
7. On Configuration 2 page, scroll to "Patient Data (CSV) Files" section
8. Download all three PDF links listed under "CSV tables/columns included"
9. All downloads work with standard curl + User-Agent header
