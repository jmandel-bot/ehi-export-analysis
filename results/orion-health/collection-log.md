# Orion Health — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10590
- Registered URL: https://orionhealth.com/global/certifications/onc-hit-certification-communicate/
- Mandatory Disclosures URL: https://orionhealth.com/us/certifications/onc-hit-certification-communicate/

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://orionhealth.com/global/certifications/onc-hit-certification-communicate/" \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```

Result: HTTP/2 200 directly (no redirects). Content-Type: text/html; charset=UTF-8. WordPress site (indicated by `link` header pointing to wp-json API). No content-disposition header — this is a standard HTML page, not a file download.

### Step 2: Page examination

```bash
curl -sL "https://orionhealth.com/global/certifications/onc-hit-certification-communicate/" \
  -H 'User-Agent: Mozilla/5.0' -o /tmp/orion-page.html
wc -c /tmp/orion-page.html
```

Result: 575,615 bytes. This is a full WordPress-rendered HTML page with real content — not a thin JS loader. The page contains navigation menus, certification details, cost attestations, real world testing links, and an inline "Requesting an EHI export" section.

### Step 3: Finding the EHI section

The EHI export documentation is embedded directly in the certification page as an inline text section under the heading "Requesting an EHI export." No accordion clicks, no separate tabs, and no expandable sections were needed — the content is directly visible in the page HTML.

Searched for downloadable file links:
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/orion-page.html
```

Found 7 PDF links — all Real World Testing plans and results:
- Real-World-Testing-Results_Report-2022_gtfhur.pdf
- real-world-testing-plan-orion-health2022.pdf
- Real-World-Testing-Results_Report-2023_a1ozik2023.pdf
- real-world-testing-plan-orion-health2023.pdf
- Real-World-Testing-Plan-Orion-Health-2024-1.pdf
- Orion-Health_Real-World-Testing-Results-Report-2024.pdf
- Real-World-Testing-Plan-Orion-Health-2025-1.pdf

No separate EHI data dictionary, schema document, or export specification file was found. The entire EHI export documentation consists of the inline text on the certification page.

Searched for EHI-related links:
```bash
grep -oiE 'href="[^"]*"' /tmp/orion-page.html | grep -iE 'ehi|export|data.dictionary|b.10'
```
No results — there are no links pointing to dedicated EHI documentation.

### Step 4: Checking alternate URLs

The CHPL metadata lists a mandatory disclosures URL at a different path:
```bash
curl -sI -L "https://orionhealth.com/us/support/disclosures/onc-hit-certification-communicate/" \
  -H 'User-Agent: Mozilla/5.0'
```
Result: 301 redirect to `https://orionhealth.com/us/certifications/onc-hit-certification-communicate/` — same content as the global page but scoped to the US region. The content is identical.

Also checked the US-specific certification page directly:
```bash
curl -sL "https://orionhealth.com/us/certifications/onc-hit-certification-communicate/" \
  -H 'User-Agent: Mozilla/5.0' -o /tmp/orion-us-page.html
```
Result: 573,697 bytes, same EHI export section content.

### Step 5: Identified downloadable/documentable assets

1. **The certification page itself** — contains the inline EHI export documentation
2. **Real World Testing Plan 2025 PDF** (12 pages, 466 KB) — contains EHI export testing metrics
3. **Real World Testing Results 2024 PDF** (6 pages, 212 KB) — confirms EHI export testing outcomes

No separate data dictionary, schema documentation, or export format specification exists.

## Downloads

### orion-health-communicate-certification-page.html (576 KB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' \
  -o downloads/orion-health-communicate-certification-page.html \
  'https://orionhealth.com/global/certifications/onc-hit-certification-communicate/'
```
Verified: WordPress HTML page containing the full certification page including inline EHI export instructions.
Saved to: downloads/orion-health-communicate-certification-page.html

### real-world-testing-plan-2025.pdf (466 KB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' \
  -o downloads/real-world-testing-plan-2025.pdf \
  'https://orionhealth.com/wp-content/uploads/Real-World-Testing-Plan-Orion-Health-2025-1.pdf'
```
Verified: `file` → PDF document, version 1.7, 12 pages
Saved to: downloads/real-world-testing-plan-2025.pdf

### real-world-testing-results-2024.pdf (212 KB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' \
  -o downloads/real-world-testing-results-2024.pdf \
  'https://orionhealth.com/wp-content/uploads/Orion-Health_Real-World-Testing-Results-Report-2024.pdf'
