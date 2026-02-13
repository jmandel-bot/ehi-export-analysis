# Oracle Health — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 10594, 11505, 11519, 11520, 11522, 11667, 11668, 11669, 11670, 11674
- **Products**: Oracle Health Millennium (CQMs), Oracle Health Millennium (Clinical), Oracle Health Millennium (Health Care Surveys), Oracle Health Millennium (Immunizations), Oracle Health Patient Portal, Oracle Health PowerChart Touch
- **Registered URL**: https://www.oracle.com/health/regulatory/certified-health-it/

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.oracle.com/health/regulatory/certified-health-it/" \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```

**Result**: HTTP/2 301 redirect from `/health/regulatory/certified-health-it/` → `/health/certified-health-it/` (dropped the `/regulatory/` path component), then HTTP/2 200. Final URL: `https://www.oracle.com/health/certified-health-it/`. Content-Type: `text/html; charset=UTF-8`. Content-Length: 63,469 bytes. No anti-bot issues — Oracle serves static HTML with a User-Agent header.

### Step 2: Page examination

```bash
curl -sL "https://www.oracle.com/health/certified-health-it/" \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
  -o /tmp/oracle-page.html
wc -c /tmp/oracle-page.html
```

**Result**: 68,165 bytes. The page is real server-rendered HTML (not a SPA). It's a comprehensive regulatory compliance hub titled "Certified Health IT | Oracle Health" with a left sidebar navigation and multiple content sections. The page was last updated 2026-01-02.

The page contains these sections (via sidebar navigation):
- ASTP/ONC Certified Health IT
- Costs and fees information
- Certified API technology fees
- AI and Machine Learning Development Practices
- **Electronic Health Information (EHI) Export** ← target
- Real World Testing
- Standards Version Advancement Process
- Multifactor authentication use cases
- Where to find more information

### Step 3: Finding the EHI section

The EHI Export section is at anchor `#ehi-export-lnk` on the same page. It's visible in the sidebar navigation. Scrolling or clicking the sidebar link brings you to the "Electronic Health Information (EHI) Export" heading. Below that is an accordion labeled **"Read more about EHI Export"** (button id: `accordion2`, aria-controls: `content-2`). The accordion content is present in the HTML source (just hidden via CSS), so curl can access it without JavaScript.

Inside the accordion are two subsections:

1. **Oracle Health EHR and Millennium Platform** — covers Oracle Health EHR, Oracle Health Millennium (Clinical), Oracle Health Millennium (CQMs), Oracle Health Millennium (Health Care Surveys), Oracle Health Millennium (Immunizations), Oracle Health PowerChart Touch, Oracle Health Patient Portal. Contains a table with links to single patient and patient population export docs.

2. **Oracle Health Data Intelligence (HDI)** — covers the Oracle Health Data Intelligence: eCQMs certified health IT module. Contains a table with links to HDI-specific export docs.

### Step 4: Identified downloadable assets

```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/oracle-page.html
```

**EHI-specific files found (6 files):**

| # | File | Type | Section |
|---|------|------|--------|
| 1 | `cerner-corp-single-patient-ehi-export-data-overview.pdf` | PDF | Millennium - Single Patient |
| 2 | `single-patient-ehi-export-data-format-specifications.zip` | ZIP | Millennium - Single Patient |
| 3 | `cerner-corp-patient-population-ehi-export-data-overview.pdf` | PDF | Millennium - Patient Population |
| 4 | `patient-population-ehi-export-data-format-specifications.zip` | ZIP | Millennium - Patient Population |
| 5 | `health-data-intelligence-ehi-export-data-overview-user-instructions.pdf` | PDF | HDI |
| 6 | `health-data-intelligence-ehi-export-data-format-specifications.pdf` | PDF | HDI |

All files are at base URL `https://www.oracle.com/a/ocom/docs/industries/healthcare/`.

## Downloads

### single-patient-ehi-export-data-overview.pdf (152 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
  -o single-patient-ehi-export-data-overview.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/cerner-corp-single-patient-ehi-export-data-overview.pdf'
```
Verified: `file` → PDF document, version 1.7. Pages: 4. Created: 2023-10-31.
Content: User instructions for single patient EHI export — describes export artifacts, directory structure, data sources (Core Millennium EHR, Multimedia Storage, DICOM, Document Imaging, Longitudinal Plan).

### single-patient-ehi-export-data-format-specifications.zip (7.4 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
  -o single-patient-ehi-export-data-format-specifications.zip \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/single-patient-ehi-export-data-format-specifications.zip'
```
Verified: Zip archive. Contains 3 entries:
- `EHI MYSQL DATA MODEL 2025401.zip` — nested ZIP containing the MySQL data model HTML reports (1,448 HTML files, 6,587+ tables documented)
- `Longitudinal Plan EHI Export - Single Patient.pdf` — links to HealtheIntent API docs for care plans, goals, health concerns, activities, strengths

### patient-population-ehi-export-data-overview.pdf (447 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
  -o patient-population-ehi-export-data-overview.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/cerner-corp-patient-population-ehi-export-data-overview.pdf'
