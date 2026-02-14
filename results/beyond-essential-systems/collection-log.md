# Beyond Essential Systems — EHI Export Documentation Collection

Collected: 2025-02-14

## Source
- Registered URL: https://beyond-essential.slab.com/posts/tamanu-patient-summary-export-1jqz4yk5
- CHPL IDs: 10617
- Product: Tamanu EMR
- Developer: Beyond Essential Systems

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://beyond-essential.slab.com/posts/tamanu-patient-summary-export-1jqz4yk5" -H 'User-Agent: Mozilla/5.0'
```
Result: HTTP/2 200, Content-Type: text/html; charset=utf-8. Served via Cloudflare. Page is a Slab wiki post.

### Step 2: Page examination
The raw HTML (17,864 bytes) is a JavaScript SPA — Slab is a team wiki platform. Content renders client-side. Opened in browser to view.

The rendered page is titled **"Tamanu Patient Summary Export"** under the topic "Interoperability Manuals" within "Tamanu Public". The full text content is brief (~878 characters):

> The Tamanu Patient Summary is an export containing electronic health information (EHI) about a subject of care. It is designed to support the transfer of essential patient information across care providers for both planned and unplanned care.
>
> A summary document that maps the Tamanu EHI content, structure and syntax for the Tamanu Patient Summary export can be found at the below link. This document can be used to process a patient's data after it has been exported.
>
> **Tamanu Patient Summary Export Mapping** [link to Google Sheet]
>
> The Tamanu Patient Summary export has been developed in alignment with the below standards and specifications:
> - HL7 FHIR International Patient Summary Implementation Guide
> - SMART Health Links Protocol
> - ONC 170.315(b)(10) Electronic Health Information export
>
> The Real World Testing Plan for ONC can be found here.

### Step 3: Identifying the key artifact
The page links to a single export documentation artifact:
- **Tamanu Patient Summary Export Mapping** → Google Spreadsheet at `https://docs.google.com/spreadsheets/d/1jPr3nRZWfiYqV5nqJpwdDIMXhWPRHwZm#gid=2084081531`

Other links are to external standards (HL7, SMART Health Links, ONC test procedure) — not followed per instructions.

### Step 4: Downloading the Google Spreadsheet
```bash
curl -sL "https://docs.google.com/spreadsheets/d/1jPr3nRZWfiYqV5nqJpwdDIMXhWPRHwZm/export?format=xlsx" \
  -o tamanu-patient-summary-export-mapping.xlsx -H 'User-Agent: Mozilla/5.0'
```
Result: Downloaded 58,417 bytes. Verified as "Microsoft Excel 2007+".

The spreadsheet contains **9 sheets**:
1. **Overview** (2 rows) — Title and description, lists the same three standards
2. **Bundle** (20 rows × 5 cols) — FHIR Bundle resource mapping (FHIRPath → Tamanu field → Data Type → Example → Notes)
3. **Composition** (50 rows × 5 cols) — FHIR Composition resource mapping (sections for allergies, conditions, immunizations, medications, etc.)
4. **Patient** (4 rows × 5 cols) — Patient resource mapping (id, text)
5. **AllergyIntolerance** (12 rows × 5 cols) — AllergyIntolerance resource mapping
6. **Condition** (13 rows × 5 cols) — Condition resource mapping
7. **Immunization** (14 rows × 5 cols) — Immunization resource mapping
8. **MedicationStatement** (21 rows × 5 cols) — MedicationStatement resource mapping
9. **REF Configurable defaults** (8 rows × 3 cols) — Configurable encoding defaults (SNOMED CT for conditions/allergies, NZMT for immunizations/medications)

Each mapping sheet has columns: FHIRPath (specs), Tamanu (source field/transform), Data Type, Example, Notes.

### Step 5: Extracting CSVs from the spreadsheet
Extracted each sheet as a separate CSV file for machine-readability using openpyxl.

### Step 6: Checking the Interoperability Manuals topic
Navigated to https://beyond-essential.slab.com/topics/interoperability-manuals-t73felcd

