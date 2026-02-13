# Altera Digital Health — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11199, 11401, 11589, 11675, 11707, 11708, 11709, 11761
- **Products**: Altera Lab™, Integrated Providers Patient Portal, Paragon® Denali, Paragon® EHR, Sunrise Acute Care, Sunrise Acute Care for Hospital-based Providers, Sunrise Ambulatory Care, TouchWorks EHR
- **Developer(s)**: Altera Digital Health Inc., Providers Management, Inc.
- **Registered URL**: https://www.alterahealth.com/legal/onc-reg-compliance/

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.alterahealth.com/legal/onc-reg-compliance/" \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36'
```

**Result**: HTTP/2 200 directly (no redirects). Content-Type: `text/html; charset=UTF-8`. Content-Length: 203,794 bytes. Hosted on WP Engine (WordPress). No anti-bot protection observed — standard User-Agent header sufficient.

### Step 2: Page examination

```bash
curl -sL "https://www.alterahealth.com/legal/onc-reg-compliance/" \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36' \
  -o /tmp/page.html
```

Page size: 203,794 bytes. It's a WordPress page with substantive HTML content — not a SPA. Accordion sections are in the DOM (content is present in HTML, just hidden via CSS). The page is a **compliance hub** with multiple accordion sections covering various ONC requirements.

Page title: "ONC Regulatory Compliance"

Accordion sections visible on the page:
1. File ONC Information Blocking Concern
2. ONC Certified Health IT Cures Update EHR API Fees
3. FHIR R4 API Terms, Conditions and Specifications
4. FHIR R4 Patient-Facing URL Endpoints
5. ONC Real World Testing Plans & Reports
6. **EHI Export Documentation** ← target section
7. **Archived EHI Export Documentation**
8. Predictive Decision Support Intervention Risk Management (IRM) Practices

### Step 3: Finding the EHI section

Clicked/expanded the **"EHI Export Documentation"** accordion section (6th section on the page). The accordion content was already in the HTML source, hidden via CSS display:none. Clicking the heading expands it.

The section opens with:
> "Documentation on the 170.315 (b)(10) EHI Export output format for each Altera ONC certified solution is provided below."

Five product subsections are listed within this accordion:

#### Altera Lab
- 1 PDF download link
- Instructions: "Click on the link matching the Altera Lab version found in the name of the export file."
- Link: [Altera Lab EHI Export Definition 23.2.0.0](https://www.alterahealth.com/download/204/ehi-documentation/11976/altera-lab-ehi-export-definition-23-2-0-0.pdf)

#### dbMotion
- 2 download links (1 XLSX, 1 PDF)
- Instructions: Open the PDF for process/output info, open the XLSX for data dictionary with output formats
- Links:
  - [dbMotion EHI Consolidated Data Files](https://www.alterahealth.com/download/204/ehi-documentation/11974/ehiconsolidateddatafiles_dbmotion.xlsx)
  - [dbMotion EHI Export Reference Guide](https://www.alterahealth.com/download/204/ehi-documentation/11975/ehiexportreferenceguide_dbmotion.pdf)

#### Paragon
- Uses FHIR CapabilityStatement JSON format
- Instructions reference a CapabilityStatement file and Extension Details file
- Notes about custom extensions and using Notepad++ for active hyperlinks
- Latest version link: [Paragon EHR® 25.1 & Paragon® Denali 1](https://www.alterahealth.com/download/204/ehi-documentation/16995/paragon-ehr-25-1-paragon-denali-1)
- Older version also available: [Paragon EHR® 24.1 & Paragon® Denali 1](https://www.alterahealth.com/download/204/ehi-documentation/15915/paragon-ehr-24-1-paragon-denali-1)
- Standalone files also linked: capabilitystatement.json, extension-details.xlsx (these appear to be older/standalone versions)

#### Sunrise
- ZIP downloads containing ER/Studio WebERDiagram HTML documentation
- Instructions: Extract ZIP, open index.html to view tree structure of tables, traverse to field definitions
- 5 version links (multiple patch releases):
  - Sunrise EHI Export Definition 22.1 PR23
  - Sunrise EHI Export Definition 22.1 PR24
  - Sunrise EHI Export Definition 22.1 PR27
  - Sunrise EHI Export Definition 22.1 PR28
  - **Sunrise EHI Export Definition 22.1 PR38** (latest)

#### TouchWorks
- ZIP downloads containing HTML documentation with tree structure
- Instructions: Extract ZIP, open main.html to view tree structure of tables
- 6 version links (latest first):
  - **Touchworks EHI Export Definition TWEHR 2026.1** (latest)
  - Touchworks EHI Export Definition TWEHR 2025.4
  - Touchworks EHI Export Definition TWEHR 2025.3
  - Touchworks EHI Export Definition TWEHR 2025.2 (different download category: /download/224/)
  - Touchworks EHI Export Definition TWEHR 2025.1
  - (Older versions in "Archived" accordion)

### Step 4: Identified downloadable assets

All EHI documentation file URLs found in the page (category 204/ehi-documentation):

| # | File | Product | Type |
|---|------|---------|------|
| 1 | altera-lab-ehi-export-definition-23-2-0-0.pdf | Altera Lab | PDF |
| 2 | ehiconsolidateddatafiles_dbmotion.xlsx | dbMotion | XLSX |
| 3 | ehiexportreferenceguide_dbmotion.pdf | dbMotion | PDF |
| 4 | capabilitystatement.json | Paragon (standalone) | JSON |
| 5 | extension-details.xlsx | Paragon (standalone) | XLSX |
| 6 | paragon-ehr-25-1-paragon-denali-1 (ZIP) | Paragon | ZIP |
| 7 | sunrise-ehi-weberdiagram-22-1-pr38 (ZIP) | Sunrise | ZIP |
| 8 | touchworks-ehi-export-definition-twehr-2026-1 (ZIP) | TouchWorks | ZIP |

I chose to download the **latest version** for each product, plus the standalone Paragon files.

## Downloads

### 1. altera-lab-ehi-export-definition-23-2-0-0.pdf (557 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36' \
  -o downloads/altera-lab-ehi-export-definition-23-2-0-0.pdf \
  'https://www.alterahealth.com/download/204/ehi-documentation/11976/altera-lab-ehi-export-definition-23-2-0-0.pdf'
```
Verified: `PDF document, version 1.4, 4 page(s)` — actually 36 pages (pdftotext output). 570,729 bytes.
Content: JSON field map documenting the EHI export format for Altera Lab. Chapters: Patient, Encounters, Enterprise Order. Defines ~304 unique JSON field labels.

