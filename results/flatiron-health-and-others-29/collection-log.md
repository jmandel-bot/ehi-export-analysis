# Flatiron Health — EHI Export Documentation Collection

Collected: 2025-02-14

## Source
- Registered URL: https://flatiron.com/certification
- CHPL IDs: 11115, 11640
- Developer(s): Flatiron Health, OneOncology, LLC
- Product(s): OncoEMR, OneOncology HIE Integration

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://flatiron.com/certification" -H 'User-Agent: Mozilla/5.0'
```
- HTTP/2 200 OK
- Content-Type: text/html; charset=UTF-8
- Hosted on HubSpot CMS behind Cloudflare
- No redirects — URL is live and serves a full HTML page (117 KB)

### Step 2: Page examination
The page is a static HTML page (not an SPA) titled "OncoEMR® ONC Certification". It contains:
- Full listing of ONC certification criteria (170.315(a)(1) through (g)(10))
- Specific section for **170.315(b)(10): Electronic Health Information (EHI) Export**
- Links to: EHI Data Dictionary, FHIR API documentation portal, Compliance Certificate, Real World Testing plans/results
- Relied upon software for (b)(10): Snowflake, AWS Aurora (PostgreSQL 13.9), AWS ECS, AWS S3, AWS S3 Batch Operations, AWS EMR

### Step 3: Finding the EHI section
Scrolled to the "EHI Export Documentation" heading on the page. It contains a single link:
- **"EHI Export documentation can be found here"** → links to `https://flatiron.com/certification/ehi-data-dictionary?hsLang=en`

Also found:
- **"Flatiron API documentation can be found here"** → links to `https://flatiron.my.site.com/FHIR/s/`

### Step 4: Download EHI Data Dictionary PDF
```bash
curl -sI -L "https://flatiron.com/certification/ehi-data-dictionary?hsLang=en" -H 'User-Agent: Mozilla/5.0'
```
- HTTP/2 301 → redirects to `https://flatiron.com/hubfs/_2023Redesign/PDFs/EHI%20Data%20Dictionary.pdf?hsLang=en`
- HTTP/2 200, Content-Type: application/pdf, Content-Length: 400903
- Downloaded: 63-page PDF, last modified 9/9/2025
- Contains: Format specification (CSV for single patient, Parquet for population exports), instructions on how to access exports, and a data dictionary covering ~97 database tables with column names, types, nullability, and descriptions

### Step 5: Explore FHIR API documentation portal
Navigated to `https://flatiron.my.site.com/FHIR/s/` in the browser (Salesforce Experience Cloud SPA — requires JavaScript).

The portal contains:
- **Home page**: Overview of FHIR API implementation, getting started guide, developer account setup
- **FHIR API Overview article**: Technical details — service base URL, supported resources/profiles, OAuth2 auth, launch mechanisms, supported operations, capability statement URL, response codes
- **FHIR Resources/Profiles**: Index of 38 individual resource documentation articles
- **FHIR FAQs**: Common questions about the API
- **API Pricing**: Patient access is free; USCDI v1 included for OncoEMR customers; additional fees for EHR Launch and value-added services
- **API Terms of Use**: Legal terms for API usage

### Step 6: Download FHIR Capability Statement (machine-readable)
```bash
curl -sL "https://fhir.prod.flatiron.io/fhir/metadata" -H 'Accept: application/fhir+json' -o fhir-capability-statement.json
```
- FHIR R4 CapabilityStatement, 12 KB JSON
- Lists 32 supported resource types
- Conforms to US Core Server CapabilityStatement (IG 4.0.1)

### Step 7: Download FHIR Service Base URL bundle
```bash
curl -sL "https://fhir.prod.flatiron.io/fhir" -H 'Accept: application/fhir+json' -o fhir-service-base-url.json
```
- 2.4 MB JSON Bundle with Endpoint and Organization resources for all Flatiron customers

### Step 8: Capture representative FHIR resource articles
Visited 3 representative FHIR resource pages (Patient, AllergyIntolerance, Condition-Encounter-Diagnosis) to document the level of detail. Each page includes:
- FHIR version supported (4.0.1)
- US Core profile version (STU 6.1.0)
- Supported data elements table with USCDI mapping
- Search parameters
- API syntax (GET/POST support)
- OncoEMR data source mapping

## Downloads

