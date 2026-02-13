# Inpatient Major EHR Vendors — EHI Export Documentation Download Manifest

Generated: 2025-02-13
Source report: `/home/exedev/EHI/reports/inpatient-major.md`

---

## 1. Epic Systems

Directory: `downloads/epic/`

| File | Size | Source URL |
|------|------|------------|
| `ehi-tables-main.html` | 8,742 bytes | https://open.epic.com/EHITables |
| `Epic-EHI-Tables.zip` | 12,664,966 bytes (12.1 MB) | https://open.epic.com/EHITables/Download |
| `ehi-tables-techspec.html` | 1,077,591 bytes (1.0 MB) | https://open.epic.com/EHITables/TechSpec |

### Curl Commands

```bash
# Main page
curl -L -o downloads/epic/ehi-tables-main.html 'https://open.epic.com/EHITables'

# ZIP file (7,674 HTM files documenting all export tables)
curl -L -o downloads/epic/Epic-EHI-Tables.zip 'https://open.epic.com/EHITables/Download'

# Tech spec (browsable table-of-contents, ~1 MB HTML)
curl -L -o downloads/epic/ehi-tables-techspec.html 'https://open.epic.com/EHITables/TechSpec'
```

### Notes
- No authentication or special headers required
- ZIP contains ~7,674 HTM files + CSS (~83 MB uncompressed)
- Each HTM file documents one database table with column-level detail

---

## 2. MEDITECH

Directory: `downloads/meditech/`

| File | Size | Source URL |
|------|------|------------|
| `ehiexport-main.html` | 8,964 bytes | https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm |
| `ehiexport-config1.html` | 29,280 bytes | https://home.meditech.com/en/d/restapiresources/pages/ehiexportconfig1.htm |
| `ehiexport-config2.html` | 22,780 bytes | https://home.meditech.com/en/d/restapiresources/pages/ehiexportconfig2.htm |
| `csacute-amb-ehi-export-dr-solution.pdf` | 262,764 bytes (257 KB) | https://home.meditech.com/en/d/regulatoryresources/otherfiles/csacuteandambehiexportdrsolutionmerged.pdf |
| `magic-ehi-export-dr-solution.pdf` | 363,475 bytes (355 KB) | https://home.meditech.com/en/d/regulatoryresources/otherfiles/mgehiexportdrsolutionmerged.pdf |
| `608-ehi-export-csv.pdf` | 251,431 bytes (245 KB) | https://home.meditech.com/en/d/regulatoryresources/otherfiles/608ehiexportcsv.pdf |

### Curl Commands

```bash
# Main page
curl -L -o downloads/meditech/ehiexport-main.html \
  'https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm'

# Config 1 (Expanse 2.2/2.1, 6.15, 6.08 Acute, Client Server Acute, MAGIC Acute)
curl -L -o downloads/meditech/ehiexport-config1.html \
  'https://home.meditech.com/en/d/restapiresources/pages/ehiexportconfig1.htm'

# Config 2 (6.08 Ambulatory, Client/Server, MAGIC)
curl -L -o downloads/meditech/ehiexport-config2.html \
  'https://home.meditech.com/en/d/restapiresources/pages/ehiexportconfig2.htm'

# PDF: CS Acute & Ambulatory EHI Export DR Solution (20 pages)
curl -L -o downloads/meditech/csacute-amb-ehi-export-dr-solution.pdf \
  'https://home.meditech.com/en/d/regulatoryresources/otherfiles/csacuteandambehiexportdrsolutionmerged.pdf'

# PDF: MAGIC EHI Export DR Solution (20 pages)
curl -L -o downloads/meditech/magic-ehi-export-dr-solution.pdf \
  'https://home.meditech.com/en/d/regulatoryresources/otherfiles/mgehiexportdrsolutionmerged.pdf'

# PDF: 6.08 EHI Export CSV Documentation (19 pages)
curl -L -o downloads/meditech/608-ehi-export-csv.pdf \
  'https://home.meditech.com/en/d/regulatoryresources/otherfiles/608ehiexportcsv.pdf'
```

### Notes
- No authentication or special headers required
- PDFs linked from Config 2 page only
- No single downloadable ZIP of all documentation (unlike Epic)

---

## 3. Oracle Health (formerly Cerner)

Directory: `downloads/oracle/`

