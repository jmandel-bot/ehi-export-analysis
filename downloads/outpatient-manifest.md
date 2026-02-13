# Outpatient Major Vendors — Download Manifest

**Downloaded:** 2026-02-13
**Total files:** 19
**Total size:** ~35.5 MB

---

## 1. athenahealth

### ambulatory-clinical-ehi-export.pdf
- **Local path:** `downloads/athenahealth/ambulatory-clinical-ehi-export.pdf`
- **File size:** 534,849 bytes (523 KB)
- **File type:** PDF document, version 1.7, 10 pages
- **Source URL:** `https://docs.athenahealth.com/downloads/exports-ambulatory-clinical-ehi-export`
- **Curl command:**
  ```
  curl -L -s --compressed -o ambulatory-clinical-ehi-export.pdf \
    -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
    "https://docs.athenahealth.com/downloads/exports-ambulatory-clinical-ehi-export"
  ```
- **Notes:** Server sends gzip-encoded response; `--compressed` flag required for proper decoding.

---

## 2. NextGen Healthcare

### ehi-data-export-page.html
- **Local path:** `downloads/nextgen/ehi-data-export-page.html`
- **File size:** 175,648 bytes (172 KB)
- **File type:** HTML (text/html; charset=utf-8)
- **Source URL:** `https://www.nextgen.com/sldkjljieo0935jljsrnfkl`
- **Curl command:**
  ```
  curl -L -s -o ehi-data-export-page.html \
    -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
    "https://www.nextgen.com/sldkjljieo0935jljsrnfkl"
  ```
- **Notes:** Obfuscated URL path; page title is "ELECTRONIC HEALTH INFORMATION DATA DICTIONARY HYPERLINKS". Has `x-robots-tag: noindex, nofollow`.

### DD_Complete_EHI_20250627.pdf
- **Local path:** `downloads/nextgen/DD_Complete_EHI_20250627.pdf`
- **File size:** 29,204,519 bytes (27.8 MB)
- **File type:** PDF document, version 1.7 (zip deflate encoded)
- **Source URL:** `https://www.nextgen.com/-/media/files/legal/2025/DD_Complete_EHI_20250627`
- **Curl command:**
  ```
  curl -L -s -o DD_Complete_EHI_20250627.pdf \
    -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
    --max-time 120 \
    "https://www.nextgen.com/-/media/files/legal/2025/DD_Complete_EHI_20250627"
  ```
- **Notes:** Very large PDF. Server sends `content-disposition: inline; filename="DD_Complete_EHI_20250627.pdf"`. Dated June 27, 2025. Schema for NextGen Enterprise EHR.

---

## 3. Greenway Health (Intergy)

### IntergyEHIExport.html
- **Local path:** `downloads/greenway/IntergyEHIExport.html`
- **File size:** 9,266 bytes (9.1 KB)
- **File type:** HTML
- **Source URL:** `https://ehi.greenwayhealth.com/Intergy/IntergyEHIExport.html`
- **Curl command:**
  ```
  curl -L -s -o IntergyEHIExport.html \
    "https://ehi.greenwayhealth.com/Intergy/IntergyEHIExport.html"
  ```

### DBDescriptions.js
- **Local path:** `downloads/greenway/DBDescriptions.js`
- **File size:** 28,531 bytes (28 KB)
- **File type:** JavaScript (contains 261 table definitions with descriptions)
- **Source URL:** `https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/Contracts/include/DBDescriptions.js`
- **Curl command:**
  ```
  curl -L -s -o DBDescriptions.js \
    "https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/Contracts/include/DBDescriptions.js"
  ```

### viewer-index.html
- **Local path:** `downloads/greenway/viewer-index.html`
- **File size:** 1,243 bytes (1.2 KB)
- **File type:** HTML (frameset with table browser)
- **Source URL:** `https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/index.html`
- **Curl command:**
  ```
  curl -L -s -o viewer-index.html \
    "https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/index.html"
  ```

### DBTOC.htm
- **Local path:** `downloads/greenway/DBTOC.htm`
- **File size:** 1,208 bytes (1.2 KB)
- **File type:** HTML (table of contents with JS-populated dropdown)
- **Source URL:** `https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/Contracts/DBTOC.htm`
- **Curl command:**
  ```
  curl -L -s -o DBTOC.htm \
    "https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/Contracts/DBTOC.htm"
  ```

### Account.htm
- **Local path:** `downloads/greenway/Account.htm`
- **File size:** 12,867 bytes (13 KB)
- **File type:** HTML (table definition with field-level detail)
- **Source URL:** `https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/Contracts/Account.htm`
- **Curl command:**
  ```
  curl -L -s -o Account.htm \
    "https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/Contracts/Account.htm"
  ```

