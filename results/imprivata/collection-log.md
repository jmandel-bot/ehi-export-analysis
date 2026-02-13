# Imprivata — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 10838, 11225, 11445, 11666
- Products: Access Intelligence, Digital Identity Intelligence, Imprivata FairWarning
- Registered URL: https://www.imprivata.com/onc-certification-disclosures

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.imprivata.com/onc-certification-disclosures" \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36'
```
**Result:** HTTP/2 200 direct (no redirects). Content-Type: text/html; charset=UTF-8. Drupal 11 CMS. 129,200 bytes. Page served from Fastly CDN (Varnish cache). No anti-bot protection encountered.

### Step 2: Page examination
```bash
curl -sL "https://www.imprivata.com/onc-certification-disclosures" \
  -H 'User-Agent: Mozilla/5.0' -o /tmp/imprivata-page.html
wc -c /tmp/imprivata-page.html  # 129,200 bytes
```
The page is a standard Drupal 11 HTML page with substantive content — not a SPA/JS loader. Full content is available via curl without a browser. The page is titled "ONC certification disclosures for Imprivata Access Intelligence."

### Step 3: Finding the EHI section
The page contains:
1. A brief introductory paragraph about ONC certification
2. Four certification disclosure tables for four certified products:
   - **Access Intelligence** v25 (Cert ID: 15.02.05.1485.ACCS.08.08.0.250722, certified 2025-Jul-22)
   - **Digital Identity Intelligence** v24 (Cert ID: 15.02.05.1485.DIGI.07.07.0.240213, certified 2024-Feb-13)
   - **Imprivata FairWarning** v23 (Cert ID: 15.02.05.1485.FAIR.06.06.0.230130, certified 2023-Jan-30)
   - **Imprivata FairWarning** v22 (Cert ID: 15.02.05.1485.FAIR.05.05.0.220222, certified 2022-Feb-22)
3. A single paragraph under the heading **"§ 170.315 (b)(10) Electronic Health Information export"**:
   > "Imprivata provides capabilities for end users to export of EHI. Permissions for export capabilities are governed in Imprivata by User Role and can also be limited to specific EHI data sources. Users with the ability to export can do so from the Report Results page in CSV (Comma Separated Value) format. Data fields included in the export capabilities are configurable by end users."
4. A section about §170.315(d)(13) Multi-factor authentication (SAML 2.0 integration)
5. A link to the 2025 Real World Testing Plan PDF

**There are no downloadable EHI export data dictionaries, schemas, or detailed documentation files.** The entire b(10) documentation is a single paragraph.

### Step 4: Searching for downloadable assets
```bash
grep -oiE 'href="[^"]*\.(pdf|zip|xlsx|xls|csv|json|doc|docx)[^"]*"' /tmp/imprivata-page.html
```
**Result:** No PDF/ZIP/XLSX links found on the page at all.

```bash
grep -oiE 'href="[^"]*"' /tmp/imprivata-page.html | grep -iE 'ehi|export|data.dictionary|b.10'
```
**Result:** No links matching EHI export documentation patterns.

### Step 5: Following related links
**RWTP link:** Found `/rwtp-digital-identity-intelligence` which links to a PDF:
```bash
curl -sL "https://www.imprivata.com/rwtp-digital-identity-intelligence" \
  -H 'User-Agent: Mozilla/5.0' | grep -oiE 'href="[^"]*\.pdf[^"]*"'
