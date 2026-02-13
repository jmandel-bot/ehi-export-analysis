# Dynamic Health IT, Inc — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11584, 11662, 11733
- **Products**: CQMsolution, ConnectEHR SMART 2.0
- **Developer**: Dynamic Health IT, Inc
- **Registered URL**: https://www.dynamichealthit.com/connectehr-ehi

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.dynamichealthit.com/connectehr-ehi" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP redirect chain:
1. `301` — `/connectehr-ehi` → `/ehi-export` (WordPress "Redirection" plugin, `x-redirect-by: redirection`)
2. `301` — `www.dynamichealthit.com/ehi-export` → `https://dynamichealthit.com/ehi-export/` (WordPress canonical redirect, `x-redirect-by: WordPress`)
3. `200` — Final URL: `https://dynamichealthit.com/ehi-export/`

- Content-Type: `text/html; charset=UTF-8`
- Server: Cloudflare + WP Engine (WordPress)
- No content-disposition (not a direct download)

### Step 2: Page examination

```bash
curl -sL "https://www.dynamichealthit.com/connectehr-ehi" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html  # 152,656 bytes
```

The page is a standard WordPress page with real HTML content (not a SPA). Most of the file size is CSS/JS boilerplate from the Kadence/Blocksy theme, Stackable blocks plugin, and various WordPress assets. The actual documentation content is rendered server-side in the HTML.

### Step 3: Finding the EHI section

The registered URL redirects directly to the dedicated EHI Export page. No hunting required — the URL is purpose-built for this content.

The page has three **tabbed sections** (Stackable block tabs, `stk-block-tabs__tab`):
1. **Overview** — General information about FHIR DocumentReference and ePHI scope
2. **ConnectEHR EHI Export** — Step-by-step instructions for exporting patient data as C-CDA 2.1 XML
3. **CQMsolution EHI Export** — Instructions for exporting QRDA I XML files containing patient-level data

Tabs require JavaScript to switch (Stackable block tabs plugin). Content for all tabs is present in the HTML source.

The CQMsolution tab also contains three expandable `<details>` elements:
1. "Is the program available in the CQMsolution license?"
2. "Is the program assigned to the user?"
3. "What type of report is being run?"

### Step 4: Searching for downloadable assets

```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html
```

**Result**: No downloadable documents (PDF, ZIP, etc.) found on the EHI Export page. The documentation is entirely inline HTML content with embedded screenshots.

I also checked the related pages:
- **Disclosures page** (`/disclosures/`) — Has product disclosure PDFs and ONC certificates, but these are certification disclosures, not EHI export data dictionaries.
- **Real World Testing page** (`/real-world-testing/`) — Has RWT plan/results PDFs, not EHI export documentation.

### Step 5: Browser verification

Navigated to `https://dynamichealthit.com/ehi-export/` in browser to confirm:
- Page renders correctly with three tabs
- Overview tab is shown by default
- Clicked "ConnectEHR EHI Export" tab → Shows 7-step process with annotated screenshots showing the ConnectEHR UI
- Clicked "CQMsolution EHI Export" tab → Shows QRDA I/III export process with expandable details and a screenshot of the download dropdown
- No additional hidden content, download buttons, or links revealed by browser rendering

### Step 6: Content summary

**ConnectEHR EHI Export** (Tab 2):
- Export format: HL7 C-CDA 2.1 Standard XML
- Process: Administration > Data Export > Data Export
- Can export individual patients or entire practice
- Requires ConnectEHR Agent running and `AgentRun_Batch` set to True in `tblConfiguration`
- 7 numbered steps with screenshots showing the UI
- Output is batch-downloadable from Data Export Status screen

**CQMsolution EHI Export** (Tab 3):
- Export format: QRDA I XML (patient-level quality measure data)
- "The QRDA I output XML contains all EHI stored in CQMsolution for each patient"
- Any QRDA I program output satisfies 170.315(b)(10)
- Includes HQR and Joint Commission output formats
- Output types depend on license (HQR PI, HQR IQR, MIPS, AOA MORE, PCF, CCBHC)
- QRDA I files are zipped and downloaded to the CQMsolution server
- Download from the Detail screen after queueing a report

