# Netsmart Technologies — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 10769, 11131, 11409, 11493, 11518, 11575
- **Products**: Carepathways Measures Reporting, TheraOffice, myAvatar Certified Edition, myEvolv Certified Edition, myHealthPointe, myUnity
- **Registered URL**: https://www.ntst.com/lp/certifications

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.ntst.com/lp/certifications" -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```

**Result**: HTTP 200 OK directly (no redirects). Server: Microsoft-IIS/10.0. Content-Type: text/html; charset=utf-8. Content-Length: 189,740 bytes. ASP.NET session cookie set. CSP headers indicate a complex site with Drift chat, Securiti consent, Marketo forms, Wistia video, and GTM analytics.

### Step 2: Page examination

```bash
curl -sL "https://www.ntst.com/lp/certifications" -H 'User-Agent: Mozilla/5.0' -o /tmp/netsmart-page.html
wc -c /tmp/netsmart-page.html
```

**Result**: 189,740 bytes. Page title: "Solution Certifications | Netsmart". Server-rendered HTML with substantial content (not a SPA). The page is a compliance hub listing multiple Netsmart products' certification information: mandatory disclosures, real-world testing plans, and EHI export documentation links.

### Step 3: Finding the EHI section

Searched the HTML for EHI-related links:

```bash
grep -oiE 'href="[^"]*"' /tmp/netsmart-page.html | grep -iE 'ehi|export|data.dictionary|b.10'
```

**Result**: Found 7 EHI export subpages linked from the main certification page:

| Product | URL |
|---------|-----|
| CarePathways | `/lp/certifications/ehi-all-data-carepathways` |
| myAvatar | `/lp/certifications/ehi-all-data-myavatar` |
| myEvolv | `/lp/certifications/ehi-all-data-myevolv` |
| myHealthPointe | `/lp/certifications/ehi-all-data-myhealthpointe` |
| myUnity | `/lp/certifications/ehi-all-data-myunity` |
| GEHRIMED | `/lp/certifications/ehi-all-data-gehrimed` |
| TheraOffice | `/lp/certifications/ehi-all-data-theraoffice` |

The links appeared under a section titled "EHI (Electronic Health Information) All Data Export" on the main certifications page. No accordion or JavaScript interaction needed — they were visible as simple `<a>` tags in the server-rendered HTML.

### Step 4: Examining each product's EHI page

Each product has its own dedicated subpage. All pages follow the same template:

1. Standard boilerplate about ONC certification
2. Product-specific EHI export description
3. A "CLICK HERE" link to download the documentation (PDF or ZIP)
4. Caveats about variation based on configuration, software version, etc.

The download links found on each page:

| Product | Download URL | Type |
|---------|-------------|------|
| CarePathways | `/-/media/pdfs/certifications/ehi-export-all-tables-2024-carepathways-measures-reporting.pdf` | PDF |
| myAvatar | `-/media/pdfs/certifications/EHI_Export_All_Tables_myAvatar_September_2023.zip` | ZIP |
| myEvolv | `/-/media/pdfs/certifications/myevolv-all-ehi-export-documentation_v2.zip` | ZIP |
| myHealthPointe | `/-/media/pdfs/certifications/myhealthpointe-ehi-export.pdf` | PDF |
| myUnity | `/-/media/pdfs/certifications/ehi_export_all_files_myunity_fall_2024.pdf` | PDF |
| TheraOffice | `/-/media/pdfs/certifications/ehi_export_all_tables_theraoffice_2024.zip` | ZIP |

**Note on myHealthPointe**: The page states: "myHealthPointe will be using relied upon software to fulfill the (b)(10) EHI Export functionality. Clients utilizing a Netsmart certified solution should refer to the affiliated EHI Export page." This means myHealthPointe is a patient portal that delegates its EHI export to the underlying EHR (myAvatar or myEvolv). Its own documentation only covers Subject Messages export.

### Step 5: Key observations from page text

**Export format descriptions per product:**
- **CarePathways, myAvatar, myEvolv, TheraOffice**: "computable, delimited file format native to [product]" — native database table exports
- **myUnity**: "computable, JSON file format native to myUnity" — JSON-based export
- **myHealthPointe**: Report-based export (PDF or Excel) via Reports applet for messages only

**GEHRIMED** was also listed on the main page but is not in our CHPL IDs list, so it was noted but not downloaded.

## Downloads

### carepathways-ehi-export-tables-2024.pdf (1,834,284 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o carepathways-ehi-export-tables-2024.pdf \
  'https://www.ntst.com/-/media/pdfs/certifications/ehi-export-all-tables-2024-carepathways-measures-reporting.pdf'