### 2. ehiconsolidateddatafiles_dbmotion.xlsx (274 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36' \
  -o downloads/ehiconsolidateddatafiles_dbmotion.xlsx \
  'https://www.alterahealth.com/download/204/ehi-documentation/11974/ehiconsolidateddatafiles_dbmotion.xlsx'
```
Verified: `Microsoft Excel 2007+`. 280,310 bytes.
Content: 19 worksheets covering: Master_Patient, Master_MedicalStaff, Master_Organization, Codes, Code_Descriptor, Master_Device, Master_Microorganism, Master_Material, Confidentiality, Encounters, Conditions, Medications, Immunizations, Measurements, Labs and pathology, Documents, Allergies, Imaging, Procedures. Each sheet has columns: Attribute, Description, Type, length, Src details, Comments.

### 3. ehiexportreferenceguide_dbmotion.pdf (1.7 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36' \
  -o downloads/ehiexportreferenceguide_dbmotion.pdf \
  'https://www.alterahealth.com/download/204/ehi-documentation/11975/ehiexportreferenceguide_dbmotion.pdf'
```
Verified: `PDF document, version 1.4, 17 page(s)`. 1,776,946 bytes.
Content: Reference guide for the dbMotion EHI Export UI and process.

### 4. capabilitystatement.json (384 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36' \
  -o downloads/capabilitystatement.json \
  'https://www.alterahealth.com/download/204/ehi-documentation/11851/capabilitystatement.json'