```
**Result:** `href="/sites/imprivata/files/2024-12/Real-World-Testing-Plan-FW-2024-12.pdf"` (appears twice)

Downloaded this PDF for additional EHI export context.

**Supported applications page:** Found at `/analytics-intelligence-platform-supported-applications`. This lists 500+ applications that Imprivata integrates with for access monitoring, including major EHR systems (Epic, Cerner, Meditech, etc.), billing systems, HR systems, imaging, lab, and document management systems.

### Step 6: Browser verification
Navigated to the page in a browser and took screenshots. Confirmed:
- No accordion sections, tabs, or hidden content
- The page is a single static page with tables and text
- No hidden download buttons or expandable sections
- The b(10) section is a plain paragraph with no links
- The page ends with the RWTP links and footer

## Downloads

### imprivata-onc-certification-disclosures.html (129 KB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o downloads/imprivata-onc-certification-disclosures.html \
  'https://www.imprivata.com/onc-certification-disclosures'
```
Verified: Full HTML page, Drupal 11 CMS, all content present without JavaScript rendering.
Saved to: downloads/imprivata-onc-certification-disclosures.html

### imprivata-rwtp-2025.pdf (157 KB)
```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o downloads/imprivata-rwtp-2025.pdf \
  'https://www.imprivata.com/sites/imprivata/files/2024-12/Real-World-Testing-Plan-FW-2024-12.pdf'
```
Verified: `file` → PDF document, version 1.7, 4 pages
Content: Real World Testing Plan for Digital Identity Intelligence / FairWarning. Contains additional detail on EHI export testing methodology — confirms CSV export from Report Results page and mentions database record count comparison for validation.
Saved to: downloads/imprivata-rwtp-2025.pdf

## Product Context

Imprivata is **NOT an EHR vendor**. These are **audit/surveillance/compliance tools** that monitor access to EHR and other healthcare IT systems.

### Product lineage:
- **Imprivata FairWarning** (v22, v23): Patient privacy monitoring tool. Originally a separate company acquired by Imprivata. Detects inappropriate EHR access ("snooping"), HIPAA violations, and insider threats.
- **Digital Identity Intelligence** (v24): Rebrand/evolution of FairWarning. Same core function — monitoring and auditing internal access to medical records.
- **Access Intelligence** (v25): Current umbrella product containing:
  - **Patient Privacy Intelligence (PPI)** — successor to FairWarning
  - **Drug Diversion Intelligence (DDI)** — monitors controlled substance access
  - **User/Entity Behavior Analytics** — general suspicious behavior detection

### What these products store:
The products ingest **access audit logs** from other systems (EHRs, pharmacy, lab, imaging, HR, etc.) and store:
- Who accessed which patient's record
- When the access occurred
- What system was accessed
- What type of access (view, modify, print, etc.)
- Behavioral analytics (patterns, anomalies, risk scores)
- Investigation workflow data (cases, findings, resolutions)

They integrate with 500+ healthcare applications (Epic, Cerner, Meditech, Allscripts, etc.) to ingest access logs. The Imprivata product itself does NOT store clinical data, billing data, insurance data, appointments, messages, or documents — it stores **metadata about who accessed those things in other systems**.

### What "EHI" means in this context:
For Imprivata, EHI is audit trail data — records of access to patient information. This is a legitimate form of EHI under the Designated Record Set (audit/access records can be part of the DRS), but it is fundamentally different from what a traditional EHR exports.

## Obstacles & Notes

1. **No data dictionary or schema documentation exists.** The entire b(10) documentation is a single paragraph describing CSV export from a Report Results page with user-configurable fields. There is no enumeration of what fields/tables/data elements are available.

2. **No downloadable documentation files.** Unlike most vendors who provide PDFs, ZIPs, or HTML data dictionaries, Imprivata provides only the inline paragraph on the disclosure page.

3. **The RWTP provides slightly more detail** — it confirms CSV export, mentions database record count comparison for validation, and describes the testing methodology as exporting EHI for a single patient in production.

4. **This is a non-EHR health IT module.** The certification criteria are limited to b(10) EHI export and security/administrative criteria (d)(1), (d)(3), (d)(5), (d)(12), (d)(13), (g)(4), (g)(5). No clinical criteria, no FHIR, no C-CDA, no CQMs.

5. **No anti-bot protection or access issues.** The page is well-served, fast, and fully accessible via curl.