```
Verified: `file` → PDF document, version 1.3, 6 pages
Saved to: downloads/real-world-testing-results-2024.pdf

## Obstacles & Notes

- No anti-bot protections encountered. Standard curl with User-Agent header works fine.
- The page is a standard WordPress site — no SPA, no JavaScript-only rendering.
- No separate EHI data dictionary or export specification exists. The entire EHI export documentation is approximately 150 words of inline text on the certification page.
- The Real World Testing Plan references a legacy URL path (`/us/support/disclosures/onc-hit-certification-communicate/`) that 301-redirects to the current certification page.
- All regional variants of the page (global, us, ca, uk, au, nz) appear to share the same content.

---

## Product: Orion Health Communicate

### Product Context

Orion Health Communicate is **not an EHR**. It is a **Direct Secure Messaging (HISP) platform** — a specialized health information exchange service that enables providers to send and receive encrypted clinical messages and documents using the Direct Project standard.

Orion Health as a company offers a broader product suite including:
- **Digital Care Record (Amadeus)** — an integrated patient record platform with clinical portal, medication management, care pathways
- **Digital Front Door (Virtuoso)** — patient engagement and portal
- **Health Intelligence Platform** — data aggregation and analytics
- **Clinical Workstation** — clinical tools

However, **Communicate is a standalone product** that can be deployed independently of these other systems. It is listed under "Additional Products" in Orion Health's navigation. The certified module IS the product — there is no broader product of which Communicate is merely a component.

From the cost attestations on the certification page:
> "Orion Health Communicate provides an EHNAC accredited HISP service compliant with the Direct Project standards. The service is offered as a Software as a Service (SaaS) offering. Orion Health Communicate implements the Edge protocols SMTP, IMAP, and Direct XDR. Intended use is for providers and hospitals to transmit messages to other members of trusted communities, such as the Direct Trust bundle. Messages may be notes, clinical data, structured data, CCDAs, other."

This means the data Communicate stores is limited to **messages sent and received through the service** — it is a message transport and storage system, not a system of record for patient clinical, billing, or administrative data.

### Export Approach

The EHI export is described entirely in the inline "Requesting an EHI export" section on the certification page. Key details:

**Process:** Not self-service. Requires submitting a support ticket through Orion Health's Support Tracker.

**Target audience:** "HIE or HISP administrative users or representatives"

**Requirements:**
- Access to Orion Health Support Tracker
- Either a Communicate Direct address OR a HIPAA compliant storage service for the archive
- The relevant patient identifier(s) from the customer's HIE

**Steps:**
1. Raise a Support Tracker ticket with patient identifiers and delivery preference
2. Communicate Operations staff processes the request
3. Staff reaches out with the EHI export

**Export format:**
- Archive format (ZIP), possibly split into multiple files for large exports
- Per-patient content: a mixture of `.eml` files (email messages) and attachments in original format
- Attachment types: primarily `.xml` and `.zip` (XDM payloads), plus `.pdf` and image formats
- Supports both single-patient and population-level exports

**RWT confirmation (from Real World Testing Plan 2025, page 4):**
- "EHI export patient and population" metric: "Ability for an external organization to request and receive an EHI export for either an individual patient or a population."
- Justification (page 6): "Demonstrates the ability to create an export file for both an individual patient and a population, and share that export electronically in a computable format."

**RWT Results (2024):** The EHI export metric does not appear in the 2024 results table — only the (h)(2) Direct messaging metrics were tested. This suggests EHI export was not tested in the 2024 cycle or was tested but not reported separately.

### EHI Coverage Assessment

This assessment must be understood in context: Communicate is a **messaging transport system**, not an EHR. The data it stores is fundamentally limited to messages and their attachments. The b(10) requirement covers "all EHI that can be stored at the time of certification by the product" — and for a messaging HISP, that is messages.

**Clinical:** The export includes whatever clinical content was transmitted as message attachments — C-CDA documents, XML files, XDM payloads. These may contain clinical data (diagnoses, medications, labs, etc.) but Communicate does not generate or manage this data; it merely transports and stores it. The clinical richness depends entirely on what was sent through the system.

**Secure messages:** This is the core data type. The `.eml` files ARE the messages — Direct Secure Messages exchanged between providers. This is the one category where Communicate's export is comprehensive by definition, since messages are the product's primary function.

**Billing/financial:** Not applicable. Communicate does not store billing data. It has no billing, claims, or revenue cycle functionality. The subscription fees are at the organizational level, not per-patient.

**Insurance/coverage:** Not applicable. Communicate does not store insurance or coverage data.

**Appointments/scheduling:** Not applicable. Communicate has no scheduling functionality.

**Documents/images:** Partially present. Message attachments are included in the export in their original format. This would include any documents, images, PDFs, or other files that were attached to Direct messages. However, this is limited to what was transmitted through Communicate — it is not a document management system.

**Audit trails:** Not documented in the export. The certification page lists 170.315 (d)(2) Auditable Events and Tamper-Resistance and (d)(3) Audit Reports as certified criteria, indicating audit logging exists within the system. However, the export documentation does not mention inclusion of audit trails, access logs, or message delivery/read tracking metadata in the EHI export.

### Issues & Red Flags

1. **Export is not self-service.** The process requires raising a support ticket and waiting for Orion Health operations staff to process it. This introduces delays and friction that may not meet the spirit of the b(10) requirement, which envisions patient-directed export capabilities.

2. **No data dictionary or schema documentation.** The export is described in approximately 150 words. There is no documentation of the .eml file structure, metadata fields, XDM payload schemas, or any other technical details. A customer or patient receiving the export has no guide to interpreting the data.

3. **Export format may not be "computable" in practice.** While the RWT plan claims the export is in "a computable format," .eml files are email-format documents that may require specialized email clients or parsers to read. The term "computable" is generous for raw email files.

4. **Audit data appears excluded.** Despite being certified for (d)(2) auditable events, the EHI export documentation makes no mention of including audit trails, message delivery receipts, read status, or access logs.

5. **Narrow scope is inherent, not a deficiency.** Unlike a full EHR where missing categories (billing, scheduling) represent compliance gaps, Communicate genuinely does not store most EHI categories. The product is a messaging transport layer. The export appears to cover what the product stores — messages and their attachments. The concern is less about missing categories and more about the lack of documentation and the manual export process.

6. **RWT results don't clearly show EHI export testing.** The 2024 Real World Testing Results report shows "Success" for all (h)(2) Direct messaging metrics but does not include the "EHI export patient and population" metric in its results table, raising questions about whether EHI export was actually tested.
