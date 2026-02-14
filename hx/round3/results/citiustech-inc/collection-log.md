# CitiusTech, Inc. — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 11282
- Registered URL: https://8759937.fs1.hubspotusercontent-na1.net/hubfs/8759937/assets/pdfs/PERFORM+Connect_FHIR_API_Document_V_22_01_02.pdf
- Developer: CitiusTech, Inc.
- Product: PERFORM+ Connect v22.01.02

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://8759937.fs1.hubspotusercontent-na1.net/hubfs/8759937/assets/pdfs/PERFORM+Connect_FHIR_API_Document_V_22_01_02.pdf" -H 'User-Agent: Mozilla/5.0' 2>&1
```

Result:
- HTTP/2 200 (direct, no redirects)
- Content-Type: application/pdf
- Content-Length: 1,832,074 bytes (~1.8 MB)
- Server: cloudflare (via CloudFront CDN)
- Last-Modified: Fri, 31 Mar 2023 13:07:24 GMT
- x-robots-tag: all (no noindex)
- cf-cache-status: HIT
- ETag: "9fc8c83d8a00c56df17c7071f5ff9c2b"

The registered URL is a direct link to a PDF hosted on HubSpot's file storage (hubspotusercontent-na1.net). No navigation, no page exploration, no JavaScript required. The URL immediately returns the PDF.

### Step 2: Download

```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/perform-connect-fhir-api-document.pdf \
  "https://8759937.fs1.hubspotusercontent-na1.net/hubfs/8759937/assets/pdfs/PERFORM+Connect_FHIR_API_Document_V_22_01_02.pdf"
```

Verification:
- `file downloads/perform-connect-fhir-api-document.pdf` → PDF document, version 1.7, 114 page(s)
- Size: 1,832,074 bytes (1.8 MB)

### Step 3: Document examination

The PDF is titled "PERFORM+ Connect FHIR API Document" (Product Version 22.01.02, Document Version 2.0). It is marked "Client Confidential" on every page footer — notable for a document that is supposed to be publicly accessible EHI export documentation.

The document is 114 pages covering:
1. Introduction (p. 9)
2. PERFORM+ Connect FHIR APIs Experience — UI walkthrough (pp. 10-11)
3. Application Programming Interfaces (APIs) — 37 FHIR resource APIs (pp. 12-110)
   - Section 3.4 specifically covers "EHI Export for 170.315(b)(10)" (pp. 27-34)
4. Errors and Exceptions (pp. 111-112)
5. Terms and Conditions of Use (p. 113)
6. Files Referenced (p. 114)

### Step 4: No additional assets found

The PDF is a single self-contained document. There are no links to additional downloadable files, ZIPs, or data dictionaries. The PDF references external JSON response files (as icons in request/response tables) but these are not downloadable — they appear to be embedded screenshots of the testing tool.

## Downloads

### perform-connect-fhir-api-document.pdf (1,832,074 bytes / 1.8 MB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/perform-connect-fhir-api-document.pdf \
  "https://8759937.fs1.hubspotusercontent-na1.net/hubfs/8759937/assets/pdfs/PERFORM+Connect_FHIR_API_Document_V_22_01_02.pdf"
```
Verified: `file` → PDF document, version 1.7, 114 pages
Saved to: downloads/perform-connect-fhir-api-document.pdf

## Obstacles & Notes

- **No obstacles encountered.** The URL is a direct PDF download hosted on HubSpot's CDN. No anti-bot protection, no accordion navigation, no JavaScript needed.
- **"Client Confidential" marking** on every page, despite being publicly accessible via an unauthenticated HubSpot URL. This is contradictory — the document is clearly public but labeled as confidential.
- **The document is a FHIR API reference**, not a dedicated EHI export data dictionary. Section 3.4 covers EHI Export for b(10) specifically, but it's only 7 pages within a 114-page API document. The b(10) EHI export section describes the same Bulk FHIR Export mechanism used in section 3.3, repackaged for the EHI export criterion.
- **Last-Modified date of March 31, 2023** — the document has not been updated since initial certification (April 2023).

---

## Product: PERFORM+ Connect

### Product Context

PERFORM+ Connect is **not an EHR**. It is a FHIR-based interoperability and API middleware platform built by CitiusTech, a healthcare IT services and consulting company headquartered in the US with ~5,400+ employees. CitiusTech is primarily a services company (serving 140+ healthcare organizations, working with 5 of the top 10 EHR vendors) that also produces a product suite called "PERFORM+."

PERFORM+ Connect is the interoperability component of this suite. It provides:
- A FHIR R4 data repository (built on HAPI FHIR)
- FHIR APIs conforming to US Core, CARIN Blue Button, and Da Vinci implementation guides
- OAuth 2.0 identity and access management
- CMS interoperability compliance (Patient Access API, Payer-to-Payer exchange)

The product's primary market is **healthcare payers/health plans** (evidenced by PMPM pricing, CMS Rule compliance focus, EOB/Claims/Coverage resources, and $member-match operation). It is also marketed to providers needing Cures Act compliance.

