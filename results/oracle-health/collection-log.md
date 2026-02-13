# Oracle Health — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11637, 11671, 11702
- **Products**: Oracle Health Data Intelligence: PI Functional Reports, Oracle Health Data Intelligence: eCQMs, Oracle Health EHR
- **Registered URL**: https://www.oracle.com/health/regulatory/certified-health-it/#ehi-export-lnk

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.oracle.com/health/regulatory/certified-health-it/#ehi-export-lnk" -H 'User-Agent: Mozilla/5.0'
```

**Result**: 301 redirect from `/health/regulatory/certified-health-it/` → `/health/certified-health-it/`, then 200 OK. The old path `/health/regulatory/` has been reorganized to `/health/`. Final URL: `https://www.oracle.com/health/certified-health-it/` (fragment `#ehi-export-lnk` preserved client-side). Content-Type: `text/html; charset=UTF-8`. Page size: 68,166 bytes.

**Note**: The registered URL uses the old path `/health/regulatory/certified-health-it/` which 301-redirects to `/health/certified-health-it/`. Both work. A User-Agent header is required (Oracle/Akamai CDN).

### Step 2: Page examination

```bash
curl -sL "https://www.oracle.com/health/regulatory/certified-health-it/#ehi-export-lnk" \
  -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
```

The page is a standard Oracle corporate compliance page (~68 KB HTML) with substantive content in the HTML source. It is NOT a JavaScript SPA — content is server-rendered and accessible via curl. The page is titled "Certified Health IT | Oracle Health" and covers multiple ONC certification topics with a left sidebar navigation.

### Step 3: Finding the EHI section

The page has a sidebar with the following sections:
- ASTP/ONC Certified Health IT
- Costs and fees information
- Certified API technology fees
- AI and Machine Learning Development Practices
- **Electronic Health Information (EHI) Export** ← target section
- Real World Testing
- Standards Version Advancement Process
- Multifactor authentication use cases
- Where to find more information

The `#ehi-export-lnk` anchor links directly to the EHI Export section heading. The section has an **accordion** labeled "Read more about EHI Export" (button with `id="accordion2"`) that must be expanded to reveal the download links.

In the HTML source, the accordion content is present in the DOM (not lazy-loaded), just hidden via CSS (`aria-expanded="false"`). So `grep` on the raw HTML finds the links even without JavaScript.

### Step 4: Accordion content — two subsections

After expanding the accordion (clicking "Read more about EHI Export"), two subsections appear:

#### Subsection 1: Oracle Health EHR and Millennium Platform

Covers: Oracle Health EHR, Oracle Health Millennium (Clinical), Millennium (CQMs), Millennium (Health Care Surveys), Millennium (Immunizations), PowerChart Touch, Patient Portal.

Documentation for **four independent storage locations**:
1. Core Millennium EHR database (relational DB)
2. Oracle Health Multimedia Storage (DICOM, audio, video, images)
3. Oracle Health Document Imaging (scanned documents)
4. Oracle Health Longitudinal Plan (care planning data)

| EHI Export Type | Data Overview | Data Format Specs |
|---|---|---|
| Single Patient Export | PDF | ZIP |
| Patient Population Export | PDF | ZIP |

#### Subsection 2: Oracle Health Data Intelligence (HDI)

Covers: Oracle Health Data Intelligence: eCQMs. The export supports all data for the HDI Longitudinal Record.

| EHI Export Type | Data Overview | Data Format Specs |
|---|---|---|
| Single Patient and Patient Population Exports | PDF | PDF |

### Step 5: Identified downloadable assets

Six files found:

1. `/a/ocom/docs/industries/healthcare/cerner-corp-single-patient-ehi-export-data-overview.pdf`
2. `/a/ocom/docs/industries/healthcare/single-patient-ehi-export-data-format-specifications.zip`
3. `/a/ocom/docs/industries/healthcare/cerner-corp-patient-population-ehi-export-data-overview.pdf`
4. `/a/ocom/docs/industries/healthcare/patient-population-ehi-export-data-format-specifications.zip`
5. `/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-overview-user-instructions.pdf`
6. `/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-format-specifications.pdf`

All links are relative paths on oracle.com, opening in new tabs (`target="_blank"`).

## Downloads

All downloaded on 2025-02-13. Base URL: `https://www.oracle.com`.

### cerner-corp-single-patient-ehi-export-data-overview.pdf (151 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/cerner-corp-single-patient-ehi-export-data-overview.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/cerner-corp-single-patient-ehi-export-data-overview.pdf'
```
Verified: `PDF document, version 1.7, 4 page(s)` — 154,866 bytes

### single-patient-ehi-export-data-format-specifications.zip (7.3 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/single-patient-ehi-export-data-format-specifications.zip \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/single-patient-ehi-export-data-format-specifications.zip'
```
Verified: `Zip archive data` — 7,656,902 bytes

Contents (nested):
- `Longitudinal Plan EHI Export - Single Patient.pdf` — care planning schema reference
- `EHI MYSQL DATA MODEL 2025401.zip` — nested ZIP containing **1,456 HTML files** (Millennium Data Model Reports v2025.4.01 for MySQL), organized by domain, with CSS and images. 55 MB extracted.

