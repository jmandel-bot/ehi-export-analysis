# Darena Health (formerly MeldRx/BlueButtonPRO) — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 11047, 11050, 11071, 11085, 11124, 11125, 11169, 11185, 11392, 11474, 11764
- Developers: Amrita Ventures, LLC; Clinicmind Inc.; Complete Healthcare Solutions, Inc.; Doctorsoft Corporation; EZDERM, LLC; Ennoble Technologies LLC; FEI Systems; Lancman Solutions LLC; Raintree Systems, Inc.; Smoky Mountain Information Systems, LLC; eRAD, Inc.
- Products: Amrita Hospital Information System, Clinicmind, Doctorsoft EHR, EZDERM, Epi-Management, Office Anywhere, PIMSY Platinum, Raintree, UnifiMD, Web Infrastructure for Treatment Services (WITS), eRAD RIS
- Registered URL: https://www.darenasolutions.com/meldrx-onc-hti1-certified#b10-EHI-Export-Documentation

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.darenasolutions.com/meldrx-onc-hti1-certified#b10-EHI-Export-Documentation" -H 'User-Agent: Mozilla/5.0'
```

**Result:** 301 redirect from `www.darenasolutions.com/meldrx-onc-hti1-certified` to `darena.health/meldrx-onc-hti1-certified`, then 200 OK. Content-Type: `text/html;charset=utf-8`. The old `darenasolutions.com` domain redirects to the new `darena.health` domain (company rebranded from MeldRx to Darena Health).

### Step 2: Page examination

The page at `darena.health/meldrx-onc-hti1-certified` is a Squarespace-hosted page (14 KB) that contains a JavaScript redirect:
```javascript
window.location.href = "/onc-hti1-certified";
```

So the actual content is at `https://darena.health/onc-hti1-certified` (234 KB, substantial HTML content served by Squarespace).

```bash
curl -sL "https://darena.health/onc-hti1-certified" -H 'User-Agent: Mozilla/5.0' -o /tmp/page2.html
wc -c /tmp/page2.html  # 234237 bytes
```

This page has real HTML content accessible via curl (not a JS SPA), though the JS redirect from the registered URL means you need to follow two hops.

### Step 3: Finding the EHI section

The page has an anchor `#b10-EHI-Export-Documentation` corresponding to:
```html
<h2 id="b10-EHI-Export-Documentation">170.315 (b)(10) EHI Export Documentation</h2>
```

The section contains two short paragraphs:

> Darena Health supports the export of EHI as follows:
>
> 1. FHIR Bulk Export Format: The user can export all available structured data through FHIR APIs as outlined in our [swagger documentation](https://app.meldrx.com/swagger/index.html). The output format is based on the FHIR [Bulk data standard](http://hl7.org/fhir/uv/bulkdata/STU1.0.1/)
>
> 2. For non-FHIR resources, Darena Health supports the export as [DocumentReference](https://www.hl7.org/fhir/documentreference.html) resource types. This resource can be used with any file, including CCDA.

That's the **entire** b(10) EHI export documentation — two sentences.

### Step 4: Swagger documentation link (dead)

The swagger link referenced in the EHI section is dead:
```bash
curl -sI "https://app.meldrx.com/swagger/index.html" -H 'User-Agent: Mozilla/5.0'
# HTTP/2 404

curl -sI "https://app.meldrx.com/swagger" -H 'User-Agent: Mozilla/5.0'
# HTTP/2 404
```

Both the swagger index.html and the swagger root return 404.

### Step 5: Alternative API documentation

The page footer links to:
- **Documentation**: https://docs.darena.health/ (Postman-hosted API docs)
- **API reference**: https://app.meldrx.com/swagger (dead, 404)

The Postman documentation at https://docs.darena.health/ is live and contains:
- Introduction
- Getting Started
- Workspace Permissions
- Darena Health Use Cases
- **Darena Health APIs for Cures Act Compliance**
  - **HTI-1 (g10 & b11)**
    - Get Connected
    - G10: Import(Upload) DH Schema, Import(Upload) CCDA, Import(Upload) CCDA Raw Body, Send Invite, Upload DocumentReference
    - G9: Create CCDA from DH Schema, Validate CCDA, Get Patient, Get CCDA DocumentReference for date, Get CCDA DocumentReference for date range
    - B11(DSI)
    - Workspace Management
    - **Bulk Export**: System App Token, Get Workspace Details, Get Groups, **Start Bulk Export**, Get Content
    - Patient Connect
  - MIPS API
  - FHIR to MIPS
  - Developer Account
  - FHIR API: Get Patients, Get Patient by Identifier, Get Resource by Patient Id

### Step 6: Swagger JSON (from previous collection)

A Swagger JSON file (v16) was previously downloaded and is available at `downloads/darena-health-swagger-api-v16.json` (647 KB). It reveals:
- The API is OpenAPI 3.0.1 titled "Darena Health APIs"
- Bulk export endpoint: `GET /api/fhir/{ws-slug}/Group/{group_id}/$export`
- Content retrieval: `GET /api/BackgroundJobs/{WORKSPACE_ID}/bulk-export/{job_id}`
- Generic FHIR resource access: `GET /api/fhir/{ws-slug}/{resourceType}`
- CCDA import/export
- MIPS reporting APIs
- DocumentReference upload

### Step 7: Identified downloadable assets

1. ONC Certification page HTML (the EHI section) — `darena-health-onc-certified-page.html`
2. Postman API documentation HTML — `darena-health-api-docs.html`
3. Swagger JSON API specification — `darena-health-swagger-api-v16.json`

No PDF data dictionary, no ZIP export, no schema documentation. The entire EHI documentation consists of two sentences on a web page plus API endpoint docs.

## Downloads

### darena-health-onc-certified-page.html (234 KB)
```bash
curl -sL "https://darena.health/onc-hti1-certified" -H 'User-Agent: Mozilla/5.0' -o darena-health-onc-certified-page.html
```
Verified: HTML document, 234,237 bytes
Contains the b(10) EHI Export Documentation section with two bullet points.

### darena-health-api-docs.html (40 KB)
```bash
curl -sL "https://docs.darena.health/" -H 'User-Agent: Mozilla/5.0' -o darena-health-api-docs.html
```
Verified: HTML document, 39,942 bytes
Postman documentation — requires JavaScript to render fully. Content was explored via browser.

### darena-health-swagger-api-v16.json (647 KB)
Swagger/OpenAPI 3.0.1 specification for Darena Health APIs. Contains all API paths, parameters, and data models.

## Product Context

**Darena Health (formerly MeldRx, formerly BlueButtonPRO) is NOT an EHR.** It is a FHIR middleware/compliance platform that provides certified modules to EHR vendors so they can achieve ONC certification. It is described as:

> "FHIR-first solutions that seamlessly integrate with EHRs, turning regulatory compliance into a pathway for improving patient outcomes."

The platform provides:
- **HTI-1 Certified Modules** — Cures Act compliance (g10, b10, b11, d criteria)
- **MIPS Reporting** — Qualified registry, measure analysis, data submission
- **Patient Connect** — Patient-mediated data exchange
- **Custom FHIR Solutions** — White-label FHIR integration

**Critical implication for EHI export:** Darena Health's b(10) export only covers data that has been loaded into the Darena Health FHIR workspace. The actual patient data lives in the underlying EHR systems (Clinicmind, Raintree, EZDERM, etc.). The 11 products listed in CHPL are full-featured EHR/practice management systems in diverse specialties (dermatology, behavioral health, substance abuse treatment, radiology, etc.) that use Darena Health as their compliance middleware.

The EHI export can only export what has been synchronized to the Darena FHIR layer — which is typically USCDI clinical data mapped to FHIR resources. The bulk of each product's native data (billing, scheduling, secure messages, specialty-specific data, audit trails) likely remains in the underlying EHR database and is NOT accessible through Darena Health's export.

## Obstacles & Notes

1. **Domain redirect chain**: `www.darenasolutions.com` → `darena.health/meldrx-onc-hti1-certified` → JS redirect to `/onc-hti1-certified`. Three hops to reach actual content.
2. **Swagger link is dead**: The EHI section links to `app.meldrx.com/swagger/index.html` which returns 404. The replacement is `docs.darena.health` but this isn't referenced from the EHI section.
3. **Newsletter popup overlay**: A newsletter signup popup obscures the EHI section content when viewing in a browser.
4. **Shared certification across 11 products**: This is one of the most extreme cases of shared certification — 11 different EHR products from 11 different developers, serving specialties from dermatology to substance abuse to radiology, all sharing a single 2-sentence EHI export documentation page from a FHIR middleware vendor.