```
Verified: `JSON text data`. 393,709 bytes.
Content: FHIR R4 CapabilityStatement with 48 resource types, documenting Paragon's EHI export using FHIR resource definitions. Each resource has field-level extensions listing supported attributes.

### 5. extension-details.xlsx (63 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36' \
  -o downloads/extension-details.xlsx \
  'https://www.alterahealth.com/download/204/ehi-documentation/11954/extension-details.xlsx'
```
Verified: `Microsoft Excel 2007+`. 64,080 bytes.
Content: Extension details for Paragon's custom FHIR extensions.

### 6. paragon-ehr-25-1-denali-1.zip (82 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36' \
  -o downloads/paragon-ehr-25-1-denali-1.zip \
  'https://www.alterahealth.com/download/204/ehi-documentation/16995/paragon-ehr-25-1-paragon-denali-1'
```
Verified: `Zip archive data, at least v2.0 to extract`. 84,099 bytes.
Contains 2 files: CapabilityStatement.json (460,104 bytes), Extension-Details.xlsx (64,427 bytes).
Note: The content-disposition header names the file `Paragon-EHR®-25.1-Paragon®-Denali-1.zip`.

### 7. sunrise-ehi-weberdiagram-22-1-pr38.zip (13.1 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36' \
  -o downloads/sunrise-ehi-weberdiagram-22-1-pr38.zip \
  'https://www.alterahealth.com/download/204/ehi-documentation/15816/ehi-weberdiagram-22-1-pr38'
```
Verified: `Zip archive data, at least v2.0 to extract`. 13,739,522 bytes.
Contains: 6,134 files, 81 MB extracted. ER/Studio WebERDiagram HTML documentation.
Structure: 4 subdirectories under `EHI WebERDiagram 22.1 PR38/`:
- `FS WebERDiagram 22.1 PR38/` — 156 files (FS = ?)
- `IMG WebERDiagram 22.1 PR38/` — 168 files (IMG database)
- `MNC WebERDiagram 22.1 PR38/` — 178 files (MNC database)
- `SCM WebERDiagram 22.1 PR38/` — 5,612 files (SCM = main clinical database)

Each subdirectory has an index.htm that loads a frameset with a tree navigation and content panes. The SCM database alone documents **2,728 tables** in its entity list.

### 8. touchworks-ehi-export-definition-twehr-2026-1.zip (1.4 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36' \
  -o downloads/touchworks-ehi-export-definition-twehr-2026-1.zip \
  'https://www.alterahealth.com/download/204/ehi-documentation/16825/twehr-2026-1-touchworks-ehi-export-definition'
```
Verified: `Zip archive data, at least v2.0 to extract`. 1,426,539 bytes.
Contains: 764 files, 7.1 MB extracted. HTML documentation site.
Entry point: `main.html` (frameset) → `tree.html` (navigation) + `index.html` (content).
Structure: `Touchworks/User_databases/` contains 8 databases:
- **Works** — 521 tables (main clinical database)
- Impact — 22 tables
- IntegratedScan — 6 tables
- AHSCharge — 2 tables
- Quippe — 2 tables
- WorksArchive — 2 tables
- WorksCDSAggregatorArchive — 0 tables
- chMedcinSearch — 1 table

Total: **556 tables** across all databases.

Each table listing includes: table name, description, and links to column-level details.

## Obstacles & Notes

1. **No anti-bot protection** — standard curl with User-Agent header worked for all downloads.
2. **WordPress/WP Engine hosting** — all downloads served via the `/download/` endpoint with content-disposition headers.
3. **Accordion structure** — content is in the DOM but hidden. Could be discovered via grep on HTML source without needing a browser.
4. **Multiple products, one page** — Altera serves documentation for 5 distinct products (Altera Lab, dbMotion, Paragon, Sunrise, TouchWorks) from a single compliance page, each with its own format and documentation approach.
5. **Version proliferation** — multiple versions are listed for Sunrise and TouchWorks. I downloaded only the latest for each.
6. **x-robots-tag: noindex, nofollow** — the download URLs include this header, meaning search engines won't index the direct file links (but the page itself is indexable).
7. **Paragon uses FHIR format** — uniquely, Paragon documents its EHI export using a FHIR CapabilityStatement JSON structure rather than database-native schema.
8. **Some URLs lack file extensions** — several download URLs (especially newer ones) don't have .zip in the URL but serve ZIP files via content-disposition.
