# Darena Health (MeldRx) — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11047, 11050, 11071, 11085, 11124, 11125, 11169, 11185, 11392, 11474, 11764
- **Developers**: Amrita Ventures, LLC; Clinicmind Inc.; Complete Healthcare Solutions, Inc.; Doctorsoft Corporation; EZDERM, LLC; Ennoble Technologies LLC; FEI Systems; Lancman Solutions LLC; Raintree Systems, Inc.; Smoky Mountain Information Systems, LLC; eRAD, Inc.
- **Products**: Amrita Hospital Information System, Clinicmind, Doctorsoft EHR, EZDERM, Epi-Management, Office Anywhere, PIMSY Platinum, Raintree, UnifiMD, Web Infrastructure for Treatment Services (WITS), eRAD RIS
- **Registered URL**: https://www.darenasolutions.com/meldrx-onc-hti1-certified#b10-EHI-Export-Documentation

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.darenasolutions.com/meldrx-onc-hti1-certified#b10-EHI-Export-Documentation" -H 'User-Agent: Mozilla/5.0'
```

**Result**: Two-hop redirect chain:
1. `HTTP/2 301` — `www.darenasolutions.com` redirects to `darena.health/meldrx-onc-hti1-certified` (domain rebranding from Darena Solutions to Darena Health)
2. `HTTP/2 200` — Final page at `darena.health/meldrx-onc-hti1-certified`, Content-Type: `text/html;charset=utf-8`, Size: ~14KB (Squarespace-hosted)

### Step 2: Page examination

```bash
curl -sL "https://www.darenasolutions.com/meldrx-onc-hti1-certified#b10-EHI-Export-Documentation" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html
```

**Result**: 53,646 bytes of HTML. Squarespace-hosted page. The page title is "Darena Health — ONC Certified Redirect". Critically, the page body contains a JavaScript redirect:

```javascript
window.location.href = "/onc-hti1-certified";
```

This means the registered URL at `/meldrx-onc-hti1-certified` is just a redirect stub that sends visitors to `/onc-hti1-certified`. The `#b10-EHI-Export-Documentation` fragment anchor exists on the destination page.

### Step 3: Browser navigation required

Used browser to navigate to the URL. The JavaScript redirect fired, sending us to `https://darena.health/onc-hti1-certified`. After the page loaded, the `#b10-EHI-Export-Documentation` anchor was present in the DOM and successfully scrolled into view.

A newsletter signup popup appeared and had to be dismissed by clicking the X button.

### Step 4: EHI Export Documentation section found

The section headed **"170.315 (b)(10) EHI Export Documentation"** contains the following content:

