# SCC Soft Computer — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11239, 11240, 11241, 11242, 11243, 11295
- **Products**: SoftLab (also applies to SoftMic, SoftBank, SoftPathDx, SoftGene)
- **Registered URL**: https://www.softcomputer.com/regulatory-affairs/ehi-export/
- **Developer**: SCC Soft Computer

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.softcomputer.com/regulatory-affairs/ehi-export/" -H 'User-Agent: Mozilla/5.0'
```

**Result**: Direct HTTP/2 200 response. No redirects. Content-Type: `text/html; charset=UTF-8`. No content-disposition headers. The URL serves a standard HTML page.

### Step 2: Page examination

```bash
curl -sL "https://www.softcomputer.com/regulatory-affairs/ehi-export/" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
```

**Result**: 81,085 bytes. Standard WordPress page (not a SPA). Content is in the HTML source — no JavaScript rendering needed. The page has a cookie consent popup but all documentation content is visible without interaction.

### Step 3: Finding the EHI documentation links

The page is very simple — a heading "EHI Export" with two columns:

**Left column: "4.0.x release EHI export documentation:"**
- HL7 Result Reporting for EHI Export → `/wp-content/uploads/2024/09/SCC_Standard_EHI_export_rel4.0.pdf`
- XML EHI Export of Patient Billing History → `/wp-content/uploads/2024/09/SCC_EHI_export_Billing_History_rel4.0.pdf`

**Right column: "4.5.x release EHI export documentation:"**
- HL7 Result Reporting for EHI Export → `/wp-content/uploads/2024/09/SCC_Standard_EHI_export_rel4.5.pdf`
- XML EHI Export of Patient Billing History → `/wp-content/uploads/2024/09/SCC_EHI_export_Billing_History_rel4.5.pdf`

Found via:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html
```

All four links are direct PDF downloads hosted on the same domain via WordPress uploads. No accordion, no SPA navigation, no login wall.

### Step 4: Browser verification

Navigated to the URL in browser. Confirmed the page shows exactly what the HTML source contains: a clean page with the SCC header, "EHI Export" heading, two columns of links, and a cookie consent popup. Screenshot captured.

## Downloads

### SCC_Standard_EHI_export_rel4.0.pdf (933 KB, 46 pages)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/SCC_Standard_EHI_export_rel4.0.pdf \
  'https://www.softcomputer.com/wp-content/uploads/2024/09/SCC_Standard_EHI_export_rel4.0.pdf'
```
Verified: `PDF document, version 1.7, 46 page(s)` (954,755 bytes)

### SCC_EHI_export_Billing_History_rel4.0.pdf (853 KB, 14 pages)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/SCC_EHI_export_Billing_History_rel4.0.pdf \
  'https://www.softcomputer.com/wp-content/uploads/2024/09/SCC_EHI_export_Billing_History_rel4.0.pdf'
```
Verified: `PDF document, version 1.5, 14 page(s)` (873,376 bytes)

### SCC_Standard_EHI_export_rel4.5.pdf (1.3 MB, 55 pages)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/SCC_Standard_EHI_export_rel4.5.pdf \
  'https://www.softcomputer.com/wp-content/uploads/2024/09/SCC_Standard_EHI_export_rel4.5.pdf'
```
Verified: `PDF document, version 1.5, 55 page(s)` (1,335,320 bytes)

### SCC_EHI_export_Billing_History_rel4.5.pdf (925 KB, 14 pages)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/SCC_EHI_export_Billing_History_rel4.5.pdf \
  'https://www.softcomputer.com/wp-content/uploads/2024/09/SCC_EHI_export_Billing_History_rel4.5.pdf'
```
Verified: `PDF document, version 1.5, 14 page(s)` (947,107 bytes)

### ehi-export-landing-page.html (79 KB)
Saved copy of the landing page HTML for reference.

## Obstacles & Notes

- **No obstacles.** Page loads cleanly via curl, no anti-bot protection, no JavaScript rendering required, no login wall.
- The PDFs appear to have been exported from Excel spreadsheets (references to `.xlsx` filenames appear as headers/footers throughout).
- The page is a standard WordPress site with a cookie consent popup (Complianz GDPR plugin) that does not block content access.
- The PDFs reference internal URLs for the documents at a `/docs/` subdirectory path (e.g., `https://www.softcomputer.com/regulatory-affairs/ehi-export/docs/SCC_Standard_EHI_export_rel4.5.pdf`) in the ReadMe file included in exports, but the actual download links use the WordPress uploads path.
- SCC Soft Computer is a laboratory information system vendor — their EHI export is specifically for lab data (clinical results, microbiology, blood bank, pathology, genetics) and billing. This is NOT a general-purpose EHR — it's a LIMS.
