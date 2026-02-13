# Epic Systems Corporation — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11595, 11596, 11597, 11603, 11604, 11641, 11643, 11644, 11653, 11654, 11683, 11684, 11685, 11686, 11687, 11711, 11712, 11713, 11730, 11731
- **Products**: Beacon Cancer Registry Reporting, Beaker Reportable Labs Reporting, EpicCare Ambulatory Base, EpicCare Inpatient Base, Infection Control Antimicrobial Use and Resistance Reporting
- **Registered URL**: https://open.epic.com/EHITables
- **Developer**: Epic Systems Corporation

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://open.epic.com/EHITables" -H 'User-Agent: Mozilla/5.0'
```

**Result**: Direct `200 OK`. No redirects.
- Content-Type: `text/html; charset=utf-8`
- Content-Length: 8,742 bytes
- Server: Microsoft-IIS/10.0 (ASP.NET MVC 5.2)
- No anti-bot protection, no Cloudflare, no login required.

### Step 2: Page examination

The landing page at `/EHITables` is a static HTML page (8,742 bytes) rendered server-side by ASP.NET MVC. No SPA, no JavaScript required for content rendering.

The page contains:
- A title "EHI Tables Export"
- A description explaining that EHI Export allows health systems to do a manual one-time export of health data for one or more patients in **tab-separated value (TSV)** format
- Two key links:
  1. **"the EHI Tables index"** → `/EHITables/TechSpec` (online browsable schema)
  2. **"download the index as a zip file"** → `/EHITables/Download` (downloadable ZIP)
- A note that some EHI (rich text documents, images) is provided as separate files outside the TSV tables
- Links to FHIR bulk data access and CCD/C-CDA documents as alternatives for standards-based exchange
- Caveats that content varies by health system's software version, configuration, and practices

### Step 3: Probing the two documentation links

#### Link 1: Online Tech Spec Index

```bash
curl -sI -L "https://open.epic.com/EHITables/TechSpec" -H 'User-Agent: Mozilla/5.0'
```

**Result**: `302 Found` → `https://open.epic.com/EHITables/GetTable/_index.htm` → `200 OK`
- Content-Length: 1,077,591 bytes (~1 MB)
- Content-Type: `text/html; charset=utf-8`
- This is the full index page listing all 7,672 EHI tables with A–W alphabetical navigation
- Each table name links to its own HTML detail page via `/EHITables/GetTable/{TABLE_NAME}.htm`

#### Link 2: Downloadable ZIP

```bash
curl -sI -L "https://open.epic.com/EHITables/Download" -H 'User-Agent: Mozilla/5.0'
```

**Result**: Direct `200 OK`
- Content-Type: `application/x-zip-compressed`
- Content-Length: 12,664,966 bytes (12.1 MB)
- Content-Disposition: `attachment; filename="Epic EHI Tables.zip"`
- No redirects, no authentication, no anti-bot — direct download.

### Step 4: Browser verification

Navigated to both pages in browser. The landing page renders cleanly with the two documentation links visible. The TechSpec page shows "EHI Export Schema" with an alphabetical table index (A through W). Both pages work without JavaScript interaction — no accordions, no tabs, no expanding sections needed.

## Downloads

### Epic_EHI_Tables.zip (12,664,966 bytes = 12.1 MB)

```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o Epic_EHI_Tables.zip \
  'https://open.epic.com/EHITables/Download'
```

**Verified**:
- `file Epic_EHI_Tables.zip` → `Zip archive data, at least v2.0 to extract, compression method=deflate`
- Contains 7,674 files (7,673 .htm + 1 .css), 83 MB uncompressed
- All files in a single directory: `DocGen_su117s2p_2026-02-12_14.10.01/`
- Generated 2026-02-12 at 14:10 CT (February 2026 release)

**Extracted to**: `downloads/extracted/DocGen_su117s2p_2026-02-12_14.10.01/`

```bash
unzip -o Epic_EHI_Tables.zip -d extracted/
```

Structure:
- `_index.htm` — Master index listing all 7,672 tables
- `CRStyleSheet.css` — Stylesheet for the HTM files
- 7,672 individual `.htm` files, one per table (e.g., `ACCOUNT.htm`, `PATIENT.htm`, `MYC_CONVO.htm`)
- Total extracted size: 93 MB

### landing-page.html (8,742 bytes)

```bash
curl -sL "https://open.epic.com/EHITables" -H 'User-Agent: Mozilla/5.0' -o landing-page.html
```

The main EHI Tables Export page for reference.

### techspec-index.html (1,077,591 bytes)

```bash
curl -sL "https://open.epic.com/EHITables/TechSpec" -H 'User-Agent: Mozilla/5.0' -o techspec-index.html
```

The online version of the `_index.htm` from the ZIP, served through the Epic web app.

## Obstacles & Notes

- **None.** This is one of the cleanest EHI documentation implementations. No anti-bot, no login, no JavaScript required, no accordions to expand, no multi-page navigation. The registered URL goes directly to a page with clear links to both an online viewer and a downloadable ZIP.
- The ZIP filename includes a build identifier (`DocGen_su117s2p`) and timestamp, suggesting automated generation from Epic's internal documentation system.
- Epic explicitly states the export format is TSV (tab-separated values), making it one of the few vendors that clearly document the actual export file format on the landing page.
- The page distinguishes EHI export from FHIR/CDA alternatives and notes that non-tabular content (documents, images) is exported separately.