| File | Size | Source URL |
|------|------|------------|
| `certified-health-it.html` | 68,166 bytes | https://www.oracle.com/health/certified-health-it/ |
| `single-patient-ehi-export-data-overview.pdf` | 154,866 bytes (151 KB) | https://www.oracle.com/a/ocom/docs/industries/healthcare/cerner-corp-single-patient-ehi-export-data-overview.pdf |
| `single-patient-ehi-export-data-format-specs.zip` | 7,656,902 bytes (7.3 MB) | https://www.oracle.com/a/ocom/docs/industries/healthcare/single-patient-ehi-export-data-format-specifications.zip |
| `patient-population-ehi-export-data-overview.pdf` | 456,977 bytes (446 KB) | https://www.oracle.com/a/ocom/docs/industries/healthcare/cerner-corp-patient-population-ehi-export-data-overview.pdf |
| `patient-population-ehi-export-data-format-specs.zip` | 15,621,689 bytes (14.9 MB) | https://www.oracle.com/a/ocom/docs/industries/healthcare/patient-population-ehi-export-data-format-specifications.zip |
| `hdi-ehi-export-data-overview.pdf` | 172,438 bytes (168 KB) | https://www.oracle.com/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-overview-user-instructions.pdf |
| `hdi-ehi-export-data-format-specs.pdf` | 5,934,347 bytes (5.7 MB) | https://www.oracle.com/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-format-specifications.pdf |

### Curl Commands

```bash
# NOTE: Oracle requires a browser-style User-Agent header. Without it, you get a redirect/block page.
UA='User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'

# Landing page
curl -L -H "$UA" -o downloads/oracle/certified-health-it.html \
  'https://www.oracle.com/health/certified-health-it/'

# Single Patient - Overview PDF (4 pages)
curl -L -H "$UA" -o downloads/oracle/single-patient-ehi-export-data-overview.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/cerner-corp-single-patient-ehi-export-data-overview.pdf'

# Single Patient - Data Format Specs ZIP (contains MySQL data model, ~1,459 HTML files)
curl -L -H "$UA" -o downloads/oracle/single-patient-ehi-export-data-format-specs.zip \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/single-patient-ehi-export-data-format-specifications.zip'

# Patient Population - Overview PDF (23 pages)
curl -L -H "$UA" -o downloads/oracle/patient-population-ehi-export-data-overview.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/cerner-corp-patient-population-ehi-export-data-overview.pdf'

# Patient Population - Data Format Specs ZIP (MySQL + Oracle models)
curl -L -H "$UA" -o downloads/oracle/patient-population-ehi-export-data-format-specs.zip \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/patient-population-ehi-export-data-format-specifications.zip'

# Health Data Intelligence - Overview PDF
curl -L -H "$UA" -o downloads/oracle/hdi-ehi-export-data-overview.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-overview-user-instructions.pdf'

# Health Data Intelligence - Data Format Specs PDF
curl -L -H "$UA" -o downloads/oracle/hdi-ehi-export-data-format-specs.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-format-specifications.pdf'
```

### Notes
- **IMPORTANT:** All Oracle downloads require a `User-Agent` header mimicking a real browser. Plain `curl` without `-H 'User-Agent: ...'` gets redirected to an HTML block page.
- The landing page URL redirects: `/health/regulatory/certified-health-it/` → `/health/certified-health-it/`
- The Data Format Specs ZIPs contain nested ZIPs (e.g., `EHI MYSQL DATA MODEL 2025401.zip`) with interactive HTML data model reports
- HDI format specs are a PDF (not ZIP), unlike the other two product lines

---

## 4. Altera Digital Health (formerly Allscripts)

Directory: `downloads/altera/`

| File | Size | Source URL |
|------|------|------------|
| `onc-reg-compliance.html` | 203,794 bytes (199 KB) | https://www.alterahealth.com/legal/onc-reg-compliance/ |
| `sunrise-ehi-export-definition-22-1-pr23.zip` | 12,488,838 bytes (11.9 MB) | https://www.alterahealth.com/download/204/ehi-documentation/11963/sunrise-ehi-export-definition-22-1pr23.zip |
| `sunrise-ehi-weberdiagram-22-1-pr24.zip` | 12,532,559 bytes (12.0 MB) | https://www.alterahealth.com/download/204/ehi-documentation/12043/sunrise-ehi-weberdiagram-22-1-pr24-1.zip |
| `sunrise-ehi-export-definition-22-1-pr27.zip` | 12,670,219 bytes (12.1 MB) | https://www.alterahealth.com/download/204/ehi-documentation/13254/sunrise-ehi-export-definition-22-1-pr27.zip |
| `ehi-weberdiagram-22-1-pr28.zip` | 12,709,122 bytes (12.1 MB) | https://www.alterahealth.com/download/204/ehi-documentation/13340/ehi-weberdiagram-22-1-pr28.zip |
| `ehi-weberdiagram-22-1-pr38.zip` | 13,739,522 bytes (13.1 MB) | https://www.alterahealth.com/download/204/ehi-documentation/15816/ehi-weberdiagram-22-1-pr38 |

