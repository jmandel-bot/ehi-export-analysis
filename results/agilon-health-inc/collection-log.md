# agilon health inc. — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10649
- Registered URL: https://www.agilonhealth.com/wp-content/uploads/2025/01/Mphrx-EHI-export-documentation.pdf

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.agilonhealth.com/wp-content/uploads/2025/01/Mphrx-EHI-export-documentation.pdf" -H 'User-Agent: Mozilla/5.0'
```
Result: HTTP/2 200, direct PDF response. No redirects. Content-Type: `application/pdf`, Content-Length: 638720 bytes (~624 KB). Served via Cloudflare CDN. Last-Modified: Fri, 31 Jan 2025 17:46:01 GMT.

### Step 2: Direct download — no page navigation needed
The registered URL is a direct link to a PDF file hosted on agilon health's WordPress site. No page navigation, accordion expansion, or JavaScript rendering was required. The URL resolved immediately to the PDF document.

### Step 3: Identified downloadable assets
Single asset:
- `Mphrx-EHI-export-documentation.pdf` (638,720 bytes) — the EHI export documentation PDF

## Downloads

### mphrx-ehi-export-documentation.pdf (624 KB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o downloads/mphrx-ehi-export-documentation.pdf \
  'https://www.agilonhealth.com/wp-content/uploads/2025/01/Mphrx-EHI-export-documentation.pdf'
```
Verified: `file downloads/mphrx-ehi-export-documentation.pdf` → PDF document, version 1.7, 12 page(s)
Pages: 12
Saved to: downloads/mphrx-ehi-export-documentation.pdf

## Obstacles & Notes
- No obstacles. Direct PDF download with no authentication, no anti-bot protection, no JavaScript required.
- The PDF is branded "mphrX" (copyright 2021), not "agilon health." mphrX was acquired by agilon health in February 2023 for $45M. The documentation predates the acquisition and has not been updated since.
- The document version is 1.0, copyright 2021, suggesting it was created at or near the time of initial ONC certification (June 2021) and has not been revised.

---

## Product: Minerva

### Product Context

**Minerva** is a FHIR-based Healthcare Data Platform-as-a-Service, originally built by **mphrX** (founded 2011, acquired by agilon health in February 2023 for $45M). It is **not a traditional EHR** — it is an interoperability and data aggregation middleware platform.

**What Minerva does:**
- Aggregates clinical data from disparate EHR systems (Epic, Cerner, athenahealth, etc.) into a unified, vendor-neutral FHIR repository
- Creates a longitudinal patient record by normalizing data from multiple source systems
- Provides SMART on FHIR and Bulk FHIR APIs for programmatic access
- Offers a white-labeled "Digital Front Door" patient-facing portal/app
- Includes surgery coordination, virtual care, care pathway management, and patient engagement tools

**What Minerva is NOT:**
- It is not a system of record where clinicians write notes, enter orders, or prescribe medications
- It does not have its own native billing/revenue cycle management
- It does not generate clinical documentation — it aggregates it from source systems

**agilon health** itself is a value-based care enablement company (NYSE: AGL) that partners with independent primary care physician groups serving Medicare populations. agilon's physician partners use their own EHRs for clinical documentation. Minerva serves as a data aggregation layer within agilon's technology platform, pulling data from those disparate EHRs to enable population health management and care coordination.

**Certified module relationship:** The certified module is "Minerva V4," certified June 9, 2021 (under mphrX, pre-acquisition). The certification covers Minerva's FHIR-based data platform capabilities — specifically its ability to store health data in FHIR format and make it available through standardized APIs and bulk export. The broader product includes patient portal, surgery coordination, and virtual care features beyond the certified module.

### Export Approach

Minerva exports EHI as **FHIR R4 NDJSON files** via two mechanisms:

1. **Single patient export from UI:** A Clinical Admin logs into the Minerva portal, selects a patient from the Patient List, clicks "Export EHI" from the Action dropdown, confirms the export, then receives a notification with a download link. The download is a ZIP file containing one NDJSON file per FHIR resource type plus a readme.txt.

2. **Bulk export via FHIR API:** Uses the FHIR Bulk Data Access pattern (`Patient/$export`). Requires SMART Backend Services Authorization (client credentials with signed JWT). Async operation — client polls a Content-Location URL for status, then downloads NDJSON files when complete. Files are split at 10,000 records per file.

