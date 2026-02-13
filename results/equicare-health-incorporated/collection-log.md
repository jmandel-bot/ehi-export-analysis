# Equicare Health Incorporated — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 11390, 11494, 11633
- Products: EQUICARE CS
- Developer: Equicare Health Incorporated
- Registered URL: https://equicarehealth.com/ehiexport/

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://equicarehealth.com/ehiexport/" -H 'User-Agent: Mozilla/5.0'
```
Result: HTTP/2 200 directly (no redirects). Content-Type: text/html; charset=UTF-8. Server is WordPress hosted on WP Engine, behind Cloudflare. Page ID 6298 (`wp/v2/pages/6298`). No content-disposition header — this is a regular webpage.

### Step 2: Page examination
```bash
curl -sL "https://equicarehealth.com/ehiexport/" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html  # 50,373 bytes
```
The page is a standard WordPress page with all content rendered server-side in static HTML. No SPA, no JavaScript-dependent content loading. The full EHI export documentation is inline on the page itself.

### Step 3: Finding the EHI section
No navigation required. The page IS the EHI export documentation. The URL goes directly to a dedicated WordPress page titled "EHI Export" with the full specification inline.

Page structure (top to bottom):
1. Site header/navigation bar (Equicare Health logo, menu)
2. **"EHI Export"** heading — introductory paragraph explaining EQUICARE CS and APP export capability
3. **"JSON Format"** section — states export uses JSON format, links to https://www.json.org/
4. **"Data Types"** section — describes DateTime (UTC), CCDA (XML markup), and Files (Base64 encoded)
5. **"Data Categories"** section — large HTML table with 17 categories, each listing all available fields
6. **"Export Example"** section — inline JSON snippet showing a PatientTestResultsList example
7. Site footer

### Step 4: Identified downloadable assets
No downloadable files (PDF, ZIP, etc.) are linked from this page. The documentation is entirely inline HTML. Two external reference links exist:
- https://www.json.org/ (JSON format reference)
- https://datatracker.ietf.org/doc/html/rfc4648#section-4 (Base64 encoding reference)

Searched for downloadable file links:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html
```
Result: Only `manifest.json` (a favicon/PWA manifest, not documentation) and `json.org` reference.

## Downloads

### ehiexport-page.html (50,373 bytes)
```bash
curl -sL "https://equicarehealth.com/ehiexport/" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/ehiexport-page.html
```
Verified: `file downloads/ehiexport-page.html` → HTML document, Unicode text, UTF-8 text
Saved to: downloads/ehiexport-page.html

This is the only artifact. The entire EHI export specification is contained in this single HTML page.

## Obstacles & Notes
- **No obstacles.** Page loads cleanly with curl, no anti-bot protection beyond Cloudflare (which doesn't block with a standard User-Agent), no login wall, no JavaScript required.
- **No downloadable files.** Documentation is inline HTML only — no PDF, no ZIP, no separate data dictionary file.
- **Specialty system.** Equicare Health is a cancer care coordination / navigation system, not a general-purpose EHR. The data categories reflect this focus (navigation summaries, survivorship care plans, treatment summaries, distress management questionnaires).
- **No billing or financial data.** The export does not include any billing, claims, charges, or financial data categories. Insurance is only captured as two fields (Insurance, InsuranceNote) within patient registration.
- **No audit trail data.** No audit log or access tracking categories.
- **Page last modified 2023-11-30** per schema.org metadata. Originally published 2023-06-08.
