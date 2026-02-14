# Clinigence Health — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 9843
- Registered URL: https://support.clinigence.com/support/solutions/articles/3000123715-patient-record-export/

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://support.clinigence.com/support/solutions/articles/3000123715-patient-record-export/" -H 'User-Agent: Mozilla/5.0'
```

Result: HTTP/2 200 directly (no redirects). Content-Type: `text/html; charset=utf-8`. The page is hosted on Freshdesk (support portal). Cloudflare is in front (`cf-ray` header, `server: cloudflare`). No anti-bot issues encountered with a basic User-Agent header.

### Step 2: Page examination

```bash
curl -sL "https://support.clinigence.com/support/solutions/articles/3000123715-patient-record-export/" -H 'User-Agent: Mozilla/5.0' -o /tmp/clinigence-page.html
wc -c /tmp/clinigence-page.html
```

Result: 22,020 bytes. This is a Freshdesk support article page with substantive HTML content — not a JavaScript SPA. The article body is contained within an `<article class="article-body" id="article-body">` element.

### Step 3: Extracting the article content

The article text (extracted from `<article>` tag) reads:

> Clinigence Health clients can export a single patient record via the patient summary screen. To export large sets of patients contact the Clinigence Health support site at support@clinigence.com and Clinigence Health will assist you with the request.
>
> To export a single patient record, log into the Clinigence Health web application, click on the Patients tab, and navigate to the patient summary screen. On the screen click on the "Export Patient" button as shown in the image below.
>
> The patient record is exported in the "Version 5" XML format, one patient per file. Attached to this page you will find a Zip file which contains:
> - notes on how to interpret the Version 5 files.
> - the Version 5 schema.
> - a sample patient file in Version 5 format.
>
> Note that the data included in the export is limited to the data received by Clinigence Health from the data source(s) and is mapped to the Clinigence Health clinical ontology.

### Step 4: Identifying downloadable assets

```bash
grep -oiE 'href="/helpdesk/attachments/[^"]*"' /tmp/clinigence-page.html
```

Found one attachment link: `href="/helpdesk/attachments/3101377237"`

Probed the attachment:
```bash
curl -sI -L "https://support.clinigence.com/helpdesk/attachments/3101377237" -H 'User-Agent: Mozilla/5.0'
```

Result: HTTP 302 redirect to a signed Amazon S3 URL for `Version%205.zip` (application/octet-stream, Content-Length: 30,916 bytes). The file is stored on Freshdesk's attachment CDN (`clinigence.attachments6.freshdesk.com`).

No other downloadable files were found on the page. No PDFs, no additional ZIP files, no data dictionary documents beyond what's in the ZIP.

## Downloads

### version-5.zip (30,916 bytes)
```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/version-5.zip \
  'https://support.clinigence.com/helpdesk/attachments/3101377237'
