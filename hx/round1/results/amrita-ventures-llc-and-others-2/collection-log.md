# Darena Health (formerly MeldRx) — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11047, 11050, 11071, 11085, 11124, 11125, 11169, 11185, 11392, 11474, 11764
- **Developer(s)**: Amrita Ventures, LLC; Clinicmind Inc.; Complete Healthcare Solutions, Inc.; Doctorsoft Corporation; EZDERM, LLC; Ennoble Technologies LLC; FEI Systems; Lancman Solutions LLC; Raintree Systems, Inc.; Smoky Mountain Information Systems, LLC; eRAD, Inc.
- **Products**: Amrita Hospital Information System, Clinicmind, Doctorsoft EHR, EZDERM, Epi-Management, Office Anywhere, PIMSY Platinum, Raintree, UnifiMD, Web Infrastructure for Treatment Services (WITS), eRAD RIS
- **Registered URL**: https://www.darenasolutions.com/meldrx-onc-hti1-certified#b10-EHI-Export-Documentation

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.darenasolutions.com/meldrx-onc-hti1-certified#b10-EHI-Export-Documentation" -H 'User-Agent: Mozilla/5.0'
```

**Result**: Two-step redirect chain:
1. `HTTP/2 301` from `www.darenasolutions.com/meldrx-onc-hti1-certified` → `https://darena.health/meldrx-onc-hti1-certified` (Squarespace server)
2. `HTTP/2 200` at `https://darena.health/meldrx-onc-hti1-certified` — Content-Type: `text/html;charset=utf-8`

However, the HTML at this intermediate page contains a **JavaScript redirect**: `window.location.href = "/onc-hti1-certified";`

So the effective final URL after JS execution is: **https://darena.health/onc-hti1-certified**

