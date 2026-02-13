# Darena Health (MeldRx) — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11047, 11050, 11071, 11085, 11124, 11125, 11169, 11185, 11392, 11474, 11764
- **Developers**: Amrita Ventures LLC, Clinicmind Inc., Complete Healthcare Solutions Inc., Doctorsoft Corporation, EZDERM LLC, Ennoble Technologies LLC, FEI Systems, Lancman Solutions LLC, Raintree Systems Inc., Smoky Mountain Information Systems LLC, eRAD Inc.
- **Products**: Amrita Hospital Information System, Clinicmind, Doctorsoft EHR, EZDERM, Epi-Management, Office Anywhere, PIMSY Platinum, Raintree, UnifiMD, Web Infrastructure for Treatment Services (WITS), eRAD RIS
- **Registered URL**: https://www.darenasolutions.com/meldrx-onc-hti1-certified#b10-EHI-Export-Documentation

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.darenasolutions.com/meldrx-onc-hti1-certified#b10-EHI-Export-Documentation" -H 'User-Agent: Mozilla/5.0'
```
**Result:**
- **301** → `https://darena.health/meldrx-onc-hti1-certified` (domain rebranded from darenasolutions.com to darena.health)
- **200** text/html;charset=utf-8, 14091 bytes (Squarespace-hosted)

### Step 2: Page examination
```bash
curl -sL "https://darena.health/meldrx-onc-hti1-certified" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
```
The initial page at `/meldrx-onc-hti1-certified` is a thin Squarespace redirect page (14 KB). It contains a JavaScript redirect:
```javascript
window.location.href = "/onc-hti1-certified";
```

### Step 3: Following the redirect
```bash
curl -sL "https://darena.health/onc-hti1-certified" -H 'User-Agent: Mozilla/5.0' -o /tmp/page2.html
```
**Result:** 234 KB HTML page. This is the main ONC certification page, hosted on Squarespace. Contains substantial HTML content (not a SPA — content is in the HTML source). Page title: "Darena Health — ONC HTI-1 Certified Solution".

### Step 4: Finding the EHI section
Searched the HTML for the `b10-EHI-Export-Documentation` anchor:
```bash
grep -i 'b10-EHI-Export' /tmp/page2.html
```
Found the anchor ID in the page. Navigated to it in the browser at `https://darena.health/onc-hti1-certified#b10-EHI-Export-Documentation`.

The section is titled **"170.315 (b)(10) EHI Export Documentation"** and contains only two brief paragraphs:

> Darena Health supports the export of EHI as follows:
> 1. FHIR Bulk Export Format: The user can export all available structured data through FHIR APIs as outlined in our [swagger documentation](https://app.meldrx.com/swagger/index.html). The output format is based on the FHIR [Bulk data standard](http://hl7.org/fhir/uv/bulkdata/STU1.0.1/)
> 2. For non-FHIR resources, Darena Health supports the export as [DocumentReference](https://www.hl7.org/fhir/documentreference.html) resource types. This resource can be used with any file, including CCDA.

That's it — no data dictionary, no field listing, no table/resource enumeration.

### Step 5: Following linked documentation

**Swagger documentation** (https://app.meldrx.com/swagger/index.html):
```bash
curl -sI "https://app.meldrx.com/swagger/index.html" -H 'User-Agent: Mozilla/5.0'
```
**Result: 404 Not Found.** The swagger endpoint is dead. Also tried https://app.meldrx.com/swagger — also 404.

**Darena Health Docs** (https://docs.darena.health/):
```bash
curl -sI "https://docs.darena.health/" -H 'User-Agent: Mozilla/5.0'
```
**Result: 200 OK.** This is a Postman-hosted API documentation portal. Contains sections:
- Introduction
- Getting Started
- Workspace Permissions
- Darena Health Use Cases
- Darena Health APIs for Cures Act Compliance
- HTI-1 (g10 & b11)
- MIPS API
- FHIR to MIPS
- Developer Account
- FHIR API

The documentation is focused on API integration for third-party app developers. There is **no EHI-specific data dictionary** — no listing of FHIR resource types included in the export, no field-level documentation, no description of what data is actually in the bulk export.

### Step 6: Checking other links on the page
Searched for any downloadable files (PDF, ZIP, etc.):
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page2.html
```
Found only Real-World Testing PDFs (2022, 2023, 2024, 2025) and a license agreement. None are EHI export documentation.

### Step 7: Browsing the solutions/product pages
Visited https://darena.health/hti-1-ready-certified-modules in the browser. This is a marketing page describing Darena Health as a "plug-and-play compliance" platform for (g)(10), (b)(10), (b)(11), (c)(1-4). No EHI data dictionary here either.

## Downloads

### darena-health-onc-certification-page.html (234 KB)
```bash
curl -sL "https://darena.health/onc-hti1-certified" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/darena-health-onc-certification-page.html
```
Verified: HTML document, UTF-8 text. Contains the full ONC certification page including the b(10) EHI Export section.
Saved to: downloads/darena-health-onc-certification-page.html

### darena-health-api-docs.html (40 KB)
```bash
curl -sL "https://docs.darena.health/" -H 'User-Agent: Mozilla/5.0' \
  -o downloads/darena-health-api-docs.html
```
Verified: HTML document, ASCII text. Postman-hosted API documentation portal (rendered mostly via JavaScript).
Saved to: downloads/darena-health-api-docs.html

## Product Context

**Darena Health (formerly MeldRx, BlueButtonPRO)** is NOT an EHR. It is a **FHIR middleware platform** — a SaaS API layer that sits between EHR systems and patient-facing apps. It provides ONC-certified modules that other EHR vendors can integrate to achieve certification compliance. Darena Health describes itself as "the nation's first ONC Certified FHIR API."

The 11 EHR products listed in the CHPL entries use Darena Health as their certified module for b(10), g(10), and other criteria. These are the actual products storing patient data:

- **Amrita Hospital Information System** — full hospital information system
- **Clinicmind** — chiropractic/PT/mental health practice management with billing, scheduling, patient portal
- **Doctorsoft EHR** — ophthalmology-specific EHR
- **EZDERM** — dermatology EHR with clinical images
- **Epi-Management** — epidemiology/public health management
- **Office Anywhere** — behavioral health EHR (FEI Systems)
- **PIMSY Platinum** — behavioral health practice management with billing
- **Raintree** — physical therapy/rehab EMR with billing, scheduling, patient engagement
- **UnifiMD** — full EHR + practice management (with Lytec billing)
- **WITS** — substance abuse treatment management system
- **eRAD RIS** — radiology information system

Every one of these products stores substantial non-clinical data (billing, scheduling, specialty workflows, state reporting) that is far beyond what a FHIR Bulk Export can represent.

## Obstacles & Notes

1. **Domain rebrand**: The registered URL at `www.darenasolutions.com` redirects to `darena.health`. Two redirects to reach the actual content.
2. **JavaScript redirect**: The page at the registered path (`/meldrx-onc-hti1-certified`) does a JS-based redirect to `/onc-hti1-certified`.
3. **Newsletter popup**: A newsletter signup popup appears when scrolling, requiring dismissal.
4. **Swagger docs are dead**: The linked swagger documentation at `app.meldrx.com/swagger/index.html` returns 404.
5. **No actual data dictionary exists**: The b(10) section contains only two sentences describing the export approach. There is no data dictionary, no resource listing, no field definitions — just a reference to FHIR Bulk Export and DocumentReference.
6. **Middleware architecture creates a fundamental gap**: Because Darena Health is middleware (not the EHR itself), it can only export data that EHR vendors push into it via FHIR. It has no direct access to the underlying EHR databases. The export is limited to whatever FHIR resources the EHR vendor chose to map.
