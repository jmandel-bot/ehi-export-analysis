# Azara Healthcare, LLC — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10733
- Registered URL: https://azaracdn.blob.core.windows.net/documentation/DRVS_Export_Formats.pdf
- Developer: Azara Healthcare, LLC
- Product: Azara DRVS (version DRVS 33)

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://azaracdn.blob.core.windows.net/documentation/DRVS_Export_Formats.pdf" -H 'User-Agent: Mozilla/5.0'
```

Result:
```
HTTP/1.1 200 OK
Content-Length: 73898
Content-Type: application/pdf
Last-Modified: Mon, 13 Nov 2023 14:46:54 GMT
ETag: 0x8DBE45761192833
Server: Windows-Azure-Blob/1.0 Microsoft-HTTPAPI/2.0
x-ms-blob-type: BlockBlob
```

Direct PDF download — no redirects, no auth, no anti-bot protection. The registered URL is a direct link to a PDF hosted on Azure Blob Storage (azaracdn.blob.core.windows.net). Content-Type is `application/pdf`, 73,898 bytes. No content-disposition header (inline display rather than forced download).

### Step 2: Download

```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o downloads/DRVS_Export_Formats.pdf \
  "https://azaracdn.blob.core.windows.net/documentation/DRVS_Export_Formats.pdf"
```

Verified:
- `file downloads/DRVS_Export_Formats.pdf` → PDF document, version 1.7, 1 page(s)
- Size: 73,898 bytes
- `pdfinfo` metadata:
  - Author: Kristen Jones
  - Creator: Microsoft Word for Microsoft 365
  - Created: Mon Nov 13 08:46:28 2023
  - Pages: 1
  - Not encrypted

### Step 3: Content examination

The PDF is a single page. Full text extracted via `pdftotext`:

> **Azara Healthcare**
> **170.315(b) (10) Electronic Health Information Export**
>
> Azara DRVS provide export of electronic health information (EHI) for a single patient as well as for patient population in the following formats:
>
> 1. CCDA: DRVS supports bulk export of HL7 CCDA xml files which comply to United States Core Data for Interoperability (USCDI), Version 1 requirements.
>    - References three HL7 C-CDA implementation guides (2012, 2015/2019, 2019)
>
> 2. FHIR: **iPatientCare** also supports HL7 Version 4.0.1 FHIR Release 4, October 30, 2019, FHIR US Core Implementation Guide STU V2.0.1, HL7 FHIR Bulk Data export. Please refer 170.315(g)(10) SmartOnFHIR API Documentation.PDF for the API Specifications.

**Critical observation:** Section 2 references "iPatientCare" — a completely different EHR product (owned by AssureCare LLC). This is a copy-paste error. The document was evidently templated from iPatientCare's own 170.315(b)(10) certification documentation, and the product name was not updated in section 2. This raises serious questions about whether the documentation accurately describes what Azara DRVS actually does.

### Step 4: No further navigation needed

This was a direct PDF link. No SPA, no accordion, no multi-page navigation. The entire documentation is contained in a single one-page PDF.

## Downloads

### DRVS_Export_Formats.pdf (73,898 bytes)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/DRVS_Export_Formats.pdf \
  'https://azaracdn.blob.core.windows.net/documentation/DRVS_Export_Formats.pdf'
```
Verified: `file downloads/DRVS_Export_Formats.pdf` → PDF document, version 1.7
Pages: 1
Author: Kristen Jones
Created: 2023-11-13
Saved to: downloads/DRVS_Export_Formats.pdf

## Obstacles & Notes

- **No obstacles accessing the documentation.** Direct Azure Blob Storage link, no auth, no anti-bot.
- **The documentation is a single page.** This is among the shortest EHI export documentation encountered. There is no data dictionary, no table listing, no field definitions, no schema documentation — just a statement that two export formats are supported (C-CDA and FHIR).
- **Copy-paste error from iPatientCare.** The FHIR section names "iPatientCare" instead of "Azara DRVS," indicating this document was copied from iPatientCare's (AssureCare LLC's) certification documentation without proper editing. iPatientCare is an unrelated ambulatory EHR product.
- **No separate SmartOnFHIR API Documentation.PDF found.** The document references a companion file "170.315(g)(10) SmartOnFHIR API Documentation.PDF" but this file was not linked or discoverable at the same Azure Blob Storage path.

---

## Product: Azara DRVS

### Product Context

Azara DRVS (Data Reporting and Visualization System) is a **population health analytics and reporting platform** — it is **not an EHR**. DRVS sits on top of EHR systems, aggregating clinical data, claims data, practice management data, and ADT (Admission/Discharge/Transfer) data from 40+ different EHR systems into a normalized, unified view with a Master Patient Index.

**Primary customers:** Federally Qualified Health Centers (FQHCs), Primary Care Associations (PCAs), Health Center Controlled Networks (HCCNs), and ACOs. The platform serves 1,000+ organizations across all 50 states, impacting care for 50+ million patients.

