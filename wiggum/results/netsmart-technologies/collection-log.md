# Netsmart Technologies — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 10769, 11131, 11409, 11493, 11518, 11575
- **Products**: Carepathways Measures Reporting, TheraOffice, myAvatar Certified Edition, myEvolv Certified Edition, myHealthpointe, myUnity
- **Registered URL**: https://www.ntst.com/lp/certifications

## Navigation Journal

### Step 1: Initial Probe

```bash
curl -sI -L "https://www.ntst.com/lp/certifications" -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```

**Result**: HTTP 200 OK. Content-Type: `text/html; charset=utf-8`. Server: `Microsoft-IIS/10.0`. Content-Length: 189,740 bytes. No redirects. Page loads directly at the registered URL.

### Step 2: Page Examination

```bash
curl -sL "https://www.ntst.com/lp/certifications" -H 'User-Agent: Mozilla/5.0' -o /tmp/netsmart-page.html
wc -c /tmp/netsmart-page.html
# Output: 189740 /tmp/netsmart-page.html
```

The page is a full HTML page (~190 KB) titled "Solution Certifications | Netsmart". It is a compliance/certification hub page (not a SPA). Content is server-rendered and available to curl. The page includes cookie consent via Securiti.ai and Marketo/Google Tag Manager tracking.

### Step 3: Finding the EHI Section

Searched the HTML for EHI-related links:

```bash
grep -oiE 'href="[^"]*"' /tmp/netsmart-page.html | grep -iE 'ehi|export|data.dictionary|b.10'
```

**Result**: Found 7 product-specific EHI export subpages under the heading "EHI (Electronic Health Information) All Data Export":

| Product | URL |
|---------|-----|
| CarePathways Measures Reporting | `/lp/certifications/ehi-all-data-carepathways` |
| myAvatar™ | `/lp/certifications/ehi-all-data-myavatar` |
| myEvolv® | `/lp/certifications/ehi-all-data-myevolv` |
| myHealthPointe™ | `/lp/certifications/ehi-all-data-myhealthpointe` |
| myUnity® | `/lp/certifications/ehi-all-data-myunity` |
| GEHRIMED® | `/lp/certifications/ehi-all-data-gehrimed` |
| TheraOffice® | `/lp/certifications/ehi-all-data-theraoffice` |

The EHI section appears in the middle of the main certifications page, between "ONC Certifications" (left column listing products) and "Real World Testing Plans". It is a simple list of links — no accordion, no JavaScript interaction needed.

### Step 4: Visiting Product-Specific EHI Pages

Fetched each product page. Each follows the same template: a brief description of EHI export functionality and a single "CLICK HERE" link to the downloadable documentation.

**Fetching each page:**
```bash
for product in carepathways myavatar myevolv myhealthpointe myunity theraoffice; do
  curl -sL "https://www.ntst.com/lp/certifications/ehi-all-data-$product" \
    -H 'User-Agent: Mozilla/5.0' -o "/tmp/netsmart-ehi-$product.html"
done
```

Each page (~175 KB HTML, server-rendered) contains:
1. A product hero banner
2. A description of the EHI export capability
3. A "CLICK HERE" link to a PDF or ZIP file
4. Standard disclaimers about content variability

### Step 5: Identified Downloadable Assets

Extracted download links from each product page:

```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/netsmart-ehi-*.html
```

| Product | File | URL |
|---------|------|-----|
| CarePathways | PDF (97 pages, 1.8 MB) | `/-/media/pdfs/certifications/ehi-export-all-tables-2024-carepathways-measures-reporting.pdf` |
| myAvatar | ZIP → PDF (7,492 pages, 16 MB uncompressed) | `/-/media/pdfs/certifications/EHI_Export_All_Tables_myAvatar_September_2023.zip` |
| myEvolv | ZIP → DOCX + XLSX + SQL (12 MB) | `/-/media/pdfs/certifications/myevolv-all-ehi-export-documentation_v2.zip` |
| myHealthPointe | PDF (3 pages, 56 KB) | `/-/media/pdfs/certifications/myhealthpointe-ehi-export.pdf` |
| myUnity | PDF (64 pages, 467 KB) | `/-/media/pdfs/certifications/ehi_export_all_files_myunity_fall_2024.pdf` |
| TheraOffice | ZIP → PDF (30 pages, 556 KB) | `/-/media/pdfs/certifications/ehi_export_all_tables_theraoffice_2024.zip` |