### Allergy.htm
- **Local path:** `downloads/greenway/Allergy.htm`
- **File size:** 5,847 bytes (5.8 KB)
- **File type:** HTML (table definition with field-level detail)
- **Source URL:** `https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/Contracts/Allergy.htm`
- **Curl command:**
  ```
  curl -L -s -o Allergy.htm \
    "https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/Contracts/Allergy.htm"
  ```

### Encounter.htm
- **Local path:** `downloads/greenway/Encounter.htm`
- **File size:** 30,036 bytes (30 KB)
- **File type:** HTML (table definition with field-level detail)
- **Source URL:** `https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/Contracts/Encounter.htm`
- **Curl command:**
  ```
  curl -L -s -o Encounter.htm \
    "https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/Contracts/Encounter.htm"
  ```

---

## 4. Veradigm

### onc-reg-compliance.html
- **Local path:** `downloads/veradigm/onc-reg-compliance.html`
- **File size:** 250,500 bytes (245 KB)
- **File type:** HTML (ONC regulatory compliance page with accordion sections)
- **Source URL:** `https://veradigm.com/legal/onc-reg-compliance/`
- **Curl command:**
  ```
  curl -L -s -o onc-reg-compliance.html \
    -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
    "https://veradigm.com/legal/onc-reg-compliance/"
  ```

### VeradigmEHR_EHI_Export_output_format_documentation_v1.pdf
- **Local path:** `downloads/veradigm/VeradigmEHR_EHI_Export_output_format_documentation_v1.pdf`
- **File size:** 761,262 bytes (744 KB)
- **File type:** PDF document, version 1.5
- **Source URL:** `https://veradigm.com/img/legal/onc/VeradigmEHR_EHI_Export_output_format_documentation_v1.pdf`
- **Curl command:**
  ```
  curl -L -s -o VeradigmEHR_EHI_Export_output_format_documentation_v1.pdf \
    "https://veradigm.com/img/legal/onc/VeradigmEHR_EHI_Export_output_format_documentation_v1.pdf"
  ```

### VeradigmePrescribe_EHI_Export_Documentation_v1.pdf
- **Local path:** `downloads/veradigm/VeradigmePrescribe_EHI_Export_Documentation_v1.pdf`
- **File size:** 684,031 bytes (668 KB)
- **File type:** PDF document, version 1.7 (zip deflate encoded)
- **Source URL:** `https://veradigm.com/img/legal/onc/VeradigmePrescribe_EHI_Export_Documentation_v1.pdf`
- **Curl command:**
  ```
  curl -L -s -o VeradigmePrescribe_EHI_Export_Documentation_v1.pdf \
    "https://veradigm.com/img/legal/onc/VeradigmePrescribe_EHI_Export_Documentation_v1.pdf"
  ```

### VeradigmFMH_EHI_Export_Data_Guide_v2.pdf
- **Local path:** `downloads/veradigm/VeradigmFMH_EHI_Export_Data_Guide_v2.pdf`
- **File size:** 539,373 bytes (527 KB)
- **File type:** PDF document, version 1.4, 29 pages
- **Source URL:** `https://veradigm.com/img/legal/onc/VeradigmFMH_EHI_Export_Data_Guide_v2.pdf`
- **Curl command:**
  ```
  curl -L -s -o VeradigmFMH_EHI_Export_Data_Guide_v2.pdf \
    "https://veradigm.com/img/legal/onc/VeradigmFMH_EHI_Export_Data_Guide_v2.pdf"
  ```

### veradigm-view-ehi-v6-index.html
- **Local path:** `downloads/veradigm/veradigm-view-ehi-v6-index.html`
- **File size:** 249,371 bytes (244 KB)
- **File type:** HTML (EHI Export Documentation v6 with TSV file listings and field specs)
- **Source URL:** `https://veradigm.com/legal/veradigm-view-ehi-export-documentation/v6/index/`
- **Curl command:**
  ```
  curl -L -s -o veradigm-view-ehi-v6-index.html \
    -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
    "https://veradigm.com/legal/veradigm-view-ehi-export-documentation/v6/index/"
  ```

---

## 5. AdvancedMD

### data-export-page.html
- **Local path:** `downloads/advancedmd/data-export-page.html`
- **File size:** 279,039 bytes (273 KB)
- **File type:** HTML (WordPress page with export documentation)
- **Source URL:** `https://www.advancedmd.com/medical-office-software/data-export/`
- **Curl command:**
  ```
  curl -L -s -o data-export-page.html \
    -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
    "https://www.advancedmd.com/medical-office-software/data-export/"
  ```

### advancedmd-dataExport-dataDictionary.pdf
- **Local path:** `downloads/advancedmd/advancedmd-dataExport-dataDictionary.pdf`
- **File size:** 452,887 bytes (443 KB)
- **File type:** PDF document, version 1.7, 6 pages
- **Source URL:** `https://info.advancedmd.com/rs/332-PCG-555/images/advancedmd-dataExport-dataDictionary.pdf`
- **Curl command:**
  ```
  curl -L -s -o advancedmd-dataExport-dataDictionary.pdf \
    -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
    "https://info.advancedmd.com/rs/332-PCG-555/images/advancedmd-dataExport-dataDictionary.pdf"
  ```
