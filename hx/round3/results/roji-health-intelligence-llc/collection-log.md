# Roji Health Intelligence LLC — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 8332
- Registered URL: https://rojihealthintel.com/costs-and-limitations/
- Developer: Roji Health Intelligence LLC
- Product: Roji Clinical Data Registry, Version 2016

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://rojihealthintel.com/costs-and-limitations/" \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```
Result: **301 redirect** from `/costs-and-limitations/` to `/costs-and-requirements/` (redirect by Yoast SEO Premium), then **200 OK** at the new URL. Content-Type: text/html; charset=UTF-8. Site is behind Sucuri/Cloudflare (Sucuri WAF, Cloudflare CDN). No anti-bot blocking with standard User-Agent.

### Step 2: Page examination
```bash
curl -sL "https://rojihealthintel.com/costs-and-requirements/" \
  -H 'User-Agent: Mozilla/5.0' \
  -o /tmp/roji-page.html
```
Page size: 107,860 bytes. WordPress-based site (Genesis framework, "Breakthrough Pro" theme). Substantive HTML content — not a SPA. Content renders without JavaScript.

The page is titled "Costs and Requirements" and serves as the vendor's mandatory disclosures page. It contains:
- **Costs section**: Volume-based platform pricing for the Roji Clinical Data Registry (per-patient, per-provider, per-TIN, per-data-source pricing)
- **Requirements section**: Hardware/software requirements (64-bit workstation, 4+ GB RAM, modern browser)
- **ONC Health IT Certification section**: Certification details, modules tested, CQM list
- **Electronic Health Information (EHI) Export section**: Brief description of EHI export capability with link to data dictionary

### Step 3: Finding the EHI section
The EHI section is directly on the page — no accordion, no tabs, no JavaScript-based content loading required. It appears at the bottom of the page after the certification details. Searched the HTML:
```bash
grep -oiE 'href="[^"]*"' /tmp/roji-page.html | grep -iE 'ehi|export|data.dictionary|b.10'
```
Found one link: `href="https://client.rojihealthintel.com/helpfiles/ehi-export/patientexport.yml"`