```
Verified: `file` → PDF document, version 1.7, 97 pages  
Author: Klein, Jennifer  
Created: 2024-09-26  
Content: 95 unique data warehouse tables (dim_* and fact_* tables) with field-level documentation

### myavatar-ehi-export-tables-2023.zip (12,504,838 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o myavatar-ehi-export-tables-2023.zip \
  'https://www.ntst.com/-/media/pdfs/certifications/EHI_Export_All_Tables_myAvatar_September_2023.zip'
```
Verified: `file` → Zip archive data  
Contents: 1 file — "EHI Export All Tables - September 2023.pdf" (7,492 pages!)  
Content: 445 unique database tables with field-level documentation for forms and tables

### myevolv-ehi-export-documentation-v2.zip (11,082,302 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o myevolv-ehi-export-documentation-v2.zip \
  'https://www.ntst.com/-/media/pdfs/certifications/myevolv-all-ehi-export-documentation_v2.zip'
```
Verified: `file` → Zip archive data  
Contents: 3 files:
- `(1) myEvolv All EHI Export Companion Guide.docx` — explains JSON export format
- `(2) myEvolv All EHI Export Data Dictionary Crosswalk.xlsx` — 5 sheets: Info, Events (1,679 rows), Events+Columns (115,663 rows), Non-Events (250 rows), Non-Events+Columns (21,006 rows)
- `(3) myEvolv ALL EHI Export Queries.sql` — SQL queries for schema discovery

### myhealthpointe-ehi-export.pdf (56,892 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o myhealthpointe-ehi-export.pdf \
  'https://www.ntst.com/-/media/pdfs/certifications/myhealthpointe-ehi-export.pdf'
```
Verified: `file` → PDF document, version 1.7, 3 pages  
Author: Wood, Rebecca  
Created: 2023-11-28  
Content: Instructions for exporting Subject Messages via the Reports applet (8 fields)

### myunity-ehi-export-fall-2024.pdf (467,428 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o myunity-ehi-export-fall-2024.pdf \
  'https://www.ntst.com/-/media/pdfs/certifications/ehi_export_all_files_myunity_fall_2024.pdf'
```
Verified: `file` → PDF document, version 1.7, 64 pages  
Created: 2024-08-26  
Content: 24 export file types documented with field-level detail

### theraoffice-ehi-export-tables-2024.zip (406,527 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o theraoffice-ehi-export-tables-2024.zip \
  'https://www.ntst.com/-/media/pdfs/certifications/ehi_export_all_tables_theraoffice_2024.zip'
```
Verified: `file` → Zip archive data  
Contents: "EHI Export All Tables - May 2024 (TheraOffice).pdf" (30 pages) + __MACOSX artifact  
Content: 19 tables (PAT_PROFILE variants + PTCASE) with column-level detail

## Product Context

Netsmart Technologies is a major health IT vendor serving **behavioral health, human services, and post-acute care** markets. Their products operate under the **CareFabric® platform**. Key products:

- **myAvatar**: Flagship behavioral health EHR for inpatient/outpatient behavioral health, addiction treatment, IDD, foster care, CCBHCs. Full billing (837P/I/D, 835 remittance, NCPDP pharmacy), scheduling, clinical documentation, treatment plans.
- **myEvolv**: Mid-market behavioral health EHR for child & family services, IDD, autism, foster care. Configurable forms, auto-claims from notes, eMAR, e-prescribing.
- **myUnity**: Post-acute care EHR for home health, hospice, senior living, skilled nursing. Unified record, billing (commercial/Medicare/Medicaid), scheduling, HIE integration.
- **CarePathways Measures Reporting**: Data warehouse/reporting product that aggregates data from Netsmart EHRs for quality measures and population health.
- **TheraOffice**: Physical/occupational/speech therapy EMR and practice management with integrated billing, scheduling, patient portal.
- **myHealthPointe**: Cross-product patient/consumer engagement portal with secure messaging, appointment requests, lab results viewing, telehealth.

Additional cross-product capabilities include **CareConnect Inbox** (secure messaging), **RevConnect** (claims management/clearinghouse), and dedicated RCM services.

## Obstacles & Notes

1. **No anti-bot protection**: All pages and downloads accessible via simple curl with standard User-Agent.
2. **Clean navigation**: Direct links from main certifications page to product-specific EHI pages, then to download files. No accordion, SPA, or JavaScript required.
3. **Multiple products = multiple documentation sets**: Unlike vendors with a single product, Netsmart has 6+ certified products, each with its own EHI export documentation. This requires per-product analysis.
4. **myAvatar PDF is massive**: 7,492 pages documenting 445 tables — comprehensive but unwieldy.
5. **Documentation dates vary**: CarePathways (Sep 2024), myAvatar (Sep 2023), myEvolv (v2, undated), myHealthPointe (Nov 2023), myUnity (Aug 2024), TheraOffice (May 2024).
6. **GEHRIMED**: A 7th product (geriatric EHR) was also listed with EHI docs but was not in our target CHPL IDs.