PERFORM+ Connect does **not** have:
- Clinical charting, ordering, or documentation capabilities
- A patient portal
- Billing or scheduling systems of its own
- Medication management or e-prescribing

It is a **data integration layer** that stores data in a FHIR repository for exchange purposes. The source of truth for clinical and administrative data remains external EHRs, claims systems, and other source systems.

The certified criteria are narrow: b(10) EHI Export, g(10) Standardized API, g(7) Application Access, and d-series security criteria. No clinical quality measures (a-series) are certified.

### Export Approach

The EHI export uses **FHIR Bulk Data Export** — the same mechanism described in the FHIR Bulk Data Access specification. Section 3.4 "EHI Export for 170.315(b)(10)" is essentially identical to Section 3.3 "Bulk FHIR Export," using the same endpoints, parameters, and NDJSON output format.

The export supports:
- Patient-level export: `POST BaseURL/bulk/Patient/$export`
- Group-level export: `GET BaseURL/bulk/Group/{id}/$export`
- Parameters: `_outputFormat`, `_type`, `_since`, `_typeFilter`
- Output format: NDJSON (application/fhir+ndjson)
- Status polling via GET to bulk status URL
- Download via GET with authorization code

The export produces FHIR R4 resources as NDJSON files — one file per resource type.

### EHI Coverage Assessment

The document covers 37 FHIR resource types across these categories:

**Clinical (present):**
- AllergyIntolerance, Condition, CarePlan, CareTeam, DiagnosticReport (Lab and Note), DocumentReference, Encounter, Goal, Immunization, ImplantableDevice, Laboratory Results Observation, Medication, MedicationDispense, MedicationRequest, Procedure, Provenance, Pulse Oximetry, Pediatric BMI/Weight, Smoking Status, Vital Signs

**Insurance/Coverage (present):**
- Coverage, InsurancePlan (under Provider Directory)

**Billing/Financial (partially present — payer-centric):**
- Claim, ExplanationOfBenefit (Inpatient-Facility, Outpatient-Facility, Pharmacy, Professional Non-Clinician) — these are CARIN Blue Button EOB resources, representing payer-adjudicated claims, not provider-side billing. They include claim numbers, diagnosis, insurer, provider, outcome, adjudication (amount type, denial reason, allowed units), and payment details.

**Appointments/Scheduling (present):**
- Appointment resource with status, service type, specialty, participants, start/end dates

**Documents/Images (partially present):**
- DocumentReference resource supports clinical notes and documents with attachments/URLs to binary content

**Secure Messages (not present):**
- No Communication, MessageHeader, or similar messaging resources. The product has no patient portal or messaging system, so this is expected for the product's scope.

**Administrative:**
- Patient, Practitioner, PractitionerRole, Organization, Location, RelatedPerson, Consent, Endpoint
- Provider Directory resources: Contract, HealthcareService, Network, OrganizationAffiliation, Formulary Drug List, Coverage Plan, Pharmacy Directory

**Audit (not present):**
- No AuditEvent or similar audit trail resources documented in the export. (Not expected in the Designated Record Set.)

### Issues & Red Flags

1. **This is FHIR API documentation, not EHI-specific export documentation.** The b(10) EHI export section (3.4) is a 7-page subset of a 114-page FHIR API reference document. It describes the exact same Bulk Data Export mechanism as section 3.3, with identical parameters and response elements. The documentation makes no effort to explain what specific data categories are included in the EHI export, or how the export covers "all electronic health information."

2. **The product is an interoperability middleware platform, not an EHR.** PERFORM+ Connect is a FHIR data repository and API layer. It does not generate or originate clinical data — it receives data from external systems and re-exposes it via FHIR APIs. The scope of "all EHI that can be stored" depends entirely on what data has been loaded into the FHIR repository by the deploying organization, not on inherent product capabilities. This makes the b(10) certification somewhat abstract — the platform can export whatever FHIR resources are in its repository, but it doesn't define what those are.

3. **Payer-centric data model.** The FHIR resources emphasize payer use cases: CARIN Blue Button EOBs, $member-match, Coverage, InsurancePlan, Formulary Drug List. This is consistent with the product's primary market (health plans) but means the "EHI" being exported is primarily claims/adjudication data, not clinical record data.

4. **No data dictionary beyond FHIR resource definitions.** The documentation lists FHIR elements for each resource type but does not describe the underlying data model, database tables, or how source system data maps to FHIR resources. Since this is a FHIR repository (not a native database), this is somewhat expected, but it means there's no way to assess data completeness independent of FHIR R4's inherent limitations.

5. **"Client Confidential" marking contradicts public accessibility requirement.** Every page is marked "Client Confidential" with text stating the document "may not be reproduced or disclosed to any unauthorized person." This is at odds with the ONC requirement that EHI export documentation be publicly accessible.

6. **Document dated March 2023, not updated since.** The PDF's last-modified date is March 31, 2023, and the certification date is April 26, 2023. The documentation has not been updated in nearly 3 years.
