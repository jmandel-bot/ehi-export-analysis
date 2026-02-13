# Medical Information Technology, Inc. (MEDITECH) — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 9091, 9092, 9095, 9101, 9103, 9107, 9108, 9109, 9162, 9238, 9258, 9265, 10924, 10925, 10926, 10927, 10929, 10930, 10931, 10932, 10933, 10934, 10935, 10972, 10973, 10976, 10977, 10978, 10979, 10981, 10982, 10984, 10985, 10988, 10993, 10994, 10995, 11018, 11742, 11743
- **Developer**: Medical Information Technology, Inc. (MEDITECH)
- **Products**: MEDITECH 6.0 Electronic Health Record Core HCIS, MEDITECH 6.0 Emergency Department Management, MEDITECH 6.1 Ambulatory Electronic Health Record, MEDITECH 6.1 Electronic Health Record Core HCIS, MEDITECH 6.1 Emergency Department Management, MEDITECH 6.1 Oncology, MEDITECH Cancer Case Reporting, MEDITECH Client/Server Electronic Health Record Core HCIS, MEDITECH Client/Server Emergency Department Management, MEDITECH Client/Server Oncology, MEDITECH Continuity of Care Interface (CCD), MEDITECH Expanse 2.1 Ambulatory, MEDITECH Expanse 2.1 Core HCIS, MEDITECH Expanse 2.1 Oncology, MEDITECH Expanse 2.2 Ambulatory, MEDITECH Expanse 2.2 Core HCIS, MEDITECH Expanse 2.2 Emergency Department Management, MEDITECH Expanse 2.2 Oncology, MEDITECH Expanse Emergency Department Management, MEDITECH MAGIC Electronic Health Record Core HCIS, MEDITECH MAGIC Emergency Department Management, MEDITECH MAGIC HCA Electronic Health Record Core HCIS (without PatientKeeper), MEDITECH MAGIC Oncology, MEDITECH MyHealth Portal, MEDITECH Public Health Interface Electronic Case Reporting, MEDITECH Public Health Interface Transmission to Immunization Registries, MEDITECH Public Health Interface for Syndromic Surveillance, MEDITECH Transmission of Reportable Laboratory Test and Values/Results
- **Registered URL**: https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP/2 200, Content-Type: text/html, Content-Length: 8964 bytes. Direct 200 response — no redirects, no anti-bot protection, no login required. Server: Microsoft-IIS/10.0.

### Step 2: Page examination

```bash
curl -sL "https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html  # 8964 bytes
```

The page is static HTML (not a SPA). It renders fully via curl with no JavaScript required. The page is a hub page that describes MEDITECH's EHI Export at a high level. It explains that the export produces a ZIP file containing machine-readable data, and that the contents vary by product version.

The page contains a table with two columns: **Configuration 1** and **Configuration 2**, each linking to a separate detailed specification page.

### Step 3: Finding the EHI documentation structure

The main page at `ehiexport.htm` is an overview/hub. It contains:

1. A description of EHI Export capabilities
2. A table mapping product versions to two configurations:
   - **Configuration 1** (link to `ehiexportconfig1.htm`) — applies to Expanse 2.2, Expanse 2.1, 6.15, 6.08 Acute, Client Server Acute, MAGIC Acute
   - **Configuration 2** (link to `ehiexportconfig2.htm`) — applies to 6.08 Ambulatory, Client/Server Acute & Ambulatory, MAGIC Acute & Ambulatory
3. A link to "Regulatory EHI Export Functionality Guides" at `https://customer.meditech.com/en/d/21stcenturycuresact/pages/ehiexport.htm` — **this is behind a login wall** (redirects to Keycloak SAML authentication at accounts.meditech.com)

### Step 4: Configuration 1 page

```bash
curl -sL "https://home.meditech.com/en/d/restapiresources/pages/ehiexportconfig1.htm" -H 'User-Agent: Mozilla/5.0' -o /tmp/config1.html
wc -c /tmp/config1.html  # 29,280 bytes
```

