# Sightview EHR Holdings / MD Office, LLC (and others) — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11525, 11529, 11577, 11582, 11583, 11606, 11607
- **Developers**: MD Office, LLC; Management Plus EHR, LLC; Medflow EHR, LLC; My Vision Express, LLC; Sightview EHR Holdings, LLC; iMedicWare, LLC
- **Products**: MDoffice, ManagementPlus, Medflow EHR, My Vision Express, Regulatory Compliance Platform, iMedicWare, myCare Portal
- **Registered URL**: https://sightview.com/about-sightview/onc-certification/

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://sightview.com/about-sightview/onc-certification/" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP 301 redirect from `sightview.com` → `www.sightview.com/about-sightview/onc-certification/`, then HTTP 200. The site is hosted on HubSpot (headers: `x-hs-portal-id: 42247126`) behind Cloudflare. Content-Type: `text/html; charset=UTF-8`.

### Step 2: Page examination

```bash
curl -sL "https://www.sightview.com/about-sightview/onc-certification/" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html
```

**Result**: 157,611 bytes. Full HTML content — not a SPA. HubSpot-hosted page with real content in the DOM. The page title is "ONC Certification" and starts with a statement about Information Blocking and Communications Conditions and Maintenance of Certification.

### Step 3: Finding the EHI section

The page has a "Certifications" section below the introductory text, organized as a grid of 8 expandable cards:
1. **Regulatory Compliance Platform** — MORE INFO +
2. **EHI Export Data Dictionary** — MORE INFO + ← This is the one
3. **Portal** — MORE INFO +
4. **ManagementPlus** — MORE INFO +
5. **MDoffice** — MORE INFO +
6. **Medflow** — MORE INFO +
7. **MyVisionExpress** — MORE INFO +
8. **iMedicWare** — MORE INFO +

Clicking "MORE INFO +" on the **"EHI Export Data Dictionary"** card opens a modal/popup containing:

**5 EHI Data Dictionary PDF links:**
- My Vision Express Data Dictionary
- iMedicWare Data Dictionary
- ManagementPlus EHI Export Data Dictionary
- MDoffice EHI Export Data Dictionary
- Medflow EHI Export Data Dictionary

**Notes about relied-upon software:**
- *Regulatory Compliance Platform* uses MDoffice, My Vision Express, Management Plus, or Medflow as relied-upon software (links to same dictionaries)
- *myCare Portal* requires an EHR as relied-upon software to perform EHI Exports; references the same EHR data dictionaries

Additionally, under other product cards (e.g., MDoffice), there is a separate older data dictionary:
- MDoffice 12.1 DATA DICTIONARY Release V1.1 (hosted on CloudFront at `d1gk9fjrp2e3pm.cloudfront.net`)

### Step 4: Identified downloadable assets

All found via `grep` on the HTML source:

```bash
grep -oiE 'href="[^"]*"' /tmp/page.html | grep -iE 'ehi|data.dictionary' | sort -u
```

6 unique PDF URLs identified (5 current EHI dictionaries from HubSpot + 1 older MDoffice dictionary from CloudFront).

## Downloads

### My_Vision_Express_EHI_Export_Data_Dictionary.pdf (906,322 bytes, 60 pages)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o My_Vision_Express_EHI_Export_Data_Dictionary.pdf \
  'https://www.sightview.com/hubfs/Sightview%20Disclosures/My%20Vision%20Express%20EHI%20Export%20Data%20Dictionary.pdf?hsLang=en'
```
Verified: PDF document, version 1.7, 60 pages

### iMedicWare_EHI_Data_Dictionary.pdf (874,169 bytes, 61 pages)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o iMedicWare_EHI_Data_Dictionary.pdf \
  'https://www.sightview.com/hubfs/Sightview%20Disclosures/iMedicWare%20EHI%20Data%20Dictionary.pdf?hsLang=en'
```
Verified: PDF document, version 1.7, 61 pages

### ManagementPlus_EHI_Data_Dictionary.pdf (915,241 bytes, 62 pages)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o ManagementPlus_EHI_Data_Dictionary.pdf \
  'https://www.sightview.com/hubfs/Sightview%20Disclosures/ManagementPlus%20EHI%20Data%20Dictionary.pdf?hsLang=en'
```
Verified: PDF document, version 1.7, 62 pages

### MDoffice_EHI_Export_Data_Dictionary.pdf (707,340 bytes, 49 pages)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o MDoffice_EHI_Export_Data_Dictionary.pdf \
  'https://www.sightview.com/hubfs/Sightview%20Disclosures/MDoffice%20EHI%20Export%20Data%20Dictionary.pdf?hsLang=en'
```
Verified: PDF document, version 1.7, 49 pages

### Medflow_EHI_Export_Data_Dictionary.pdf (912,427 bytes, 61 pages)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o Medflow_EHI_Export_Data_Dictionary.pdf \
  'https://www.sightview.com/hubfs/Sightview%20Disclosures/Medflow%20EHI%20Export%20Data%20Dictionary.pdf?hsLang=en'
```
Verified: PDF document, version 1.7, 61 pages

### MDoffice_12.1_DATA_DICTIONARY_Release_V1.1.pdf (831,446 bytes, 48 pages)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o MDoffice_12.1_DATA_DICTIONARY_Release_V1.1.pdf \
  'https://d1gk9fjrp2e3pm.cloudfront.net/2023/12/MDoffice-12.1-DATA-DICTIONARY-Release-V1.1-1.pdf'
```
Verified: PDF document, version 1.7, 48 pages
Note: This is the older V1.1 version (Dec 2023). The newer V2.0 (Jul 2024) is the HubSpot-hosted MDoffice_EHI_Export_Data_Dictionary.pdf above.

## Obstacles & Notes

- **No anti-bot issues**: Cloudflare + HubSpot hosting, but standard User-Agent header worked fine for all downloads.
- **Accordion/modal UI**: The EHI data dictionaries are behind a "MORE INFO +" button that opens a modal popup. Content is in the DOM (discoverable via grep) but not visible until clicked.
- **No iMedicWare-specific EHI dictionary URL on CloudFront**: Only MDoffice had an older version on CloudFront; iMedicWare, ManagementPlus, Medflow, and MVE only have the newer HubSpot versions.
- **Regulatory Compliance Platform and myCare Portal do NOT have their own data dictionaries**: They are explicitly documented as relying on the underlying EHR's export functionality. myCare Portal is a patient portal; Regulatory Compliance Platform is a compliance add-on. Both point to the 4-5 EHR product dictionaries.
- **Ophthalmology/optometry-focused products**: All products under Sightview are eye care EHRs (formerly Eye Care Leaders). The data dictionaries reflect this with extensive ophthalmic data sections (OCT, visual fields, refraction, etc.).
