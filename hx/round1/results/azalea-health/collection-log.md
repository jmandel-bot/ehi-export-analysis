# Azalea Health — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11140 (Azalea Hospital / ChartAccess®), 11151 (Azalea Ambulatory / Azalea EHR)
- **Products**: Azalea EHR, ChartAccess®
- **Registered URL**: https://www.azaleahealth.com/resources/onc-certification/

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.azaleahealth.com/resources/onc-certification/" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP/2 200. WordPress site on Cloudflare (Kinsta hosting). Content-Type: text/html; charset=UTF-8. No redirects.

### Step 2: Page examination

```bash
curl -sL "https://www.azaleahealth.com/resources/onc-certification/" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html  # 307,309 bytes
```

Large WordPress/Elementor page. Real HTML content — not a SPA. Contains multiple Elementor accordion sections for both "Azalea EHR" and "ChartAccess®" products, covering various ONC certification criteria.

### Step 3: Finding the EHI section

Searched for EHI/export/b10 links:

```bash
grep -oiE 'href="[^"]*[^"]*"' /tmp/page.html | grep -iE 'ehi|export|data.dictionary|b.10|b10'
```

**Result**: Found two identical links to `https://dev.azaleahealth.com/compliance/b10`

These links are inside Elementor accordion sections labeled **"EHI Export Documentation"** (one under Azalea EHR, one under ChartAccess®). Both point to the same URL. The accordion content reads:

> "In accordance with 170.315(b)(10) EHR certification criteria, please click below for our full EHI Export documentation."

The HTML context shows these are `data-tab="4"` accordion items (the 4th accordion in each product section).

### Step 4: Following the b10 link

