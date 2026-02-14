# Nextech — EHI Export Documentation Collection

Collected: February 14, 2026

## Source
- Registered URL: https://www.nextech.com/compliance/ehi-export-documentation
- Developer: Nextech
- Products: Nextech EHR (powered by ICP), Nextech Select/NexCloud, SRS EHR
- CHPL IDs: 11040, 11724

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.nextech.com/compliance/ehi-export-documentation" -H 'User-Agent: Mozilla/5.0'
```
Result: HTTP/2 200 OK, Content-Type: text/html; charset=UTF-8
- No redirects, direct HTML page
- Served via Cloudflare CDN
- HubSpot CMS page (x-hs-content-id: 139729612152)

### Step 2: Page examination
```bash
curl -sL "https://www.nextech.com/compliance/ehi-export-documentation" -H 'User-Agent: Mozilla/5.0' -o page.html
wc -c page.html
```
Result: 92,339 bytes
- Standard HubSpot marketing page with navigation
- Title: "Cures Update §170.315(b)(10) Electronic Health Information Export Documentation"
- Static HTML with direct download links (no JavaScript SPA required)

### Step 3: Finding the EHI documentation
Page structure is clear and well-organized:
- Hero section with title and "Learn More" button
- Main content area lists three product families:
  1. **Nextech | IntelleChartPRO** (formerly ICP)
  2. **Nextech Select/NexCloud**
  3. **Nextech | SRSPro**

Each product section has two download links:
- PDF: Export Documentation (process, format specifications)
- Excel: Data Dictionary (table/field definitions)

### Step 4: Link extraction
```bash
grep -oiE 'href="[^"]*\.(pdf|xlsx?)' page.html
```
Found 6 files total:

**IntelleChartPRO (ICP):**
- Nextech%20EHR%20(powered%20by%20ICP)%20EHI%20Export%20Documentation.pdf
- Nextech%20EHR%20(powered%20by%20ICP)%20EHI%20Data%20Dictionary-1.xlsx

**Nextech Select/NexCloud:**
- Nextech%20Select_NexCloud%20EHI%20Export%20Documentation_2025.pdf
- Nextech%20Select_NexCloud%20EHI%20Export%20Data%20Dictionary_2025.xlsx

**SRSPro:**
- SRSPro%20EHI%20Export%20Documentation_10.30.25_.pdf
- EHI%20Single%20Export%20Data%20Dictionary_10.28.25.xlsx

### Step 5: Browser verification
Navigated to page in browser to capture visual documentation:
- Screenshot 1: Page header with title and product overview
- Screenshot 2: IntelleChartPRO section with download links
- Screenshot 3: SRSPro section with download links

No accordion/collapse behavior - all links visible on page load.
No authentication required - all files publicly accessible.

### Step 6: File downloads
All files downloaded via curl with User-Agent header.
No anti-bot measures encountered.

## Downloads

### Nextech_EHR_ICP_EHI_Export_Documentation.pdf (327 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o "Nextech_EHR_ICP_EHI_Export_Documentation.pdf" \
  'https://www.nextech.com/hubfs/Nextech%20EHR%20(powered%20by%20ICP)%20EHI%20Export%20Documentation.pdf'
```
Verified: PDF document, version 1.7, 6 pages
Saved to: downloads/Nextech_EHR_ICP_EHI_Export_Documentation.pdf
Content: Export process documentation for Nextech EHR (ICP product)

### Nextech_EHR_ICP_EHI_Data_Dictionary.xlsx (40 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o "Nextech_EHR_ICP_EHI_Data_Dictionary.xlsx" \
  'https://www.nextech.com/hubfs/Nextech%20EHR%20(powered%20by%20ICP)%20EHI%20Data%20Dictionary-1.xlsx'
```
Verified: Microsoft Excel 2007+
Saved to: downloads/Nextech_EHR_ICP_EHI_Data_Dictionary.xlsx
Content: Data dictionary for ICP export format

### Nextech_Select_NexCloud_EHI_Export_Documentation.pdf (713 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o "Nextech_Select_NexCloud_EHI_Export_Documentation.pdf" \
  'https://www.nextech.com/hubfs/Nextech%20Select_NexCloud%20EHI%20Export%20Documentation_2025.pdf'
```
Verified: PDF document, version 1.7, 8 pages
Saved to: downloads/Nextech_Select_NexCloud_EHI_Export_Documentation.pdf
Content: Export process documentation for Nextech Select/NexCloud products (2025 edition)

### Nextech_Select_NexCloud_EHI_Data_Dictionary.xlsx (56 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o "Nextech_Select_NexCloud_EHI_Data_Dictionary.xlsx" \
  'https://www.nextech.com/hubfs/Nextech%20Select_NexCloud%20EHI%20Export%20Data%20Dictionary_2025.xlsx'
```
Verified: Microsoft Excel 2007+
Saved to: downloads/Nextech_Select_NexCloud_EHI_Data_Dictionary.xlsx
Content: Data dictionary for Nextech Select/NexCloud export format (2025 edition)

### SRSPro_EHI_Export_Documentation.pdf (442 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o "SRSPro_EHI_Export_Documentation.pdf" \
  'https://www.nextech.com/hubfs/SRSPro%20EHI%20Export%20Documentation_10.30.25_.pdf'
```
Verified: PDF document, version 1.7, 8 pages
Saved to: downloads/SRSPro_EHI_Export_Documentation.pdf
Content: Export process documentation for SRSPro product (dated October 30, 2025)

### EHI_Single_Export_Data_Dictionary.xlsx (131 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o "EHI_Single_Export_Data_Dictionary.xlsx" \
  'https://www.nextech.com/hubfs/EHI%20Single%20Export%20Data%20Dictionary_10.28.25.xlsx'
```
Verified: Microsoft Excel 2007+
Saved to: downloads/EHI_Single_Export_Data_Dictionary.xlsx
Content: Data dictionary for SRSPro single export format (dated October 28, 2025)

## Access Summary
- Final URL (after redirects): https://www.nextech.com/compliance/ehi-export-documentation (no redirects)
- Status: **found** ✓
- Required browser: No (curl sufficient)
- Navigation complexity: **direct_link** (all files linked from main page)
- Anti-bot issues: None
- Authentication: None required (publicly accessible)

## Obstacles & Dead Ends
None encountered. This is an exemplary implementation:
- Clean, dedicated URL for EHI documentation
- All files directly linked from main page (no hidden accordions)
- No JavaScript required for access
- No authentication barriers
- Files served directly from HubSpot CDN (no indirect redirects)
- Clear labeling by product family
- Both documentation and data dictionaries provided for each product
- Current/recent versions (2025 dated files)

## Additional Findings

### Product Coverage
Nextech provides EHI export documentation for three distinct product families:
1. **Nextech EHR (powered by ICP)** - Original IntelleChartPRO product
2. **Nextech Select/NexCloud** - Cloud-based offerings
3. **SRS EHR (SRSPro)** - Surgery-focused EHR

CHPL IDs 11040 and 11724 likely map to these products.

### Documentation Quality
Each product has:
- Export process documentation (PDF) - how to perform the export
- Data dictionary (Excel) - field-level schema documentation

This dual-format approach is user-friendly (PDF for reading, Excel for programmatic use).

### File Naming Convention
Files are descriptively named and include version indicators:
- Product name in filename
- "2025" or dated stamps (10.30.25, 10.28.25) indicating recent updates
- Clear distinction between documentation and data dictionary

### No External Dependencies
Page does not link to external API documentation or require referencing third-party sites.
All documentation is self-contained.