```

Verified: `file version-5.zip` → Zip archive data, made by v6.3, extract using at least v2.0
Last modified: Sun, Mar 22 2018 17:19:00

Contents (`unzip -l version-5.zip`):
| Size | Date | Name |
|------|------|------|
| 54,241 | 2018-03-22 | Clinigence V5 Export Sample.xml |
| 25,581 | 2018-03-20 | Notes on Using Version 5.docx |
| 28,123 | 2018-03-20 | Version 5 schema.xsd |

Total: 107,945 bytes uncompressed across 3 files.

Extracted to: `downloads/version-5-extracted/`

### File descriptions:

1. **Notes on Using Version 5.docx** — A Word document explaining the Version 5 XML format. Describes the hierarchical data model (Objects, Properties, Facts), explains how dates work, defines the concept of Actors, Patients, Programs/Guidelines/Measures, and lists all valid Clinigence Object Classes (32 classes total).

2. **Version 5 schema.xsd** — The XML Schema Definition (XSD) file for the Version 5 format. Defines `ClinigencePatientData` as the root element containing Actor and Patient elements. Patients contain Properties (demographics), Programs (quality measures), and Objects (clinical data). Objects have a `class` attribute and contain Properties which contain Facts. UniversalKey elements provide coded references (LOINC, CPT, RxNorm, ICD, etc.).

3. **Clinigence V5 Export Sample.xml** — A sample patient export file for a fictional patient "Wiley Cayote" at "ACME Family Practice." Contains: demographics (gender, DOB, address, race, ethnicity), provider relationships, payer policy number, quality measure program assignments (2017 Clinical Quality Measures with multiple guidelines), and clinical objects including Encounters (with CPT codes), Labs, Medications (with RxNorm codes), Vital Signs (with LOINC codes), and Patient demographics objects.

Saved to: `downloads/version-5.zip` and extracted to `downloads/version-5-extracted/`

## Obstacles & Notes

- No anti-bot issues. Standard curl with User-Agent header worked perfectly.
- The Freshdesk attachment URL uses a 302 redirect to a time-limited signed S3 URL. The redirect is transparent to curl with `-L`.
- The ZIP file dates from March 2018 — nearly 8 years old and predating the final b(10) compliance deadline. The documentation has not been updated.
- The article mentions an image showing the "Export Patient" button but the image was not captured (it's rendered inline on the Freshdesk page, not a downloadable asset).
- Bulk export requires contacting Clinigence Health support (support@clinigence.com) — only single-patient export is self-service via the UI.

---

## Product: Clinigence Value Improvement Platform (VIP)

### Product Context

Clinigence Health's Value Improvement Platform (VIP) is **not an EHR**. It is a cloud-based healthcare analytics and population health management platform that specializes in clinical quality measure (CQM) reporting, value-based care analytics, and population health insights.

The platform **aggregates data from external sources** — EHR systems, claims feeds — via structured formats (CCDa, QRDA CAT 1, HL7, proprietary formats). It does not create or manage clinical documentation itself. It ingests data, maps it to its internal "clinical ontology" (the Version 5 format), calculates quality measures, and produces analytics dashboards.

Key characteristics:
- **CMS Qualified Registry** — submits MIPS data to CMS for providers
- **Certified criteria** are narrowly scoped: (b)(10) EHI export, (c)(1)-(c)(3) CQMs, (d)(1)-(d)(13) privacy/security, (g)(4)-(g)(5) quality management
- **No clinical data criteria** — does not have (a)(1)-(a)(14), confirming it is not a clinical system
- **No patient portal** — no (e)(1) certification
- **No FHIR APIs** — no (g)(7)-(g)(10) certification
- Serves health plans, ACOs, DCEs, provider groups, TPAs
- Acquired by AssureCare in 2024; originally a subsidiary of Nutex Health

The vendor's website (clinigencehealth.com) confirms the platform does not have billing/revenue cycle management, appointment scheduling, a patient portal, or document management capabilities. It analyzes claims data for cost insights but does not generate or manage billing workflows.

### Export Approach

The export uses Clinigence's proprietary "Version 5" XML format. One patient per XML file. The format is a hierarchical tree structure with:
- **Actors** — organizations and providers referenced in the data
- **Patients** — containing demographics (as Properties), quality measure assignments (Programs/Guidelines/Measures), and clinical data (as Objects)
- **Objects** — clinical data containers classified by type (32 defined object classes), each containing Properties and Facts with optional coded references (UniversalKey)

This is **not** a native database export, FHIR export, or C-CDA export. It is a proprietary XML schema designed for Clinigence's data exchange. The export contains only data that has been "received by Clinigence Health from the data source(s) and is mapped to the Clinigence Health clinical ontology" — meaning it's a re-export of aggregated clinical and claims data, not original source data.

The sample file demonstrates: demographics, encounter data (with CPT codes), lab results, medications (with RxNorm), vital signs (with LOINC), and quality measure classifications. It notably includes a Payer policy number in the patient's UniversalKey.

### EHI Coverage Assessment

The 32 defined object classes in Version 5 are:
Act, Adverse Event, Adverse Reaction, Allergy, Assertion, Care Goal, Care Plan, Communication, Device, Diagnosis, Diagnostic Study, Encounter, Followup, Health Maintenance, Immunization, Intolerance, Lab, Medication, Negation Rationale, Note, Observation, Payer, Physical Exam, Procedure, Rationale, Referral, Refill Request, Review of Systems, Social History, Substance, Symptom, Transfer, Vital Signs

**Clinical**: Strong coverage. Object classes cover diagnoses, medications, allergies, labs, immunizations, procedures, vital signs, social history, care plans, care goals, observations, and notes. Standard clinical terminology codes are supported via UniversalKey (LOINC, CPT, RxNorm, ICD, SNOMED).

**Secure messages**: Not present. No object class for messages or communications between patients and providers. The "Communication" object class exists but the documentation does not clarify its use, and the product has no patient portal, so there would be no patient-provider messaging data to export. This absence is not a gap given the product's nature.

**Billing/financial**: Minimal. CPT codes appear on Encounter objects, but there are no dedicated billing line items, charges, payments, claims, or financial amounts. The "Payer" object class exists but the sample only shows a policy number in a UniversalKey. Since Clinigence ingests claims data for analytics, it likely stores some billing/claims information internally, but the export format does not appear designed to convey billing detail with dollar amounts.

**Insurance/coverage**: Minimal. A "Payer" object class exists, and the sample file shows a payer policy number. But there are no dedicated fields for eligibility, authorization, benefits, copay, or deductible information.

**Appointments/scheduling**: Not present. The "Encounter" object class records encounters that have occurred (with dates and CPT codes), but there is no scheduling or appointment booking functionality. This is expected — the platform is an analytics tool, not a scheduling system.

**Documents/images**: Not present. No object classes for scanned documents, uploaded images, attachments, or DICOM data. The "Note" class could potentially contain free-text clinical notes, but there are no binary document/image capabilities. This is expected given the platform's nature.

**Audit trails**: Not present. No object classes for access logs or audit trails. (Not expected per HIPAA Designated Record Set.)

### Issues & Red Flags

1. **Documentation is extremely dated** — The ZIP file dates from March 2018 (nearly 8 years old). The schema version is "1.0.3" and the sample data references "2017 Clinical Quality Measures." No evidence of updates since initial certification.

2. **Bulk export requires contacting support** — Only single-patient export is self-service. Bulk export requires emailing support@clinigence.com. This is a usability concern for the b(10) requirement, which envisions patients being able to obtain their data.

3. **Export is limited to mapped data** — The article explicitly states: "the data included in the export is limited to the data received by Clinigence Health from the data source(s) and is mapped to the Clinigence Health clinical ontology." This means any data the platform received but could not map would be excluded from the export.

4. **Proprietary format with limited tooling** — Version 5 XML is a Clinigence-specific format. Unlike FHIR, C-CDA, CSV, or standard database dumps, there is no ecosystem of tools to parse this format. Recipients need the provided documentation to interpret the data.

5. **Product is not an EHR** — This is a critical context issue. The platform stores aggregated/derived data from other systems, not original clinical records. The EHI export therefore contains a secondary copy of data, not the authoritative source. This significantly changes the completeness analysis — the product genuinely does not store billing workflows, scheduling, messaging, or document management data because it is an analytics overlay, not a primary clinical system.

6. **Claims data gap** — While the platform ingests claims data for analytics purposes, the Version 5 export format appears to primarily model clinical data. Claims-derived financial data (charge amounts, payment amounts, adjustments) does not appear to have clear representation in the schema, even though Clinigence likely stores it internally for cost/utilization analysis.