This is a **pure FHIR resource export**, not a native database dump. The export is limited to the 21 FHIR resource types that Minerva supports. Because Minerva is a data aggregation platform (not a source EHR), the exported data is whatever was ingested from upstream source systems and mapped to these FHIR resources.

**Supported FHIR resource types (21):**
AllergyIntolerance, CarePlan, CareTeam, ClinicalImpression, Condition, Device, DiagnosticReport, DocumentReference, Encounter, Goal, Immunization, Location, Medication, MedicationRequest, Observation, Organization, Patient, Practitioner, PractitionerRole, Procedure, Provenance

### EHI Coverage Assessment

**Clinical data: PRESENT (partial)**
The export includes standard clinical FHIR resources: AllergyIntolerance, Condition (diagnoses), Medication, MedicationRequest, Immunization, Observation (vitals, labs), Procedure, DiagnosticReport, ClinicalImpression, CarePlan, CareTeam, Goal. This covers the core clinical data categories reasonably well within the constraints of FHIR R4 resources. However, the data is only as complete as what was ingested from source systems.

**Secure messages: NOT PRESENT**
No messaging-related FHIR resources (Communication, CommunicationRequest) are included in the supported resource list. Minerva's Digital Front Door patient portal includes notification and engagement capabilities, but any messages or communications are not exported. This is a gap if the platform stores patient-provider communications.

**Billing/financial: NOT PRESENT**
No billing-related FHIR resources (Claim, ClaimResponse, ExplanationOfBenefit, ChargeItem, Invoice, Account) are included. Minerva integrates with billing gateways but is not a native billing system, so it may not store billing data itself. However, if any financial data flows through the platform, it is not exported.

**Insurance/coverage: NOT PRESENT**
No insurance-related FHIR resources (Coverage, InsurancePlan, ExplanationOfBenefit) are included. Given that agilon health's business model centers on Medicare Advantage/capitated arrangements, insurance and coverage data likely flows through the broader agilon platform but is not part of Minerva's export.

**Appointments/scheduling: NOT PRESENT**
No scheduling-related FHIR resources (Appointment, Schedule, Slot) are included. Minerva's Digital Front Door portal includes appointment booking capabilities, and the surgery coordination module manages OR scheduling. The absence of Appointment resources from the export is a notable gap given these product capabilities.

**Documents/images: PRESENT (limited)**
DocumentReference is included as a supported resource type. This would capture references to clinical documents aggregated from source systems. However, it's unclear whether the actual document content (binary attachments, images, scanned documents) is included in the export or only the metadata references.

**Audit trails: PRESENT (limited)**
Provenance is included as a supported resource type. FHIR Provenance records track who created or modified resources and when, providing a basic form of audit trail. However, this is not equivalent to a comprehensive access log showing who viewed records. It's limited to data provenance metadata.

### Issues & Red Flags

1. **FHIR-only export with significant category gaps.** The export covers only 21 FHIR resource types, all clinical or administrative. No billing, insurance, scheduling, or messaging resources are included. For a platform that aggregates data from multiple EHRs, the export should arguably include all data the platform stores, not just clinical FHIR resources.

2. **Data aggregation platform, not source system.** Minerva aggregates data from other EHRs — it is not where clinical documentation originates. The EHI export from Minerva is inherently limited to what was ingested and mapped to FHIR resources. The source EHRs hold the authoritative, complete patient records. This raises a fundamental question about the completeness requirement: does b(10) require Minerva to export only what it stores (aggregated FHIR data), or all EHI "that can be stored by the product"?

3. **Documentation is outdated.** The PDF is version 1.0, copyright 2021 (pre-acquisition by agilon health). It has not been updated since initial certification. The document still carries mphrX branding exclusively. Five years without a documentation update is concerning.

4. **No field-level documentation.** The PDF describes the export process (how to trigger it, API endpoints, error codes) but provides zero detail about the data content. There are no field definitions, no data dictionaries, no schema descriptions. The only content detail is a list of 21 FHIR resource type names and a link to the HL7 NDJSON specification. Users are directed to the generic FHIR specification for format details.

5. **Access token requires vendor contact.** To use the bulk export API, users must email techsvc@mphrx.com (an address at the pre-acquisition company) with application details to obtain a client ID. This is not self-service and raises questions about whether the email address is still monitored post-acquisition.

6. **Export files auto-deleted after 48 hours.** Downloaded export files expire and are auto-deleted after 48 hours, which could be problematic for large exports or organizations that need time to process the data.
