# Greenway Health, LLC — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11351, 11682, 11727
- **Products**: Greenway Insights, Intergy EHR
- **Registered URL**: https://ehi.greenwayhealth.com/Intergy/IntergyEHIExport.html

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://ehi.greenwayhealth.com/Intergy/IntergyEHIExport.html" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP/2 200 directly — no redirects. Content-Type: `text/html`, Content-Length: 9,266 bytes. Served from Amazon S3 via CloudFront (static hosting). Last-Modified: Fri, 25 Jul 2025 19:57:47 GMT. Headers reveal it's served through an AWS Storage Gateway (`x-amz-meta-user-agent: aws-storage-gateway`). No anti-bot protection, no special headers required.

### Step 2: Page examination

```bash
curl -sL "https://ehi.greenwayhealth.com/Intergy/IntergyEHIExport.html" -H 'User-Agent: Mozilla/5.0' -o page.html
```

The page is **static HTML** (9,266 bytes), not a SPA. Fully readable via curl. It contains:
- Greenway Health branding/nav bar
- Breadcrumb: Home > Intergy EHI Export
- Title: "Intergy EHI Export"
- Prominent blue "Data Tables" button linking to `./EHI/Viewer/index.html`
- Detailed prose describing the export package structure for both Single Patient and Patient Population exports
- A table of MEDCIN smoking status findings with SNOMED code mappings
- Minimum supported version: Intergy 21.24.00.00

### Step 3: Finding the EHI documentation

The documentation is **directly on the registered URL** — no accordion, no buried sections. The page itself IS the EHI export documentation, describing:
1. **Single Patient Export** — Documents folder (ZIP files with RTF/PDF/DOC), Images folder (TIF/video with .ann XML annotations), Tables folder (CSV files)
2. **Patient Population Export** — Documents (GenFileBlob, TMSCatalogBlob, PracPersonSecureMsgBlob folders, 10K doc limit per folder), Images (TAR format, 5GB limit per tar), Tables (CSV), Bulk Export Status (CSV)
3. **Data Tables** — A linked sub-site with field-level data dictionary

The "Data Tables" button at `./EHI/Viewer/index.html` leads to the full data dictionary.

### Step 4: Exploring the Data Tables viewer

The Data Tables viewer at `https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/index.html` is a **frameset** (1,243 bytes) with:
- **Left frame**: Table of Contents (`Contracts/DBTOC.htm`) — a searchable dropdown listing all 261 tables
- **Right frame**: Individual table pages (e.g., `Contracts/Account.htm`)

The TOC is JavaScript-generated. The table list is populated from `Contracts/include/DBDescriptions.js` (28,531 bytes), which contains table names and descriptions as a JS array.

Each table's `.htm` page contains:
- Last Updated date (9/24/2025) and Intergy Version (22.00.00.00)
- Table description
- **Field-level detail**: Field name, Datatype (e.g., INTEGER, CHARACTER(10), DECIMAL(10,2), DATE), Default value, Null Option (MANDATORY/OPTIONAL), Comment/description
- **Parent Tables**: With join conditions and delete behavior
- **Child Tables**: With join conditions and delete behavior

### Step 5: Identifying the parent site

The breadcrumb links to a home page at `https://ehi.greenwayhealth.com/` which serves as a landing page for both Greenway EHR products:
- **Prime Suite** → `./PrimeSuite/PrimeSuiteEHIExport.html`
- **Intergy** → `./Intergy/IntergyEHIExport.html` (our target)

The home page also notes that supporting products (Greenway Insights, Greenway Patient Portal, Greenway eCR) should use the EHI Export capability of their associated EHR.

### Step 6: Identified downloadable assets

No ZIP or PDF download is offered. The documentation is the HTML site itself — 261 individual `.htm` files (one per table) plus the overview page. This is a "dedicated doc subdomain" pattern.

Assets identified:
1. Main page: `IntergyEHIExport.html` (9,266 bytes)
2. Data Tables viewer: `EHI/Viewer/index.html` (1,243 bytes)
3. Table of Contents: `EHI/Viewer/Contracts/DBTOC.htm` (1,208 bytes)
4. 261 individual table `.htm` files in `EHI/Viewer/Contracts/`
5. Supporting JS: `DBDescriptions.js` (28,531 bytes), `TableSearch.js` (4,085 bytes)
6. CSS files: `ehistyle.css`, `style.css`, `dbTables.css`
7. Image: `tmscatalogblob.jpg` (186,447 bytes)

## Downloads

All files saved to `/home/exedev/EHI/wiggum/results/greenway-health-llc/downloads/`

### IntergyEHIExport.html (9,266 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o downloads/IntergyEHIExport.html \
  'https://ehi.greenwayhealth.com/Intergy/IntergyEHIExport.html'
```
Verified: HTML document, 9,266 bytes

### home-default.html (3,468 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o downloads/home-default.html \
  'https://ehi.greenwayhealth.com/'
```
Verified: HTML document, 3,468 bytes (parent landing page for both products)

### Data Tables — 261 HTM files + supporting files (2.4 MB total)
```bash
# Downloaded all 261 table .htm files via batch curl:
for table in $(cat table_names.txt); do
  curl -sL -H 'User-Agent: Mozilla/5.0' \
    -o "downloads/data-tables/$table.htm" \
    "https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/Contracts/$table.htm"
done
```
All 261 downloaded successfully (HTTP 200). Also downloaded:
- `data-tables/DBTOC.htm` (1,208 bytes)
- `data-tables/index.html` (1,243 bytes) — the viewer frameset
- `data-tables/include/DBDescriptions.js` (28,531 bytes)
- `data-tables/include/TableSearch.js` (4,085 bytes)
- `data-tables/include/dbTables.css`
- `data-tables/include/style.css`

### Assets
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o downloads/assets/ehistyle.css \
  'https://ehi.greenwayhealth.com/Intergy/assets/ehistyle.css'
curl -sL -H 'User-Agent: Mozilla/5.0' -o downloads/assets/tmscatalogblob.jpg \
  'https://ehi.greenwayhealth.com/Intergy/assets/tmscatalogblob.jpg'
```

### Download Summary
- **271 files** total
- **2.15 MB** total size
- **0 failures**

## Obstacles & Notes

- **No obstacles encountered.** The site is a clean static HTML site served via S3/CloudFront. No anti-bot, no login, no JavaScript SPA issues. curl works perfectly.
- The Data Tables TOC requires JavaScript to populate (it reads from `DBDescriptions.js`), but the individual table `.htm` files are independently accessible via direct URL.
- No downloadable ZIP or PDF is offered — the documentation is the website itself.
- The site was last updated 9/24/2025 for Intergy version 22.00.00.00.
- The registered URL leads directly to documentation — no marketing fluff, no compliance hub to navigate.
