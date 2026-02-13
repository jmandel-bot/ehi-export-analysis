# Outpatient EHR Vendor EHI Export Documentation Report

**Date:** 2026-02-13  
**Certification Criterion:** 170.315(b)(10) — Electronic Health Information Export  
**Scope:** Major outpatient/ambulatory EHR vendors

---

## 1. athenahealth — athenaClinicals

**URL:** https://docs.athenahealth.com/athenaone-dataexports/

### Documentation Format & Accessibility
- **Format:** JavaScript Single Page Application (SPA) — a dedicated documentation portal built with React/custom framework (`document-portal-ui`). Content is **not** accessible via simple curl; requires full browser JavaScript execution.
- **Downloadable PDF:** A downloadable PDF version is available at `https://docs.athenahealth.com/downloads/exports-ambulatory-clinical-ehi-export` (served as `application/pdf`, gzip-compressed). The link text says "Ambulatory Clinical EHI Export" with a download icon.
- **Navigation Structure:** Left sidebar with sections:
  - Overview → EHI Exports Overview
  - **Ambulatory EHI Exports** → Clinical EHI Export, Collector EHI Export
  - **Inpatient EHI Exports** → Clinical EHI Export, Collector EHI Export
  - Updates → Release Notes

### Content Summary
- **Extremely detailed and well-organized.** The Ambulatory Clinical EHI Export page includes:
  - Explanation of EHI and what's included/excluded
  - **File Formats** section
  - **General Instructions** for processing files and reconciling datasets
  - **Clinical EHI Export Dataset List & Specifications** — a comprehensive table listing ~60+ datasets by name (e.g., Admin Documents, Allergies, Assessment and Plan, Cancer Cases, Care Plan, Care Team Members, Chief Complaint, Clinical Documents, Encounters, Family History, Immunizations, Lab Results, Medications, Observations/Vitals, Orders, Procedures, Social History, Surgical History, etc.)
  - Each dataset links to the **athenahealth API Reference** showing field-level detail with: **field name, data type, and description** (e.g., the Allergies dataset shows `showinactive` (boolean), `THIRDPARTYUSERNAME` (string), output parameters like `lastmodifiedby` (string), `lastmodifieddatetime` (string), etc.)
  - Folder structure and naming conventions
  - Care Plan Events and Eye Care Measurements specifications
- **Export types:** Single patient, multi-patient, and bulk patient export
- **Data format:** JSON files from API endpoints; datasets reference athenahealth API fields

### Downloadability Assessment
- ⚠️ The SPA requires a browser to view. Cannot be scraped with curl alone.
- ✅ A downloadable PDF consolidation is available.
- ✅ Individual dataset specs link to the public API documentation which provides curl examples.

### Notable Observations
- This is one of the most comprehensive and well-structured EHI export documentation sites among all vendors.
- The data model maps directly to athenahealth's REST API endpoints.
- Field-level specifications include data types and descriptions.
- The documentation portal is public — no authentication required.

---

## 2. NextGen Healthcare — NextGen Enterprise EHR

**URL:** https://www.nextgen.com/sldkjljieo0935jljsrnfkl

### Documentation Format & Accessibility
- **Format:** Standard HTML page on nextgen.com, rendered server-side (content accessible via curl, despite the obfuscated URL path).
- **Primary Asset:** A single massive **PDF data dictionary** — `DD_Complete_EHI_20250627.pdf` — **29.2 MB** (29,204,519 bytes)
  - Direct download URL: `https://www.nextgen.com/-/media/files/legal/2025/DD_Complete_EHI_20250627`
  - Served as `application/pdf` with `content-disposition: inline; filename="DD_Complete_EHI_20250627.pdf"`
  - Dated June 27, 2025
  - Has `x-robots-tag: noindex, nofollow` (intentionally hidden from search engines)

### Content Summary
- The page is titled **"EHI Data Export"** and covers multiple NextGen products:
  1. **NextGen® Enterprise EHR** — Database dictionary defining the schema of exported tables and data elements. Available in v6.2021.1 Cures and higher. Schema varies by specialty/version.
  2. **NextGen® Office** — EHI export as ZIP archive containing CCDA (XML), CSV, binary files (images/PDFs), and HTML files.
  3. **NextGen® Direct Messaging** — EHI export as ZIP archive with CDA (XML) and binary files. Version 2.14+.
  4. **Mirth Connect** — Export of messages with attachments in XML format.