**Note on myAvatar link**: The href in the HTML was `href="-/media/..."` (missing leading slash), but curl resolves it correctly as a relative URL from the base.

### Key Observations from Page Content

Each product page describes the export format:

- **CarePathways, myAvatar, myEvolv, TheraOffice**: "computable, delimited file format native to [product]. Each table will be exported to its own file with a filename matching the table name."
- **myUnity**: "computable, **JSON file format** native to myUnity. Each EHI Export file will be exported to its own zip file with a unique filename." — Notably different format.
- **myHealthPointe**: "will be using **relied upon software** to fulfill the (b)(10) EHI Export functionality. Clients utilizing a Netsmart certified solution should refer to the affiliated EHI Export page." — Delegates EHI export to whichever certified product the org also uses (e.g., myAvatar). The myHealthPointe-specific doc only covers secure messages via a reports applet.
- **myEvolv Companion Guide** states: exports are in **JSON format**, deposited as ZIP files containing JSON files via SFTP or local directory.

## Downloads

All files downloaded to: `/home/exedev/EHI/wiggum/results/netsmart-technologies/downloads/`

### ehi-export-all-tables-2024-carepathways-measures-reporting.pdf (1,834,284 bytes)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o downloads/ehi-export-all-tables-2024-carepathways-measures-reporting.pdf \
  'https://www.ntst.com/-/media/pdfs/certifications/ehi-export-all-tables-2024-carepathways-measures-reporting.pdf'
```
Verified: `PDF document, version 1.7, 97 page(s)`

### EHI_Export_All_Tables_myAvatar_September_2023.zip (12,504,838 bytes)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o downloads/EHI_Export_All_Tables_myAvatar_September_2023.zip \
  'https://www.ntst.com/-/media/pdfs/certifications/EHI_Export_All_Tables_myAvatar_September_2023.zip'
```
Verified: `Zip archive data, at least v2.0 to extract, compression method=deflate`
Extracted: 1 file → `EHI Export All Tables - September 2023.pdf` (16,026,215 bytes, 7,492 pages)

### myevolv-all-ehi-export-documentation_v2.zip (11,082,302 bytes)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o downloads/myevolv-all-ehi-export-documentation_v2.zip \
  'https://www.ntst.com/-/media/pdfs/certifications/myevolv-all-ehi-export-documentation_v2.zip'
```
Verified: `Zip archive data, at least v2.0 to extract, compression method=deflate`
Extracted: 3 files:
- `(1) myEvolv All EHI Export Companion Guide.docx` (938,744 bytes) — configuration & usage guide
- `(2) myEvolv All EHI Export Data Dictionary Crosswalk.xlsx` (11,179,055 bytes) — full data dictionary
- `(3) myEvolv ALL EHI Export Queries.sql` (6,464 bytes) — SQL queries to reproduce the crosswalk

### myhealthpointe-ehi-export.pdf (56,892 bytes)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o downloads/myhealthpointe-ehi-export.pdf \
  'https://www.ntst.com/-/media/pdfs/certifications/myhealthpointe-ehi-export.pdf'
```
Verified: `PDF document, version 1.7, 3 page(s)`

### ehi_export_all_files_myunity_fall_2024.pdf (467,428 bytes)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o downloads/ehi_export_all_files_myunity_fall_2024.pdf \
  'https://www.ntst.com/-/media/pdfs/certifications/ehi_export_all_files_myunity_fall_2024.pdf'
```
Verified: `PDF document, version 1.7, 64 page(s)`

### ehi_export_all_tables_theraoffice_2024.zip (406,527 bytes)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o downloads/ehi_export_all_tables_theraoffice_2024.zip \
  'https://www.ntst.com/-/media/pdfs/certifications/ehi_export_all_tables_theraoffice_2024.zip'
```
Verified: `Zip archive data, at least v2.0 to extract, compression method=deflate`
Extracted: `EHI Export All Tables - May 2024 (TheraOffice).pdf` (556,196 bytes, 30 pages)

## Product-by-Product Analysis

### CarePathways Measures Reporting
- **Export format**: Delimited file format (table-per-file)
- **Tables documented**: 62 tables (star/snowflake schema: `mv_fact_*`, `dim_*`, `fact_*`)
- **Documentation level**: Column-level (table_schema, table_name, column_name); includes SQL sample queries for single-client and all-client exports
- **Notable**: Uses an EDW (Enterprise Data Warehouse) schema (`edw_ORGNAME`). Fact/dimension naming convention suggests this is a reporting data warehouse, not the operational system.
- **Last updated**: September 2024

