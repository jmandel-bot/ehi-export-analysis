# Oracle Health — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 10594, 11505, 11519, 11520, 11522, 11667, 11668, 11669, 11670, 11674
- **Products**: Oracle Health Millennium (CQMs), Oracle Health Millennium (Clinical), Oracle Health Millennium (Health Care Surveys), Oracle Health Millennium (Immunizations), Oracle Health Patient Portal, Oracle Health PowerChart Touch
- **Registered URL**: https://www.oracle.com/health/regulatory/certified-health-it/

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.oracle.com/health/regulatory/certified-health-it/" \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```

**Result**: HTTP 301 redirect from `/health/regulatory/certified-health-it/` → `/health/certified-health-it/`, then HTTP 200. The registered URL has been reorganized — the `/regulatory/` path component was removed. The redirect is transparent. Final URL: `https://www.oracle.com/health/certified-health-it/`. Content-Type: `text/html; charset=UTF-8`.

**Note**: Oracle requires a User-Agent header. Without one, the response may differ.

### Step 2: Page examination

```bash
curl -sL "https://www.oracle.com/health/regulatory/certified-health-it/" \
  -H 'User-Agent: Mozilla/5.0 ...' -o /tmp/oracle-page.html
wc -c /tmp/oracle-page.html  # 68,166 bytes
```

The page is a **compliance hub** with a sidebar table of contents and multiple sections. It is static HTML served by Oracle's CMS — not a SPA. Content is fully available via curl. Title: "Certified Health IT | Oracle Health". The page description references "Cerner" (the pre-acquisition name).

Sidebar navigation sections:
1. ASTP/ONC Certified Health IT
2. Costs and fees information
3. Certified API technology fees
4. Artificial Intelligence and Machine Learning Development Practices
5. **Electronic Health Information (EHI) Export** ← target section
6. Real World Testing
7. Standards Version Advancement Process
8. Multifactor authentication use cases
9. Where to find more information about the Oracle Health certifications

### Step 3: Finding the EHI section

The EHI Export section is anchored at `#ehi-export-lnk` on the page. The section header reads "Electronic Health Information (EHI) Export". Below the introductory text, there is an **accordion** labeled "Read more about EHI Export" (button `aria-controls="content-2"`, initially `aria-expanded="false"`).

The accordion content is **in the HTML source** (not lazy-loaded). It was found via:
```bash
grep -oiE 'href="[^"]*"' /tmp/oracle-page.html | grep -iE 'ehi|export'
```

Inside the accordion, there are **two subsections**:

#### Subsection 1: Oracle Health EHR and Millennium Platform
A table with two rows:

| EHI Export Type | Data Overview and Instructions | Data Format Specifications |
|---|---|---|
| Single Patient Export | [Single Patient EHI Export Data Overview and User Instructions (PDF)](https://www.oracle.com/a/ocom/docs/industries/healthcare/cerner-corp-single-patient-ehi-export-data-overview.pdf) | [Single Patient EHI Export Data Format Specifications (ZIP)](https://www.oracle.com/a/ocom/docs/industries/healthcare/single-patient-ehi-export-data-format-specifications.zip) |
| Patient Population Export | [Patient Population EHI Export Data Overview and User Instructions (PDF)](https://www.oracle.com/a/ocom/docs/industries/healthcare/cerner-corp-patient-population-ehi-export-data-overview.pdf) | [Patient Population EHI Export Data Format Specifications (ZIP)](https://www.oracle.com/a/ocom/docs/industries/healthcare/patient-population-ehi-export-data-format-specifications.zip) |

#### Subsection 2: Oracle Health Data Intelligence (HDI)
A table with one row:

| EHI Export Type | Data Overview and Instructions | Data Format Specifications |
|---|---|---|
| Single Patient and Patient Population Exports | [Oracle Health Data Intelligence EHI Export Data Overview and User Instructions (PDF)](https://www.oracle.com/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-overview-user-instructions.pdf) | [Oracle Health Data Intelligence EHI Export Data Format Specifications (PDF)](https://www.oracle.com/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-format-specifications.pdf) |

### Step 4: Identified downloadable assets

Six files total:

1. `cerner-corp-single-patient-ehi-export-data-overview.pdf` — Single patient overview & instructions
2. `single-patient-ehi-export-data-format-specifications.zip` — Single patient data model
3. `cerner-corp-patient-population-ehi-export-data-overview.pdf` — Population export overview & instructions
4. `patient-population-ehi-export-data-format-specifications.zip` — Population export data model
5. `health-data-intelligence-ehi-export-data-overview-user-instructions.pdf` — HDI overview & instructions
6. `health-data-intelligence-ehi-export-data-format-specifications.pdf` — HDI data format specs (Avro schema)

## Downloads

All downloads used the same User-Agent header and base URL pattern:
```
BASE="https://www.oracle.com/a/ocom/docs/industries/healthcare"
UA='User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```

### 1. cerner-corp-single-patient-ehi-export-data-overview.pdf (151 KB)
```bash
curl -L -H "$UA" \
  -o downloads/cerner-corp-single-patient-ehi-export-data-overview.pdf \
  "$BASE/cerner-corp-single-patient-ehi-export-data-overview.pdf"
```
Verified: `PDF document, version 1.7, 4 page(s)` — 154,866 bytes

### 2. single-patient-ehi-export-data-format-specifications.zip (7.3 MB)
```bash
curl -L -H "$UA" \
  -o downloads/single-patient-ehi-export-data-format-specifications.zip \
  "$BASE/single-patient-ehi-export-data-format-specifications.zip"
```
Verified: `Zip archive data, at least v2.0 to extract` — 7,656,902 bytes

Contents (2 files):
- `Longitudinal Plan EHI Export - Single Patient.pdf` — NDJSON export format for Longitudinal Plan
- `EHI MYSQL DATA MODEL 2025401.zip` — **nested ZIP** containing 1,456 HTML files (55 MB extracted)
  - `start_cerner_millennium_data_model_reports.html` — index page
  - `html/` — 1,454 HTML files organized by domain (dms_*.html)
  - `css/model.css`, `images/` — supporting assets

### 3. cerner-corp-patient-population-ehi-export-data-overview.pdf (447 KB)
```bash
curl -L -H "$UA" \
  -o downloads/cerner-corp-patient-population-ehi-export-data-overview.pdf \
  "$BASE/cerner-corp-patient-population-ehi-export-data-overview.pdf"
```
Verified: `PDF document, version 1.7, 23 page(s)` — 456,977 bytes

### 4. patient-population-ehi-export-data-format-specifications.zip (14.9 MB)
```bash
curl -L -H "$UA" \
  -o downloads/patient-population-ehi-export-data-format-specifications.zip \
  "$BASE/patient-population-ehi-export-data-format-specifications.zip"
```
Verified: `Zip archive data, at least v2.0 to extract` — 15,621,689 bytes

Contents (7 files):
- `Longitudinal Plan EHI Export - Patient Population.pdf`
- `EHI ORACLE DATA MODEL 2025401.zip` — nested ZIP, 1,456 HTML files (55 MB extracted, Oracle DB variant)
- `EHI MYSQL DATA MODEL 2025401.zip` — nested ZIP, 1,456 HTML files (55 MB extracted, MySQL variant)
- `Oracle Health Document Imaging Content Management Database Schema.pdf` (7 pages)
- `Oracle Health Multimedia Storage DICOM Data Structure and Definitions.pdf`
- `Oracle Health Multimedia Storage Non-DICOM Data Column Definitions.pdf` (1 page)
- `Oracle Health Document Imaging AxAnnotations.xsd` (XML Schema for document annotations)

### 5. health-data-intelligence-ehi-export-data-overview-user-instructions.pdf (168 KB)
```bash
curl -L -H "$UA" \
  -o downloads/health-data-intelligence-ehi-export-data-overview-user-instructions.pdf \
  "$BASE/health-data-intelligence-ehi-export-data-overview-user-instructions.pdf"
```
Verified: `PDF document, version 1.7, 3 page(s)` — 172,438 bytes

### 6. health-data-intelligence-ehi-export-data-format-specifications.pdf (5.7 MB)
```bash
curl -L -H "$UA" \
  -o downloads/health-data-intelligence-ehi-export-data-format-specifications.pdf \
  "$BASE/health-data-intelligence-ehi-export-data-format-specifications.pdf"
```
Verified: `PDF document, version 1.7, 8 page(s)` — 5,934,347 bytes

### Extraction of nested ZIPs

```bash
# Single Patient MySQL Data Model
unzip -o single-patient-ehi-export-data-format-specifications.zip -d extracted/single-patient/
unzip -o "extracted/single-patient/.../EHI MYSQL DATA MODEL 2025401.zip" -d extracted/single-patient/mysql-data-model/
# 1,456 files, 55 MB

# Patient Population Oracle Data Model
unzip -o patient-population-ehi-export-data-format-specifications.zip -d extracted/patient-population/
unzip -o "extracted/patient-population/.../EHI ORACLE DATA MODEL 2025401.zip" -d extracted/patient-population/oracle-data-model/
# 1,456 files, 55 MB

# Patient Population MySQL Data Model
unzip -o "extracted/patient-population/.../EHI MYSQL DATA MODEL 2025401.zip" -d extracted/patient-population/mysql-data-model/
# 1,456 files, 55 MB
```

## Obstacles & Notes

1. **301 redirect**: The registered URL `/health/regulatory/certified-health-it/` redirects to `/health/certified-health-it/`. The `/regulatory/` path component was removed at some point but the redirect works transparently.

2. **Accordion**: EHI documentation links are inside a collapsed accordion ("Read more about EHI Export"). The content is present in the HTML source (not lazy-loaded), so curl/grep finds it without needing a browser. But a human user must click to expand it.

3. **User-Agent required**: Oracle's servers require a User-Agent header for proper content delivery.

4. **Nested ZIPs**: Both specification ZIPs contain nested ZIPs (the data model reports). Two levels of extraction are required.

5. **Dual database format**: The patient population specs include BOTH Oracle and MySQL data model variants (identical table/column structure, different SQL dialects). The single patient export only includes MySQL (since single-patient exports produce MySQL SQL dumps).

6. **Data model version**: 2025.4.01, last updated January 16, 2025.

7. **Legacy naming**: Files still carry "cerner-corp" prefixes (Oracle acquired Cerner in 2022). The data model HTML pages reference "Oracle_Cerner" branding.

8. **Four independent storage locations**: The Millennium documentation covers four distinct data stores:
   - Core Millennium EHR database (relational, SQL)
   - Oracle Health Multimedia Storage (DICOM and non-DICOM files)
   - Oracle Health Document Imaging (document management system with its own schema)
   - Longitudinal Plan (NDJSON, via HealtheIntent platform)
