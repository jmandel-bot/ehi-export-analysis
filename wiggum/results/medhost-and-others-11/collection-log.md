# MEDHOST — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10738, 10739, 11651, 11655, 11678
- Products: MEDHOST EDIS, MEDHOST Enterprise - Clinicals, MEDHOST Enterprise - Financials, YourCareCommunity Patient Portal with YourCareEverywhere App, YourCareCommunity Provider Portal
- Developers: MEDHOST, MEDHOST Cloud Services, Inc.
- Registered URL: https://www.medhost.com/ehr/interoperability/

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.medhost.com/ehr/interoperability/" -H 'User-Agent: Mozilla/5.0'
```

Result: HTTP/2 200. WordPress site ("X-Powered-By: WP Engine") behind Cloudflare. Content-Type: text/html; charset=UTF-8. No redirects.

### Step 2: Page examination

```bash
curl -sL "https://www.medhost.com/ehr/interoperability/" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html
```

Result: 198,235 bytes. The page is a WordPress page using WP Rocket (RocketLazyLoadScripts) for lazy loading JavaScript. Despite the JS lazy-loading, the substantive HTML content is present in the source — it's server-rendered HTML with JS-deferred interactions, not a true SPA.

### Step 3: Finding the EHI section

Searched HTML source for EHI-related content:

```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html
```

Found: `href="https://www.medhost.com/fhir/extensions/MEDHOST-FHIR-Extension-Fields.xlsx"`

Searched for EHI section in source:
```bash
grep -iE 'ehi|electronic.health.information|b\(10\)' /tmp/page.html
```

Found an HTML section with `id="EHIExport"` containing the EHI Export documentation content directly in the page HTML.

The EHI Export section is located at `<section id="EHIExport">` on the interoperability page. It contains:
- Description of two export types: Single patient and System
- Statement that export uses FHIR R4 v4.0.1 as a guideline
- Link to FHIR extension fields XLSX: https://www.medhost.com/fhir/extensions/MEDHOST-FHIR-Extension-Fields.xlsx
- Statement that output is "multiple NDJSON files per patient... presented as a compressed (zip) file"

Using the browser, I scrolled to the `#EHIExport` section and confirmed the content is visible.

### Step 4: Identified subpage — Cures 2023 Interoperability Solution

The interoperability page links to a subpage:
https://www.medhost.com/ehr/interoperability/medhost-cures-2023-interoperability-solution/

```bash
curl -sL "https://www.medhost.com/ehr/interoperability/medhost-cures-2023-interoperability-solution/" -H 'User-Agent: Mozilla/5.0' -o /tmp/cures2023.html
```

Result: 174,130 bytes. Marketing page describing the Cures 2023 Solution. Key text: "Enables export of EHI (single patient and system) in machine computable format" and "Single patient export from the patient portal". No additional technical documentation or downloadable files beyond what's on the main interop page.

### Step 5: Developer portal discovery

Found a "Developer Network" link in the page footer pointing to: https://yourcareinteract.medhost.com/

This is an Angular SPA (developer portal). It has:
- Home page describing "YourCare Interact" API portal
- Documentation page with accordion sections
- FHIR 4.0 API page (Swagger UI showing OpenAPI spec)
- A "Data Export" accordion section

Navigated to https://yourcareinteract.medhost.com/documentation using the browser (Angular SPA, requires JS).

Expanded the "Data Export" accordion. Content:

> **System and Patient Export**
> Currently the System and Patient Export are not supported through FHIR API
>
> **Group Export**
> The following is the process to request a group export:
> 1. Identify Patients for Group Inclusion
> 2. Submit Patient List to MEDHOST Support
> 3. Receive the Group ID
> 4. Initiate Group Export — Use the provided Group ID to initiate and monitor the export process using the FHIR Bulk Data Group Export operation
>
> NOTE: Group export is limited to 5000 patients per group

### Step 6: FHIR API Swagger spec discovery