The EHI section text reads:
> **Electronic Health Information (EHI) Export**
> Roji Health Intelligence supports both single patient and population exports. Single patient and population exports are available free of charge for users with patient level access in JSON format. Instructions for accessing, using and exporting are available to authorized users in the FAQ. The data dictionary is available [here](https://client.rojihealthintel.com/helpfiles/ehi-export/patientexport.yml).

### Step 4: Attempting to download the data dictionary
```bash
curl -sI "https://client.rojihealthintel.com/helpfiles/ehi-export/patientexport.yml" \
  -H 'User-Agent: Mozilla/5.0'
```
Result: **404 Not Found**. The server (`Server: Roji`) returns a generic IIS-style 404 error page. The file has been removed or moved from the client portal.

Also tried the parent directory:
```bash
curl -sI "https://client.rojihealthintel.com/helpfiles/ehi-export/" \
  -H 'User-Agent: Mozilla/5.0'
```
Result: Also **404 Not Found**.

### Step 5: Wayback Machine recovery
Checked the Wayback Machine CDX API for snapshots:
```bash
curl -s "https://web.archive.org/cdx/search/cdx?url=client.rojihealthintel.com/helpfiles/*&output=text&fl=timestamp,original,statuscode&limit=20"
```
Result: **One snapshot found** — `20240423174254` (April 23, 2024) with status 200.

Successfully retrieved the file from the Wayback Machine:
```bash
curl -sL "https://web.archive.org/web/20240423174254if_/https://client.rojihealthintel.com/helpfiles/ehi-export/patientexport.yml" \
  -H 'User-Agent: Mozilla/5.0' \
  -o downloads/patientexport.yml
```
Result: 16,576 bytes. Despite the `.yml` extension, the file is actually a **JSON Schema** document (JSON format, using JSON Schema draft-07). The `$schema` URL has a Wayback Machine prefix (`https://web.archive.org/web/20240423174254/http://json-schema.org/draft-07/schema#`) which is an artifact of the archival process; the original would have been `http://json-schema.org/draft-07/schema#`.

### Step 6: Saving the costs-and-requirements page
```bash
curl -sL "https://rojihealthintel.com/costs-and-requirements/" \
  -H 'User-Agent: Mozilla/5.0' \
  -o downloads/costs-and-requirements-page.html
```
Result: 107,860 bytes. Full HTML page saved for reference.

## Downloads

### patientexport.yml (16,576 bytes)
```bash
curl -sL "https://web.archive.org/web/20240423174254if_/https://client.rojihealthintel.com/helpfiles/ehi-export/patientexport.yml" \
  -H 'User-Agent: Mozilla/5.0' \
  -o downloads/patientexport.yml
```
- Original URL: https://client.rojihealthintel.com/helpfiles/ehi-export/patientexport.yml
- Retrieved from: Wayback Machine (snapshot 2024-04-23)
- Verified: `file patientexport.yml` → JSON text data
- Content: JSON Schema (draft-07) describing the "Roji Health Intelligence PatientData schema"
- Note: Original URL returns 404 as of 2026-02-13. File was only retrievable via Wayback Machine.
- Saved to: downloads/patientexport.yml

### costs-and-requirements-page.html (107,860 bytes)
```bash
curl -sL "https://rojihealthintel.com/costs-and-requirements/" \
  -H 'User-Agent: Mozilla/5.0' \
  -o downloads/costs-and-requirements-page.html
```
- Verified: HTML document
- Content: Full costs/requirements/certification/EHI export page
- Saved to: downloads/costs-and-requirements-page.html

## Obstacles & Notes
- The registered CHPL URL (`/costs-and-limitations/`) 301-redirects to `/costs-and-requirements/`, suggesting the page was renamed at some point (confirmed by Wayback Machine: the old URL was active 2019-2024, the new URL appears starting 2024-09).
- The data dictionary file (`patientexport.yml`) is currently **dead (404)** on the live client portal. It was only recoverable via the Wayback Machine's single snapshot from April 2024. This means the publicly-linked data dictionary has been inaccessible for an unknown period.
- The `.yml` file extension is misleading — the actual content is JSON, not YAML. This is a minor quality issue in the documentation.
- Export instructions are noted as "available to authorized users in the FAQ" — meaning only the data dictionary is publicly accessible; the actual export instructions require login to the client portal.

---

## Product: Roji Clinical Data Registry

### Product Context
Roji Clinical Data Registry is **not an EHR**. It is a **CMS-approved Qualified Clinical Data Registry (QCDR)** and quality reporting analytics platform, delivered as SaaS. The company (formerly known as ICLOPS, founded 2002) has operated as a CMS-qualified registry since 2008.

The product aggregates clinical data **from** existing EHR systems (via flat files, FHIR, HL7, and custom formats) into a patient-centric database. Its primary functions are:
- **Clinical quality measure (CQM/eCQM) calculation and reporting** for MIPS, MVPs, APP, and ACO programs
- **Episode-of-care cost analysis** using claims data
- **Population health analytics** and risk identification
- **Provider benchmarking and performance tracking**

The product is used by ACOs, health systems, and medical groups that already have separate EHR systems. It is a secondary analytics layer, not a primary system of record for clinical care.

The certified criteria confirm the product's narrow scope:
- **(c)(2)-(c)(4)**: Clinical quality measures import, calculate, report, filter — the core function
- **(b)(10)**: EHI export — the subject of this analysis
- **(d)(1)-(d)(3), (d)(5), (d)(12)-(d)(13)**: Privacy, security, access controls
- **(g)(4)-(g)(5)**: Quality management system, accessibility

Notably **absent** from certification:
- No (a)(1)-(a)(14) clinical data criteria (not a clinical EHR)
- No (e)(1) patient portal (no patient-facing features)
- No (f)(1)-(f)(7) public health reporting
- No (g)(7)-(g)(10) API access criteria

### Export Approach
The EHI export is a **native JSON export** of the registry's patient-level data. The page states: "Single patient and population exports are available free of charge for users with patient level access in JSON format."

The data dictionary (patientexport.yml, actually JSON Schema) defines a single `PatientData` object with these top-level sections:
1. **Demographics** — patient identifiers (Roji ID + source system IDs), name, DOB, contact info, payor, gender, race, ethnicity, death info
2. **QualityMeasures** — per-provider, per-measure quality data with eligibility triggers and compliance values
3. **PatientRisk** — risk score, BMI, smoking status, blood pressure
4. **Conditions** — list of conditions
5. **UtilizationProvider** — provider utilization data (NPI, taxonomy, visit counts, date ranges)
6. **Episodes** — episode-of-care data with cost information (AvgCost, EpisodeCost, CostDifference)
7. **Populations** — (empty schema, no properties defined)
8. **HistoryClaims** — claims history with diagnosis codes (DxCode1-8), procedure codes, modifier codes, service provider
9. **Immunizations** — vaccine name and administration dates
10. **Outcomes** — named outcomes with date/value pairs
11. **Medications** — (empty schema, no properties defined)

The export includes metadata: Author, Title, Created, CreatedBy, and schema references.

### EHI Coverage Assessment
This product stores a **very specific, narrow slice of health information** — it is a quality registry, not an EHR. The EHI export should be assessed relative to what the system actually stores, not what a full EHR would store.

**Clinical data**: Partially present. The export includes conditions, immunizations, outcomes, risk scores, vitals (BP, BMI, smoking), and medications (field exists but schema is empty). It also includes claims-derived diagnosis and procedure codes. However, this is aggregated/derived data — not primary clinical documentation (no progress notes, no orders, no lab result values, no radiology reports). This is appropriate given the product's nature as a registry that ingests summarized data.

**Secure messages**: Not present. The product has no patient portal or messaging capability, so this is expected and not a gap.

**Billing/financial**: Partially present. The `Episodes` section includes cost data (AvgCost, EpisodeCost, CostDifference), and `HistoryClaims` includes procedure codes and diagnosis codes. However, this is claims analytics data, not primary billing records. No dollar amounts on individual claims, no payment/adjustment records, no insurance billing detail. This is consistent with the product's role — it analyzes cost data from claims feeds but doesn't generate or manage billing.

**Insurance/coverage**: Minimally present. The Demographics section includes a single `Payor` field. No detailed insurance plan information, eligibility, authorization, or benefit data.

**Appointments/scheduling**: Not present. The product has no scheduling capability. `UtilizationProvider` tracks visit counts and date ranges but not individual appointment records.

**Documents/images**: Not present. The product has no document management or imaging capability. Not a gap given the product's nature.

**Audit**: Not present. Not expected in EHI exports.

### Issues & Red Flags
1. **Data dictionary is currently inaccessible (404)**. The linked file at `client.rojihealthintel.com/helpfiles/ehi-export/patientexport.yml` returns 404. It was only recoverable from the Wayback Machine (April 2024 snapshot). This is a compliance issue — the data dictionary should be publicly accessible per the CHPL listing.

2. **Empty schema sections**. The `Medications` and `Populations` sections are listed as required in the schema but have no properties defined (empty `{}`). It's unclear whether these fields are actually populated in the export or are placeholders.

3. **Export instructions behind login wall**. The page states "Instructions for accessing, using and exporting are available to authorized users in the FAQ." Only the data dictionary is publicly linked; the actual export procedure requires client portal access.

4. **Misleading file extension**. The data dictionary is a JSON Schema document with a `.yml` extension, suggesting limited attention to documentation quality.

5. **Schema lacks data types for some fields**. Several fields (Race, Ethnicity, DateOfDeath, CauseOfDeath, some fields in HistoryClaims) have no type specified, making the schema less useful as documentation.

6. **Typos in schema**. "Taxomomy" (should be "Taxonomy") in QualityMeasures, "Complience" (should be "Compliance") in Quality — suggests the schema was not carefully reviewed.

7. **No description fields**. The JSON Schema uses no `description` annotations — field names are the only documentation. For a data dictionary, this is sparse.
