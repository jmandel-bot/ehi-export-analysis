# GEMMS / MedInformatix — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11587, 11588, 11601, 11602
- **Developers**: GEMMS, MedInformatix
- **Products**: GEMMS ONE, MedInformatix EHR
- **Registered URL**: https://www.medinformatix.com/ONC/EHIExport.html

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.medinformatix.com/ONC/EHIExport.html" -H 'User-Agent: Mozilla/5.0'
```

**Result**: Direct 200 OK. No redirects.
- Content-Type: text/html
- Content-Length: 244,777 bytes (~239 KB)
- Server: AmazonS3 via CloudFront CDN
- Last-Modified: Thu, 12 Feb 2026 04:10:28 GMT
- No anti-bot protection detected, no special headers needed.

### Step 2: Page examination

```bash
curl -sL "https://www.medinformatix.com/ONC/EHIExport.html" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html
```

**Result**: 244,777 bytes. This is a large static HTML page — the **entire EHI export documentation is on this single page**. No SPA, no JavaScript-driven content loading. The page uses `MI-common.js` for header/footer injection and has an anti-clickjacking frame-buster script, but all documentation content is in the HTML source.

The page has CSS from `../css/MICss.css` and uses a checkbox-based accordion pattern (pure CSS, no JavaScript needed to expand sections).

### Step 3: Page structure and content

The page is organized into three major sections:

1. **EHI Export Background** — regulatory context, definition of EHI, documentation overview
2. **Export Formats** — three-column layout with icons:
   - Clinical Data – C-CDA R2.1
   - Discrete Data – Comma separated values (CSV)
   - Document Repository – PDF and other file types
3. **Detailed documentation for each format:**
   - C-CDA R2.1 section: lists USCDI V1 data classes, links to C-CDA R2.1 Companion Guide, C-CDA R2.1 Sample, and USCDI V1 spec
   - CSV section: 27 data tables with expandable accordion panels, each containing field-level descriptions and example records
   - Document Repository section: brief description of exported documents (PDF, BMP, JPG, TIF, GIF, DOC, XLS, MPG, AVI, etc.)

### Step 4: Searching for downloadable files

```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html
```

**Result**: Only external reference links found:
- `https://www.healthit.gov/sites/default/files/page2/2021-12/Understanding_EHI.pdf` (ONC fact sheet, not vendor doc)
- `https://www.healthit.gov/isa/sites/isa/files/2020-03/USCDI-Version1-2020-Final-Standard.pdf` (USCDI spec)

**No downloadable PDF, ZIP, or other file from MedInformatix.** The documentation IS the HTML page itself.

### Step 5: Accordion content verification

The 27 CSV table descriptions are in accordion panels using `<input type="checkbox">` / `<label class="accordion-label">` pattern. All content is present in the HTML source — no lazy loading, no AJAX calls needed. `grep` finds all field descriptions in the raw HTML.

Accordion labels found:
1. List of Exported Tables (summary table)
2. APPOINTMENTS.CSV – Patient Appointments
3. BALANCE.CSV - Patient Balances
4. CLACTIVITYLOG.CSV – Account Activity
5. CLALLRGY.CSV – Patient Allergies
6. CLAUTHRZ.CSV - Patient Authorizations
7. CLCLAIM.CSV - Patient Claims
8. CLCNOTES.CSV - Patient Collection Notes
9. CLDISPENSE.CSV - Patient Vaccines
10. CLDOCTOR.CSV - Patient Doctors
11. CLFAMILY.CSV - Family History
12. CLINBOXLOG.CSV - Patient Inbox Import Log
13. CLLAB.CSV - Patient Labs
14. CLMAIL.CSV - Patient Messages
15. CLMASTER.CSV - Patient Demographics
16. CLORDER.CSV - Patient Orders
17. CLPCP.CSV - Patient Providers
18. CLPHARMACY.CSV - Patient Pharmacies
19. CLPNOTES.CSV - Patient Clinical Notes
20. CLPROBLM.CSV - Patient Diagnosis
21. CLPROBLMHIST.CSV - Patient Diagnosis History
22. CLRXHIST.CSV - Patient Medication History
23. CLVITAL.CSV - Patient Vital Sign History
24. CLVNOTES.CSV - Patient Account Notes
25. GUARANTOR.CSV - Patient Guarantor
26. PAYMENTS.CSV - Patient Payments
27. Statements.CSV - Patient Statements
28. zQualityPayCharge.CSV - Patient QPP MIPS Codes

### Step 6: Browser rendering verification

Navigated to the URL in a browser. Page renders correctly:
- Dark blue/teal themed page with MedInformatix branding
- Nav bar: Solutions, Customers, Company, MICentral, Contact
- Three export format icons in the middle section
- Accordion panels expand on click to show field definitions and example records
- "Back to top" floating button visible
- No login wall, no gating, fully public.

## Downloads

### EHIExport.html (244,777 bytes)
```bash
curl -sL "https://www.medinformatix.com/ONC/EHIExport.html" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/EHIExport.html
```
Verified: `file` reports "HTML document, Unicode text, UTF-8 text"
Saved to: `downloads/EHIExport.html`

### MICss.css (63,783 bytes)
```bash
curl -sL "https://www.medinformatix.com/css/MICss.css" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/MICss.css
```
Verified: `file` reports "Unicode text, UTF-8 text"
Saved to: `downloads/MICss.css`

### MI-common.js (16,686 bytes)
```bash
curl -sL "https://www.medinformatix.com/js/MI-common.js" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/MI-common.js
```
Verified: `file` reports "ASCII text"
Saved to: `downloads/MI-common.js`

## Obstacles & Notes

- **No obstacles.** Straightforward static HTML page served from S3/CloudFront. No anti-bot, no login wall, no JavaScript-dependent content.
- The page is ~239 KB which is large for a single HTML page — all 27 table definitions with field descriptions and example records are inline.
- No downloadable PDF or ZIP version is offered. If you want to keep a copy of the documentation, you must save the HTML page.
- The page references external ONC/HL7 resources for C-CDA and USCDI specs but provides no vendor-specific downloadable artifacts beyond the HTML page itself.
- The CSS accordion pattern means all content is in the DOM regardless of expanded/collapsed state — `grep` catches everything.