**What DRVS stores:**
- Aggregated clinical data: diagnoses, medications, lab results, immunizations, care gaps, chronic conditions
- Claims data for cost/utilization analysis
- Practice management data (provider productivity)
- ADT data from HIE feeds (admissions, ED visits, transitions of care)
- Referral tracking data
- Specialty modules: maternal/OB, dental, behavioral health, substance use, infectious disease
- Social determinants of health (SDOH) data
- Risk stratification scores
- Patient survey/satisfaction data

**What DRVS does NOT have:**
- No patient portal (has SMS-based patient outreach, but no portal messaging)
- No billing/revenue cycle management (has a "FinOps" analytics module that monitors billing workflows, but is not a transactional billing system)
- No scheduling system (consumes practice management data but doesn't provide scheduling)
- No document management/scanning
- No order entry, prescribing, or clinical documentation

**Corporate history:** Azara merged with SPH Analytics' population health division in December 2020. In February 2025, Azara acquired i2i Population Health. The company is backed by Hughes & Company and Insight Partners.

### Export Approach

The EHI export documentation describes two formats:

1. **C-CDA XML export** — "bulk export of HL7 CCDA xml files" compliant with USCDI Version 1. This is the primary described export mechanism for DRVS itself.

2. **FHIR R4 Bulk Data export** — referenced in the document but attributed to "iPatientCare" (copy-paste error), pointing to a separate API documentation PDF. This likely does not apply to DRVS at all.

**This is fundamentally a C-CDA-only export.** The FHIR section appears to be copied text and the referenced API documentation file is not available at the Azara CDN. C-CDA is a clinical summary standard — it covers a subset of clinical data (diagnoses, medications, allergies, labs, immunizations, procedures, vital signs) but inherently cannot represent:

- Aggregated population-level analytics and quality measures
- Risk stratification scores
- Care gap analyses
- Claims/cost data
- SDOH data in its full structured form
- Specialty module data (dental, maternal, substance use)
- Survey/satisfaction data
- Cross-EHR Master Patient Index linkages

This creates a fundamental mismatch: DRVS stores aggregated population health analytics data, but exports it through a format designed for individual clinical summaries.

### EHI Coverage Assessment

| Category | Present? | Evidence |
|----------|----------|----------|
| Clinical | Partially | C-CDA would include diagnoses, medications, allergies, labs, immunizations, vitals, procedures from the aggregated data. However, DRVS's specialty module data (dental, maternal/OB, substance use, infectious disease) likely exceeds what C-CDA can represent. |
| Secure messages | N/A | DRVS does not have messaging functionality. Has SMS-based patient outreach but not a messaging system that stores conversation history. |
| Billing/financial | No | DRVS stores claims data and has a FinOps analytics module, but C-CDA has no billing/financial sections. No other export mechanism described. |
| Insurance/coverage | No | Not mentioned in export documentation. DRVS may store some insurance data from aggregated sources, but C-CDA does not support this. |
| Appointments/scheduling | No | DRVS does not have scheduling but may store encounter/visit data from aggregated EHR feeds. C-CDA encounter sections are limited. |
| Documents/images | No | DRVS is not a document management system. |
| Audit trails | No | No audit trail export mentioned. |

### Issues & Red Flags

1. **Copy-paste documentation from unrelated vendor.** The FHIR section of the EHI export documentation names "iPatientCare" (an AssureCare LLC product) instead of Azara DRVS. This indicates the documentation was templated from another vendor's certification materials and not properly reviewed. This undermines confidence in the accuracy of any claims made in the document.

2. **One-page documentation with zero technical detail.** The entire EHI export specification is a single page with no data dictionary, no field definitions, no schema documentation, and no examples. There is no information about what data elements are included in the C-CDA exports, what sections are populated, or how DRVS's unique data (quality measures, risk scores, care gaps, claims analytics) is represented.

3. **C-CDA format mismatch.** DRVS is a population health analytics platform that stores aggregated data from 40+ EHR systems — including claims, quality measures, risk scores, care gaps, SDOH, and specialty-specific data. C-CDA is a clinical summary standard that cannot represent most of this data. The export format fundamentally cannot capture the full scope of EHI that DRVS stores.

4. **Missing companion documentation.** The document references "170.315(g)(10) SmartOnFHIR API Documentation.PDF" for FHIR specifications, but this file is not available at the same CDN location and no URL is provided.

5. **USCDI Version 1 only.** The documentation references USCDI Version 1 (the initial, most limited version), despite being authored in November 2023 when USCDI v3 was current.

6. **Documentation last updated November 2023 — over 2 years old.** No evidence of updates since initial creation.

7. **Unclear what data is actually exported.** Since DRVS aggregates data from multiple EHR systems, it's unclear whether the C-CDA export represents the raw aggregated data, a deduplicated view, quality measure results, or something else entirely. The documentation provides no clarity on this.
