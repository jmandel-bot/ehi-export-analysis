# CareCloud, Inc. — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 8830, 9546, 10771, 11108, 11121, 11202
- Products: CareVue, ChartLogic EHR, ChartLogic EHR Classic, ChartLogic Patient Portal, PCG, Wellsoft EDIS
- Developer: CareCloud, Inc.
- Registered URL: https://www.medsphere.com/certifications/

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.medsphere.com/certifications/" -H 'User-Agent: Mozilla/5.0' 2>&1
```

Result: HTTP/2 200 directly (no redirects). Content-Type: text/html; charset=UTF-8. Served by Cloudflare (cf-cache-status: DYNAMIC), powered by WP Engine (WordPress). The page is at its registered URL without redirects.

### Step 2: Page examination

```bash
curl -sL "https://www.medsphere.com/certifications/" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html  # 111,500 bytes
```

The page is a WordPress-hosted static HTML page at 111.5 KB. It contains real content visible via curl (not a JavaScript SPA). The page has tab-based navigation with sections for **CareVue**, **ChartLogic**, **Wellsoft**, and **Micro-Office Systems** (PCG). Each tab contains certification details and EHI Export Documentation for the respective product.

The page was last modified 2026-01-09T22:46:52+00:00 per JSON-LD metadata.

### Step 3: Finding the EHI content

The EHI documentation is directly on the certifications page, embedded inline within each product section. No accordion expansion needed — the content is visible in the HTML source and rendered in tab panels.

Searching for downloadable assets:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html
```

Found:
1. `https://msc-ehi-export.medsphere.com/EHI_EXPORT.zip` — CareVue XSD file
2. `https://msc-ehi-export.medsphere.com/EHI_EXPORT.txt` — CareVue XSD (viewable)
3. `https://msc-ehi-export.medsphere.com/DD_FILTERED.html` — CareVue data dictionary
4. `https://go.chartlogic.com/l/76372/2023-11-21/clp3t8/76372/1700602435OhJooh0K/EHI_export_with_descriptions.xlsx` — Wellsoft/ChartLogic data dictionary (XLSX)
5. `http://www.medsphere.com/wp-content/uploads/2024/07/Additional-Costs-and-Disclosures-of-Certified-Health-IT-2.pdf` — Cost disclosures

### Step 4: Product-by-product EHI export approach

On the certifications page, each product has a distinct EHI export approach described inline:

**CareVue (CHPL 11121)**:
- Exports XML files containing "all patient-relevant record information in a single standard format"
- One XML file per patient, named with last name + MRN
- Provides XSD schema file and a detailed data dictionary (143 database tables)
- This is a **native database export** — the data dictionary describes VistA/RPMS-derived file structures

**ChartLogic EHR V1 (CHPL 11108)** and **ChartLogic EHR Classic (CHPL 10771)**:
- Exports C-CDA format for individual and population export
- Additionally exports scanned documents and images as PDFs
- C-CDA complies with USCDI Version 1
- No separate data dictionary provided (relies on HL7 C-CDA specification)

**ChartLogic Patient Portal 9 (CHPL 8830)**:
- Exports C-CDA format only
- No mention of documents/images export

**Wellsoft EDIS v11 (CHPL 9546)**:
- Exports as "standardized CCDA or .csv"
- Data dictionary link points to the same XLSX at go.chartlogic.com (now dead)

**PCG Version 3.5 (CHPL 11202)**:
- Exports C-CDA format
- Single-patient export via UI; bulk export requires contacting support@micro-officesystems.com
- Bulk export delivered as zipped CCD-A files

### Step 5: Downloading assets

The ChartLogic/Wellsoft XLSX data dictionary link (`go.chartlogic.com/l/76372/...`) is dead — returns "This content isn't available. Contact the owner of this site for help." via Pardot (Salesforce marketing automation). This is a significant loss since it was the only data dictionary for the Wellsoft CSV export format.

```bash
curl -sL -H 'User-Agent: Mozilla/5.0' 'https://go.chartlogic.com/l/76372/2023-11-21/clp3t8/76372/1700602435OhJooh0K/EHI_export_with_descriptions.xlsx'
# Returns: "This content isn't available. Contact the owner of this site for help."
```

Checked Wayback Machine — no captures of this URL exist.

## Downloads

### carevue-ehi-export-xsd.txt (6,899 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o carevue-ehi-export-xsd.txt \
  'https://msc-ehi-export.medsphere.com/EHI_EXPORT.txt'