- **Notes:** C-CDA/HTML data dictionary. Hosted on Marketo (info.advancedmd.com).

### advancedmd-ehrExport-dataDictionary.pdf
- **Local path:** `downloads/advancedmd/advancedmd-ehrExport-dataDictionary.pdf`
- **File size:** 825,611 bytes (807 KB)
- **File type:** PDF document, version 1.7, 13 pages
- **Source URL:** `https://info.advancedmd.com/rs/332-PCG-555/images/advancedmd-ehrExport-dataDictionary.pdf`
- **Curl command:**
  ```
  curl -L -s -o advancedmd-ehrExport-dataDictionary.pdf \
    -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
    "https://info.advancedmd.com/rs/332-PCG-555/images/advancedmd-ehrExport-dataDictionary.pdf"
  ```
- **Notes:** EHR bulk export data dictionary with SQL table/column definitions (e.g., EHR_Allergies, EHR_Immunizations).

### advancedmd-bulkDataExport-scannedDocsImages.pdf
- **Local path:** `downloads/advancedmd/advancedmd-bulkDataExport-scannedDocsImages.pdf`
- **File size:** 2,191,272 bytes (2.1 MB)
- **File type:** PDF document, version 1.7, 9 pages
- **Source URL:** `https://info.advancedmd.com/rs/332-PCG-555/images/advancedmd-bulkDataExport-scannedDocsImages.pdf`
- **Curl command:**
  ```
  curl -L -s -o advancedmd-bulkDataExport-scannedDocsImages.pdf \
    -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36' \
    "https://info.advancedmd.com/rs/332-PCG-555/images/advancedmd-bulkDataExport-scannedDocsImages.pdf"
  ```
- **Notes:** Scanned documents/images export guidance. Larger due to screenshots.

---

## File Summary Table

| # | Vendor | Filename | Size | Type | Pages |
|---|--------|----------|------|------|-------|
| 1 | athenahealth | ambulatory-clinical-ehi-export.pdf | 523 KB | PDF 1.7 | 10 |
| 2 | NextGen | ehi-data-export-page.html | 172 KB | HTML | — |
| 3 | NextGen | DD_Complete_EHI_20250627.pdf | 27.8 MB | PDF 1.7 | many |
| 4 | Greenway | IntergyEHIExport.html | 9.1 KB | HTML | — |
| 5 | Greenway | DBDescriptions.js | 28 KB | JS | — |
| 6 | Greenway | viewer-index.html | 1.2 KB | HTML | — |
| 7 | Greenway | DBTOC.htm | 1.2 KB | HTML | — |
| 8 | Greenway | Account.htm | 13 KB | HTML | — |
| 9 | Greenway | Allergy.htm | 5.8 KB | HTML | — |
| 10 | Greenway | Encounter.htm | 30 KB | HTML | — |
| 11 | Veradigm | onc-reg-compliance.html | 245 KB | HTML | — |
| 12 | Veradigm | VeradigmEHR_EHI_Export_...v1.pdf | 744 KB | PDF 1.5 | — |
| 13 | Veradigm | VeradigmePrescribe_...v1.pdf | 668 KB | PDF 1.7 | — |
| 14 | Veradigm | VeradigmFMH_...v2.pdf | 527 KB | PDF 1.4 | 29 |
| 15 | Veradigm | veradigm-view-ehi-v6-index.html | 244 KB | HTML | — |
| 16 | AdvancedMD | data-export-page.html | 273 KB | HTML | — |
| 17 | AdvancedMD | advancedmd-dataExport-dataDictionary.pdf | 443 KB | PDF 1.7 | 6 |
| 18 | AdvancedMD | advancedmd-ehrExport-dataDictionary.pdf | 807 KB | PDF 1.7 | 13 |
| 19 | AdvancedMD | advancedmd-bulkDataExport-scannedDocsImages.pdf | 2.1 MB | PDF 1.7 | 9 |

**Combined size of all 19 files: ~35.5 MB** (dominated by the NextGen 27.8 MB PDF)

---

## Integrity Notes

- All files verified with `file` command to confirm correct type (PDF vs HTML).
- All HTTP responses returned status 200.
- athenahealth PDF required `--compressed` flag due to gzip content-encoding.
- No authentication was required for any download.
- NextGen PDF has `x-robots-tag: noindex, nofollow` — intentionally unlisted.
- AdvancedMD PDFs hosted on Marketo CDN (`info.advancedmd.com`).
- Greenway files hosted on AWS S3 via CloudFront (`ehi.greenwayhealth.com`).
