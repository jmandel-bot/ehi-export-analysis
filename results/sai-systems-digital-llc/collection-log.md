# Sai Systems Digital LLC — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 11177
- Registered URL: https://saisystems.com/health/pacehr-ehi/
- Developer: Sai Systems Digital LLC
- Product: PacEHR v20
- Certification Date: 2022-12-29

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://saisystems.com/health/pacehr-ehi/" -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```
**Result:** HTTP/2 403 Forbidden. The server (nginx) returns a 403 for curl requests. Content-Type: text/html, Content-Length: 75193. The returned HTML is a hosting provider's generic 403 error page (styled with "Roboto" font, geometric shapes, and a "403 - Forbidden" message).

The entire saisystems.com domain returns 403 to curl, including the root (/), /health/, and the EHI page. The developer's other domain thesnfist.com also returns 403 to curl.

### Step 2: Page examination via browser
Since curl returns 403, navigated to the URL in Chrome browser. The page loaded successfully — the 403 appears to be an anti-bot protection that blocks requests without proper cookies/session.

**Page title:** "PacEHR Electronic Health Info (EHI) All Data Export"
**Page type:** WordPress site (Divi theme) hosted at saisystems.com/health/
**Content:** Static HTML page with descriptive text about PacEHR's EHI export capability. No downloadable files, no data dictionary, no schema documentation. The page describes:
- What EHI is (referencing HIPAA Designated Record Set)
- Export use cases (bulk export and single/multi-patient export)
- Types of exports offered (mentions "machine readable XML formats")
- Links to FHIR API documentation at thesnfist.com/cures-update/

### Step 3: Finding additional EHI content
The saisystems.com EHI page links to "FHIR API documentation for PacEHR" at https://thesnfist.com/cures-update/. Navigated there.

**Discovery:** Found a SECOND EHI page at https://thesnfist.com/pacehr-ehi/ (linked from the footer of thesnfist.com). This page is MORE detailed than the registered URL and describes:
- A **native database table export** in "PacEHR-native, computable, delimited file format"
- Each table exported as an individual file
- A reference to "CLICK HERE to download a zip file containing comprehensive documents" for table descriptions and column details

**Critical finding:** The "CLICK HERE" text on thesnfist.com/pacehr-ehi/ is NOT actually a hyperlink — it is plain text with no `<a>` tag. The zip file containing the data dictionary is referenced but not downloadable. This appears to be a broken/incomplete link.

### Step 4: Identified pages and assets

| Asset | URL | Type | Notes |
|-------|-----|------|-------|
| EHI page (registered URL) | https://saisystems.com/health/pacehr-ehi/ | HTML page | General overview, mentions XML export |
| EHI page (thesnfist) | https://thesnfist.com/pacehr-ehi/ | HTML page | More detailed, describes native table export, broken zip download link |
| FHIR API documentation | https://thesnfist.com/cures-update/ | HTML page | Comprehensive FHIR resource/endpoint documentation + Terms of Service |
| Cures Act / Mandatory Disclosures | https://thesnfist.com/cures-act/ | HTML page | Certification details, ONC compliance info |
| Compliance Certificate | https://43775473.fs1.hubspotusercontent-na1.net/hubfs/43775473/PacEHR%20Certifications/Compliance%20Certificate%20PacEHR%20v20%20010325.pdf | PDF | 1-page ONC certification compliance certificate |

