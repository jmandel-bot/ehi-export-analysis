# iTRUST — EHI Export Documentation Collection Log

## Source
- CHPL IDs: 11324
- Registered URL: https://www.itrust.io/b10/
- Developer: iTRUST
- Product: iTRUST (version "i")
- Certification Date: 2023-07-24

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://www.itrust.io/b10/" -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
```
Result:
- 301 redirect from `/b10/` → `/b10` (trailing slash removal)
- 200 OK at `https://www.itrust.io/b10`
- Content-Type: `text/html; charset=utf-8`
- Server: nginx
- No anti-bot protection detected
- No content-disposition header (not a direct file download)

### Step 2: Page examination
```bash
curl -sL "https://www.itrust.io/b10/" -H 'User-Agent: Mozilla/5.0' -o /tmp/itrust-b10.html
wc -c /tmp/itrust-b10.html
```
Result: 17,107 bytes. Static HTML page rendered server-side (Rails app with Turbo/Stimulus, but content is in the initial HTML). No JavaScript rendering required.

The b(10) page content is minimal — a single `<section>` with three short paragraphs:

> **b(10) Export Documentation:**
>
> Single patient export is available within iTRUST in the Admin module under Patient
>
> Population export is available upon request by contacting customer support.
>
> Data dictionary is available by [here](/7954-2)

### Step 3: Finding the EHI data dictionary
The b10 landing page contains a single link to the data dictionary at `/7954-2`. No accordions, tabs, or SPA navigation needed — the link is plainly visible.

```bash
grep -oiE 'href="[^"]*"' /tmp/itrust-b10.html | grep -iE 'ehi|export|data|dictionary|7954'
```
Result: `href="/7954-2"` — this is the data dictionary link.

### Step 4: Fetching the data dictionary page
```bash
curl -sL "https://www.itrust.io/7954-2" -H 'User-Agent: Mozilla/5.0' -o /tmp/itrust-dd.html
wc -c /tmp/itrust-dd.html
```
Result: 61,796 bytes. The page contains a complete OpenAPI 3.0.1 JSON schema displayed inside a `<pre>` tag. The JSON is rendered directly in the HTML — no JavaScript rendering required.

The schema defines the structure of the patient export as JSON, with 35 schema objects and 279 total fields across all schemas.

### Step 5: No additional links or downloads
The data dictionary page (`/7954-2`) contains only the OpenAPI JSON schema. There are no additional links, PDFs, ZIPs, or other downloadable assets. The entire EHI export documentation consists of:
1. The b10 landing page (3 sentences of overview)
2. The data dictionary page (OpenAPI 3.0.1 JSON schema)

No further navigation was needed.

## Downloads

### itrust-b10-page.html (17,107 bytes)
```bash
curl -sL "https://www.itrust.io/b10/" -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' -o downloads/itrust-b10-page.html
```
Verified: `file itrust-b10-page.html` → HTML document, Unicode text, UTF-8 text
Content: b(10) landing page with export instructions and link to data dictionary.

### itrust-data-dictionary.html (61,796 bytes)
```bash
curl -sL "https://www.itrust.io/7954-2" -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' -o downloads/itrust-data-dictionary.html
```
Verified: `file itrust-data-dictionary.html` → HTML document, Unicode text, UTF-8 text
Content: Full OpenAPI 3.0.1 schema for patient export JSON, embedded in a `<pre>` tag.

### itrust-ehi-openapi-schema.json (44,975 bytes)
Extracted from the HTML above by parsing the `<pre>` tag content. Valid JSON confirmed via `json.load()`.
Contains 35 schema definitions, 279 total fields.
Root Patient object has 17 top-level properties: exportTimestamp, demographics, healthGoals, healthConcerns, immunizations, implantableDevices, allergies, encounters, medicalOrders, insurances, invoices, diagnoses, familyHealthHistories, referrals, contacts, statements, familyMembers.

## Obstacles & Notes
- No obstacles encountered. Both pages load cleanly via curl with no anti-bot protection.
- The URL `/7954-2` is not intuitively named — it appears to be an internal CMS page ID rather than a descriptive path.
- Population export requires contacting customer support (not self-service).
- No version history or last-updated date visible on either page.

---

## Product: iTRUST

### Product Context
iTRUST is a cloud-based, all-in-one practice management, EHR, and optical point-of-sale platform built specifically for eye care providers (optometry and ophthalmology). Hosted on AWS and Azure with HIPAA-compliant infrastructure. Based in Miami, FL.

The product serves:
- Independent optometry practices
- Ophthalmology clinics (retina, cataract, glaucoma, oculoplastics)
- Optical retail stores / dispensaries
- Multi-location enterprise groups
- Colleges / training institutions

