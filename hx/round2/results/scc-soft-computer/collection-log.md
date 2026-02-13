# SCC Soft Computer — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11239, 11240, 11241, 11242, 11243, 11295
- **Products**: SoftLab (also covers SoftMic, SoftBank, SoftPathDx, SoftGene)
- **Developer**: SCC Soft Computer
- **Registered URL**: https://www.softcomputer.com/regulatory-affairs/ehi-export/

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.softcomputer.com/regulatory-affairs/ehi-export/" -H 'User-Agent: Mozilla/5.0'
```
**Result**: Direct HTTP/2 200 response. No redirects. Content-Type: `text/html; charset=UTF-8`. Last-Modified: Thu, 12 Feb 2026 17:18:55 GMT. WordPress site with standard headers.

### Step 2: Page examination
```bash
curl -sL "https://www.softcomputer.com/regulatory-affairs/ehi-export/" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html
```
**Result**: 81,085 bytes. WordPress-rendered static HTML page. Title: "Regulatory Affairs | SCC Soft Computer". The page has real HTML content — not a JS SPA.

### Step 3: Finding the EHI documentation
The page is simple and clean. The heading is "EHI Export" and below it are two columns:

**4.0.x release EHI export documentation:**
- HL7 Result Reporting for EHI Export (PDF link)
- XML EHI Export of Patient Billing History (PDF link)

**4.5.x release EHI export documentation:**
- HL7 Result Reporting for EHI Export (PDF link)
- XML EHI Export of Patient Billing History (PDF link)

All four links are directly visible on the page — no accordion, no JavaScript required, no clicks needed. Cookie consent banner from Complianz appears but doesn't block content.

### Step 4: Identified downloadable assets
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/page.html
```
**Result**: Four PDF files found:
1. `/wp-content/uploads/2024/09/SCC_Standard_EHI_export_rel4.0.pdf`
2. `/wp-content/uploads/2024/09/SCC_EHI_export_Billing_History_rel4.0.pdf`
3. `/wp-content/uploads/2024/09/SCC_Standard_EHI_export_rel4.5.pdf`
4. `/wp-content/uploads/2024/09/SCC_EHI_export_Billing_History_rel4.5.pdf`

All hosted on the same WordPress site under `/wp-content/uploads/2024/09/`.

## Downloads

### SCC_Standard_EHI_export_rel4.5.pdf (1,335,320 bytes / 55 pages)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o downloads/SCC_Standard_EHI_export_rel4.5.pdf \
  'https://www.softcomputer.com/wp-content/uploads/2024/09/SCC_Standard_EHI_export_rel4.5.pdf'
```
Verified: `file` → PDF document, version 1.5, 55 pages
Content: HL7 v2.5.1 Result Reporting interface specification for EHI Export. Covers message structure, segment definitions (MSH, PID, NK1, PV1, IN1, ORC, OBR, OBX, NTE, DG1, SPM, FHS, FTS), rules, and field-level detail. Applies to SoftLab, SoftMic, SoftBank, SoftPathDx, and SoftGene.

### SCC_EHI_export_Billing_History_rel4.5.pdf (947,107 bytes / 14 pages)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o downloads/SCC_EHI_export_Billing_History_rel4.5.pdf \
  'https://www.softcomputer.com/wp-content/uploads/2024/09/SCC_EHI_export_Billing_History_rel4.5.pdf'
```
Verified: `file` → PDF document, version 1.5, 14 pages
Content: XML schema specification for billing history export. Covers patient demographics, invoice data, charge-level details (CPT, CDM, modifiers, diagnosis codes, quantities, charges, payments, balances), and transaction-level data (charges, payments, adjustments, actions). Includes example XML output.

### SCC_Standard_EHI_export_rel4.0.pdf (954,755 bytes / 46 pages)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o downloads/SCC_Standard_EHI_export_rel4.0.pdf \
  'https://www.softcomputer.com/wp-content/uploads/2024/09/SCC_Standard_EHI_export_rel4.0.pdf'
```
Verified: `file` → PDF document, version 1.7, 46 pages
Content: Same HL7 Result Reporting spec but for release 4.0.x. Revision 1.1, revised 12/11/2023.

### SCC_EHI_export_Billing_History_rel4.0.pdf (873,376 bytes / 14 pages)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o downloads/SCC_EHI_export_Billing_History_rel4.0.pdf \
  'https://www.softcomputer.com/wp-content/uploads/2024/09/SCC_EHI_export_Billing_History_rel4.0.pdf'
```
Verified: `file` → PDF document, version 1.5, 14 pages
Content: Same billing history XML spec for release 4.0.x.

## Product Context

SCC Soft Computer is a **laboratory information systems (LIS) vendor**, not a full EHR. Founded in 1979 in Clearwater, FL. Their tagline is "The Leader in Laboratory And Genetics Information Management Solutions."

### Product Suite
The certified module is **SoftLab**, but the EHI export applies to the broader family of SCC laboratory products:
- **SoftLab** — Core LIS for clinical chemistry, hematology, urinalysis, etc.
- **SoftMic** — Microbiology information system
- **SoftBank / SoftBank.web** — Blood bank / blood services management
- **SoftPathDx** — Pathology information system
- **SoftGene / SoftGenomics** — Genetics and molecular diagnostics
- **SoftMolecular** — Molecular diagnostics
- **SoftExpressPlus** — Outreach/reference lab connectivity
- **SoftBill / SoftAR** — Laboratory billing and accounts receivable
- **SoftMedia** — Document/image management linked to lab results
- **SoftWebPlus** — Web accessioning (no longer listed as separate product page)

### What This Product Is NOT
SCC Soft Computer does **not** make a full EHR. There are:
- **No patient portals** for messaging (not an EHR function for a LIS)
- **No scheduling/appointment systems** (orders come from external HIS/EMR systems)
- **No clinical documentation** (no progress notes, assessments, care plans — it's a lab system)
- **No medication management** (not a pharmacy or prescribing system)

The product stores:
- Laboratory test orders, specimens, and results (all specialties)
- Patient demographics (received from HIS/ADT feeds)
- Insurance information (received from HIS/ADT feeds)
- Billing/AR for laboratory services
- Next of kin information
- Linked documents and images (via SoftMedia)
- Audit trails (confirmed on product page: "SoftLab provides complete audit trails and processing history")

### RCM Services
SCC also offers Revenue Cycle Management (RCM) services through a partnership with RCM Enterprise Services®. This includes claims submission, eligibility verification, payment posting, and financial analytics. The RCM specialty page mentions a "Lab Portal" for order entry and results.

## Obstacles & Notes
- **No obstacles.** Clean WordPress page, direct PDF links, no anti-bot protection, no login required, no JavaScript rendering needed.
- PDFs were uploaded in September 2024 (`/wp-content/uploads/2024/09/`), suggesting the documentation was published around that time.
- Both 4.0.x and 4.5.x versions are provided, covering different software releases. The 4.5 version has 9 more pages (55 vs 46) suggesting expanded content.
- The PDFs reference corresponding `.xlsx` files in headers/footers (e.g., "SCC Standard EHI export rel4.5.xlsx"), suggesting the documentation was authored in Excel and exported to PDF. The Excel files are not available for download.
- Bulk/population export requires contacting SCC services — it's not fully self-service for population-level exports.