### myAvatar Certified Edition
- **Export format**: Delimited file format (table-per-file)
- **Tables documented**: 445 unique tables across 293 forms
- **Documentation level**: Column-level with data types, descriptions, and form-to-table mapping
- **Scale**: 7,492-page PDF — the most comprehensive documentation of any Netsmart product
- **Notable coverage**: Massive billing infrastructure (100+ billing tables covering 837/835/834/271/276/277/278 EDI transactions), 20+ insurance/eligibility/authorization tables, 27+ appointment/scheduling tables, 45+ audit tables, progress notes, clinical pathways, telehealth
- **Last updated**: September 2023

### myEvolv Certified Edition
- **Export format**: JSON files, packaged as ZIP, deposited to SFTP or local directory
- **Events documented**: 1,679 event types across 119 categories
- **Non-event forms**: 250 forms
- **Total event+column entries**: 115,663 (Events + Columns sheet) + 21,006 (Non-Events + Columns sheet)
- **Documentation level**: Field-level with JSON property names, form field captions, type codes, subform details, assessment question mappings
- **Includes**: Companion guide (DOCX) with configuration steps, usage instructions, JSON interpretation guide, and screenshots; SQL queries to reproduce the crosswalk; XLSX data dictionary
- **Notable**: The most developer-friendly documentation — includes SQL source, JSON examples, and a step-by-step setup guide
- **Last updated**: November 2024

### myHealthPointe
- **Export format**: PDF or Excel report from the Reports applet (Subject Messages Report only)
- **Tables documented**: 0 actual database tables — only documents 8 fields in a secure messages report
- **Documentation level**: Minimal — only field name and description for the messages report
- **Notable**: Uses "relied upon software" for b(10). The myHealthPointe-specific documentation only covers portal messages. Organizations must refer to their affiliated product (myAvatar, etc.) for full EHI export.
- **Last updated**: November 2023

### myUnity
- **Export format**: JSON files, packaged as ZIP
- **Files documented**: 24 distinct export files (Demographics, CCD, FamilyHealthHistory, HealthInsurance, Referrals, ResponsibleParties, CensusAdvanceDirectives, AssessmentandPlanOfTreatment, Consents, Attachments, Documents, PatientNotes, Orders, OrderAdministrations, Claims, ClaimCharges, ClaimChargeAdjustments, RegulatoryAssessment, EventADTs, Appointments, Eligibility, Authorization, NonRegulatoryAssessment)
- **Fields documented**: 366 fields with name, type, and description
- **Documentation level**: Field-level with data types and descriptions
- **Last updated**: August 2024 (content dated March 2024)

### TheraOffice
- **Export format**: Delimited file format (table-per-file)
- **Tables documented**: 19 tables (PAT_PROFILE, PAT_PROFILE_CORE, 16 PAT_PROFILE_USCDI_* tables, PTCASE)
- **Fields documented**: 523 columns with name, data type, and max length
- **Documentation level**: Column-level with SQL data types
- **Notable**: Very USCDI-aligned naming convention (PAT_PROFILE_USCDI_*). Smallest scope of any product with data dictionary detail.
- **Last updated**: May 2024

## Obstacles & Notes

1. **No anti-bot protection**: All pages and downloads are accessible via simple curl with a User-Agent header. No Cloudflare, no login wall, no JavaScript required.
2. **myAvatar ZIP link** had a missing leading slash in the href (`href="-/media/..."` instead of `href="/-/media/..."`), but browsers and curl resolve it correctly.
3. **TheraOffice ZIP** contained a `__MACOSX` resource fork directory (macOS artifact) — not meaningful.
4. **myHealthPointe relies on other products**: Its EHI export documentation is effectively a stub — only 3 pages covering secure messages. Full EHI export is delegated to the underlying certified product.
5. **GEHRIMED** was excluded from this analysis as it is not in the target product list.
6. **myEvolv XLSX is very large** (11 MB) — the Data Dictionary Crosswalk contains 115,000+ rows of event/column mappings.
7. **Naming inconsistency**: myAvatar PDF is dated September 2023 (nearly 2 years old), while myEvolv was updated November 2024 and CarePathways September 2024.