```
Verified: `file` → XML 1.0 document, ASCII text
Content: XSD schema defining the CareVue EHI export XML format. Defines patient data, encounter data, and lab data structures with fields for fileNumber, fieldName, internal/external values, word processing, subfiles, and lab-specific structures (accessions, test results, micro results, susceptibilities).
Saved to: downloads/carevue-ehi-export-xsd.txt

### carevue-ehi-export.zip (1,174 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o carevue-ehi-export.zip \
  'https://msc-ehi-export.medsphere.com/EHI_EXPORT.zip'
```
Verified: `file` → Zip archive data, compression method=deflate
Contents: Single file `EHI_EXPORT.xsd` (6,899 bytes, dated 2023-09-14)
Saved to: downloads/carevue-ehi-export.zip

### carevue-data-dictionary.html (4,433,117 bytes / 4.3 MB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o carevue-data-dictionary.html \
  'https://msc-ehi-export.medsphere.com/DD_FILTERED.html'
```
Verified: `file` → HTML document, ASCII text
Content: Comprehensive data dictionary titled "Data Dictionary - All Files" covering 143 database tables/files with field-level detail. Each table includes file number, file description, and a table of fields with Name, Number, Description, Data Type, and Field Specific Data (including code sets). This is clearly derived from a VistA/CPRS database structure (references DHCP, VHA Directives, FileMan).
Saved to: downloads/carevue-data-dictionary.html

### additional-costs-disclosures.pdf (171,943 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o additional-costs-disclosures.pdf \
  'http://www.medsphere.com/wp-content/uploads/2024/07/Additional-Costs-and-Disclosures-of-Certified-Health-IT-2.pdf'
```
Verified: `file` → PDF document, version 1.7, 5 pages
Content: Cost disclosure document (not EHI-specific)
Saved to: downloads/additional-costs-disclosures.pdf

### medsphere-certifications-page.html (111,500 bytes)
Saved the full certifications page HTML as reference.
Saved to: downloads/medsphere-certifications-page.html

### FAILED: chartlogic-ehi-export-with-descriptions.xlsx
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o chartlogic-ehi-export-with-descriptions.xlsx \
  'https://go.chartlogic.com/l/76372/2023-11-21/clp3t8/76372/1700602435OhJooh0K/EHI_export_with_descriptions.xlsx'
```
Result: 72-byte text file containing "This content isn't available. Contact the owner of this site for help." — The Pardot-hosted link is dead. This was the data dictionary for the Wellsoft EDIS CSV export. No Wayback Machine archive exists.

## Product Context

CareCloud, Inc. operates through the Medsphere brand and manages multiple distinct healthcare IT products acquired over time:

- **CareVue** (formerly OpenVista CareVue): A hospital/inpatient EHR based on VistA (the VA's open-source EHR). Serves acute care hospitals, behavioral health facilities, rural/critical access hospitals. The VistA heritage means it uses the FileMan database structure.

- **ChartLogic EHR**: An ambulatory/physician practice EHR. Includes electronic medical records, practice management (scheduling, billing), e-prescribing, and a patient portal ("Connect Patient"). Serves physician practices across specialties including ophthalmology, orthopedics. ChartLogic has its own billing/revenue cycle management.

- **Wellsoft EDIS**: An Emergency Department Information System. Provides patient tracking, clinical documentation, medication management, triage, and real-time reporting for hospital EDs and urgent care centers. Also marketed as the hospital-wide EHR.

- **PCG** (via Micro-Office Systems): A patient portal/PHR product.

Medsphere also offers Revenue Cycle Management (RCM-Cloud), healthcare analytics, supply chain management, and IT services — suggesting the broader product ecosystem stores billing, financial, and operational data.

Key observations:
- ChartLogic explicitly has billing/practice management and a patient portal, meaning it stores scheduling, billing, and potentially messaging data
- CareVue is VistA-based, so its data dictionary reveals the full DHCP/VistA file structure including accounts receivable and insurance eligibility
- Wellsoft EDIS handles ED operations including triage, tracking, and documentation

## Obstacles & Notes

1. **Dead Pardot link**: The Wellsoft/ChartLogic XLSX data dictionary at `go.chartlogic.com` is no longer available. This is the only documentation for the Wellsoft CSV export format. No Wayback Machine capture exists.

2. **Multiple products, vastly different export approaches**: CareVue gets a native database export (XML with 143 tables), while ChartLogic, ChartLogic Patient Portal, and PCG all use C-CDA only. Wellsoft offers C-CDA or CSV but the CSV documentation is lost.

3. **PCG requires contacting vendor for bulk export**: The PCG section states "To obtain a bulk export in the format of zipped CCD-A files, submit a request to support@micro-officesystems.com" — the UI only allows one patient at a time.

4. **WordPress with lazy-loading JS**: The product pages (solutions/hospital-ehr, etc.) are heavily JavaScript-rendered and mostly empty via curl. The certifications page, however, has all content in the HTML source.

5. **CareVue's VistA heritage**: The data dictionary clearly derives from the VistA/RPMS system (references DHCP, FileMan, VA-specific fields like veteran status, service-connected disability). CareVue is the open-source OpenVista system adapted for commercial use.