### Step 5: Checked for additional resources
- **thesnfist.com/download/** — This is the mobile app download page (App Store / Google Play), not EHI-related
- **Wayback Machine** — No archived snapshots found for saisystems.com/health/pacehr-ehi/ or thesnfist.com/pacehr-ehi/

## Downloads

### pacehr-ehi-page.html (154 KB)
```bash
# Saved via browser (curl returns 403) — used Chrome DevTools to extract document.documentElement.outerHTML
# Source: https://saisystems.com/health/pacehr-ehi/
```
Verified: HTML file, WordPress/Divi page
Saved to: downloads/pacehr-ehi-page.html

### thesnfist-pacehr-ehi-page.html (146 KB)
```bash
# Saved via browser — used Chrome DevTools to extract document.documentElement.outerHTML
# Source: https://thesnfist.com/pacehr-ehi/
```
Verified: HTML file, WordPress/Divi page. Contains more detailed EHI export description with broken "CLICK HERE" zip download link.
Saved to: downloads/thesnfist-pacehr-ehi-page.html

### cures-update-fhir-api-docs.html (203 KB)
```bash
# Saved via browser — used Chrome DevTools to extract document.documentElement.outerHTML
# Source: https://thesnfist.com/cures-update/
```
Verified: HTML file containing FHIR API documentation for PacEHR, including resource endpoints, USCDI data elements, and API Terms of Service.
Saved to: downloads/cures-update-fhir-api-docs.html

### compliance-certificate-pacehr-v20.pdf (266 KB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' -o compliance-certificate-pacehr-v20.pdf 'https://43775473.fs1.hubspotusercontent-na1.net/hubfs/43775473/PacEHR%20Certifications/Compliance%20Certificate%20PacEHR%20v20%20010325.pdf'
```
Verified: `file` → PDF document, version 1.7, 1 page
Saved to: downloads/compliance-certificate-pacehr-v20.pdf

### ehi-page-screenshot.png (3.5 MB)
Full-page screenshot of https://saisystems.com/health/pacehr-ehi/
Saved to: downloads/ehi-page-screenshot.png

### thesnfist-pacehr-ehi-screenshot.png (562 KB)
Full-page screenshot of https://thesnfist.com/pacehr-ehi/
Saved to: downloads/thesnfist-pacehr-ehi-screenshot.png

### cures-update-screenshot.png (3.5 MB)
Full-page screenshot of https://thesnfist.com/cures-update/
Saved to: downloads/cures-update-screenshot.png

## Obstacles & Notes

1. **Anti-bot protection (403 for curl):** Both saisystems.com and thesnfist.com return HTTP 403 to curl requests regardless of User-Agent. All page content had to be accessed via the browser. The HubSpot-hosted PDF (compliance certificate) downloaded fine via curl.

2. **Two different EHI pages:** The registered URL (saisystems.com/health/pacehr-ehi/) and thesnfist.com/pacehr-ehi/ are different pages with different content. The thesnfist.com version is more detailed and describes a native database table export, while the saisystems.com version is more general and mentions XML format.

3. **Broken download link:** The thesnfist.com/pacehr-ehi/ page references a zip file download ("CLICK HERE to download a zip file containing comprehensive documents") but the "CLICK HERE" text is NOT a hyperlink. The data dictionary zip file is referenced but inaccessible.

4. **Inconsistent export descriptions:** The saisystems.com EHI page says export is "in machine readable XML formats" and mentions FHIR APIs. The thesnfist.com EHI page describes "PacEHR-native, computable, delimited file format" with each table as an individual file. These appear to describe two different export mechanisms or the description evolved over time.

5. **No actual data dictionary found:** Despite extensive searching across both domains, no downloadable data dictionary, schema documentation, or table/field definitions were found. The FHIR API documentation lists FHIR resources and USCDI data elements but does not document the native database tables referenced in the EHI export.

---

## Product: PacEHR

### Product Context
PacEHR (Post-Acute Care Electronic Health Record) is a specialty EHR system designed specifically for Post-Acute and Long-Term Care (PALTC) providers, particularly Skilled Nursing Facilities (SNFs). It is marketed as "the first EHR system created by and for post-acute long-term (PALTC) professionals."

PacEHR is the core clinical product within Sai Systems Digital LLC's broader platform called "TheSNFist Suite." The suite includes:
- **PacEHR** — the EHR with voice-to-text documentation, customized macros, encounter templates, MIPS/CCM reporting
- **billEHR** — mobile point-of-care charge capture app
- **Revenue Cycle Management** — full-service medical billing and collections
- **Medical Coding and Billing** — expert billing/coding services
- **Credentialing and Enrollment** — payor enrollment management
- **SNFConnect** — internal communications platform for PALTC operations
- **TheSNFist Telehealth** — telehealth for providers
- **Chronic Care Management (CCM)** — nursing services, care coordination, pharmacy coordination

PacEHR features real-time AI coding for ICD and CPT codes ("Point of Service Awareness"), built-in encounter/note signing, PointClickCare integration, and facility-based patient census management. The product relies on **Updox** as additional software for certification compliance (likely for patient portal/engagement capabilities).

The certified criteria indicate the product handles:
- (a)(1) CPOE: Medications
- (a)(5) Demographics
- (a)(14) Implantable Device List
- (b)(1) Transitions of Care
- (b)(10) EHI Export
- (b)(11) EHI Export (Single Patient)
- (g)(10) Standardized API
- (h)(1) Direct Project

Notably absent from certification: (a)(2)-(a)(4) CPOE for labs/imaging/diagnostics, (a)(6)-(a)(9) problem list/medication allergy/clinical decision support/documentation, (a)(12)-(a)(13) family/social history, (e)(1) patient portal. This is a relatively limited certification footprint.

### Export Approach
There appear to be **two export mechanisms** described across the two EHI pages:

1. **FHIR-based export** (described on saisystems.com/health/pacehr-ehi/): Export in "machine readable XML formats" utilizing FHIR APIs. The FHIR API documentation at thesnfist.com/cures-update/ documents 15 FHIR resources (AllergyIntolerance, CarePlan, CareTeam, Condition, Device, DocumentReference, DiagnosticReport, Encounter, Goal, Immunization, Location, Medication, MedicationRequest, Observation, Patient, Practitioner, Procedure). The FHIR server is described as "FHIR Server 1.0.0 for Cures Act Update" accepting application/fhir+json format.

2. **Native database table export** (described on thesnfist.com/pacehr-ehi/): "PacEHR-native, computable, delimited file format" where "each table is exported as an individual file, named according to the documentation." This is described as a manual, one-time export of health data. A zip file with comprehensive table/column documentation is referenced but the download link is broken.

The native table export approach is the more promising one for EHI completeness, but without the data dictionary zip file, it's impossible to assess what tables and fields are included.

### EHI Coverage Assessment

**Clinical:** Present (based on FHIR API documentation). The FHIR resources cover: allergies, care plans, care teams, conditions/problems, devices, document references (CCDA clinical notes), encounters, goals, immunizations, medications, observations (labs, vitals, smoking status), patients, practitioners, procedures. This covers core clinical data well for a PALTC setting.

**Secure messages:** NOT present. No mention of messaging, inbox, portal communications, or chat in any documentation. The product relies on Updox for patient engagement and SNFConnect for internal communications, but neither appears in the export documentation. This is a gap, though the product's limited certification footprint (no (e)(1) patient portal) suggests messaging may not be a core feature of the certified module.

**Billing/financial:** NOT present in export documentation. Despite the broader TheSNFist Suite having extensive billing capabilities (billEHR, RCM, medical coding), and PacEHR itself having "Point of Service Awareness" real-time CPT/ICD coding, no billing tables, charges, claims, payments, or financial data appear in the FHIR API documentation or any export description. This is a significant gap given the product's integrated billing features.

**Insurance/coverage:** NOT present. No insurance, coverage, eligibility, authorization, or payer information documented in any export resource.

**Appointments/scheduling:** NOT explicitly present. The FHIR API documents Encounter resources (type, diagnosis, time, location, disposition) which partially covers visit data, but no dedicated appointment/scheduling resources. Given the SNF rounding-based workflow, formal appointment scheduling may not be a primary feature.

**Documents/images:** Partially present. The FHIR API includes DocumentReference resources covering CCDA clinical documents (consultation notes, discharge summaries, H&P, procedure notes, progress notes, imaging narrative, lab reports, pathology reports). The thesnfist.com EHI page notes "certain electronic health information, such as rich text documents or images, may not be available in table format. However, these are referenced in the extracts created for subsequent export." This suggests documents/images exist but may not be fully included.

**Audit:** NOT present. No audit trail, access log, or tracking resources documented.

### Issues & Red Flags

1. **Broken data dictionary download:** The most critical EHI documentation artifact — a zip file containing table descriptions and column details for the native database export — is referenced but the "CLICK HERE" text is not a working hyperlink. This means the core technical documentation for the EHI export is inaccessible.

2. **Inconsistent export descriptions across two sites:** The registered URL (saisystems.com) describes XML/FHIR-based export while the thesnfist.com page describes native delimited table export. It's unclear whether these are the same mechanism, two options, or an evolving description.

3. **FHIR-only documented resources are clinically limited:** The 15 FHIR resources documented cover only USCDI clinical data elements. Billing, insurance, scheduling, messaging, and audit are entirely absent from the FHIR API documentation.

4. **Product has billing capabilities not reflected in export:** PacEHR includes real-time CPT/ICD coding and integrates with billEHR and full RCM services. None of this financial data appears in the export documentation.

5. **No patient portal in certified module:** PacEHR relies on Updox for patient engagement capabilities. Portal messaging data (if any) would be in a third-party system and is not addressed in the export.

6. **Anti-bot protection on documentation sites:** Both saisystems.com and thesnfist.com return 403 to curl, requiring browser access. While not a compliance violation, it makes the documentation less accessible for automated auditing.

7. **FHIR STU3 implementation:** The FHIR API documentation links to HL7 STU3 resources (not R4), which is an older standard with fewer data elements available.