This page documents the structure of the EHI export ZIP for Configuration 1. It contains:
- **Export Zip Overview**: Lists standard files in every export (README.txt, EHIEXPORTSCHEMA.txt, ACCOUNTS_INDEX.html/.xml, Table of Contents.ndjson)
- **Product Sections Index**: Table showing which sections are included per product version
- **Section Information**: Detailed description of each section's folder/file structure:
  - Electronic Chart (documents organized by account/category/subcategory)
  - Ambulatory Results (PDFs)
  - Authorization & Referral Management Reports (PDFs with auth and insurance data)
  - Financial Reports (FinancialEHI.txt, ResidentTrustEHI.txt, CostEstimation.txt)
  - FHIR Resource Bundle (US Core FHIR Resources.json — Patient $everything)
  - Historical Ambulatory Data
  - Immunization History (PDF)
  - Immunizations (text)
  - Implantable Devices (text)
  - Patient Notices (PDF)
  - Population Health (PDF)
  - Provider Messages (text)
  - Structured Clinical Documents (C-CDA folder)
  - Utilization Review (PDF)
- **Table of Contents.ndjson Schema**: Pseudo-JSON documenting the FHIR DocumentReference resource used as metadata for each file in the export

Also links to a prior version at `/en/d/restapiresources/pages/ehiexportold.htm` (27,779 bytes, essentially same content as config1 with the main page intro repeated).

### Step 5: Configuration 2 page

```bash
curl -sL "https://home.meditech.com/en/d/restapiresources/pages/ehiexportconfig2.htm" -H 'User-Agent: Mozilla/5.0' -o /tmp/config2.html
wc -c /tmp/config2.html  # 22,780 bytes
```

This page documents Configuration 2, which applies to older platforms (6.08 Ambulatory, Client/Server, MAGIC) configured with Medical Records (MRI) and Data Repository (DR). It contains similar structure with these sections:
- Patient Data (CSV) Files — CSV files named by namespace, with links to 3 PDF data dictionaries
- FHIR Resource Bundle
- Clinical Reports/Documents (varies by platform: C/S, MAGIC, MAGIC Ambulatory, MPM 6.08 Ambulatory)
- Provider and Patient Messages (PDF or TXT depending on platform)
- Financial Reports (FinancialEHI.txt)
- Structured Clinical Documents (C-CDA)
- External Documents/Images (scanned external documents)
- Point of Contact Scanned Documents
- JSONTOC Schema (same ndjson metadata format)

Critically, Configuration 2 links to **three PDF data dictionaries** for the CSV export tables:
1. `608ehiexportcsv.pdf` — MPM 6.08 Ambulatory CSV tables
2. `csacuteandambehiexportdrsolutionmerged.pdf` — Client/Server Acute & Ambulatory CSV tables
3. `mgehiexportdrsolutionmerged.pdf` — MAGIC Acute & Ambulatory CSV tables

### Step 6: Identified downloadable assets

From the Configuration 2 page, three PDF links:
- `/en/d/regulatoryresources/otherfiles/608ehiexportcsv.pdf`
- `/en/d/regulatoryresources/otherfiles/csacuteandambehiexportdrsolutionmerged.pdf`
- `/en/d/regulatoryresources/otherfiles/mgehiexportdrsolutionmerged.pdf`

Additionally, 4 HTML pages constitute the documentation:
- `ehiexport.htm` (main hub)
- `ehiexportconfig1.htm` (Configuration 1 spec)
- `ehiexportconfig2.htm` (Configuration 2 spec)
- `ehiexportold.htm` (prior version of config1)

### Step 7: Login-walled content

The link to "Regulatory EHI Export Functionality Guides" at `https://customer.meditech.com/en/d/21stcenturycuresact/pages/ehiexport.htm` redirects (HTTP 302) to a Keycloak SAML login page at `accounts.meditech.com`. This is a customer portal requiring authentication. The publicly accessible documentation (the four HTML pages + three PDFs) appears to be the complete public-facing EHI export documentation.

## Downloads

### 608ehiexportcsv.pdf (245 KB, 19 pages)

```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/608ehiexportcsv.pdf \
  'https://home.meditech.com/en/d/regulatoryresources/otherfiles/608ehiexportcsv.pdf'
```

