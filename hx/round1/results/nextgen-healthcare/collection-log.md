# NextGen Healthcare — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 9372, 10673, 10861, 11451, 11612, 11645, 11758
- **Products**: Mirth Connect, NextGen Direct Messaging, NextGen Enterprise EHR, NextGen Office
- **Registered URL**: https://www.nextgen.com/sldkjljieo0935jljsrnfkl

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.nextgen.com/sldkjljieo0935jljsrnfkl" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP/2 200 direct (no redirects). Content-Type: text/html; charset=utf-8. Content-Length: 175,648 bytes. The page is served with `no-cache, no-store` headers. No content-disposition header — it's an HTML page, not a file download.

Notable: The URL uses an obfuscated path (`sldkjljieo0935jljsrnfkl`) and the page has `<meta name="robots" content="noindex, nofollow">` and `x-robots-tag: noindex, nofollow` — NextGen intentionally makes this page unfindable by search engines.

The canonical URL is `https://www.nextgen.com/legal/sldkjljieo0935jljsrnfkl` (under `/legal/`).

### Step 2: Page examination

```bash
curl -sL "https://www.nextgen.com/sldkjljieo0935jljsrnfkl" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html  # 175648 bytes
```

The page is a Sitecore CMS-rendered HTML page (cookies: `shell#lang=en`, `sxa_site=NextGen`). It contains real HTML content — no SPA/JavaScript rendering needed. The full text is visible via curl.

Page title: **"ELECTRONIC HEALTH INFORMATION DATA DICTIONARY HYPERLINKS"**

Page heading visible on the rendered page: **"EHI Data Export"**

The page structure is straightforward:
1. Intro paragraph about EHI and patient access
2. "Key Information About the Exported Data" — bullet list about machine-readable format, data dictionaries, images/documents in file folders, and alternate format options
3. **"Database Dictionaries"** section with subsections for each product:
   - **NextGen® Enterprise EHR** — paragraph describing the export, with a "Database dictionary" link to a PDF
   - **NextGen® Office** — describes ZIP archive with CCDA XML, CSV, binary files, and HTML files (no separate data dictionary download)
   - **NextGen® Direct Messaging** — describes ZIP archive with CDA XML and binary files (no separate data dictionary download)
   - **Mirth Connect** — describes XML message export with base64 attachments (no separate data dictionary download)
4. Legal notice (copyright 2023 NXGN Management, LLC)

### Step 3: Finding the EHI documentation

The documentation link was found directly on the landing page. No accordion, no tabs, no SPA navigation required.

```bash
grep -oiE 'href="[^"]*"' /tmp/page.html | grep -iE 'ehi|export|data.dictionary|b.10|dictionary'
```

Result:
```
href="/-/media/files/legal/2025/DD_Complete_EHI_20250627"
```

This is the only downloadable documentation artifact. The other three products (NextGen Office, Direct Messaging, Mirth Connect) describe their export formats in prose on the page itself but provide no downloadable data dictionaries.

### Step 4: Probing the download link

```bash
curl -sI -L "https://www.nextgen.com/-/media/files/legal/2025/DD_Complete_EHI_20250627" -H 'User-Agent: Mozilla/5.0'
```

Result:
- HTTP/2 200
- Content-Type: application/pdf
- Content-Length: 29,204,519 (27.8 MB)
- Content-Disposition: `inline; filename="DD_Complete_EHI_20250627.pdf"`
- Last-Modified: Tue, 01 Jul 2025 15:34:37 GMT
- x-robots-tag: noindex, nofollow
- ETag: b99d596e2cc4478499d5d1b8a117f629

A 27.8 MB PDF file. The filename indicates it's the complete EHI data dictionary dated June 27, 2025.

## Downloads

### DD_Complete_EHI_20250627.pdf (27.8 MB)

```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/DD_Complete_EHI_20250627.pdf \
  'https://www.nextgen.com/-/media/files/legal/2025/DD_Complete_EHI_20250627'
```

Verified:
```
$ file downloads/DD_Complete_EHI_20250627.pdf
downloads/DD_Complete_EHI_20250627.pdf: PDF document, version 1.7 (zip deflate encoded)

$ ls -la downloads/DD_Complete_EHI_20250627.pdf
-rw-r--r-- 1 exedev exedev 29204519 Feb 13 17:48 downloads/DD_Complete_EHI_20250627.pdf

$ pdfinfo downloads/DD_Complete_EHI_20250627.pdf
Title:           (empty)
Author:          NextGen Healthcare
Creator:         Adobe Acrobat (64-bit) 25.1.20531
Producer:        Adobe Acrobat (64-bit) 25.1.20531
CreationDate:    Fri Jun 27 05:11:05 2025 UTC
ModDate:         Fri Jun 27 05:18:20 2025 UTC
Pages:           10875
Page size:       612 x 792 pts (letter)
File size:       29204519 bytes
PDF version:     1.7
```

Saved to: `downloads/DD_Complete_EHI_20250627.pdf`

### landing-page.html (175 KB)

```bash
curl -sL "https://www.nextgen.com/sldkjljieo0935jljsrnfkl" -H 'User-Agent: Mozilla/5.0' -o downloads/landing-page.html
```

Saved to: `downloads/landing-page.html`

### all_table_names.txt (derived)

Extracted all 5,290 unique table names from the PDF text. Saved to: `downloads/all_table_names.txt`

## Obstacles & Notes

1. **Obfuscated URL**: The path `sldkjljieo0935jljsrnfkl` is deliberately non-descriptive. Combined with `noindex, nofollow`, this page is effectively invisible to search engines.

2. **No anti-bot protection**: Standard curl with a User-Agent header works fine. No Cloudflare, no CAPTCHA, no cookie requirements.

3. **Only one product has a data dictionary download**: NextGen Enterprise EHR has the 10,875-page PDF. The other three products (NextGen Office, Direct Messaging, Mirth Connect) describe their export format in a few sentences of prose on the landing page — no downloadable schema documentation.

4. **No field descriptions**: The PDF contains table name, column name, data type, default value, and not-null constraints — but no column descriptions, definitions, or value set enumerations. It's a raw SQL Server schema dump.

5. **Massive scale**: 10,875 pages, 5,290 tables, ~281,893 columns. This reflects a real database export (not a curated subset) — the tables clearly come from specialty clinical modules (ophthalmology, cardiology, orthopedics, OB/GYN, behavioral health, etc.).
