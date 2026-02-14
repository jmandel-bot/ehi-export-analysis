# Astronaut, LLC — EHI Export Documentation

Collected: 2025-02-14

## Source
- Registered URL: https://astronautehr.com/index.php/disclosures/export-format-documentation/
- CHPL ID: 10809
- CHPL Product Number: 15.02.05.3099.ASTR.01.00.1.220201
- Product: Astronaut EHR, Version 1709
- Developer: Astronaut, LLC

## Navigation Journal

1. **HTTP probe** of the registered URL:
   ```
   curl -sI -L "https://astronautehr.com/index.php/disclosures/export-format-documentation/" -H 'User-Agent: Mozilla/5.0'
   ```
   Returned HTTP 200, `Content-Type: text/html; charset=UTF-8`. WordPress site behind Cloudflare. No redirect.

2. **Fetched HTML page** and searched for downloadable files:
   ```
   curl -sL "https://astronautehr.com/index.php/disclosures/export-format-documentation/" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
   grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|csv|json)[^"]*"' /tmp/page.html
   ```
   Found one PDF link: `https://astronautehr.com/wp-content/uploads/2025/08/Astronaut-EHR-Export-Format-Documentation.pdf`

3. **Page structure**: The WordPress page titled "Export Format Documentation" embeds the PDF inline via an `<object>` tag (which fails to render in browsers without a PDF plugin, showing "Couldn't load plugin.") and provides a download link. No other documentation files are linked.

4. **Downloaded the PDF**:
   ```
   curl -sL -H 'User-Agent: Mozilla/5.0' -o Astronaut-EHR-Export-Format-Documentation.pdf \
     'https://astronautehr.com/wp-content/uploads/2025/08/Astronaut-EHR-Export-Format-Documentation.pdf'
   ```
   Confirmed: PDF document, version 1.4, 10 pages, 222,805 bytes. Produced by "Skia/PDF m141 Google Docs Renderer" (i.e., created in Google Docs).

5. **Checked parent disclosures page** (`/index.php/disclosures/`) — lists all certified criteria but contains no additional EHI export documentation files beyond the same link.

6. **Took screenshot** of the export format documentation page for reference.

## What Was Found

The sole artifact is a 10-page PDF titled "Export Format Documentation" (copyright 2023). It describes the EHI export mechanism for Astronaut EHR.

### Export Format

The export uses a **dual-format approach**:

1. **C-CDA (Consolidated Clinical Document Architecture) XML** — for the majority of clinical EHI data. The document describes 16 C-CDA sections that are included.

2. **Proprietary CSV** — for "advanced demographics and remaining EHI" that doesn't fit into C-CDA. The CSV uses a simple name-value pair format: `Place of Birth, USA, Mother's Maiden Name, Annabelle, Spouse's Employer Name, Astronaut LLC, Date of Retirement, 10/31/2023…`

### Access Method

Data is stored on a FHIR server. Authorized users must be granted permission by Astronaut EHR's IT staff, who walk them through the extraction process. Both **Single Patient Export** and **Bulk Patient Export** are available. Access requires authorization — it is not self-service.

### C-CDA Sections Documented

