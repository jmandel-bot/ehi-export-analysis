# NextGen Healthcare — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 9372, 10673, 10861, 11451, 11612, 11645, 11758
- Products: Mirth Connect, NextGen Direct Messaging, NextGen Enterprise EHR, NextGen Office
- Registered URL: https://www.nextgen.com/sldkjljieo0935jljsrnfkl

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.nextgen.com/sldkjljieo0935jljsrnfkl" -H 'User-Agent: Mozilla/5.0'
```

Result: HTTP/2 200 directly (no redirects). Content-Type: text/html; charset=utf-8. Content-Length: 175,648 bytes. Notable headers: `cache-control: no-cache, no-store`. No `x-robots-tag` on the HTML page itself. The URL uses an obfuscated path (`sldkjljieo0935jljsrnfkl`) — intentionally hard to guess, not discoverable by browsing the site.

### Step 2: Page examination

Fetched the full HTML:
```bash
curl -sL "https://www.nextgen.com/sldkjljieo0935jljsrnfkl" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
```

Page size: 175,648 bytes. This is a full server-rendered HTML page (Sitecore CMS), not a SPA. The page has real content visible via curl without JavaScript. The `<title>` is "ELECTRONIC HEALTH INFORMATION DATA DICTIONARY HYPERLINKS". The main heading rendered in the browser is "EHI Data Export".

### Step 3: Finding the EHI section

The page IS the EHI documentation hub — no navigation required. It is a single-purpose page covering all four certified products. The content structure is:

1. **Introductory paragraph** — states the page covers database dictionaries for all certified products
2. **"Key Information About the Exported Data"** — bullet list explaining data format
3. **"Database Dictionaries"** section with four subsections:
   - **NextGen® Enterprise EHR** — link to a PDF data dictionary
   - **NextGen® Office** — describes export format (ZIP with CCDA/CSV/binary/HTML), no downloadable dictionary
   - **NextGen® Direct Messaging** — describes export format (ZIP with CDA/binary), no downloadable dictionary
   - **Mirth Connect** — describes XML message export, no downloadable dictionary
4. **Legal notice** (copyright 2023 NXGN Management, LLC)

### Step 4: Identified downloadable assets

Only one EHI-related download link found on the page:

- `/-/media/files/legal/2025/DD_Complete_EHI_20250627` — the NextGen Enterprise EHR database dictionary

Also found on the page (not EHI-related, in the site header/footer):
- Corporate brochure PDF
- NextGen Data Platform brochure PDF

### Step 5: Probed the data dictionary file

```bash
curl -sI -L "https://www.nextgen.com/-/media/files/legal/2025/DD_Complete_EHI_20250627" -H 'User-Agent: Mozilla/5.0'
```

Result: HTTP/2 200. Content-Type: application/pdf. Content-Length: 29,204,519 bytes (~29 MB). Content-Disposition: `inline; filename="DD_Complete_EHI_20250627.pdf"`. Last-Modified: Tue, 01 Jul 2025 15:34:37 GMT. **`x-robots-tag: noindex, nofollow`** — the PDF itself is marked to prevent search engine indexing.

### Step 6: Checked alternate URL path

The HTML page contains a self-referencing link at `href="/legal/sldkjljieo0935jljsrnfkl"` (under the /legal/ path). Probing this:
```bash
curl -sI -L "https://www.nextgen.com/legal/sldkjljieo0935jljsrnfkl" -H 'User-Agent: Mozilla/5.0'
```
Result: HTTP/2 200, same content-length (175,648). This is an alternate path to the same page.

## Downloads

### DD_Complete_EHI_20250627.pdf (27.8 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/DD_Complete_EHI_20250627.pdf \
  'https://www.nextgen.com/-/media/files/legal/2025/DD_Complete_EHI_20250627'
```
Verified: `file DD_Complete_EHI_20250627.pdf` → PDF document, version 1.7 (zip deflate encoded)
Pages: 10,875 (from pdfinfo)
Author: NextGen Healthcare
Creator: Adobe Acrobat (64-bit) 25.1.20531
Creation Date: Fri Jun 27 05:11:05 2025 UTC
Modified Date: Fri Jun 27 05:18:20 2025 UTC
Title: (blank)
Saved to: downloads/DD_Complete_EHI_20250627.pdf

### ehi-landing-page.html (172 KB)
```bash
curl -sL "https://www.nextgen.com/sldkjljieo0935jljsrnfkl" -H 'User-Agent: Mozilla/5.0' -o downloads/ehi-landing-page.html
```
Verified: HTML document
Saved to: downloads/ehi-landing-page.html

## Product Context

NextGen Healthcare (NASDAQ: NXGN) is a major ambulatory EHR and practice management vendor. Their product suite includes:

- **NextGen Enterprise EHR** — full electronic health record system for ambulatory practices, with 40+ clinical specialty templates (cardiology, behavioral health, OB/GYN, orthopedics, ophthalmology, pediatrics, etc.)
- **NextGen Practice Management (PM)** — award-winning billing, scheduling, registration, claims processing, and revenue cycle management
- **Patient Experience / Portal** — patient portal with secure text messaging, online scheduling, payments, results viewing, patient education
- **NextGen Office** — cloud-based EHR/PM for smaller practices
- **NextGen Direct Messaging** — Direct protocol messaging for HIE
- **Mirth Connect** — interoperability integration engine
- **Revenue Cycle Management (RCM)** — clearinghouse, claims processing, denial management

The homepage describes the product as "Intelligent EHR, PM, Patient Experience, and RCMS." The patient experience page explicitly mentions "Secure text messaging" and "Patient portal (payments, education, results, etc.)" — with a customer quote describing patients "sending us lots of messages, so that they don't have to call us on the phone."

The certified module is "NextGen Enterprise EHR" but the broader product includes Practice Management, Patient Portal with messaging, Revenue Cycle Management, and scheduling — all of which store patient data that constitutes EHI.

## Obstacles & Notes

1. **Obfuscated URL** — The path `sldkjljieo0935jljsrnfkl` is an opaque random string. It is not discoverable from the NextGen website navigation. There is no link to this page from the main site navigation, solutions pages, or footer.

2. **x-robots-tag: noindex, nofollow** on the PDF — The data dictionary PDF is explicitly marked to prevent search engine indexing. Combined with the obfuscated URL, this means the documentation is effectively hidden from anyone who doesn't already have the URL.

3. **Only one downloadable data dictionary** — Despite covering four certified products, only the NextGen Enterprise EHR has a downloadable data dictionary (the 10,875-page PDF). The other three products (NextGen Office, Direct Messaging, Mirth Connect) have only brief prose descriptions of their export format with no detailed schema documentation.

4. **Massive PDF, no structured alternative** — The 29 MB PDF with 10,875 pages is difficult to work with programmatically. No HTML, CSV, JSON, or other machine-readable format of the data dictionary is provided. Extracting table/column information requires parsing the PDF.

5. **Copyright year discrepancy** — The legal notice on the page says "© 2023 NXGN Management, LLC" but the PDF was created June 27, 2025. The page copyright hasn't been updated.