- **Key details:**
  - Data is "presented in a machine-readable format"
  - Database dictionaries "outline the structure of each exported table and its corresponding data elements"
  - Images, documents, reports, and audio files are referenced in tables but located in separate folders

### Downloadability Assessment
- ✅ The HTML page is publicly accessible and readable via curl.
- ✅ The 29 MB PDF data dictionary is directly downloadable via curl.
- The obfuscated URL (`sldkjljieo0935jljsrnfkl`) works and serves a fully functional page — it appears to be an intentionally unlisted but valid path.

### Notable Observations
- The 29 MB PDF is extremely large, suggesting a very comprehensive database dictionary with many tables and fields.
- The page covers 4 different NextGen products on one page.
- The obfuscated URL path is a common pattern for complying with ONC's publication requirement while not making the page easily discoverable.

---

## 3. Greenway Health — Intergy EHR

**URL:** https://ehi.greenwayhealth.com/Intergy/IntergyEHIExport.html

### Documentation Format & Accessibility
- **Format:** Static HTML pages hosted on AWS S3/CloudFront. Fully accessible via curl — no JavaScript required for the main page.
- **Data Tables Viewer:** An interactive HTML frameset at `https://ehi.greenwayhealth.com/Intergy/EHI/Viewer/index.html` containing:
  - Left iframe: Table of contents with searchable list (`DBTOC.htm`)
  - Right iframe: Individual table detail pages (e.g., `Account.htm`)
  - Table definitions loaded from `DBDescriptions.js`

### Content Summary
- **261 database tables** documented with descriptions, loaded from a JavaScript file (`DBDescriptions.js`)
- **Field-level detail** for each table includes: Field Name, Datatype (e.g., INTEGER, CHARACTER(10)), Default Value, Null Option (MANDATORY/etc.), and Comment/Description
- **Parent/Child table relationships** documented for each table
- **Version info:** Intergy Version 22.00.00.00, last updated 9/24/2025
- **Export types:**
  - **Single Patient Export:** Documents folder (clinical documents, images), Images folder (X-rays with annotations in TIF/video/XML), Tables folder (CSV format)
  - **Patient Population Export:** Documents (GenFileBlob, TMSCatalogBlob, PracPersonSecureMsgBlob — 10K doc limit per folder), Images (TAR format, 5GB limit per tar), Tables (CSV), Bulk Export Status file
- **Sample tables:** Account, Allergy, Appointment, Carrier, Charge, Claim, Encounter, EncounterFinding, EncounterVital, LabOrder, LabOrderTestResult, Medication, etc.
- **Clinical coding:** MEDCIN findings documented for pregnancy (finding 30596) and smoking status (finding 100000511) with SNOMED code mappings
- **Minimum supported version:** Intergy 21.24.00.00

### Downloadability Assessment
- ✅ Main page fully accessible via curl.
- ✅ Table definitions accessible via curl (JS file + individual HTML table pages).
- ✅ All content is static HTML/JS — no authentication required.
- ✅ Individual table pages can be fetched directly (e.g., `Contracts/Account.htm`).

### Notable Observations
- One of the most transparent and technically detailed EHI documentation sites.
- The database-level schema documentation (261 tables with full field specs) is exceptionally thorough.
- Export format is CSV for data tables, with separate folders for documents and images.
- The TMSCatalogBlob → TMSCatalog.csv mapping is well-documented with examples.
- Hosted on a dedicated subdomain (`ehi.greenwayhealth.com`) showing organizational commitment.

---

## 4. Veradigm (formerly Allscripts Practice Solutions)

**URL:** https://veradigm.com/legal/onc-reg-compliance/

### Documentation Format & Accessibility
- **Format:** HTML page with accordion sections. The EHI Export Documentation is in accordion section #6. Accessible via curl.
- **Multiple products documented with separate assets:**

