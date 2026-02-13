# Clinisys Inc. — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 11285, 11490, 11581, 11634
- Products: Clinisys Harvest (v14, v15), Clinisys Orchard (v11, v12)
- Registered URL: https://www.clinisys.com/uk/en/history/orchard/
- Unique Certification Numbers:
  - Clinisys Harvest 15: `15.07.09.2825.OR02.15.03.0.250101`
  - Clinisys Harvest 14: `15.07.09.2825.OR02.14.02.0.230518`
  - Clinisys Orchard 12: `15.11.09.2825.ENLB.12.01.0.250513`
  - Clinisys Orchard 11: `15.11.09.2825.ENLB.11.00.0.240618`

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://www.clinisys.com/uk/en/history/orchard/" -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36'
```

Result:
- HTTP/2 200 (direct, no redirects)
- Content-Type: text/html; charset=UTF-8
- Server: cloudflare (Kinsta hosting behind Cloudflare CDN)
- WordPress site (WP-JSON API link in headers, PHPSESSID cookie)
- Last-Modified: 2026-02-06T20:06:49 GMT
- No content-disposition header (HTML page, not a file download)

### Step 2: Page examination

```bash
curl -sL "https://www.clinisys.com/uk/en/history/orchard/" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html  # 119,400 bytes
```

The page is a WordPress-rendered HTML page with substantive content (not a SPA). It renders without JavaScript, though JavaScript enhances accordion interactions. The page title is "Orchard - Clinisys" and it serves as Clinisys's combined product page and ONC compliance hub for their Orchard/Harvest laboratory information system products.

Page structure (top to bottom):
1. Hero banner: "Orchard is now Clinisys™"
2. Introduction text about Clinisys as a LIS provider
3. Product cards: Orchard Point-of-Care, Orchard Enterprise, Orchard Harvest
4. "Laboratory information management system (LIMS) or a laboratory information system (LIS) capabilities" section
5. **"ONC Health IT Certification"** section with accordion panels
6. Footer

### Step 3: Finding the EHI export documentation

The ONC Health IT Certification section contains these accordion panels:

1. **Clinisys Harvest 15** — certification info, b(10) description, View Certificate link
2. **Clinisys Harvest 14** — same structure
3. **Clinisys Orchard 12** — same structure
4. **Clinisys Orchard 11** — same structure
5. **Real World Testing Plan & Results** — 2023, 2024, 2025 plan/results PDFs
6. **Export Specifications** — ← THIS IS WHERE THE EHI DOCS ARE
7. **Compliance with Multi-factor Authentication** — d(13) description

All accordion content is present in the HTML source (CSS checkbox toggle, not JS-loaded). The accordion items use `<input type="checkbox">` elements to toggle visibility.

The b(10) sections within each product accordion say:
> "Supports patients' access to their electronic data as well as providing all the EHI from the Clinisys certified Health IT product for export to another health IT system."

### Step 4: Identified downloadable assets

Within the **Export Specifications** accordion:

1. [Orchard Enterprise Results Export Specification](https://www.clinisys.com/app/uploads/2025/11/Orchard-Enterprise-Results-Export-Specification.pdf)
2. [Orchard Harvest Results Export Specification](https://www.clinisys.com/app/uploads/2025/11/Orchard-Harvest-Results-Export-Specification.pdf)

No other EHI export documentation was found on this page. The product-specific accordion sections (Harvest 15, Orchard 12, etc.) only contain certification info and links to compliance certificates, not export specifications.

### Step 5: Cross-reference with US ONC Disclosure page

I also checked the US ONC Disclosure page at https://www.clinisys.com/us/en/onc-disclosure/ which covers the **Sunquest Laboratory** product line (a different Clinisys product). That page contains:
- Patient-Data-Export-Specification.pdf — a pipe-delimited native data export spec for Sunquest/SQ Lab products
- Patient-Population-Export-Specification.pdf — an HL7-based historical load interface spec for Sunquest

These documents are for Sunquest Laboratory (different CHPL IDs), NOT for Orchard/Harvest. The Sunquest Patient-Data-Export-Specification is notably more comprehensive (covering patient demographics, blood bank data, lab orders, accessions, test components, results, and historical data in a native pipe-delimited format). The Orchard page does not link to these documents.

## Downloads

### orchard-enterprise-results-export-specification.pdf (953 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o orchard-enterprise-results-export-specification.pdf \
  'https://www.clinisys.com/app/uploads/2025/11/Orchard-Enterprise-Results-Export-Specification.pdf'
```
Verified: `file` → PDF document, version 1.7, 15 pages
Title: "Microsoft Word - Orchard Enterprise Results Export Specification"
Revised: 03/15/2021
Content: HL7 v2.3 ORU^R01 result export specification for Orchard Enterprise Lab. Documents MSH, PID, NTE, PV1, ORC, OBR, OBX segments with field-level detail.