On the FHIR 4.0 API documentation page, found a Swagger UI iframe loading from:
https://yourcareinteract.medhost.com/assets/doc/swagger.json

This JSON file documents 30 FHIR resource types with 61 API paths.

### Step 7: Checked for additional documentation paths

```bash
curl -sI -L "https://www.medhost.com/fhir/" -H 'User-Agent: Mozilla/5.0'
```
Result: HTTP 403 (directory listing blocked)

```bash
curl -sI -L "https://www.medhost.com/fhir/extensions/" -H 'User-Agent: Mozilla/5.0'
```
Result: HTTP 403 (directory listing blocked)

The XLSX at the specific path works, but parent directories are not browsable.

### Step 8: HTI Program page check

https://www.medhost.com/ehr/interoperability/medhost-hti-program/ — Marketing page about HTI-1 Final Rule compliance. No additional EHI export technical documentation.

## Downloads

### MEDHOST-FHIR-Extension-Fields.xlsx (135 KB)

```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/MEDHOST-FHIR-Extension-Fields.xlsx \
  'https://www.medhost.com/fhir/extensions/MEDHOST-FHIR-Extension-Fields.xlsx'
```

Verified: `file` reports "Microsoft Excel 2007+". Size: 138,660 bytes.
Saved to: downloads/MEDHOST-FHIR-Extension-Fields.xlsx

Contents: 44 sheets total. 41 resource-specific sheets documenting 708 FHIR extension fields that MEDHOST adds beyond standard FHIR R4. Each sheet has columns: Field Name, Version, FHIR Field Type, Max Field Length, Field Description, Enterprise Database table/col, EDIS database table/col.

### medhost-fhir-swagger.json (452 KB)

```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o downloads/medhost-fhir-swagger.json \
  'https://yourcareinteract.medhost.com/assets/doc/swagger.json'
```

Verified: valid JSON. Size: 462,905 bytes. Title: "MEDHOST FHIR". 61 paths, 30 model definitions.
Saved to: downloads/medhost-fhir-swagger.json

### interoperability-page.html (194 KB)

```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o downloads/interoperability-page.html \
  'https://www.medhost.com/ehr/interoperability/'
```

Saved to: downloads/interoperability-page.html (198,235 bytes)

### cures-2023-page.html (170 KB)

```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o downloads/cures-2023-page.html \
  'https://www.medhost.com/ehr/interoperability/medhost-cures-2023-interoperability-solution/'
```

Saved to: downloads/cures-2023-page.html (174,130 bytes)

## Obstacles & Notes

1. **WP Rocket lazy loading**: The WordPress site uses WP Rocket's RocketLazyLoadScripts, which defers all JavaScript execution until user interaction. However, the EHI content is in the server-rendered HTML, so `curl` can extract it without JavaScript.

2. **Developer portal is an Angular SPA**: The developer portal at yourcareinteract.medhost.com requires a browser to navigate. The documentation page uses Bootstrap accordions that need to be clicked to expand. However, the Swagger JSON is available at a direct URL.

3. **No dedicated EHI documentation page**: The EHI export documentation is a single section (`#EHIExport`) within a broader interoperability marketing page, plus the downloadable XLSX extension fields file. There's no standalone data dictionary, no comprehensive schema, and no dedicated documentation site.

4. **System/Patient Export not via FHIR API**: The developer portal explicitly states "Currently the System and Patient Export are not supported through FHIR API" — only Group Export (FHIR Bulk Data) is supported through the API. The actual single-patient and system EHI exports appear to be handled through the MEDHOST YourCare Universe patient portal and administrative tools respectively, separate from the FHIR API.

5. **Extension fields reference internal database columns**: The XLSX includes columns for "Enterprise Database table/col" and "EDIS database table/col" providing internal database table/column mappings (e.g., `BILMST50.SUM(CGDAMT)`, `PATHIST.SSNAL`). This is unusually transparent — it reveals the actual database schema behind the FHIR resources.