### EHI_Data_Dictionary.pdf (391 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' -o EHI_Data_Dictionary.pdf 'https://flatiron.com/hubfs/_2023Redesign/PDFs/EHI%20Data%20Dictionary.pdf'
```
Verified: PDF document, 63 pages, last modified 9/9/2025
Saved to: downloads/EHI_Data_Dictionary.pdf
Content: EHI Export data dictionary with:
- Export format specification: CSV (single patient) and Parquet (population)
- Additional files in XML, JPEG, PNG, TIFF, PDF formats for human-readable content
- Access instructions for OncoEMR UI (self-service) and SFTP (large exports)
- Data dictionary for ~97 tables including: Address_History, Allergy_History, Appointment_History, Demographics_History, Diagnosis_History, Document_History, Immunization_History, Lab_Result_History, Medication_History, Order_History, Treatment_Current_History, Vital_Sign_History, and more
- Each column documented with: TableName, ColumnName, Type, Nullable, Description

### fhir-capability-statement.json (12 KB)
```bash
curl -sL "https://fhir.prod.flatiron.io/fhir/metadata" -H 'Accept: application/fhir+json' -o fhir-capability-statement.json
```
Verified: Valid FHIR R4 CapabilityStatement JSON
Saved to: downloads/fhir-capability-statement.json
Content: Machine-readable FHIR server capability statement listing 32 supported resource types, search parameters, supported operations

### fhir-service-base-url.json (2.4 MB)
```bash
curl -sL "https://fhir.prod.flatiron.io/fhir" -H 'Accept: application/fhir+json' -o fhir-service-base-url.json
```
Verified: FHIR Bundle JSON with Endpoint and Organization resources
Saved to: downloads/fhir-service-base-url.json
Content: Service base URL bundle with endpoint configurations and organization metadata for all Flatiron customers

### fhir-api-overview.txt (10 KB)
Source: https://flatiron.my.site.com/FHIR/s/article/Flatiron-FHIR-Overview (browser-rendered SPA)
Saved to: downloads/fhir-api-overview.txt
Content: Flatiron's FHIR API technical overview — service base URL (https://fhir.prod.flatiron.io/fhir), supported FHIR profiles (US Core R4.0.1 STU 6.1.0), OAuth2 authorization, 5 launch mechanisms (Provider EHR Launch, Provider Standalone, Provider Backend Single Patient, Provider Backend Bulk Data, Patient Standalone), supported operations, capability statement URL, response codes

### fhir-home-page.txt (15 KB)
Source: https://flatiron.my.site.com/FHIR/s/ (browser-rendered SPA)
Saved to: downloads/fhir-home-page.txt
Content: FHIR portal home page — getting started guide, SMART-on-FHIR development, developer account creation, registration process

### fhir-resources-index.json (4 KB)
Source: https://flatiron.my.site.com/FHIR/s/topic/0TO1T000000cWozWAE/fhir-resourcesprofiles (browser-rendered SPA)
Saved to: downloads/fhir-resources-index.json
Content: JSON array of 38 FHIR resource article URLs with titles

### fhir-resources-profiles.txt (7 KB)
Source: https://flatiron.my.site.com/FHIR/s/topic/0TO1T000000cWozWAE/fhir-resourcesprofiles (browser-rendered SPA)
Saved to: downloads/fhir-resources-profiles.txt
Content: FHIR Resources/Profiles topic listing page text

### resource-patient.txt (6 KB)
Source: https://flatiron.my.site.com/FHIR/s/article/Patient (browser-rendered SPA)
Saved to: downloads/resource-patient.txt
Content: Patient resource documentation — FHIR 4.0.1, US Core STU 6.1.0, supported data elements (name, DOB, language, address, phone), search parameters

### resource-allergyintolerance.txt (5 KB)
Source: https://flatiron.my.site.com/FHIR/s/article/AllergyIntolerance (browser-rendered SPA)
Saved to: downloads/resource-allergyintolerance.txt
Content: AllergyIntolerance resource documentation with field mappings and supported elements

### resource-condition-encounter-diagnosis.txt (3 KB)
Source: https://flatiron.my.site.com/FHIR/s/article/Resource-Condition-Encounter-Diagnosis (browser-rendered SPA)
Saved to: downloads/resource-condition-encounter-diagnosis.txt
Content: Condition - Encounter Diagnosis resource documentation with field mappings

### fhir-faqs.txt (5 KB)
Source: https://flatiron.my.site.com/FHIR/s/article/FHIR-FAQs (browser-rendered SPA)
Saved to: downloads/fhir-faqs.txt
Content: FHIR API FAQ — what FHIR is, supported resources, USCDI data elements, search parameters

### fhir-api-pricing.txt (5 KB)
Source: https://flatiron.my.site.com/FHIR/s/article/API-Pricing (browser-rendered SPA)
Saved to: downloads/fhir-api-pricing.txt
Content: API pricing — patient access free; USCDI v1 included for OncoEMR customers; fees for EHR Launch and value-added services

### fhir-api-terms.txt (16 KB)
Source: https://flatiron.my.site.com/FHIR/s/article/API-Terms-of-Use (browser-rendered SPA)
Saved to: downloads/fhir-api-terms.txt
Content: Full legal terms and conditions for FHIR API usage

### certification-page.html (118 KB)
```bash
curl -sL "https://flatiron.com/certification" -H 'User-Agent: Mozilla/5.0' -o certification-page.html
```
Saved to: downloads/certification-page.html
Content: Full HTML source of the certification page

### certification-page-ehi-section.png (54 KB)
Screenshot of the EHI Export Documentation section of the certification page
Saved to: downloads/certification-page-ehi-section.png

### fhir-api-portal-screenshot.png (106 KB)
Screenshot of the FHIR API portal home page
Saved to: downloads/fhir-api-portal-screenshot.png

## Access Summary
- Final URL (after redirects): https://flatiron.com/certification (no redirect)
- Status: found
- Required browser: partially — main page and PDF are curl-accessible; FHIR API portal requires browser (Salesforce SPA); FHIR REST endpoints are curl-accessible
- Navigation complexity: one_click (EHI data dictionary is one click from main page; FHIR API docs require SPA navigation)
- Anti-bot issues: none — standard User-Agent header sufficient for all content

## Obstacles & Dead Ends
- The FHIR API documentation portal (flatiron.my.site.com) is a Salesforce Experience Cloud SPA that requires JavaScript rendering — cannot be scraped with curl alone
- The 38 individual FHIR resource articles were not all downloaded (only 3 representative examples captured); the index of all URLs is preserved in fhir-resources-index.json for reproducibility
- The fhir-service-base-url.json file is 2.4 MB as it contains endpoint/organization data for all Flatiron customers
- No login was required to access any of the documentation