**Modules and capabilities** (from the vendor's website):
- Electronic Health Record (EHR) — optometry/ophthalmology exam templates, SOAP notes
- Optical Point of Sale (POS) — frame/lens inventory, retail transactions
- Claims & Billing — insurance claims creation, submission, tracking, ERA reconciliation
- EDI Clearinghouse — direct payer connections, real-time eligibility, claim status
- Medical E-Prescribing (ERX) — electronic prescriptions, drug interaction alerts
- Patient Engagement — workflow dashboard, patient flow management
- Online Patient Booking — 24/7 self-service scheduling
- Automated Recall & Reminders — AI-driven follow-up scheduling
- 2-Way Text Messaging — HIPAA-compliant SMS and WhatsApp messaging
- Telemedicine — video visits with screen recording saved to patient records
- Integrated Patient Payments — multi-channel payment collection
- VoIP Phone System — cloud phone with call logging, voicemail transcription
- AI Doctor Assistant — real-time transcription, SOAP note generation, code suggestions
- Marketing Blast — mass SMS/email campaigns
- Reports — real-time practice performance dashboards
- Website Hosting & Building — HIPAA-secure practice websites

**CHPL certified criteria** (from metadata): Only (a)(12), (a)(15), (b)(10), (d)(1)-(d)(13), (g)(4)-(g)(5). Notably missing: (a)(1)-(a)(14) clinical criteria (except a12/a15), (e)(1) patient portal, (f)(1)-(f)(7) public health reporting, (g)(7)-(g)(10) API access. This is a very narrow certification — only 2 clinical criteria: (a)(12) Family Health History and (a)(15) Social, Psychological, Behavioral Factors. The (d) criteria are safety/security requirements. The product clearly does much more than what's certified.

### Export Approach
iTRUST uses a **native JSON export** approach. The export produces a single JSON object per patient, structured as an OpenAPI 3.0.1 schema. This is neither FHIR nor C-CDA — it's a proprietary JSON format that maps to iTRUST's internal data model.

The export endpoint is `patient/export` (POST) returning `application/json`. The schema defines 35 object types with 279 total fields, organized under a root `Patient` object.

This is a good approach for completeness because it exports the system's native data structures rather than mapping to an external standard. However, the schema is notably compact for a product with this many modules — 35 schemas is far fewer than you'd expect from a system with billing, POS, scheduling, messaging, telemedicine, and document management capabilities.

**Single patient export** is available self-service in the Admin module. **Population export** requires contacting customer support — this is a significant limitation as b(10) requires both single-patient and bulk export capabilities.

### EHI Coverage Assessment

**Clinical data: PRESENT** — Encounters with diagnoses, vital signs, tests, refractions (eye-care-specific), services/procedures, clinical decision support, care plan items, family/social history, allergies, immunizations, medications (via medicalOrders), implantable devices, health goals/concerns, orientation/mood assessment. The clinical coverage is solid and includes eye-care-specific data (refractions with OD/OS sphere/cylinder/axis/prism, ocular family history).

**Billing/financial data: PRESENT** — Invoices with line items including CPT codes, unit prices, discounts, tax, adjustments, paid amounts, and balances. Payments with date, method, and amount. Claim history with submission dates and status messages. Statements with balances and due dates. This is notably detailed — actual dollar amounts, not just code references.

**Insurance/coverage data: PRESENT** — Insurance objects with company name, coverage type, policy number, group number, payer ID, and policyholder relationship. Basic but functional.

**Appointments/scheduling: NOT PRESENT** — Despite the product having extensive scheduling capabilities (online booking, recall, surgical calendars), there is no appointment or scheduling data in the export schema. The Encounter object has encounterDate and status but encounters are completed visits, not future appointments. This is a significant gap given the product's scheduling and recall features.

**Secure messages / patient communications: NOT PRESENT** — The product has 2-way text messaging (SMS/WhatsApp), VoIP with call logging, AI Receptionist interactions, and recall/reminder communications. None of this appears in the export schema. No message, communication, SMS, text, chat, correspondence, or inbox fields anywhere in the schema.

**Documents/images: NOT PRESENT** — The product stores telemedicine video recordings, scanned documents, diagnostic images (OCT), voicemail recordings/transcriptions, and uploaded files. None of these appear in the export schema. There is no document, image, attachment, file, blob, or media type in the 35 schemas.

**Audit/access: NOT PRESENT** — No audit trail data in the export. (This is generally excluded from the Designated Record Set, so its absence is expected and not a gap.)

### Issues & Red Flags

1. **Significant data gaps relative to product capabilities.** The product stores substantially more data than what the export covers. Appointment scheduling, patient communications (SMS/WhatsApp), telemedicine recordings, diagnostic images, optical POS transactions, and document storage are all product features whose data is absent from the export. Given the b(10) requirement to export "all EHI that can be stored by the product," these are notable omissions.

2. **Population export requires contacting customer support.** This is not self-service, which may not meet the spirit of the b(10) requirement for readily available export functionality.

3. **No prescription (medication) schema.** The product has e-prescribing (ERX) capability, but the export schema has no dedicated Prescription or Medication object. Medications may be partially captured via MedicalOrder, but medication lists, prescription history, and pharmacy information are not explicitly represented.

4. **Optical POS data absent.** The product's optical point-of-sale system tracks frame/lens inventory, retail transactions, and customer purchase profiles. None of this appears in the export — InvoiceItem covers service billing but not retail product sales.

5. **Documentation is minimal.** The b10 page is 3 sentences. The data dictionary is just the OpenAPI schema with no narrative explanation, no examples, no process documentation for how to perform an export, and no information about export formats, timing, or completeness guarantees.

6. **No version or update date.** Neither page shows when the documentation was last updated or what version of iTRUST it corresponds to.