### cerner-corp-patient-population-ehi-export-data-overview.pdf (447 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/cerner-corp-patient-population-ehi-export-data-overview.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/cerner-corp-patient-population-ehi-export-data-overview.pdf'
```
Verified: `PDF document, version 1.7, 23 page(s)` — 456,977 bytes

### patient-population-ehi-export-data-format-specifications.zip (14.9 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/patient-population-ehi-export-data-format-specifications.zip \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/patient-population-ehi-export-data-format-specifications.zip'
```
Verified: `Zip archive data` — 15,621,689 bytes

Contents (nested):
- `Longitudinal Plan EHI Export - Patient Population.pdf` — care planning schema reference
- `Oracle Health Document Imaging Content Management Database Schema.pdf` — document imaging DB schema
- `Oracle Health Multimedia Storage DICOM Data Structure and Definitions.pdf` — DICOM XML structure with sample
- `Oracle Health Multimedia Storage Non-DICOM Data Column Definitions.pdf` — non-DICOM multimedia column definitions
- `Oracle Health Document Imaging AxAnnotations.xsd` — XML Schema for document annotations
- `EHI ORACLE DATA MODEL 2025401.zip` — nested ZIP, **1,456 HTML files** (Millennium Data Model Reports for Oracle DB). 55 MB extracted.
- `EHI MYSQL DATA MODEL 2025401.zip` — nested ZIP, **1,456 HTML files** (same schema for MySQL). 55 MB extracted.

### health-data-intelligence-ehi-export-data-overview-user-instructions.pdf (168 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/health-data-intelligence-ehi-export-data-overview-user-instructions.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-overview-user-instructions.pdf'
```
Verified: `PDF document, version 1.7, 3 page(s)` — 172,438 bytes

### health-data-intelligence-ehi-export-data-format-specifications.pdf (5.7 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/health-data-intelligence-ehi-export-data-format-specifications.pdf \
  'https://www.oracle.com/a/ocom/docs/industries/healthcare/health-data-intelligence-ehi-export-data-format-specifications.pdf'
```
Verified: `PDF document, version 1.3, 8 page(s)` — 5,934,347 bytes (8 pages but 5.7 MB — very large; likely contains embedded content or dense Avro schema)

## ZIP Extraction Summary

### Single Patient ZIP structure:
```
single-patient-ehi-export-data-format-specifications/
├── Longitudinal Plan EHI Export - Single Patient.pdf
└── EHI MYSQL DATA MODEL 2025401.zip
    └── (1,456 HTML files + CSS + images — Millennium schema for MySQL)
```

### Patient Population ZIP structure:
```
patient-population-ehi-export-data-format-specifications/
├── Longitudinal Plan EHI Export - Patient Population.pdf
├── Oracle Health Document Imaging Content Management Database Schema.pdf
├── Oracle Health Multimedia Storage DICOM Data Structure and Definitions.pdf
├── Oracle Health Multimedia Storage Non-DICOM Data Column Definitions.pdf
├── Oracle Health Document Imaging AxAnnotations.xsd
├── EHI ORACLE DATA MODEL 2025401.zip
│   └── (1,456 HTML files — Millennium schema for Oracle DB)
└── EHI MYSQL DATA MODEL 2025401.zip
    └── (1,456 HTML files — Millennium schema for MySQL)
```

## Obstacles & Notes

1. **URL redirect**: The CHPL-registered URL uses `/health/regulatory/certified-health-it/` which 301-redirects to `/health/certified-health-it/`. Both paths work.

2. **User-Agent required**: Oracle's Akamai CDN requires a User-Agent header or may return a redirect/block page.

3. **Accordion**: The download links are hidden behind an expandable accordion ("Read more about EHI Export"). Content IS in the HTML DOM, just CSS-hidden, so curl + grep finds the links. But a human browsing the page must click to expand.

4. **Nested ZIPs**: The format specification ZIPs contain nested ZIPs (EHI ORACLE DATA MODEL / EHI MYSQL DATA MODEL) that must be extracted separately.

5. **Legacy Cerner naming**: File names still use "cerner-corp" prefix (Oracle acquired Cerner in 2022). The data model reports are titled "Cerner Millennium Data Model Reports."

6. **Four storage systems**: The Millennium export covers four independent data stores:
   - Core Millennium EHR (relational database — SQL files for MySQL or Oracle DB dump)
   - Multimedia Storage (DICOM and non-DICOM media files in original format)
   - Document Imaging (scanned documents with annotation metadata)
   - Longitudinal Plan (care planning data via HealtheIntent/HDI platform)

7. **HDI uses Avro/JSON**: The Health Data Intelligence export uses a completely different format (JSON based on Avro schemas) from the Millennium export (SQL database dump). The HDI PDF documents 124 unique Avro entity types in the `com.cerner.pophealth.program.models.avro.poprecord` namespace.

8. **External documentation references**: The Longitudinal Plan PDFs reference external documentation at `docs.healtheintent.com` for detailed schema information (feed types, JSON structure, field definitions).
