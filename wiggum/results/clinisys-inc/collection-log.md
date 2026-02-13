# Clinisys Inc. — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11285, 11490, 11581, 11634
- **Products**: Clinisys Harvest (versions 14, 15), Clinisys Orchard (versions 11, 12)
- **Developer**: Clinisys, Inc. (formerly Orchard Software Corporation)
- **Registered URL**: https://www.clinisys.com/uk/en/history/orchard/

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.clinisys.com/uk/en/history/orchard/" -H 'User-Agent: Mozilla/5.0'
```

**Result**: HTTP/2 200 OK. Direct response, no redirects. Content-Type: `text/html; charset=UTF-8`. Server: Cloudflare. WordPress site (revealed by `link: <https://www.clinisys.com/wp-json/>` header and `PHPSESSID` cookie). No anti-bot challenge encountered.

### Step 2: Page examination

```bash
curl -sL "https://www.clinisys.com/uk/en/history/orchard/" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html
```

**Result**: 119,400 bytes. Full static HTML (WordPress-rendered), not a SPA. Content is fully in the HTML source — no JavaScript rendering required. Page title: "Orchard - Clinisys".

The page is a **compliance/product hub** for the Orchard product line (rebranded from Orchard Software to Clinisys). It has:
- A hero banner: "Orchard is now Clinisys™"
- Product descriptions for Clinisys Orchard and Clinisys Harvest
- Multiple accordion sections for certification details, testing, and export specs

### Step 3: Finding the EHI section

The page uses WordPress accordion blocks (`block-accordion-item`). The accordion sections are:

1. **Clinisys Harvest 15** — Certification details, lists 170.315(b)(10) as certified criterion
2. **Clinisys Harvest 14** — Same
3. **Clinisys Orchard 12** — Same
4. **Clinisys Orchard 11** — Same
5. **Real World Testing Plan & Results** — RWT documents
6. **Export Specifications** — ⬅️ **This is the EHI export documentation section**
7. **Compliance with Multi-factor Authentication** — MFA compliance info

The "Export Specifications" accordion is collapsed by default (CSS checkbox toggle). Its content is present in the HTML source — no JavaScript needed to discover it. Inside the accordion are two PDF download buttons:

- "Orchard Enterprise Results Export Specification" → links to PDF
- "Orchard Harvest Results Export Specification" → links to PDF

All four product versions (Harvest 14/15, Orchard 11/12) reference `170.315(b)(10) Electronic Health Information (EHI) Export` with the description: "Supports patients' access to their electronic data as well as providing all the EHI from the Clinisys certified Health IT product for export to another health IT system."

### Step 4: Identified downloadable assets

From the "Export Specifications" accordion:

1. `https://www.clinisys.com/app/uploads/2025/11/Orchard-Enterprise-Results-Export-Specification.pdf`
2. `https://www.clinisys.com/app/uploads/2025/11/Orchard-Harvest-Results-Export-Specification.pdf`

Other PDFs on the page (not EHI export docs, but for reference):
- Certification certificates for all 4 product versions
- RWT plans and results (2023-2025)
- ESG report and Code of Conduct

## Downloads

### Orchard-Enterprise-Results-Export-Specification.pdf (953 KB, 15 pages)

```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/Orchard-Enterprise-Results-Export-Specification.pdf \
  'https://www.clinisys.com/app/uploads/2025/11/Orchard-Enterprise-Results-Export-Specification.pdf'
```

**Verified**:
- `file` output: `PDF document, version 1.7, 15 page(s)`
- Size: 976,077 bytes (953 KB)
- Title: "HL7 Result Export HL7 Specification v2.3 — Orchard® Enterprise Lab™"
- Revised: 03/15/2021
- Copyright: Orchard Software Corporation 1998-2023

**Contents**: HL7 v2.3 ORU^R01 message specification for lab results export from Orchard Enterprise. Documents 7 HL7 segments (MSH, PID, NTE, PV1, ORC, OBR, OBX) with ~222 field definitions including field names, lengths, and mapping comments.

### Orchard-Harvest-Results-Export-Specification.pdf (985 KB, 13 pages)

```bash
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o downloads/Orchard-Harvest-Results-Export-Specification.pdf \
  'https://www.clinisys.com/app/uploads/2025/11/Orchard-Harvest-Results-Export-Specification.pdf'
```

**Verified**:
- `file` output: `PDF document, version 1.7, 13 page(s)`
- Size: 1,009,269 bytes (985 KB)
- Title: "HL7 Outbound Result Specification v2.3 — Orchard® Harvest™"
- Revised: 04/28/2023
- Copyright: Orchard Software Corporation 1998-2023

**Contents**: HL7 v2.3 ORU^R01 message specification for lab results export from Orchard Harvest. Documents the same 7 HL7 segments with ~160 field definitions. Similar structure to the Enterprise version but with some differences in supported fields.

## Obstacles & Notes

1. **No anti-bot protection** — Cloudflare is present but didn't challenge curl requests. User-Agent header sufficient.

2. **Accordion content hidden by CSS** — The "Export Specifications" section uses a checkbox-based CSS toggle. Content is fully in the DOM but visually hidden until the accordion is expanded. `grep` finds links without needing a browser.

3. **URL path is misleading** — The registered URL path (`/uk/en/history/orchard/`) suggests a UK/English locale and "history" section, but this is actually the main compliance/certification page for the Orchard product line.

4. **Laboratory-only scope** — These are Laboratory Information Systems (LIS). The "EHI export" documentation covers **only lab results** in HL7 v2.3 ORU format. This is expected — the system is purpose-built for clinical laboratory workflows, not general-purpose EHR functionality. The export format documents how lab results (orders, specimens, observations, results) are exported.

5. **HL7 v2.3 is the export format, not FHIR** — The export uses traditional HL7 v2.3 messaging (ORU^R01), which is a well-established healthcare interoperability format. This is a legitimate b(10) export format — the data flows as-is from the LIS database in HL7 message structure.

6. **No sample data or developer guide** — The documentation is purely specification-level. No example export files, test data, or processing guides are provided.

7. **"Results Export" not "All EHI Export"** — The documentation is titled "Results Export Specification" and scoped to lab results. For a lab-only system, results + patient demographics + orders may constitute the complete Designated Record Set, but the documentation doesn't explicitly enumerate all data domains in the system or confirm this covers "all" EHI.