The `#b10-EHI-Export-Documentation` fragment anchor works on the final page (there's an `id="b10-EHI-Export-Documentation"` heading).

### Step 2: Page examination

```bash
curl -sL "https://darena.health/onc-hti1-certified" -H 'User-Agent: Mozilla/5.0' -o /tmp/page2.html
wc -c /tmp/page2.html
```

**Result**: 234,237 bytes. Squarespace-hosted HTML page. Contains real content rendered server-side (not an SPA). The page title is "ONC Certification 2026" and is hosted on `darena.health` (primary domain), formerly `darenasolutions.com`.

The page is a comprehensive ONC certification page covering all certified modules. An announcement bar states: "MeldRx is now Darena Health!"

### Step 3: Finding the EHI section

The page has an anchor `id="b10-EHI-Export-Documentation"` with the heading:

> **170.315 (b)(10) EHI Export Documentation**

The EHI documentation is inline text on the page (no accordion, no separate download). The complete b(10) section reads:

> Darena Health supports the export of EHI as follows:
> 1. FHIR Bulk Export Format: The user can export all available structured data through FHIR APIs as outlined in our [swagger documentation](https://app.meldrx.com/swagger/index.html). The output format is based on the FHIR [Bulk data standard](http://hl7.org/fhir/uv/bulkdata/STU1.0.1/)
> 2. For non-FHIR resources, Darena Health supports the export as [DocumentReference](https://www.hl7.org/fhir/documentreference.html) resource types. This resource can be used with any file, including CCDA.

Additionally, lower on the page, under a detailed criterion-by-criterion breakdown:

> **170.315 (b)(10): Electronic Health Information Export**
> Enable a user to timely create an export file(s) with all of a single patient's electronic health information stored at the time of certification by the product, of which the Health IT Module is a part.
> Included in the contract. No additional costs or fees.

### Step 4: Following the swagger documentation link

The EHI section links to `https://app.meldrx.com/swagger/index.html` for swagger documentation.

```bash
curl -sI -L "https://app.meldrx.com/swagger/index.html" -H 'User-Agent: Mozilla/5.0'
```

**Result**: `HTTP/2 404`. The swagger endpoint is dead.

```bash
curl -sI -L "https://app.meldrx.com/swagger" -H 'User-Agent: Mozilla/5.0'
```

**Result**: Also `HTTP/2 404`. The swagger documentation has been taken down.

### Step 5: Discovering the Postman documentation site

The page also links to `https://docs.darena.health/` which resolves to a **Postman Documenter** hosted API documentation site.

```bash
curl -sI -L "https://docs.darena.health/" -H 'User-Agent: Mozilla/5.0'
```

**Result**: `HTTP/1.1 200 OK`, Content-Type: `text/html; charset=utf-8`. Cloudflare-proxied, Postman-hosted documentation.

Navigated to `https://docs.darena.health/` in browser. The site has a left sidebar with the following structure:

- **DARENA HEALTH**
  - Introduction
  - Getting Started
  - Workspace Permissions
  - Darena Health Use Cases
  - Darena Health APIs for Cures Act Compliance
    - **HTI-1 (g10 & b11)**
      - Get Connected
      - G10
        - Import(Upload) DH Schema
        - Import(Upload) CCDA
        - Import(Upload) CCDA Raw Body
        - Send Invite
        - Upload DocumentReference
      - G9
      - B11(DSI)
      - Workspace Management
      - **Bulk Export** ← This is the b(10) EHI Export documentation
        - POST System App Token
        - GET Get Workspace Details
        - GET Get Groups
        - GET Start Bulk Export
        - GET Get Content
      - Patient Connect
    - MIPS API
    - FHIR to MIPS
    - Developer Account
    - FHIR API
      - GET Get Patients
      - GET Get Patient by Identifier
      - GET Get Resource by Patient Id

### Step 6: Bulk Export API Details

Clicked on "Bulk Export" folder and examined each endpoint:

1. **System App Token** (POST `https://app.meldrx.com/connect/token`)
   - Body: `client_id`, `client_secret`, `grant_type=client_credentials`, `scope=system/*.read`

2. **Get Workspace Details** (GET)

3. **Get Groups** (GET)

4. **Start Bulk Export** (GET `https://app.meldrx.com/api/fhir/WORKSPACE_ID/Group/{group_id}}/$export`)
   - Initiates FHIR Bulk Data $export operation on a Group resource

5. **Get Content** (GET `https://app.meldrx.com/api/BackgroundJobs/WORKSPACE_ID/bulk-export/{job_id}`)
   - Retrieves the exported content after the async job completes

### Step 7: Supported FHIR Resources

On the "Import(Upload) DH Schema" page, the list of supported FHIR resources is documented:

- Patient
- Encounter
- AllergyIntolerance
- CarePlan
- Condition
- CareTeam
- Coverage
- DiagnosticReport
- Goal
- Immunization
- Location
- MedicationDispense
- MedicationRequest
- Organization
- Practitioner
- PractitionerRole
- Procedure
- Medication
- Observation
- Device
- RelatedPerson
- ServiceRequest
- Specimen
- DocumentReference

This is **24 FHIR resource types**, closely aligned with US Core / USCDI v3.1.

### Step 8: Additional links found on the ONC page

- License agreement: `https://cdn.meldrx.com/assets/docs/license-agreement.pdf` (14 pages)
- Real World Testing reports:
  - 2024: `/s/2024-RWT-Results_MeldRx.pdf`
  - 2025: `/s/2025-Real-World_Testing_Results_Darena-Health.pdf`
- Trust center: `https://trust.darena.health`
- GitHub: `https://github.com/darena-solutions`
- Discord: `https://discord.darena.health`

## Downloads

### onc-hti1-certified.html (234 KB)
```bash
curl -sL "https://darena.health/onc-hti1-certified" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/onc-hti1-certified.html
```
Verified: HTML document, UTF-8, 234,237 bytes
Saved to: `downloads/onc-hti1-certified.html`

### docs-darena-health-index.html (40 KB)
```bash
curl -sL "https://docs.darena.health/" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/docs-darena-health-index.html
```
Verified: HTML document, ASCII, 39,942 bytes
Note: This is a Postman Documenter SPA — the HTML shell loads JS which renders the documentation. The curl-fetched HTML is the shell only; full content requires a browser. However, the Postman docs are publicly accessible at `https://docs.darena.health/`.
Saved to: `downloads/docs-darena-health-index.html`

### license-agreement.pdf (364 KB)
```bash
curl -sL "https://cdn.meldrx.com/assets/docs/license-agreement.pdf" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/license-agreement.pdf
```
Verified: PDF document, version 1.7, 14 pages, 364,133 bytes
Saved to: `downloads/license-agreement.pdf`

### 2024-RWT-Results_MeldRx.pdf (921 KB)
```bash
curl -sL "https://darena.health/s/2024-RWT-Results_MeldRx.pdf" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/2024-RWT-Results_MeldRx.pdf
```
Verified: PDF document, version 1.7, 11 pages, 920,615 bytes
Saved to: `downloads/2024-RWT-Results_MeldRx.pdf`

### 2025-RWT-Results-Darena-Health.pdf (210 KB)
```bash
curl -sL "https://darena.health/s/2025-Real-World_Testing_Results_Darena-Health.pdf" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/2025-RWT-Results-Darena-Health.pdf
```
Verified: PDF document, version 1.7, 6 pages, 210,241 bytes
Saved to: `downloads/2025-RWT-Results-Darena-Health.pdf`

### fhir-bulk-data-spec.html (12 KB)
```bash
curl -sL "http://hl7.org/fhir/uv/bulkdata/STU1.0.1/" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/fhir-bulk-data-spec.html
```
Verified: HTML, 11,911 bytes (referenced FHIR Bulk Data standard)
Saved to: `downloads/fhir-bulk-data-spec.html`

## Obstacles & Notes

1. **Domain migration**: The registered URL at `www.darenasolutions.com` 301-redirects to `darena.health`, then does a JavaScript redirect from `/meldrx-onc-hti1-certified` to `/onc-hti1-certified`. The original URL still works but requires following the JS redirect.

2. **Dead swagger link**: The EHI section links to `https://app.meldrx.com/swagger/index.html` which returns 404. The swagger documentation has been replaced by the Postman documentation at `https://docs.darena.health/`.

3. **Postman Documenter is SPA**: The `docs.darena.health` site is a Postman-hosted documentation site that requires JavaScript to render. The curl-downloaded HTML is a shell/loader. Full content is only accessible via browser or via the Postman collection import ("Run in Postman" button).

4. **Minimal b(10) documentation**: The EHI export documentation is extremely concise — just two paragraphs describing that (1) FHIR Bulk Export is used for structured data and (2) DocumentReference is used for non-FHIR resources. There is no separate data dictionary, no field-level documentation, and no downloadable ZIP/PDF specifically for b(10).

5. **Platform-as-a-service model**: Darena Health is a FHIR middleware platform that multiple EHR vendors use for ONC certification. The 11 different developers/products listed all share this same Darena Health certification. The EHI export is performed through the Darena Health FHIR Bulk Export API, not through each individual EHR's native export.

6. **No anti-bot protection**: Squarespace pages and Postman docs loaded without issues. No Cloudflare challenges, no special headers needed beyond a basic User-Agent.