```bash
curl -sI -L "https://dev.azaleahealth.com/compliance/b10" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP/2 200. Content-Type: text/html; charset=UTF-8. Server: Apache. Sets Laravel session cookies (XSRF-TOKEN, devportal_session). This is Azalea's Developer Portal.

```bash
curl -sL "https://dev.azaleahealth.com/compliance/b10" -H 'User-Agent: Mozilla/5.0' -o /tmp/b10.html
wc -c /tmp/b10.html  # 18,087 bytes
```

The page is a Laravel-based developer portal. Content renders server-side (not a SPA) — the full text is in the HTML. Uses custom web components (`<ahi-nav-item>`, `<ahi-text>`) but content is directly in the DOM.

The b10 overview page contains:
- A table linking to platform-specific export guides:
  - **Azalea Ambulatory** → Ambulatory EHI Export Guide (`/ambulatory/export`) — CHPL 11151
  - **Azalea Hospital** → Hospital EHI Export Guide (`/hospital/export`) — CHPL 11140
- Sections: File Format, Resources Included, Unstructured Data, Single Patient EHI Export, Patient Population EHI Export

### Step 5: Following platform-specific export guides

**Ambulatory EHI Export Guide:**
```bash
curl -sL "https://dev.azaleahealth.com/ambulatory/export" -H 'User-Agent: Mozilla/5.0' -o /tmp/amb_export.html
wc -c /tmp/amb_export.html  # 26,785 bytes
```

Contains a "Resource Data Mappings" table with 57 rows mapping EHR concepts to FHIR R4 resources.

**Hospital EHI Export Guide:**
```bash
curl -sL "https://dev.azaleahealth.com/hospital/export" -H 'User-Agent: Mozilla/5.0' -o /tmp/hosp_export.html
wc -c /tmp/hosp_export.html  # 22,840 bytes
```

Contains a "Resource Data Mappings" table with 45 rows mapping EHR concepts to FHIR R4 resources.

### Step 6: Additional related pages

The developer portal sidebar also links to:
- **Ambulatory Resources** (`/ambulatory/resources`) — lists supported FHIR resources with interaction details (62,324 bytes)
- **Hospital Resources** (`/hospital/resources`) — same for hospital (36,983 bytes)
- **Bulk Data Export** (`/implementation/bulk-data-export`) — implementation guide for the export API (17,589 bytes)

### Step 7: PDFs on the main certification page

The main certification page also hosts these PDFs (not EHI-specific but related):
- `Compliance-Certificate-Azalea-EHR-4.0-020326-1.pdf`
- `Azalea-EHR-Cost-Disclosures-January-2025-8.docx.pdf`
- `MFA-Use-Cases-Azalea-EHR-04.16.25.pdf`
- `Compliance-Certificate-ChartAccess-®-7.0-020326-2.pdf`
- `ChartAccess-Cost-Disclosures-January-2025-8.docx.pdf`
- `MFA-Use-Cases-ChartAccess-04.16.25.pdf`

These are compliance certificates and cost disclosures — not EHI export documentation. Not downloaded.

## Downloads

### b10-overview.html (18,087 bytes)
```bash
curl -sL "https://dev.azaleahealth.com/compliance/b10" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/b10-overview.html
```
Verified: HTML document, Unicode text, UTF-8 text
Saved to: `downloads/b10-overview.html`

### ambulatory-ehi-export-guide.html (26,785 bytes)
```bash
curl -sL "https://dev.azaleahealth.com/ambulatory/export" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/ambulatory-ehi-export-guide.html
```
Verified: HTML document, Unicode text, UTF-8 text
Saved to: `downloads/ambulatory-ehi-export-guide.html`

### hospital-ehi-export-guide.html (22,840 bytes)
```bash
curl -sL "https://dev.azaleahealth.com/hospital/export" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/hospital-ehi-export-guide.html
```
Verified: HTML document, Unicode text, UTF-8 text
Saved to: `downloads/hospital-ehi-export-guide.html`

### bulk-data-export-guide.html (17,589 bytes)
```bash
curl -sL "https://dev.azaleahealth.com/implementation/bulk-data-export" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/bulk-data-export-guide.html
```
Verified: HTML document, Unicode text, UTF-8 text
Saved to: `downloads/bulk-data-export-guide.html`

### ambulatory-resources.html (62,324 bytes)
```bash
curl -sL "https://dev.azaleahealth.com/ambulatory/resources" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/ambulatory-resources.html
```
Verified: HTML document, Unicode text, UTF-8 text
Saved to: `downloads/ambulatory-resources.html`

### hospital-resources.html (36,983 bytes)
```bash
curl -sL "https://dev.azaleahealth.com/hospital/resources" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/hospital-resources.html
```
Verified: HTML document, Unicode text, UTF-8 text
Saved to: `downloads/hospital-resources.html`

### onc-certification-landing.html (307,309 bytes)
```bash
curl -sL "https://www.azaleahealth.com/resources/onc-certification/" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/onc-certification-landing.html
```
Verified: HTML document, ASCII text
Saved to: `downloads/onc-certification-landing.html`

## Obstacles & Notes

1. **No obstacles.** All pages returned 200 with no anti-bot protection, no login required, no special headers needed.
2. **Content renders server-side.** Despite being a Laravel app with custom web components, all content is in the HTML response. Browser not required to see documentation.
3. **Accordion on landing page.** The EHI export link on the main certification page is inside an Elementor accordion section titled "EHI Export Documentation" (4th accordion). Content is in the DOM (display:none when collapsed) — grep finds it without needing JavaScript.
4. **Developer Portal navigation.** The dev portal has a sidebar with sections: Compliance & Certification → §170.315 (b)(10) EHI Export. Platform-specific guides are under Ambulatory → EHI Export Guide and Hospital → EHI Export Guide.
5. **No downloadable files (PDF/ZIP).** All documentation is HTML pages on the developer portal. No PDF data dictionary, no ZIP export, no downloadable schema files.
6. **Both products share the same b10 overview.** The Azalea EHR (ambulatory) and ChartAccess® (hospital) accordions on the main page both link to the identical b10 overview URL, which then branches to platform-specific guides.
