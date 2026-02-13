# Sightview EHR Holdings — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 11525, 11529, 11577, 11582, 11583, 11606, 11607
- Developers: MD Office, LLC; Management Plus EHR, LLC; Medflow EHR, LLC; My Vision Express, LLC; Sightview EHR Holdings, LLC; iMedicWare, LLC
- Products: MDoffice, ManagementPlus, Medflow EHR, My Vision Express, Regulatory Compliance Platform, iMedicWare, myCare Portal
- Registered URL: https://sightview.com/about-sightview/onc-certification/

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://sightview.com/about-sightview/onc-certification/" -H 'User-Agent: Mozilla/5.0'
```
- HTTP 301 → `https://www.sightview.com/about-sightview/onc-certification/`
- HTTP 200, Content-Type: text/html; charset=UTF-8
- Hosted on HubSpot CMS behind Cloudflare
- Last-Modified: Fri, 13 Feb 2026 17:10:51 GMT (very recently updated)

### Step 2: Page examination
```bash
curl -sL "https://sightview.com/about-sightview/onc-certification/" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html
```
- Page size: 157,611 bytes
- Full HTML content with HubSpot CMS rendering (not a SPA)
- Content is visible via curl — no JavaScript required to see links
- Page titled "ONC Certification | Sightview"

### Step 3: Finding the EHI section
The page is a compliance hub organized as a grid of product cards with "Certifications" heading. The top row has three cards:
1. "Regulatory Compliance Platform" - MORE INFO +
2. **"EHI Export Data Dictionary"** - MORE INFO + (this is the key card)
3. "Portal" - MORE INFO +

Below that are product-specific cards: ManagementPlus, MDoffice, Medflow, MyVisionExpress, iMedicWare.

The EHI Export Data Dictionary card expands (via modal/accordion) to show links to individual product data dictionaries.

Key note on the page: *"myCare Portal requires the use of an Electronic Health Record (EHR) as relied upon software to perform EHI Exports. Please reference the EHI Export Format Documentation associated with your EHR."*

The EHI data dictionary links appear in multiple locations on the page (duplicated across sections).

### Step 4: Identified downloadable assets

EHI Export Data Dictionaries found via grep:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html
```

**EHI-relevant PDFs:**
1. `My Vision Express EHI Export Data Dictionary.pdf` — HubSpot-hosted
2. `iMedicWare EHI Data Dictionary.pdf` — HubSpot-hosted
3. `ManagementPlus EHI Data Dictionary.pdf` — HubSpot-hosted
4. `MDoffice EHI Export Data Dictionary.pdf` — HubSpot-hosted
5. `Medflow EHI Export Data Dictionary.pdf` — HubSpot-hosted
6. `MDoffice-12.1-DATA-DICTIONARY-Release-V1.1-1.pdf` — CloudFront-hosted (older v1.1)

**Non-EHI PDFs on page (not downloaded):** Real World Test Plans/Results, Cost Disclosures, API Documentation — these are regulatory compliance artifacts, not EHI export documentation.

## Downloads

### MyVisionExpress-EHI-Export-Data-Dictionary.pdf (885 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o MyVisionExpress-EHI-Export-Data-Dictionary.pdf \
  'https://www.sightview.com/hubfs/Sightview%20Disclosures/My%20Vision%20Express%20EHI%20Export%20Data%20Dictionary.pdf?hsLang=en'
```
Verified: `file` → PDF document, version 1.7, 60 pages
Created: Fri Aug 2 13:11:23 2024
Saved to: downloads/MyVisionExpress-EHI-Export-Data-Dictionary.pdf

### iMedicWare-EHI-Data-Dictionary.pdf (854 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o iMedicWare-EHI-Data-Dictionary.pdf \
  'https://www.sightview.com/hubfs/Sightview%20Disclosures/iMedicWare%20EHI%20Data%20Dictionary.pdf?hsLang=en'
```
Verified: `file` → PDF document, version 1.7, 61 pages
Created: Fri Aug 2 13:07:32 2024
Saved to: downloads/iMedicWare-EHI-Data-Dictionary.pdf

### ManagementPlus-EHI-Data-Dictionary.pdf (893 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o ManagementPlus-EHI-Data-Dictionary.pdf \
  'https://www.sightview.com/hubfs/Sightview%20Disclosures/ManagementPlus%20EHI%20Data%20Dictionary.pdf?hsLang=en'
```
Verified: `file` → PDF document, version 1.7, 62 pages
Created: Fri Aug 2 13:08:48 2024
Saved to: downloads/ManagementPlus-EHI-Data-Dictionary.pdf