### Curl Commands

```bash
# Landing page (WordPress, 204 KB with accordion sections)
curl -L -o downloads/altera/onc-reg-compliance.html \
  'https://www.alterahealth.com/legal/onc-reg-compliance/'

# Sunrise EHI Export Definition 22.1 PR23
curl -L -o downloads/altera/sunrise-ehi-export-definition-22-1-pr23.zip \
  'https://www.alterahealth.com/download/204/ehi-documentation/11963/sunrise-ehi-export-definition-22-1pr23.zip'

# Sunrise EHI WebER Diagram 22.1 PR24
curl -L -o downloads/altera/sunrise-ehi-weberdiagram-22-1-pr24.zip \
  'https://www.alterahealth.com/download/204/ehi-documentation/12043/sunrise-ehi-weberdiagram-22-1-pr24-1.zip'

# Sunrise EHI Export Definition 22.1 PR27 (latest export definition with ~2,668 table definitions)
curl -L -o downloads/altera/sunrise-ehi-export-definition-22-1-pr27.zip \
  'https://www.alterahealth.com/download/204/ehi-documentation/13254/sunrise-ehi-export-definition-22-1-pr27.zip'

# EHI WebER Diagram 22.1 PR28
curl -L -o downloads/altera/ehi-weberdiagram-22-1-pr28.zip \
  'https://www.alterahealth.com/download/204/ehi-documentation/13340/ehi-weberdiagram-22-1-pr28.zip'

# EHI WebER Diagram 22.1 PR38 (latest available; URL has no .zip extension but downloads as ZIP)
curl -L -o downloads/altera/ehi-weberdiagram-22-1-pr38.zip \
  'https://www.alterahealth.com/download/204/ehi-documentation/15816/ehi-weberdiagram-22-1-pr38'
```

### Notes
- No authentication or special headers required
- The page labels PR38 as "Sunrise EHI Export Definition 22.1 PR38" but the URL suggests it's a WebER diagram
- Export Definition ZIPs contain ER/Studio Intranet Documentation (HTML framesets with table-level docs)
- WebER Diagram ZIPs contain the visual ER diagrams
- Only PR23 and PR27 are labeled as "Export Definition"; PR24, PR28, PR38 are WebER Diagrams
- The report mentioned PR24 and PR28 as Export Definitions too, but the actual page only has PR23 and PR27 as Export Definitions

---

## 5. MEDHOST

Directory: `downloads/medhost/`

| File | Size | Source URL |
|------|------|------------|
| `interoperability-main.html` | 198,235 bytes (194 KB) | https://www.medhost.com/ehr/interoperability/ |
| `MEDHOST-FHIR-Extension-Fields.xlsx` | 138,660 bytes (135 KB) | https://www.medhost.com/fhir/extensions/MEDHOST-FHIR-Extension-Fields.xlsx |

### Curl Commands

```bash
# Main interoperability page (EHI section embedded in marketing page)
curl -L -o downloads/medhost/interoperability-main.html \
  'https://www.medhost.com/ehr/interoperability/'

# FHIR Extension Fields Excel file (41 sheets, ~776 extension fields)
curl -L -o downloads/medhost/MEDHOST-FHIR-Extension-Fields.xlsx \
  'https://www.medhost.com/fhir/extensions/MEDHOST-FHIR-Extension-Fields.xlsx'
```

### Notes
- No authentication or special headers required
- MEDHOST has the most minimal documentation — a single Excel file
- The XLSX documents only FHIR extension fields beyond standard FHIR R4; base resources reference hl7.org/fhir/R4

---

## Total Download Summary

| Vendor | Files | Total Size |
|--------|-------|------------|
| Epic | 3 | 13.1 MB |
| MEDITECH | 6 | 916 KB |
| Oracle Health | 7 | 28.6 MB |
| Altera | 6 | 63.4 MB |
| MEDHOST | 2 | 329 KB |
| **Total** | **24** | **~106 MB** |

All files verified as correct type (ZIP archives, PDF documents, HTML, XLSX) via `file` command.