### orchard-harvest-results-export-specification.pdf (985 KB)
```bash
curl -L -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o orchard-harvest-results-export-specification.pdf \
  'https://www.clinisys.com/app/uploads/2025/11/Orchard-Harvest-Results-Export-Specification.pdf'
```
Verified: `file` → PDF document, version 1.7, 13 pages
Title: "Microsoft Word - Harvest Results Export Specification"
Revised: 04/28/2023
Content: HL7 v2.3 ORU^R01 result export specification for Orchard Harvest LIS. Same segment structure as Enterprise version (MSH, PID, NTE, PV1, ORC, OBR, OBX) with field-level detail.

## Product Context

Clinisys (formerly Orchard Software Corporation) is a laboratory information system (LIS) vendor, not an EHR vendor. Their products are:

- **Orchard Enterprise** — Enterprise-grade cloud-based LIS for high-volume labs (clinical, micro, pathology, toxicology). Flagship product.
- **Orchard Harvest** — Smaller-scale LIS, predecessor to Enterprise (customers being encouraged to migrate to Enterprise).
- **Orchard Point-of-Care** — POCT governance system (specialized add-on).

Key product capabilities:
- Lab order management and result delivery
- Specimen tracking through all testing phases
- Auto-verification, rules-based decision support
- HL7-based integration with EHRs, HIEs, analyzers
- Patient portal for lab results access
- Provider web portal (Orchard Outreach) for order entry and results retrieval
- Billing code generation (CPT codes) — integration with billing systems, not a billing system itself
- Quality control tracking and audit trails
- Public health reporting (HL7 to state/CDC)
- Microbiology, anatomic pathology, toxicology modules

This is a **standalone LIS** that integrates with external EHRs. It is NOT an EHR. The ONC certification covers only LIS-relevant criteria: b(10), d(1), d(2), d(3), d(7), and f(3).

## Obstacles & Notes

1. **No anti-bot issues.** The page loaded cleanly via curl. Cloudflare was present but did not block requests. Cookie consent banner appeared in browser but content was accessible without accepting.

2. **Accordion navigation required.** The EHI export documentation was inside the "Export Specifications" accordion panel, which required expanding. However, the content was present in the HTML source and accessible via grep without JavaScript.

3. **The "Export Specifications" are HL7 interface specs, not comprehensive EHI data dictionary docs.** The documents describe HL7 v2.3 ORU result message format — essentially an interface specification for how results are transmitted, not a data dictionary of everything the system stores. This is a narrower scope than what most vendors provide for b(10) documentation.

4. **The Sunquest product line has more comprehensive EHI export documentation** (Patient-Data-Export-Specification.pdf) available at the US ONC Disclosure page. The Orchard products do not link to an equivalent document.

5. **All four CHPL IDs share the same two export specification documents.** The Orchard Enterprise spec covers Orchard 11/12, and the Harvest spec covers Harvest 14/15.