### MDoffice-EHI-Export-Data-Dictionary.pdf (691 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o MDoffice-EHI-Export-Data-Dictionary.pdf \
  'https://www.sightview.com/hubfs/Sightview%20Disclosures/MDoffice%20EHI%20Export%20Data%20Dictionary.pdf?hsLang=en'
```
Verified: `file` → PDF document, version 1.7, 49 pages
Created: Fri Aug 2 13:09:36 2024
Saved to: downloads/MDoffice-EHI-Export-Data-Dictionary.pdf

### Medflow-EHI-Export-Data-Dictionary.pdf (891 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o Medflow-EHI-Export-Data-Dictionary.pdf \
  'https://www.sightview.com/hubfs/Sightview%20Disclosures/Medflow%20EHI%20Export%20Data%20Dictionary.pdf?hsLang=en'
```
Verified: `file` → PDF document, version 1.7, 61 pages
Created: Fri Aug 2 13:10:30 2024
Saved to: downloads/Medflow-EHI-Export-Data-Dictionary.pdf

### MDoffice-12.1-DATA-DICTIONARY-Release-V1.1.pdf (811 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o MDoffice-12.1-DATA-DICTIONARY-Release-V1.1.pdf \
  'https://d1gk9fjrp2e3pm.cloudfront.net/2023/12/MDoffice-12.1-DATA-DICTIONARY-Release-V1.1-1.pdf'
```
Verified: `file` → PDF document, version 1.7, 48 pages
Created: Wed Dec 13 18:43:01 2023 (older version)
Title: "EHI Export Data Dictionary MDoffice 12.1"
Saved to: downloads/MDoffice-12.1-DATA-DICTIONARY-Release-V1.1.pdf

## Product Context

Sightview EHR Holdings is a holding company that acquired and consolidated multiple ophthalmology/optometry-focused EHR products under one umbrella. The constituent products are:

- **MDoffice** — Ophthalmology EHR (the simplest/oldest export, 50 CSVs, no messaging)
- **ManagementPlus** — Ophthalmology/optometry EHR + practice management (68 CSVs, includes messaging)
- **Medflow EHR** — Ophthalmology EHR (68 CSVs, includes messaging, identical structure to ManagementPlus)
- **My Vision Express** — Optometry/optical EHR + practice management (68 CSVs, includes messaging)
- **iMedicWare** — Ophthalmology EHR (68 CSVs, includes messaging)
- **Regulatory Compliance Platform** — Cross-product regulatory compliance module
- **myCare Portal** — Patient portal (relies on the EHR for EHI export — does not have its own)

Sightview's website describes the platform as "Intelligent EHR and practice management solutions built exclusively for eye care." Key capabilities include:
- Electronic Health Records with ophthalmology/optometry-specific workflows
- Practice Management (scheduling, billing, documentation)
- Optical retail management (inventory, frames, lenses, sales)
- Revenue Cycle Management (claims, remittances, authorizations)
- Patient engagement (voice, email, two-way text messaging)
- Ambulatory Surgery Center management
- MIPS reporting
- Integrated Payments

The broader platform clearly stores billing/financial data, scheduling data, patient portal messages, optical inventory/sales data, and RCM data — all of which should be part of an EHI export.

## Obstacles & Notes

- **No anti-bot issues.** HubSpot CMS served content cleanly via curl.
- **Redirect:** `sightview.com` → `www.sightview.com` (301 redirect via Cloudflare).
- **All EHI docs created on same day:** All five product data dictionaries were created on August 2, 2024, suggesting a coordinated effort to produce standardized documentation across all products.
- **MDoffice is the outlier:** Only 49 pages and ~50 CSV files vs 60-62 pages and ~68 CSV files for the other four products. Most notably, MDoffice lacks the Communications section (messaging) and several additional ophthalmic test CSVs.
- **myCare Portal punt:** The page explicitly states myCare Portal relies on the EHR for EHI exports, meaning portal-specific data (like patient-initiated messages via the portal) would only be captured if the underlying EHR's export includes it. This is a potential gap.
- **Two MDoffice versions exist:** Version 1.1 (Dec 2023, CloudFront) and Version 2.0 (Aug 2024, HubSpot). The CSV file lists are identical between versions; v2.0 appears to be a Sightview rebranding with minor formatting changes.