**Overview** (Tab 1):
- Discusses FHIR R4 DocumentReference as a container for ePHI data outside USCDI scope
- Lists supported document types: CDA, FHIR documents, PDFs, scanned paper, faxes, clinical notes, images, non-standard formats, prescriptions, immunizations
- Currently supports CCD in DocumentReference; planning to expand to other mime types

## Downloads

### ehi-export-page.html (152,656 bytes)
```bash
curl -sL "https://dynamichealthit.com/ehi-export/" -H 'User-Agent: Mozilla/5.0' -o downloads/ehi-export-page.html
```
Verified: HTML document, ASCII text
Saved to: `downloads/ehi-export-page.html`

### ehi_graphic.jpg (206,630 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o downloads/ehi_graphic.jpg "https://dynamichealthit.com/wp-content/uploads/2024/01/ehi_graphic.jpg"
```
Verified: JPEG image data, 1542×718
Saved to: `downloads/ehi_graphic.jpg`

### Dataexport.png (55,256 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o downloads/Dataexport.png "https://dynamichealthit.com/wp-content/uploads/2023/08/Dataexport.png"
```
Verified: PNG image data, 883×316
Saved to: `downloads/Dataexport.png`

### ConnectEHR-data-Export.png (56,438 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o downloads/ConnectEHR-data-Export.png "https://dynamichealthit.com/wp-content/uploads/2023/08/ConnectEHR-data-Export.png"
```
Verified: PNG image data, 939×637
Saved to: `downloads/ConnectEHR-data-Export.png`

### Data-Queued-Export-edited.jpg (13,947 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o downloads/Data-Queued-Export-edited.jpg "https://dynamichealthit.com/wp-content/uploads/2023/08/Data-Queued-Export-edited.jpg"
```
Verified: JPEG image data
Saved to: `downloads/Data-Queued-Export-edited.jpg`

### Download-export.jpg (5,521 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o downloads/Download-export.jpg "https://dynamichealthit.com/wp-content/uploads/2023/08/Download-export.jpg"
```
Verified: JPEG image data
Saved to: `downloads/Download-export.jpg`

### ehi.webp (91,208 bytes)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o downloads/ehi.webp "https://dynamichealthit.com/wp-content/uploads/2023/11/ehi.webp"
```
Verified: RIFF Web/P image
Saved to: `downloads/ehi.webp`

## Obstacles & Notes

- **No obstacles**: Page is publicly accessible, no anti-bot protection beyond Cloudflare (which doesn't block with User-Agent header), no login required.
- **URL redirect**: The registered CHPL URL (`/connectehr-ehi`) redirects via WordPress Redirection plugin to `/ehi-export/`. Both paths work.
- **No downloadable data dictionary**: Unlike many vendors, Dynamic Health IT provides no PDF, spreadsheet, or ZIP with a data dictionary or schema definition. The documentation is entirely inline HTML with screenshots.
- **Tabbed interface requires JS**: The three content tabs use the Stackable Gutenberg Blocks plugin. However, all tab content is present in the HTML source — only the visibility toggling requires JavaScript.
- **Chat widget**: A customer support chat widget (CleanTalk) appears but does not obstruct content.
- **Limited export format documentation**: For ConnectEHR, the export is described only as "C-CDA 2.1 XML" with UI steps to generate it. No data dictionary, field listing, or schema is provided. For CQMsolution, the export is "QRDA I XML" — a standard format, but no details about what specific data elements are included beyond "all EHI stored in CQMsolution for each patient."
- **FHIR DocumentReference overlap**: The Overview tab discusses using FHIR DocumentReference as a container for non-USCDI data, blurring the line between API-based access and file-based EHI export. The actual b(10) export functionality is in the ConnectEHR and CQMsolution tabs.