> Darena Health supports the export of EHI as follows:
>
> 1. FHIR Bulk Export Format: The user can export all available structured data through FHIR APIs as outlined in our [swagger documentation](https://app.meldrx.com/swagger/index.html). The output format is based on the FHIR [Bulk data standard](http://hl7.org/fhir/uv/bulkdata/STU1.0.1/)
>
> 2. For non-FHIR resources, Darena Health supports the export as [DocumentReference](https://www.hl7.org/fhir/documentreference.html) resource types. This resource can be used with any file, including CCDA.

This is the **entirety** of the EHI export documentation on the page. There is no data dictionary, no table listing, no field-level documentation, no downloadable PDF or ZIP. The documentation consists of two sentences pointing to the Swagger API docs and the FHIR Bulk Data standard.

### Step 5: Follow swagger documentation link

Navigated to https://app.meldrx.com/swagger/index.html

**Result**: Swagger UI page showing "Darena Health APIs v1" (OAS 3.0), version selector showing "v16". The API has 81 endpoints grouped into 18 sections:
- Apps (CDS Hooks)
- BulkSetup
- CqmScoresProcessingInfo
- Documents
- Downloads
- Encounters
- Fhir (generic FHIR CRUD endpoints)
- Import
- ImprovementActivityScores
- Invites
- McpDiscovery
- MeldRx.Account
- MipsReports
- Patients
- PromotingInteroperabilityScores
- QualityMeasureScores
- Tools
- WorkspaceExtensions

The FHIR endpoint is generic (`/api/fhir/{ws-slug}/{resourceType}`) and supports an `$Export` operation. The API schema contains 298 components total.

### Step 6: Downloaded Swagger JSON

```bash
curl -sL "https://app.meldrx.com/swagger/v1/swagger.json" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/darena-health-swagger-api-v16.json
```

646,785 bytes. JSON text data. Contains full OpenAPI 3.0 specification.

### Step 7: Identified downloadable assets

| Asset | URL | Type | Relevance |
|-------|-----|------|----------|
| Swagger API specification | https://app.meldrx.com/swagger/v1/swagger.json | JSON (646 KB) | Primary EHI documentation |
| ONC Certification page | https://darena.health/onc-hti1-certified | HTML (234 KB) | EHI section + cost transparency |

No PDF, ZIP, or other downloadable data dictionary was found. The entire EHI export documentation is the two-sentence description on the ONC page plus the Swagger API docs.

## Downloads

### darena-health-swagger-api-v16.json (646 KB)
```bash
curl -sL "https://app.meldrx.com/swagger/v1/swagger.json" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/darena-health-swagger-api-v16.json
```
Verified: `file` → JSON text data
Contains: Full OpenAPI 3.0 spec with 81 paths, 298 schemas
Saved to: downloads/darena-health-swagger-api-v16.json

### darena-health-onc-hti1-certified.html (234 KB)
```bash
curl -sL "https://darena.health/onc-hti1-certified" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/darena-health-onc-hti1-certified.html
```
Verified: `file` → HTML document, UTF-8 text
Contains: Full ONC certification page with EHI section, cost transparency table, certified criteria list
Saved to: downloads/darena-health-onc-hti1-certified.html

## Product Context

### Darena Health (formerly MeldRx / BlueButtonPRO)

Darena Health is **not an EHR**. It is a **middleware compliance platform** — a multi-tenant, cloud-based FHIR API service that other EHR vendors integrate with to achieve ONC certification. Darena provides pre-certified modules for criteria including (b)(10) EHI Export, (b)(11) DSI, (g)(10) Standardized API, and others.

The platform's value proposition is that EHR vendors can "plug in" to Darena's pre-certified API rather than building their own FHIR infrastructure. The EHR pushes its data into Darena's FHIR data store, and Darena handles the certified API and export requirements.

This creates a fundamental architectural question for b(10) compliance: **the EHI export can only export data that the upstream EHR has pushed into Darena**. If the EHR only sends clinical data to Darena (e.g., for USCDI compliance), then the Darena export will only contain clinical data — even though the EHR product stores billing, scheduling, messaging, and other data natively.

### Downstream Products

The 11 CHPL listings using Darena represent a diverse set of EHR products:

- **Amrita Hospital Information System** — hospital information system (India-focused)
- **Clinicmind** — practice management + EHR for behavioral health, chiropractic, and other specialties
- **Doctorsoft EHR** — general-purpose EHR
- **EZDERM** — dermatology-specific EHR
- **Epi-Management** — epidemiology/public health management (FEI Systems)
- **Office Anywhere** (Lancman Solutions) — mental health / behavioral health practice management
- **PIMSY Platinum** — behavioral health EHR and practice management
- **Raintree** — physical therapy / rehabilitation EHR and practice management
- **UnifiMD** (Complete Healthcare Solutions) — ambulatory EHR
- **WITS** (FEI Systems) — substance abuse treatment information system
- **eRAD RIS** — radiology information system

Many of these products have their own billing, scheduling, patient portal, and document management features. The Darena-based EHI export would only cover data that each EHR has mapped and pushed to the Darena FHIR platform.

## Obstacles & Notes

1. **Domain rebranding**: The registered URL uses `www.darenasolutions.com` which now redirects to `darena.health`. The page at the old domain is just a JavaScript redirect stub.

2. **Double redirect**: Registered URL → 301 to `darena.health/meldrx-onc-hti1-certified` → JS redirect to `/onc-hti1-certified`. Requires browser (JavaScript) to reach the actual content.

3. **Newsletter popup**: A Squarespace newsletter popup blocks the content and must be dismissed.

4. **Minimal documentation**: The entire EHI export documentation is two sentences. No data dictionary, no field definitions, no schema documentation beyond the Swagger API spec.

5. **Single documentation page for 11 products**: All 11 CHPL listings from different developers point to this same Darena page. There is no product-specific EHI export documentation for any of the individual EHR products.