The PDF describes these C-CDA sections (each with a paragraph-level summary paraphrased from HL7's C-CDA documentation):

| # | Section | Content |
|---|---------|----------|
| 1 | Allergies | Medication allergies, adverse reactions, anaphylaxis |
| 2 | Immunizations | Current status and relevant history |
| 3 | Medications | Current prescriptions, drug monitoring |
| 4 | Plan of Treatment | Pending orders, interventions, encounters |
| 5 | Goals | Patient-defined and health concern-specific goals |
| 6 | Problem(s) | Clinical problems and diagnoses |
| 7 | Results (Lab) | Lab, imaging, and procedure results |
| 8 | Vitals | Blood pressure, heart rate, respiratory rate, etc. |
| 9 | Procedures | Surgical, diagnostic, therapeutic procedures |
| 10 | Social History | Smoking status, pregnancy, etc. |
| 11 | Encounters | Healthcare encounters |
| 12 | Functional Status | ADLs, IADLs, functional abilities |
| 13 | Medical Equipment | Implantable and external medical devices |
| 14 | Assessments | Clinician conclusions and working assumptions |
| 15 | Advanced Demographics | Via proprietary CSV (see below) |
| 16 | Remaining EHI | Via proprietary CSV (see below) |

### C-CDA Format Guide

The PDF includes a basic XML format guide showing the hierarchical structure of C-CDA documents (header with patient demographics and author info, body sections with entries). This is generic C-CDA structure explanation, not Astronaut-specific.

### Proprietary CSV for Remaining Data

The "Advanced Demographics and Remaining EHI" section (page 9) explains that data not fitting into C-CDA is bundled in CSV format using a name-value pair convention. The example given:

```
Place of Birth, USA, Mother's Maiden Name, Annabelle, Spouse's Employer Name, Astronaut LLC, Date of Retirement, 10/31/2023…
```

The documentation states: "The way the remaining EHI data is bundled is optimized to be easy to understand while also excluding categories that have no data assigned to them. The user can rest assured that all available data will be present upon exportation."

No schema, field list, or data dictionary for the CSV portion is provided.

## Export Coverage Assessment

### Data Domain Coverage

Astronaut EHR is built on VistA, a comprehensive health information system with hundreds of FileMan data files, and targets behavioral health / psychiatry. The product research identified these key data domains:

**Clearly covered by C-CDA sections:**
- Patient demographics (C-CDA header + CSV for "advanced" demographics)
- Allergies
- Medications / prescriptions
- Problems / diagnoses
- Lab results
- Vital signs
- Immunizations
- Procedures
- Social history
- Encounters
- Goals
- Plan of treatment
- Assessments
- Medical equipment / implantable devices
- Functional status

**Potentially covered by "Remaining EHI" CSV (but not enumerated):**
- Billing data (inpatient and outpatient billing lists, ICD/CPT codes)
- Scheduling / appointments
- Clinical notes (Touch Note™, Rocket Note™, etc.)
- Order entry (CPOE for medications, lab, imaging)
- Decision support interventions
- Audit logs
- Patient consents
- E-prescribing records (via NewCrop/Surescripts)
- Supervision records (Turbo Supervision™)
- Clinical quality measure data

**Likely missing or unclear:**
- **Psychiatric-specific assessments** — PHQ-9 scores, suicide risk assessments, substance use disorder treatment data. These are core to the product's behavioral health focus. It's unclear whether the generic "Assessments" C-CDA section captures these structured instruments or whether they're in the CSV catch-all.
- **Clinical notes / documents** — Not mentioned as a C-CDA section. VistA-based systems have extensive clinical documentation. Where do full clinical notes go?
- **E-prescribing records** — The product uses NewCrop (DrFirst) for e-prescribing. Whether locally-stored prescription transmission records are exported is unknown.
- **Billing / claims data** — Astronaut added full integrated billing in 2020. No mention of billing data in the export documentation.
- **Scheduling data** — Not mentioned.
- **Audit logs** — Not mentioned.
- **VistA FileMan data** — As a VistA-based system, the underlying database potentially contains data in hundreds of FileMan files. The export documentation gives no indication of how much of this data is captured.
- **Psychotherapy notes** — Explicitly excluded per the PDF ("excluding psychotherapy notes" per 45 CFR 164.502), which is legally appropriate.

The fundamental problem is that the "Remaining EHI" CSV is described as a catch-all but **no enumeration of what it contains is provided**. The documentation says "all available data will be present" but gives no field list, no schema, and only one fictional demographic example. There is no way to verify coverage without actually running an export.

### Export Format & Standards

- **Primary format**: C-CDA XML — a recognized HL7 standard, well-suited for clinical data exchange
- **Secondary format**: Proprietary CSV with name-value pairs — non-standard, ad-hoc
- **Access**: Via FHIR server with IT-assisted authorization
- **C-CDA version**: References "C-CDA on FHIR v2.0.0-ballot" but actual C-CDA profile constraints are not specified
- **No FHIR resource mapping** — Despite data being stored on a FHIR server, the export itself is C-CDA + CSV, not FHIR NDJSON

The C-CDA portion covers standard clinical data well. The CSV portion is concerning — the name-value pair format (without headers, just alternating key/value in a flat list) is unusual and potentially difficult to parse programmatically, especially for complex or nested data.

The format choice is reasonable for a small vendor — C-CDA is appropriate for clinical data, and CSV is a pragmatic choice for the remainder. However, the lack of any schema or field documentation for the CSV portion significantly undermines its utility.

### Documentation Quality

**Poor.** This is a 10-page document that is more of a conceptual overview than actionable technical documentation:

- **No data dictionary** — There is no field-level documentation for either the C-CDA sections or the CSV export. The C-CDA section descriptions are paragraph summaries paraphrased from HL7's website, not Astronaut-specific field mappings.
- **No schema files** — No XSD, no sample C-CDA, no CSV schema
- **No sample export files** — No examples of actual exported data
- **No field definitions** — No column names, data types, value sets, or constraints
- **No relationship documentation** — No description of how C-CDA and CSV files relate to each other in an export package
- **No export instructions** — The "Accessing Data" section says IT staff will "walk an end-user through the process" but provides no actual steps
- **Generic C-CDA explanation** — Three pages are spent explaining basic XML structure and C-CDA concepts that are standard HL7 knowledge, not Astronaut-specific
- **No versioning or change history** — Copyright 2023, but the PDF was uploaded to the August 2025 directory, suggesting an update with no version tracking

A developer attempting to import this data would have **no way to build an importer** from this documentation alone. They would need to: (1) obtain an actual export, (2) reverse-engineer the C-CDA profiles used, and (3) reverse-engineer the CSV format from sample data.

### Structure & Completeness

- **Granularity**: Section-level only (16 named C-CDA sections + vague CSV catch-all). No field-level detail.
- **Coded fields**: Not documented. No value sets specified.
- **Relationships**: Not documented. How the C-CDA file and CSV file(s) relate to each other is not described.
- **Data types**: Not specified for any field.
- **Cardinality**: Not specified.
- **Completeness**: The document reads as a compliance checkbox rather than a genuine technical specification. The section descriptions are generic C-CDA prose, not Astronaut's implementation details.

### (b)(10) vs (g)(10) Assessment

This is **not** a case of a vendor simply repackaging their FHIR/g(10) API as the b(10) export. Astronaut has attempted to address the broader EHI requirement by:
1. Using C-CDA (not FHIR) as the primary export format
2. Acknowledging that some data doesn't fit C-CDA and providing a CSV supplement
3. Explicitly referencing the "record set defined in 45 CFR 164.502" (the designated record set)

However, the execution is severely lacking. The CSV catch-all is undocumented, and the C-CDA portion only covers standard clinical data categories. For a VistA-based behavioral health system, the gap between what's described (standard C-CDA sections) and what the system likely stores (hundreds of VistA FileMan files, psychiatric-specific structured data, billing, scheduling, supervision records) is substantial.

## Access Summary
- Final URL (after redirects): https://astronautehr.com/index.php/disclosures/export-format-documentation/
- Status: found
- Required browser: no (direct PDF download link in page source)
- Navigation complexity: direct_link
- Anti-bot issues: none (Cloudflare present but no blocking)

## Obstacles & Dead Ends

- The PDF embed on the page fails to render in the browser ("Couldn't load plugin"), but the download link works fine via curl.
- No other documentation files were found — the single PDF is the entirety of the export format documentation.
- The disclosures parent page lists all certified criteria but links back to the same export documentation page for (b)(10).