The topic contains:
- **Posts**: "ONC Real World Testing" and "Tamanu Patient Summary Export" (the page we already have)
- **FHIR API** section: "Design Principles", "Jump straight in: Fetch a Patient", "Workflow: Patient Master Index"

The FHIR API section is a separate system from the EHI export — the export uses FHIR IPS (International Patient Summary) format delivered via SMART Health Links, not the FHIR API. Per instructions, did not follow FHIR API docs.

### Step 7: Screenshots
Captured screenshots of:
- The main Slab page (tamanu-patient-summary-export)
- The Google Spreadsheet overview
- The Interoperability Manuals topic page

## Downloads

### tamanu-patient-summary-export-mapping.xlsx (57 KB)
```bash
curl -sL "https://docs.google.com/spreadsheets/d/1jPr3nRZWfiYqV5nqJpwdDIMXhWPRHwZm/export?format=xlsx" \
  -o tamanu-patient-summary-export-mapping.xlsx -H 'User-Agent: Mozilla/5.0'
```
Verified: Microsoft Excel 2007+, 9 sheets
Saved to: downloads/tamanu-patient-summary-export-mapping.xlsx
Content: EHI export data dictionary / field mapping. Maps Tamanu internal fields to FHIR IPS resources (Bundle, Composition, Patient, AllergyIntolerance, Condition, Immunization, MedicationStatement) with examples and configurable encoding defaults.

### csv-sheets/ (9 CSV files, 20 KB total)
Extracted from the XLSX for machine-readability:
- overview.csv, bundle.csv, composition.csv, patient.csv, allergyintolerance.csv, condition.csv, immunization.csv, medicationstatement.csv, ref-configurable-defaults.csv

### tamanu-patient-summary-export-page.txt (1.3 KB)
Full text content of the Slab wiki page.

### screenshot-main-page.png (64 KB)
Screenshot of the registered documentation URL.

### screenshot-spreadsheet.png (60 KB)
Screenshot of the Google Sheets export mapping document (Overview tab).

### screenshot-interop-manuals-topic.png (30 KB)
Screenshot of the Interoperability Manuals topic showing all available documentation.

## Access Summary
- Final URL (after redirects): https://beyond-essential.slab.com/posts/tamanu-patient-summary-export-1jqz4yk5
- Status: found
- Required browser: yes (Slab is a JavaScript SPA; content doesn't render in curl)
- Navigation complexity: one_click (main page → single Google Sheets link)
- Anti-bot issues: none

## Export Format Summary

The Tamanu Patient Summary export produces a **FHIR IPS (International Patient Summary) Bundle** delivered via the **SMART Health Links Protocol**. The export contains:

| FHIR Resource | Tamanu Data | Fields Mapped |
|---|---|---|
| Bundle | Container | 20 fields (type, identifier, timestamp, etc.) |
| Composition | Document structure | 50 fields (sections for allergies, conditions, immunizations, medications) |
| Patient | Demographics | 4 fields (id, text) |
| AllergyIntolerance | Patient allergies | 12 fields (code, clinical status, verification, category) |
| Condition | Diagnoses/conditions | 13 fields (code, clinical status, subject) |
| Immunization | Vaccinations | 14 fields (vaccine code, occurrence, status, lot number) |
| MedicationStatement | Medications | 21 fields (medication code, status, dosage, effective period) |

Configurable encoding systems:
- Conditions & Allergies: SNOMED CT (`http://snomed.info/sct`)
- Immunizations & Medications: NZMT (`http://nzmt.org.nz`) — New Zealand Medicines Terminology

## Obstacles & Dead Ends
- Slab wiki requires JavaScript rendering — curl only gets the SPA shell
- Google Sheets required export URL construction (append `/export?format=xlsx`)
- GitHub code search was rate-limited; however, the registered documentation (the spreadsheet) is the authoritative artifact
- The documentation is minimal — a single page with a single linked spreadsheet. This is consistent with a vendor that obtained minimal ONC certification ((b)(10) only) for international credibility rather than US market entry
