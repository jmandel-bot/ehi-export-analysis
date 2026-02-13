# Epic Systems Corporation — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11595, 11596, 11597, 11603, 11604, 11641, 11643, 11644, 11653, 11654, 11683, 11684, 11685, 11686, 11687, 11711, 11712, 11713, 11730, 11731
- **Products**: Beacon Cancer Registry Reporting, Beaker Reportable Labs Reporting, EpicCare Ambulatory Base, EpicCare Inpatient Base, Infection Control Antimicrobial Use and Resistance Reporting
- **Registered URL**: https://open.epic.com/EHITables

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://open.epic.com/EHITables" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP 200 OK directly. No redirects. Content-Type: `text/html; charset=utf-8`, Content-Length: 8742 bytes. Server: Microsoft-IIS/10.0 (ASP.NET MVC). The page is a static HTML page, not a SPA.

### Step 2: Page examination

```bash
curl -sL "https://open.epic.com/EHITables" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html  # 8742 bytes
```

The page is a clean, static HTML page titled "EHI Tables Export" with substantive content. It is NOT a JavaScript SPA — all content is in the HTML source. The page contains:

1. A description of EHI Export functionality ("allows health systems to do a manual one-time export of health data")
2. A statement that export is in TSV format native to Epic
3. Two key links:
   - "the EHI Tables index" → `/EHITables/TechSpec` (redirects to `/EHITables/GetTable/_index.htm`)
   - "download the index as a zip file" → `/EHITables/Download`
4. Notes about variability based on software applications, version, and configuration
5. References to FHIR bulk data access and CCD/C-CDA as standards-based alternatives

### Step 3: Finding the EHI documentation

```bash
grep -oiE 'href="[^"]*[^"]*"' /tmp/page.html | grep -iE 'ehi|export|data.dictionary|b.10|download'
```

Found two documentation links:
- `href="/EHITables/TechSpec"` — Online browsable index of all EHI tables
- `href="/EHITables/Download"` — ZIP download of the same content

No accordion, no hidden sections, no multi-page navigation required. Both links are prominently displayed in the main content area.

### Step 4: Checking the download endpoint

```bash
curl -sI -L "https://open.epic.com/EHITables/Download" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP 200 OK. Content-Type: `application/x-zip-compressed`. Content-Disposition: `attachment; filename="Epic EHI Tables.zip"`. Content-Length: 12,664,966 bytes (~12.1 MB). Direct download, no redirects.

### Step 5: Checking the tech spec endpoint

```bash
curl -sI -L "https://open.epic.com/EHITables/TechSpec" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP 302 redirect to `https://open.epic.com/EHITables/GetTable/_index.htm`, then HTTP 200 OK. Content-Type: `text/html; charset=utf-8`. Content-Length: 1,077,591 bytes (~1 MB). This is a large HTML index page listing all 7,672 EHI tables with alphabetical navigation (A-W) and links to individual table documentation pages.

The index page states: "This documentation describes each Epic-released EHI table as of 2/12/2026 at 2:10 PM CT in the current released version of February 2026."

## Downloads

### Epic EHI Tables.zip (12,664,966 bytes / 12.1 MB)

```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/epic-ehi-tables.zip \
  'https://open.epic.com/EHITables/Download'
```

Verified: `file epic-ehi-tables.zip` → `Zip archive data, at least v2.0 to extract, compression method=deflate`

Contents: 7,674 files total (83,024,535 bytes uncompressed)
- 1 CSS file (`CRStyleSheet.css`)
- 1 index file (`_index.htm` — 1,071,083 bytes)
- 7,672 individual table documentation files (e.g., `ACCOUNT.htm`, `PAT_ENC.htm`)

Extracted to: `downloads/epic-ehi-tables/DocGen_su117s2p_2026-02-12_14.10.01/`

Each HTM file documents a single database table with:
- Table name and description
- Primary key definition
- Column information: ordinal position, name, data type, discontinued flag
- Per-column descriptions explaining what the column stores

## Product Context

Epic Systems Corporation is the largest EHR vendor in the United States, serving over 250 million patient records. The certified modules listed (EpicCare Ambulatory Base, EpicCare Inpatient Base, Beacon Cancer Registry Reporting, Beaker Reportable Labs Reporting, Infection Control Antimicrobial Use and Resistance Reporting) are components of the broader Epic EHR platform.

The full Epic platform includes:
- **EpicCare Ambulatory** — outpatient/clinic EHR
- **EpicCare Inpatient** — hospital EHR
- **MyChart** — patient portal with messaging, appointment scheduling, bill pay
- **Resolute/Professional Billing** — professional fee billing and revenue cycle
- **Resolute Hospital Billing** — hospital billing, claims, accounts receivable
- **Cadence** — scheduling and appointment management
- **Beaker** — laboratory information system
- **Radiant** — radiology information system
- **Beacon** — oncology-specific module
- **OpTime** — surgical/OR management
- **Tapestry** — payer/insurance module
- **Healthy Planet** — population health management
- **Wisdom** — behavioral health

All of these modules share a common database, and the EHI export is a dump of tables from that database. The export includes tables from across all of these modules.

## Obstacles & Notes

- **No obstacles encountered.** The documentation is publicly accessible, clearly organized, and requires no special headers, authentication, or JavaScript rendering.
- The ZIP downloads cleanly via curl with a standard User-Agent header.
- The online index is also accessible via curl (server-rendered HTML, not a SPA).
- Epic notes that actual export content varies by health system based on which Epic applications are in use and their configuration.
- The documentation version is "February 2026" (generated 2/12/2026 at 2:10 PM CT), indicating it is actively maintained and updated.