| Product | Format | Size | Link |
|---------|--------|------|------|
| Veradigm EHR | PDF | 684 KB | `/img/legal/onc/VeradigmEHR_EHI_Export_output_format_documentation_v1.pdf` |
| Veradigm ePrescribe | PDF | 539 KB | `/img/legal/onc/VeradigmePrescribe_EHI_Export_Documentation_v1.pdf` |
| Veradigm FollowMyHealth | PDF (v2) | 324 KB | `/img/legal/onc/VeradigmFMH_EHI_Export_Data_Guide_v2.pdf` |
| Veradigm FollowMyHealth | HTML (v1) | — | `https://fhir.followmyhealth.com/documentation/EHIExportDocumentation/v1` |
| Veradigm Practice Management | PDF (v2) | — | `/img/legal/onc/EHIDataExportFile_ReferenceGuide_VeradigmPM_V2.pdf` |
| Veradigm View | HTML (v1–v6) | 249 KB each | `/legal/veradigm-view-ehi-export-documentation/v6/index/` |

### Content Summary
- **Veradigm View (v6)** is the most detailed, with an interactive HTML documentation site:
  - Describes TSV (tab-separated value) file format export
  - Lists export files organized by category (Demographics, Patient, etc.)
  - Each TSV file links to a detail page with **field-level specifications**: Field Name, Data Type, and Field Description
  - Example fields for `patient-demographics.tsv`: FirstName (String), MiddleName (String), LastName (String), NameSuffix (String), PreferredName (String), Gender (String), BirthDate (DateTime?), etc.
  - Files include: `patient-appointments.tsv`, `patient-contacts.tsv`, `patient-demographics.tsv`, `patient-ethnicity.tsv`, `patient-financial-resources.tsv`, `patient-gender-identity-sexual-orientation.tsv`, `patient-race.tsv`, `tribal-affiliation.tsv`, `patient-documents.tsv`, `patient-questionnaire.tsv`, etc.
- **Versioning:** Veradigm View has 6 versions documented (v1 through v6, spanning April 2025 to January 2026), showing active maintenance.
- **ONC compliance page** also includes: compliance certificates, cost documentation, API fees, Real World Testing plans/reports, and an information blocking complaint form.

### Downloadability Assessment
- ✅ ONC compliance page accessible via curl.
- ✅ All PDF documents directly downloadable via curl with `download` attribute.
- ✅ Veradigm View HTML documentation accessible via browser (standard HTML, mostly curl-accessible).
- ✅ Cost spreadsheets (XLSX) also downloadable.

### Notable Observations
- Veradigm covers 5+ separate certified products, each with its own EHI documentation.
- The Veradigm View documentation is the most modern, with versioned HTML pages and field-level detail.
- The FollowMyHealth v1 documentation is hosted on a FHIR-related subdomain, suggesting FHIR-aligned data.
- Strong versioning practices with dated publications.

---

## 5. AdvancedMD

**URL:** https://www.advancedmd.com/medical-office-software/data-export/

### Documentation Format & Accessibility
- **Format:** WordPress-hosted HTML page (WP Engine). Content is primarily rendered server-side and largely accessible via curl.
- **Downloadable PDFs (4 documents):**

| Document | Size | URL |
|----------|------|-----|
| C-CDA/HTML Data Dictionary | 453 KB | `https://info.advancedmd.com/rs/332-PCG-555/images/advancedmd-dataExport-dataDictionary.pdf` |
| EHR Bulk Export Data Dictionary | 826 KB | `https://info.advancedmd.com/rs/332-PCG-555/images/advancedmd-ehrExport-dataDictionary.pdf` |
| Scanned Doc/Images Guidance | 2.1 MB | `https://info.advancedmd.com/rs/332-PCG-555/images/advancedmd-bulkDataExport-scannedDocsImages.pdf` |
| Data Export Flyer | 36 KB | `https://info.advancedmd.com/rs/332-PCG-555/images/advancedmd-flyer-dataExport.pdf` |

### Content Summary
- **Single Patient Export Options:**
  1. **Patient Transaction Report** — CSV export from PM Report Center. Header: Patient, Birthdate, Chart Number, Email. Body: Visit Number, Date of Service, Charge Code, Transaction Code, Modifiers, Primary Diagnosis, Payment Method, etc.
  2. **Patient Visit Summary Report** — CSV export with visit details including Charge Code Description, Diagnosis Codes, Modifiers, Carrier, Copay, Provider Name, Facility, Appointment Date/Time/Type
  3. **EHR Data Portability Export Tool** — C-CDA XML file + HTML supplement following USCDI v1 (Allergies, Medications, Problems, Procedures, Results, Vital Signs, Assessments, Goals, Health Concerns, Immunizations, Social History, etc.)
  4. **EHR Patient Chart Print Tool** — PDF export of clinical notes, word merge summaries, messages