```
Verified: PDF document, version 1.7. Pages: 23. Created: 2023-10-27.
Content: Detailed instructions for patient population EHI export. Covers Core Millennium EHR Data (including multi-tenant vs single-tenant delivery), Multimedia Storage (DICOM and non-DICOM), Document Imaging, and Longitudinal Plan data. Includes appendices with data structure definitions.

### patient-population-ehi-export-data-format-specifications.zip (15 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
  -o patient-population-ehi-export-data-format-specifications.zip \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/patient-population-ehi-export-data-format-specifications.zip'
```
Verified: Zip archive. Contains 8 entries:
- `EHI MYSQL DATA MODEL 2025401.zip` — MySQL data model HTML reports (identical to single patient)
- `EHI ORACLE DATA MODEL 2025401.zip` — Oracle Database version of the same data model (also 6,587 tables, 1,448 HTML files)
- `Longitudinal Plan EHI Export - Patient Population.pdf`
- `Oracle Health Document Imaging AxAnnotations.xsd` — XML schema for document annotations
- `Oracle Health Document Imaging Content Management Database Schema.pdf` — full database schema for the document imaging system (AE_ADEFS, AE_APPS, AE_CFG, etc.)
- `Oracle Health Multimedia Storage DICOM Data Structure and Definitions.pdf` — DICOM data XML/JSON structure with sample data
- `Oracle Health Multimedia Storage Non-DICOM Data Column Definitions.pdf` — column definitions for non-DICOM multimedia (ObjectIdentifier, CompressionCode, MimeTypeCode, etc.)

### hdi-ehi-export-data-overview-user-instructions.pdf (169 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
  -o hdi-ehi-export-data-overview-user-instructions.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-overview-user-instructions.pdf'
```
Verified: PDF document, version 1.7. Pages: 3. Created: 2024-11-21.
Content: Instructions for requesting EHI exports via Longitudinal Record Bulk Extract API and Data Syndication API. Covers authentication (bearer token, OAuth 1.0a), requesting population/patient-level extracts, downloading results.

### hdi-ehi-export-data-format-specifications.pdf (5.7 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
  -o hdi-ehi-export-data-format-specifications.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-format-specifications.pdf'
```
Verified: PDF document, version 1.3. Pages: 196 (originally reported as 8 by `file`, but pdfinfo shows 196). Created: 2024-11-06.
Content: Avro-schema-based entity type definitions for the HDI Longitudinal Record ("Poprecord Entity Types"). Approximately 219 entity types covering clinical data, claims, appointments, insurance coverage, and more. Exported as JSON files in tar.gz archives.

## Product Context

Oracle Health (formerly Cerner Corporation, acquired by Oracle in 2022) is one of the largest EHR vendors in the world. The **Millennium platform** is a comprehensive enterprise health information system used by large hospital systems, academic medical centers, and community hospitals. It covers:

- **Clinical**: Full EHR with clinical documentation (PowerChart), physician orders (CPOE), medications (PharmNet), lab (PathNet), radiology (RadNet), surgery (SurgiNet), nursing documentation, oncology, behavioral health, women's health, rehabilitation, clinical trials
- **Financial/Revenue Cycle**: Registration, charge capture, billing, claims management, collections, accounts receivable, general ledger interface, payment posting (PFT suite — "Patient Financial Transactions")
- **Scheduling**: Appointment scheduling with complex build capabilities (SCH_ tables)
- **Patient Portal**: Patient-facing portal with invitations and portal events
- **Document Management**: Document imaging (Oracle Health Document Imaging) and multimedia storage (DICOM, images, audio, video)
- **Interoperability**: Open Engine for HL7/FHIR integration, Direct messaging
- **Analytics**: Oracle Health Data Intelligence (HDI) — a separate cloud-based analytics platform that aggregates data from Millennium into a longitudinal record
- **Clinical Operations**: Patient tracking, bed management, workforce management

The certified modules listed in the CHPL cover Clinical, CQMs, Health Care Surveys, Immunizations, Patient Portal, and PowerChart Touch — but the broader product is the entire Millennium platform. The EHI export documentation explicitly states it covers the full Millennium database.

## Obstacles & Notes

1. **URL redirect**: The registered URL `/health/regulatory/certified-health-it/` redirects to `/health/certified-health-it/` — the `/regulatory/` path segment was removed at some point. The redirect works fine.

2. **Accordion**: The EHI Export download links are inside a collapsed accordion section ("Read more about EHI Export"). The content is in the HTML source regardless (visible to curl/grep), but users navigating the browser must click to expand it.

3. **Legacy naming**: Several files still use "Cerner Corporation" or "Cerner" naming (e.g., `cerner-corp-single-patient-ehi-export-data-overview.pdf`), reflecting the pre-acquisition naming. The data model reports header reads "Millennium Data Model Reports — 2025.4.01" with the Oracle Cerner logo.

4. **Four data storage locations**: The documentation is organized around four independent storage locations: (a) Core Millennium EHR database, (b) Oracle Health Multimedia Storage (DICOM + non-DICOM), (c) Oracle Health Document Imaging, and (d) Longitudinal Plan (One Plan / HealtheIntent). This makes the export comprehensive but complex to consume.

5. **Nested ZIPs**: The format specifications ZIPs contain nested ZIPs (MySQL data model and Oracle data model are themselves ZIP files containing HTML report sites). This requires two levels of extraction.

6. **Data model version**: The data model reports are version 2025.4.01, last updated January 16, 2025.
