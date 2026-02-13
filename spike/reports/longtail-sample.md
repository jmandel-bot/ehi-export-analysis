# Long-Tail / Smaller EHR Vendor — EHI Export Documentation Survey

**Date:** 2025-07-17  
**Criterion:** ONC Cures Act §170.315(b)(10) Electronic Health Information Export  
**Scope:** 5 smaller/long-tail certified EHR vendors

---

## 1. Nextech — Nextech EHR (IntelleChartPRO)

**URL:** https://www.nextech.com/compliance/ehi-export-documentation  
**Redirects:** None (direct 200 OK)  
**Page type:** HubSpot-hosted HTML marketing/compliance page

### Documentation Format & Accessibility

Nextech provides a **dedicated EHI export documentation landing page** that lists three product lines, each with downloadable PDF documentation and XLSX data dictionaries:

| Product | PDF | XLSX Data Dictionary |
|---------|-----|-----|
| IntelleChartPRO | [EHI Export Documentation](https://www.nextech.com/hubfs/Nextech%20EHR%20(powered%20by%20ICP)%20EHI%20Export%20Documentation.pdf) (335 KB, 6 pages) | [Data Dictionary](https://www.nextech.com/hubfs/Nextech%20EHR%20(powered%20by%20ICP)%20EHI%20Data%20Dictionary-1.xlsx) (40 KB) |
| Nextech Select/NexCloud | [EHI Export Documentation](https://www.nextech.com/hubfs/Nextech%20Select_NexCloud%20EHI%20Export%20Documentation_2025.pdf) | [Data Dictionary](https://www.nextech.com/hubfs/Nextech%20Select_NexCloud%20EHI%20Export%20Data%20Dictionary_2025.xlsx) |
| SRSPro | [EHI Export Documentation](https://www.nextech.com/hubfs/SRSPro%20EHI%20Export%20Documentation_10.30.25_.pdf) | [Data Dictionary](https://www.nextech.com/hubfs/EHI%20Single%20Export%20Data%20Dictionary_10.28.25.xlsx) |

### Content Summary

**PDF (IntelleChartPRO):** 6-page document describing:
- Export produces a **ZIP file** containing JSON, XML (CCDA), and PDF files
- Detailed folder structure: Appointments, Clinical Alerts, Communications, Consents, Demographics, Documents, Encounters, Glaucoma Flowsheet, Insurance & Auth, Laboratory, Letters, Procedures, Referrals, Refractions, Specialty Medications, etc.
- File naming convention using patient name + MRN
- Auditing info for single and bulk exports

**XLSX Data Dictionary (IntelleChartPRO):** 18 worksheet tabs covering every data domain:
- Each tab corresponds to one export file (e.g., `Appointments (JSON)`, `Patient Demographics (JSON)`, `ChartNote (PDF)`)
- Columns: Field Name, Description, Note
- Detail level: **individual field/column level** — e.g., `lastName`, `firstName`, `mi`, `suffix` for demographics
- Largest sheets: Patient Demographics (72 rows), ChartNote (50 rows), Tasking_Microservice (50 rows), Refractions (32 rows)

### Downloadability
- ✅ All files directly curl-able (no auth, no JS required)
- ✅ Standard PDF and XLSX formats
- Ophthalmology-specific domain (refractions, glaucoma flowsheets, retina injection logs)

### Assessment
**Quality: HIGH** — Comprehensive, field-level data dictionary in a structured spreadsheet format. Export uses JSON/XML/PDF with clear folder organization. One of the best-documented smaller vendors.

---

## 2. Netsmart Technologies — myAvatar Certified Edition

**URL:** https://www.ntst.com/lp/certifications  
**Redirects:** None (direct 200 OK)  
**Page type:** HTML certifications portal page

### Documentation Format & Accessibility

The main certifications page is a **hub** listing multiple Netsmart products. Under an "EHI (Electronic Health Information) All Data Export" section, it links to product-specific EHI documentation pages:

- [myAvatar](https://www.ntst.com/lp/certifications/ehi-all-data-myavatar)
- [myEvolv](https://www.ntst.com/lp/certifications/ehi-all-data-myevolv)
- [myHealthPointe](https://www.ntst.com/lp/certifications/ehi-all-data-myhealthpointe)
- [myUnity](https://www.ntst.com/lp/certifications/ehi-all-data-myunity)
- [GEHRIMED](https://www.ntst.com/lp/certifications/ehi-all-data-gehrimed)
- [TheraOffice](https://www.ntst.com/lp/certifications/ehi-all-data-theraoffice)
- [CarePathways](https://www.ntst.com/lp/certifications/ehi-all-data-carepathways)

The **myAvatar EHI page** provides:
- Contextual description of the EHI export functionality
- A **downloadable ZIP file** containing the full documentation

**ZIP file:** [EHI_Export_All_Tables_myAvatar_September_2023.zip](https://www.ntst.com/-/media/pdfs/certifications/EHI_Export_All_Tables_myAvatar_September_2023.zip) (12.5 MB)

Contains: **"EHI Export All Tables - September 2023.pdf"** — a single massive PDF

### Content Summary

The PDF is **7,492 pages** (16 MB) — an exhaustive database-level data dictionary covering:
- Every form and database table in the myAvatar system
- Format: `SYSTEM.<table_name>` with column-level detail
- Each column entry includes: Column Name, Column Type, Max Length, Description
- Example tables: `cf_acct_recurring_entries`, `cf_acct_transaction_detail`, `AppointmentData`, `appt_data`, `allergies`, `check_in_clients`, `telehealth_appt`, etc.
- Organized by form → table mapping (e.g., "Documentation for form: Scheduling_Calendar → Table Name: SYSTEM.AppointmentData")

The EHI page also mentions:
- Export outputs **computable, delimited file format** native to myAvatar
- Each table exported to its own file
- Rich text documents and images referenced separately
- Integration options via FHIR APIs and HL7 also mentioned (separate from b(10) export)

### Downloadability
- ✅ ZIP directly curl-able from the media CDN
- ✅ Standard PDF inside ZIP
- ⚠️ 12.5 MB download, 16 MB PDF, 7,492 pages — extremely large

### Assessment
**Quality: VERY HIGH** — The most exhaustive documentation in this sample. Full database schema at the column level with types and descriptions for every table. Behavioral health / human services focused (myAvatar serves mental health, substance abuse, etc.). The sheer volume (7,492 pages) reflects the complexity of the platform.

---

## 3. CareCloud — talkEHR

**URL:** https://www.talkehr.com/cost-and-fees-information  
**Redirects:** None (direct 200 OK)  
**Page type:** Webflow-hosted HTML page (cost, fees, and certification info)

### Documentation Format & Accessibility

The page is a **combined cost/fees/certification disclosure page** that lists all certified criteria, CQMs, software dependencies, and includes a link to the EHI export documentation PDF at the bottom:

**PDF:** [talkEHR §170.315(b)(10) Electronic Health Information Export - Documentation](https://cdn.prod.website-files.com/6040fac6832b627ac2ffc9ad/6553a43229cacaf138511818_talkEHR%20Certification%20-%20%C2%A7170.315(b)(10)%20Electronic%20Health%20Information%20Export%20-%20Documentation.pdf) (1.1 MB, 12 pages)

### Content Summary

The 12-page PDF covers:
- **Overview:** talkEHR supports EHI export via CCD (C-CDA) format for clinical data + PDF format for other data
- **Single Patient Export:** Via CCDA Export Tab — generates XML download
- **Bulk Patient Export:** Via Data Portability Tab — generates ZIP of CCDA XML files
- **CCD Output Format:** References HL7 CDA R2 Consolidated CDA (US Realm Draft STU 2.1, August 2015)
- **CCD Sections:** Table mapping Data Elements → XPATH/Entry → Code System → Code System Name for:
  - Allergies, Medications, Problems, Procedures, Results, Vital Signs, Immunizations, Social History, Plan of Treatment, Goals, Assessment, Functional Status, Health Concerns
- **Non-CCD data exported as PDF:** Demographics/Insurance, Advance Directives, Appointments, Provider-to-Patient Messages, Billing Data (CPT/ICD/Modifier), Documents (progress notes, lab results, radiology reports, scanned docs)
- **FHIR Data Export:** Mentions FHIR DocumentReference and Bulk Data support for population export
- **Organizational structure** of export files

### Downloadability
- ✅ PDF directly curl-able from Webflow CDN
- ✅ Standard PDF format
- The main page requires scrolling to find the EHI link (it's near the bottom in the footer area)

### Assessment
**Quality: MODERATE** — Provides a reasonable overview with CCD section-level mapping (XPATH entries and code systems). However, much of the non-clinical data (demographics, billing, appointments) is just exported as PDF with no structured format documentation — described in one-line vague statements like "comprehensive view of appointments, structured for clarity." The CCD portion has decent technical detail.

---

## 4. TruBridge — TruBridge EHR

**URL:** https://ehi-export.plt.trubridge.com/  
**Redirects:** None (direct 200 OK)  
**Page type:** Custom-built **static web application** (HTML + CSS + Web Components via Lit)

### Documentation Format & Accessibility

TruBridge has a **dedicated documentation web app** with a left-nav sidebar and multi-page structure. It covers two products:
- **TruBridge EHR** (9 versions: v2105 through v2203)
- **Centriq**

For **TruBridge EHR v2203** (latest), the documentation is organized into sections:

| Category | Sub-pages |
|----------|----------|
| Clinical Data | Ancillary Transcriptions, Electronic Forms, Escribe Messages, Home Health, Medical Records Transcriptions, Medication History, Point of Care Reports |
| Full Database Export | Complete JSON database export documentation |
| Images and Documents | Digital Signature, Electronic File Maintenance, File Index, Patient Data, VDMS |
| Insurance and Eligibility | Escribe ePA, Escribe 271, Patient Connect 271, Real Time Benefit, TruBridge EHR 271 Format |

### Content Summary

**Overview page:** Describes four export categories with file naming convention (`RepoCode_SPID_PROFILE_VISIT_TITLE_CREATIONDATE_CREATIONTIME_KEY`).

**Full Database Export page:** Lists **~465 database tables** alphabetically (A through Z), each with:
- Table name and description
- Field-level detail: field name + description for every column
- Example: `allergies1` table = "Patient Allergy Record" with fields like `alg1_severity` ("Severity Code"), `alg1_patnum` ("Person Profile Number"), `alg1_last_updated` ("Allergies Last Updated Timestamp")
- Export format: **JSON** with defined schema

Tables span the full EHR domain: allergies, appointments, AR charges, blood sugar documentation, care plans, census, clinical reconciliation, diagnoses, drug use history, immunizations, lab orders, medications, nursing assessments, pharmacy orders, vitals, etc.

### Downloadability
- ✅ All pages are static HTML, directly curl-able
- ✅ No authentication required
- ⚠️ No single PDF or downloadable archive — it's an HTML web app you browse
- ⚠️ Version-specific — each EHR version has its own documentation tree
- The site uses Web Components (Lit library) for navigation, but content renders in plain HTML

### Assessment
**Quality: VERY HIGH** — One of the most professionally structured EHI documentation sites. Dedicated web app with versioned documentation, ~465 tables with field-level descriptions. The database export is JSON-formatted. Hospital/acute-care focused (AR charges, census, pharmacy, nursing). Unique in providing version-by-version documentation.

---

## 5. Eye Care Leaders / SightView — MDoffice

**URL:** https://sightview.com/about-sightview/onc-certification/  
**Redirects:** `sightview.com` → `www.sightview.com` (1 redirect)  
**Page type:** HubSpot-hosted HTML page

### Documentation Format & Accessibility

The ONC Certification page serves as a **hub for multiple SightView/Eye Care Leaders products**, each with its own EHI data dictionary PDF:

| Product | Data Dictionary PDF |
|---------|----|
| My Vision Express | [PDF](https://www.sightview.com/hubfs/Sightview%20Disclosures/My%20Vision%20Express%20EHI%20Export%20Data%20Dictionary.pdf) |
| iMedicWare | [PDF](https://www.sightview.com/hubfs/Sightview%20Disclosures/iMedicWare%20EHI%20Data%20Dictionary.pdf) |
| ManagementPlus | [PDF](https://www.sightview.com/hubfs/Sightview%20Disclosures/ManagementPlus%20EHI%20Data%20Dictionary.pdf) |
| **MDoffice** | [PDF](https://www.sightview.com/hubfs/Sightview%20Disclosures/MDoffice%20EHI%20Export%20Data%20Dictionary.pdf) (707 KB, 49 pages) |
| Medflow | [PDF](https://www.sightview.com/hubfs/Sightview%20Disclosures/Medflow%20EHI%20Export%20Data%20Dictionary.pdf) |

There's also an older MDoffice 12.1 Data Dictionary from CloudFront CDN (831 KB, 48 pages).

### Content Summary (MDoffice EHI Export Data Dictionary, v2.0)

49-page PDF organized by folder structure of the export ZIP file:

**Export format:** Two ZIP files — `ehi_structured_file` (discrete data in CSV) and `ehi_unstructured_file` (documents/images)

**Structured data folders and CSV files:**
- **Administration:** Care Team Members, Facility, Insurance Data, Organization, Patient Demographics, Previous Details, Patient Relations, Authorizations, Referrals, Work Information
- **Clinical:** Allergies, Family Health History, Functional Assessment, Goals, Health Concerns, Immunizations, Implantable Devices, Medications, Problems, Procedures, Smoking Status, Substance Use, Vitals
- **Clinical Notes:** Progress Notes
- **Diagnostic Imaging:** Ascan, Bscan, External Anterior, Fundus, GDX, Gonio, HRT (ophthalmology-specific)
- **Examination:** AR, Contact Lens, IOP, Cycloplegic, Glasses Prescription, Refraction, Retinoscopy, Vision Distance/Near Acuity

Each CSV file is documented with:
- File name
- Column names with descriptions
- Example: `Care_Team_Members.csv` → columns: `PATIENT_ID`, `DATE_OF_SERVICE`, `CARE_TEAM`, `USER_TYPE`, `Comments`

**Ophthalmology-specific data domains** are heavily represented (IOP, refractions, retinoscopy, gonioscopy, etc.)

### Downloadability
- ✅ All PDFs directly curl-able from HubSpot CDN
- ✅ Standard PDF format
- Multiple products documented separately
- Includes legal disclaimers about data security responsibilities

### Assessment
**Quality: HIGH** — Well-structured field-level documentation for CSV-based exports. Ophthalmology/optometry specialty focus is well-documented with domain-specific data elements. The CSV format is practical for data portability. Covers 5 different products under the SightView umbrella.

---

## Summary Comparison

| Vendor | Format | Detail Level | Pages/Size | Export Format | Directly Downloadable | Specialty Focus |
|--------|--------|-------------|------------|---------------|----------------------|----------------|
| **Nextech** | PDF + XLSX | Field-level | 6 pg + 18 tabs | JSON/XML/PDF ZIP | ✅ Yes | Ophthalmology |
| **Netsmart** | PDF in ZIP | Column-level w/ types | 7,492 pages | Delimited files | ✅ Yes | Behavioral health |
| **CareCloud/talkEHR** | PDF | Section/XPATH-level | 12 pages | CCD XML + PDF | ✅ Yes | General ambulatory |
| **TruBridge** | HTML web app | Field-level | ~465 tables | JSON + native files | ✅ (HTML only) | Hospital/acute care |
| **SightView/MDoffice** | PDF | Column-level | 49 pages | CSV in ZIP | ✅ Yes | Ophthalmology/Optometry |

### Key Observations

1. **All 5 vendors have publicly accessible EHI export documentation** — no authentication or gating required.

2. **Documentation depth varies dramatically:**
   - Netsmart's 7,492-page PDF is the most exhaustive (full database schema)
   - TruBridge's web app with ~465 tables is also very comprehensive
   - CareCloud/talkEHR's 12-page document is the thinnest, relying heavily on CCD standard references

3. **Export formats differ significantly:**
   - JSON (Nextech, TruBridge)
   - CSV (SightView/MDoffice)
   - CCD/C-CDA XML (CareCloud/talkEHR, Nextech)
   - Delimited files (Netsmart)
   - PDF for unstructured data (all vendors)

4. **Specialty focus drives content:**
   - Ophthalmology vendors (Nextech, SightView) include specialized data like refractions, IOP, retinal imaging
   - Behavioral health (Netsmart) has extensive form/table mappings
   - Hospital/acute (TruBridge) includes AR charges, pharmacy, nursing documentation

5. **Structured data dictionaries (XLSX, CSV definitions) are the most useful** for automated processing — Nextech and SightView/MDoffice excel here.

6. **No vendor provides structured download formats** (JSON schema, CSV data dictionary as CSV) — all documentation is in PDF or XLSX, requiring human interpretation.

7. **Version management:** TruBridge is unique in maintaining version-specific documentation (9 EHR versions documented separately). Others appear to maintain a single current version.