Verified: `PDF document, version 1.4, 19 page(s)`, 251,431 bytes
Content: Data dictionary for MPM 6.08 Ambulatory CSV export. Lists Field → Table → Column mappings. Contains ~3,042 lines of text. Tables include: AdmEmployers, AdmInsuredData, AdmVisits, AprEnc, AprEncMessages, ArmAuths, MriPatients, PbrAccountTransactions, RxmOrds, SchAppointments, and many more.

### csacuteandambehiexportdrsolutionmerged.pdf (257 KB, 30 pages)

```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/csacuteandambehiexportdrsolutionmerged.pdf \
  'https://home.meditech.com/en/d/regulatoryresources/otherfiles/csacuteandambehiexportdrsolutionmerged.pdf'
```

Verified: `PDF document, version 1.4, 30 page(s)`, 262,764 bytes
Content: Data dictionary for Client/Server Acute & Ambulatory CSV export. Far more extensive — ~7,835 lines. Includes blood bank (Bbk*), ED management (Edm*), imaging (Its*), lab (Lab*), microbiology (Mic*), nursing (Nur*), order entry (Oe*), pharmacy (Pha*, Rxm*), pathology (Pth*), surgical scheduling (Sch*), and Hub patient problems tables.

### mgehiexportdrsolutionmerged.pdf (355 KB, 48 pages)

```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/mgehiexportdrsolutionmerged.pdf \
  'https://home.meditech.com/en/d/regulatoryresources/otherfiles/mgehiexportdrsolutionmerged.pdf'
```

Verified: `PDF document, version 1.4, 48 page(s)`, 363,475 bytes
Content: Data dictionary for MAGIC Acute & Ambulatory CSV export. ~7,165 lines. Similar scope to C/S but with MAGIC-specific table names. Includes radiology (RadExam*), episodes/problems (Eps*), and ambulatory visit data (PbrMpiVis*).

### HTML pages (all 4 saved)

```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o downloads/ehiexport-main.html 'https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm'
curl -sL -H 'User-Agent: Mozilla/5.0' -o downloads/ehiexportconfig1.html 'https://home.meditech.com/en/d/restapiresources/pages/ehiexportconfig1.htm'
curl -sL -H 'User-Agent: Mozilla/5.0' -o downloads/ehiexportconfig2.html 'https://home.meditech.com/en/d/restapiresources/pages/ehiexportconfig2.htm'
curl -sL -H 'User-Agent: Mozilla/5.0' -o downloads/ehiexportold.html 'https://home.meditech.com/en/d/restapiresources/pages/ehiexportold.htm'
```

Verified: 8,964 + 29,280 + 22,780 + 27,779 = 88,803 bytes total HTML.

## Obstacles & Notes

1. **Login-walled functionality guide**: The "Regulatory EHI Export Functionality Guides" link goes to `customer.meditech.com` which requires Keycloak SAML authentication. This presumably contains step-by-step guides for running the export, but is not publicly accessible. This is a separate resource from the format documentation itself.

2. **No anti-bot protection**: All public pages serve immediately with a simple User-Agent header. No Cloudflare, no CAPTCHA, no rate limiting observed.

3. **Configuration 1 vs Configuration 2**: MEDITECH has two distinct export configurations depending on product version and module setup. Configuration 1 (newer platforms, HIM/SCN) produces a richer export with eChart documents, FHIR bundle, C-CDA, and supplemental reports. Configuration 2 (older platforms, MRI/DR) additionally provides patient data as CSV files with well-documented schemas.

4. **No downloadable artifacts for Configuration 1**: Configuration 1 only has inline HTML documentation describing the folder/file structure. The three PDF data dictionaries only apply to Configuration 2's CSV exports. Configuration 1's export format is primarily document-based (PDFs, images, FHIR JSON, C-CDA XML) rather than structured tabular data.

5. **fhir.meditech.com**: The config1 page links to `https://fhir.meditech.com/explorer/topic/USCore-patient-health-data` for FHIR resource documentation. This is a separate FHIR documentation site, not specific to EHI export.
