# Imprivata — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10838, 11225, 11445, 11666
- Products: Access Intelligence, Digital Identity Intelligence, Imprivata FairWarning
- Registered URL: https://www.imprivata.com/onc-certification-disclosures

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.imprivata.com/onc-certification-disclosures" -H 'User-Agent: Mozilla/5.0'
```
**Result:** HTTP/2 200. Direct response, no redirects. Content-Type: text/html; charset=UTF-8. Drupal 11 CMS (X-Generator header). Content-Length: 129028 bytes. Fastly CDN caching. No anti-bot protection encountered.

### Step 2: Page examination
```bash
curl -sL "https://www.imprivata.com/onc-certification-disclosures" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html   # 129028 bytes
```
The page is a Drupal-rendered static HTML page (not a SPA). Content is fully present in the HTML source — no JavaScript rendering required. The 129KB size is mostly due to Drupal boilerplate, navigation, scripts, and CSS.

### Step 3: Finding the EHI section
The page is a single-page compliance disclosure. Content is laid out linearly with no accordions, tabs, or hidden sections. Structure:

1. **Disclaimer** — standard ONC compliance boilerplate
2. **"Certified EHR vendor and product information"** — four HTML tables, one per certified product/version:
   - Access Intelligence v25 (Cert ID: 15.02.05.1485.ACCS.08.08.0.250722)
   - Digital Identity Intelligence v24 (Cert ID: 15.02.05.1485.DIGI.07.07.0.240213)
   - Imprivata FairWarning v23 (Cert ID: 15.02.05.1485.FAIR.06.06.0.230130)
   - Imprivata FairWarning v22 (Cert ID: 15.02.05.1485.FAIR.05.05.0.220222)
3. **"§ 170.315 (b)(10) Electronic Health Information export"** — a single paragraph (the entire EHI export documentation)
4. **"§ 170.315 (d)(13) Multi-factor authentication"** — MFA disclosure
5. **Real World Testing links** — Plan: links to /rwtp-digital-identity-intelligence; Results: plain text "2025"

The b(10) section was reached by scrolling down the page. No clicks, accordion expansions, or navigation required.

### Step 4: Identified downloadable assets
Searched for PDF, ZIP, XLSX, CSV, JSON, DOC links:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html
```
**Result: No downloadable files found.** There are no PDF, ZIP, or other document downloads on this page. The entire EHI export documentation is the single inline paragraph.

Also searched for EHI/export-related links:
```bash
grep -oiE 'href="[^"]*[^"]*"' /tmp/page.html | grep -iE 'ehi|export|data.dictionary|b.10'
```
**Result: No links found.** No data dictionary, no schema, no separate documentation page.

### Step 5: Browser verification
Navigated to the page in a browser to confirm no JS-rendered content was missed. Confirmed:
- Cookie consent banner (OneTrust) overlays the page initially
- After dismissing, the page shows exactly what curl returned
- No hidden accordions, expandable sections, or dynamic content
- The b(10) paragraph is the complete documentation

## Downloads

### onc-certification-disclosures.html (129,028 bytes)
```bash
curl -sL "https://www.imprivata.com/onc-certification-disclosures" \
  -H 'User-Agent: Mozilla/5.0' \
  -o downloads/onc-certification-disclosures.html
```
Verified: `file` reports "HTML document, Unicode text, UTF-8 text"
Saved to: downloads/onc-certification-disclosures.html

## The Actual EHI Export Documentation (Complete Text)

The entire b(10) documentation is this single paragraph:

> **§ 170.315 (b)(10) Electronic Health Information export**
>
> Imprivata provides capabilities for end users to export of EHI. Permissions for export capabilities are governed in Imprivata by User Role and can also be limited to specific EHI data sources. Users with the ability to export can do so from the Report Results page in CSV (Comma Separated Value) format. Data fields included in the export capabilities are configurable by end users.

This is the entirety of what Imprivata provides for b(10) documentation. There is:
- No data dictionary
- No field/column definitions
- No table/entity list
- No schema
- No sample export
- No developer guide
- No description of what data domains are included

## Obstacles & Notes

1. **No anti-bot protection.** curl worked perfectly with a standard User-Agent.
2. **No JavaScript required.** Drupal renders the full page server-side.
3. **Minimal documentation.** This is one of the least detailed b(10) disclosures encountered. The vendor describes the export mechanism (CSV from Report Results page, configurable fields, role-based access) but provides zero detail about what data is actually exported, what fields exist, or what the export files look like.
4. **Nature of the products:** Imprivata's certified products (Access Intelligence, Digital Identity Intelligence, FairWarning) are patient privacy monitoring / access auditing tools, NOT traditional EHR clinical systems. They track who accessed patient records. The "EHI" they store is primarily audit/access log data, not clinical data. This explains the sparse documentation — the data model is relatively narrow.
5. **Single documentation for all products.** All four certified products share the same b(10) paragraph. There's no per-product differentiation.
6. **Real World Testing Plan link** goes to `/rwtp-digital-identity-intelligence` but was not followed as it's outside the EHI export scope.
