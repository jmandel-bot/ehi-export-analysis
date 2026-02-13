# Bizmatics Inc. (PrognoCIS) — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 8856, 11738
- **Products**: PrognoCIS
- **Developer**: Bizmatics Inc.
- **Registered URL**: https://prognocis.com/macra/#ehiexport

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://prognocis.com/macra/#ehiexport" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP/2 200 directly. No redirects. Content-Type: `text/html; charset=UTF-8`. Server: nginx. The page includes HSTS and various security headers. No content-disposition (not a direct download).

### Step 2: Page examination

```bash
curl -sL "https://prognocis.com/macra/#ehiexport" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html
```

**Result**: 419,611 bytes. The page is a WordPress site with RocketLazyLoadScripts (JS lazy-loader), but the substantive HTML content is present in the source — not a SPA. The page title is "ONC Healthcare IT Certified EHR for Your Medical Practice" and is a compliance/marketing page covering multiple ONC certification criteria.

### Step 3: Finding the EHI section

The `#ehiexport` fragment anchor in the registered URL does NOT correspond to an actual element ID in the page. The browser does not auto-scroll to an EHI section. However, scrolling down the page reveals a section headed "PrognoCIS - Compliant with ONC Certifications for Healthcare IT" which contains the EHI export content.

The relevant text reads:
> "PrognoCIS Electronic Health Information Export functionality is ONC 2015 Edition Cures Update Certified, which allows users to export the health data for Single Patient or Patient Populations."

Directly below this is a link labeled "ONC Certifications for Healthcare IT" with the description "Criteria '§170.315(b)(10) Electronic Health Information export PrognoCIS Support'".

### Step 4: Identified downloadable assets

Searching the page source:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html | grep -iE 'ehi|b-10'
```

**Result**: One PDF link found:
- `https://prognocis.com/wp-content/uploads/2023/12/b-10-EHI-Export_PrognoCIS-Support.pdf`

This is the sole EHI export documentation artifact. No ZIP, no data dictionary spreadsheet, no additional files. The documentation is entirely contained in this single 26-page PDF.

### Step 5: No additional navigation needed

The documentation is a single-hop from the landing page. No accordion expansion, no login, no additional clicks required. The link is directly visible in the page source and rendered on the page.

## Downloads

### b-10-EHI-Export_PrognoCIS-Support.pdf (662 KB)

```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/b-10-EHI-Export_PrognoCIS-Support.pdf \
  'https://prognocis.com/wp-content/uploads/2023/12/b-10-EHI-Export_PrognoCIS-Support.pdf'
```

**Verified**:
- File size: 678,081 bytes (662 KB)
- `file` output: `PDF document, version 1.7, 26 page(s)`
- Saved to: `downloads/b-10-EHI-Export_PrognoCIS-Support.pdf`

### macra-page.html (410 KB)

Landing page saved for reference:
```bash
curl -sL "https://prognocis.com/macra/#ehiexport" -H 'User-Agent: Mozilla/5.0' -o downloads/macra-page.html
```

## Obstacles & Notes

- **No obstacles encountered.** The page loads fine with curl, no anti-bot protection, no login wall.
- The `#ehiexport` anchor in the registered URL does not resolve to an actual HTML element ID — the page has no element with `id="ehiexport"`. The EHI content is simply part of the page body.
- The page uses WordPress with WP Rocket's lazy-loading script framework, but the actual content (including the PDF link) is present in the HTML source and does not require JavaScript execution to access.
- The PDF is dated from December 2023 (based on the uploads path `2023/12/`). Version labeled "Denali 3.1".
- Patient population export requires contacting Bizmatics support (support@bizmaticsinc.com) — it is NOT self-service. Only single-patient export is self-service via the CuresEHIExport user role.