- **Bulk Patient Export Options (require developer assistance):**
  1. **Practice Management Data Export** — Microsoft Access database file (.mdb) with demographics, transactions, appointments, charges, payments, write-offs, provider info, carrier info
  2. **Scanned Documents & Images** — Folder structure with index files sorted by date
  3. **EHR Bulk Data Export** — SQL Server database (.bak file) containing allergies, immunizations, messages, diagnoses, prescriptions, lab results, notes, and Word Merge templates

- **EHR Bulk Export Data Dictionary** content (from PDF): Field-level detail with table names (e.g., `EHR_Allergies`, `EHR_Immunizations`) and columns with descriptions. Example: `EHR_Allergies` table has columns: LicenseKey, AllergyID, PatientID, AllergyName, AllergyStartDate, AllergyReaction, AllergyTreatment, AllergyStatus, AllergyNoKnownAllergies, AllergyCategoryID, CreatedBy, CreatedAt, ChangedBy, ChangedAt.

- **C-CDA Data Dictionary** content (from PDF): Maps C-CDA sections to source fields, vocabulary codes (RxNorm, SNOMED, ICD-10, CPT, LOINC), and implementation notes.

- Also has a **"Download Desk Guide"** button and **ODBC** direct read-only database access option.

### Downloadability Assessment
- ✅ Main page accessible via curl (WordPress).
- ✅ All 4 PDFs directly downloadable via curl from Marketo/info.advancedmd.com CDN.
- ✅ No authentication required.
- The PDFs are hosted on Marketo (marketing automation) which may occasionally require cookies.

### Notable Observations
- Export formats are diverse: CSV, C-CDA XML, Microsoft Access (.mdb), SQL Server backup (.bak), PDF, ODBC
- Bulk exports **require developer assistance** — not self-service
- The EHR bulk export uses SQL Server `.bak` files, which requires SQL Server Management Studio to restore — a significant technical barrier
- The page doubles as a marketing/product page with demo request forms
- Data dictionary PDFs provide table and column-level detail with descriptions
- Includes an ODBC option for direct read-only database access (unique among vendors surveyed)

---

## Summary Comparison

| Vendor | Format | Detail Level | # Tables/Datasets | Curl-Accessible | Self-Service |
|--------|--------|-------------|-------------------|-----------------|-------------|
| **athenahealth** | SPA + downloadable PDF | Field-level (name, type, description) | ~60+ datasets | ⚠️ SPA needs browser; PDF downloadable | Yes (single/multi/bulk) |
| **NextGen** | HTML page + 29MB PDF | Database schema-level | Extensive (29MB PDF) | ✅ Full | Yes (v6.2021.1+) |
| **Greenway (Intergy)** | Static HTML + JS viewer | Field-level (name, datatype, null, comment) | 261 tables | ✅ Full | Yes |
| **Veradigm** | HTML + PDFs (multiple products) | Field-level for View; varies by product | Varies by product | ✅ Full | Yes |
| **AdvancedMD** | WordPress page + PDFs | Table/column-level | ~10-15 EHR tables | ✅ Full | Partial (bulk needs dev) |

### Export Data Formats by Vendor

| Vendor | Export Format(s) |
|--------|------------------|
| athenahealth | JSON (API-based) |
| NextGen Enterprise | Database tables (machine-readable), CCDA XML, CSV, binary |
| Greenway Intergy | CSV tables, documents (ZIP/RTF/PDF), images (TIF/TAR) |
| Veradigm View | TSV (tab-separated values) |
| Veradigm EHR | PDF documentation (export format TBD from PDF) |
| AdvancedMD | CSV, C-CDA XML, MS Access (.mdb), SQL Server (.bak), ODBC |

### Key Takeaways

1. **Greenway Intergy** has the most transparent, technically accessible documentation — 261 fully-specified database tables in static HTML, viewable and scrapable without JavaScript.
2. **athenahealth** has the most polished documentation portal but requires browser rendering (SPA).
3. **NextGen** packs everything into a single 29MB PDF — comprehensive but unwieldy.
4. **Veradigm** takes a multi-product approach with versioned documentation, showing active maintenance.
5. **AdvancedMD** offers the most diverse export formats but bulk exports require developer assistance, creating a practical barrier.
6. All vendors make their documentation publicly accessible without authentication, as required by ONC.
