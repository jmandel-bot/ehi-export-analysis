# QRS, Inc. — Product Research

Researched: 2025-07-14
Developer website: https://qrshs.com/

## Overview

QRS, Inc. ("Quality Rep Services") is a small, privately held medical software company founded in 1983, headquartered in Knoxville, Tennessee (2010 Castaic Lane, Knoxville, TN 37932). The company was founded by Rusty Dickerson (still President) originally as a manufacturer's representative for cardiac medical equipment — the name "QRS" references the points on a heartbeat wave (ECG). The company transitioned into medical practice management and EHR software.

QRS is a very small vendor serving ambulatory medical practices across the United States. The company emphasizes long-standing customer relationships (testimonials reference 13–15+ year relationships), U.S.-based support, and a "turnkey" approach that bundles software, hardware, networking, data conversion, and ongoing support. They also operate their own claims clearinghouse, clearing "more than two million claims per year." The company does not disclose customer counts or revenue. There is no BBB listing, no G2 or Capterra presence, and very limited third-party coverage — consistent with a very small, niche vendor. Their SSL certificate was expired at time of research (qrshs.com), though the site was functional.

## Product: PARADIGM®

CHPL ID: 15.04.04.2838.PARA.22.01.1.221227 (CHPL listing 11142)

### What It Is

PARADIGM is an integrated EHR and practice management (PM) system for ambulatory medical practices. A critical architectural detail from the vendor's own website: "PARADIGM was designed as a single product with all the benefits of an EHR and Practice Management system. It is not a cobbled together system built from systems that were acquired by purchasing other companies. PARADIGM shares a single database between the EHR and the Practice Management system." This means clinical and billing/administrative data live in one unified database.

The certified module (PARADIGM® version 22) covers both the EHR and PM capabilities. The CHPL certification spans a broad set of criteria: clinical data ((a)(2), (a)(3), (a)(5), (a)(12), (a)(14)), transitions of care ((b)(1), (b)(2), (b)(7), (b)(8), (b)(10), (b)(11)), patient portal/VDT ((e)(1), (e)(3)), clinical quality measures ((c)(1), (c)(2), (c)(3)), public health reporting ((f)(1), (f)(2), (f)(5)), and API/FHIR access ((g)(2)–(g)(7), (g)(9), (g)(10)). This is a comprehensive certification covering 39 criteria — indicative of a full-featured ambulatory EHR+PM.

### Users & Market

PARADIGM is marketed to healthcare providers in ambulatory care settings. Per the Real World Testing results: "PARADIGM® EHR is principally marketed to healthcare providers in ambulatory care settings." The vendor's about page says: "Our Software is used by providers across America to streamline their scheduling, charting, imaging, billing, patient engagement, encounter documentation, data security, and more."

Target specialties are broad. The PM page specifically mentions specialty-specific modules for: Radiology, Allergy, Anesthesia Billing, Chiropractic, and Durable Medical Equipment. Customer testimonials come from billing service operators and multi-provider practices. One testimonial references opening a medical billing service and choosing Paradigm for it, suggesting the product is also used by third-party billing companies.

No customer count or install base data is publicly available. The vendor appears to serve primarily small to mid-size medical practices and billing services. The 2025 RWT report mentions testing with "a minimum of three client practices" and notes that "many client practices did not regularly utilize Direct Messaging to share clinical data" — suggesting a relatively small, low-complexity customer base.

### Modules & Functionality

Based on the vendor's website feature descriptions:

**PARADIGM EHR** (from qrshs.com/paradigm-ehr/):
- **Patient Flow**: View of the day's schedule with color-coded status (checked in, in care, fee slip created, checked out)
- **Custom Chart Layout**: Customizable chart tab configuration for organizing and storing patient information
- **Speech Recognition**: Supports speech-to-text for data entry into forms
- **Voice File Storage**: Can store .wav voice files attached to specific encounters
- **Note Generation**: Generates comprehensive final summary notes per encounter; customizable to include specific clinical areas
- **Prescriptions**: Issue prescriptions, refill existing prescriptions, enter historical medication information; auto-files to medications section of chart
- **Recall/Follow-ups**: Enter recall or follow-up appointments that automatically integrate with the scheduling system
- **Scanning**: Supports TIF, PDF, JPG file scanning into patient charts; described as key for paper chart elimination
- **Patient Search**: Database search functionality
- **Dynamic Fee Slip**: (listed as module; details not elaborated on the EHR page)
- **Electronic Work Lists**: Described as going beyond standard management reports
- **HL7 Interfaces**: Connects to labs, hospitals, and collection agencies

**PARADIGM PM** (from qrshs.com/paradigm-pm/):
- **Appointment Scheduling / Patient Flow**: Integrated scheduling
- **Claims Scrubbing**: Automated claim cleaning before submission
- **Insurance Contract Management**: Consolidated management of multiple insurance plans under common contracts
- **Claims Tracking**: View all claim types (printed and electronic) via Claims Manager
- **Patient Management**: Single-screen management of patient personal and insurance information
- **Referral Management**: Referral and authorization management from gatekeepers
- **Electronic Claims**: Direct access to QRS Clearinghouse for electronic claim submission
- **Electronic Remittance**: Electronic remittance advice posting
- **Collections**: Built-in collections program for working slow-paying accounts before write-off
- **Claims Error Information Management**: Auto-filing clean claims and repairing denials
- **Line Item Posting**: Charge-by-charge disbursement of payment, adjustment, and coordination of benefits; supports secondary claim filing
- **Charge/Payment/Adjustment Posting**: Single-screen concept for posting charges, payments, adjustments, plus messages and notes to encounters
- **Refund Management**: Refund program with check printing capability
- **Management Reporting**: Standard and custom reports
- **Institutional Billing (UB04)**: Supports facility billing
- **Insurance Card Scanning**: Scan insurance cards
- **Medicare Contract Fee Schedules**: Built-in Medicare fee schedules
- **Specialty-specific modules**: Radiology, Allergy, Anesthesia Billing, Chiropractic, Durable Medical Equipment
- **ODBC Connectivity**: Supports Crystal Reports, Access, Excel for custom reporting
- **HL7 Interfaces**: Labs, hospitals, collection agencies

**Additional Services & Integrations** (from various qrshs.com pages):
- **QRS Clearinghouse**: Vendor-operated clearinghouse clearing 2M+ claims/year; provides both claims submission and electronic remittance
- **EDI (Electronic Data Interchange)**: Direct electronic claims and remittance for Blues, Medicare, Medicaid across "almost every state"
- **Insurance Eligibility Verification (PARADIGM Verify)**: Real-time electronic eligibility checks connecting to thousands of payers; automated checks 24 hours before scheduled appointments. (Note: the eligibility page oddly references "Practice EHR" in one paragraph — possibly copied content from another product or a white-label relationship, though more likely just a web content error.)
- **Payment Processing**: Integrated merchant services that post directly to billing software and patient accounts; HIPAA-compliant
- **Electronic Statements**: Outsourced statement printing/mailing services
- **Appointment Reminder Service (PARADIGM ARS)**: Automated appointment reminders via messaging
- **Patient Portal**: portal.qrshs.com — login page exists; certified for (e)(1) patient view/download/transmit
- **FHIR API**: REST-based FHIR R4 API at api.qrshs.com supporting US Core resources
- **Patient API**: Separate API for patient search and C-CDA retrieval
- **Data Conversion**: Converts data from other PM systems into PARADIGM
- **Disaster Recovery**: Automated daily backup to QRS office in Knoxville with secondary offsite backup
- **Network Services**: Full networking services
- **Hardware Services**: Hardware sales, installation, and repair
- **Custom Programming**: Custom reports, data conversions, interfaces, custom forms & scripting

### Data & Content

Based on the unified single-database architecture and the features described above, PARADIGM stores:

**Clinical data** (evidenced by EHR features and FHIR API resources):
- Patient demographics (name, DOB, SSN, gender, race, ethnicity, language, address, phone — per FHIR Patient resource)
- Allergies and intolerances (per FHIR AllergyIntolerance resource and EHR features)
- Conditions/problems (per FHIR Condition resource)
- Medications and prescriptions (per FHIR MedicationRequest and EHR prescription module)
- Immunizations (per FHIR Immunization resource)
- Procedures (per FHIR Procedure resource)
- Vital signs and lab results (per FHIR Observation resource)
- Diagnostic reports (per FHIR DiagnosticReport resource)
- Care plans and assessments (per FHIR CarePlan resource)
- Care team members (per FHIR CareTeam resource)
- Goals (per FHIR Goal resource)
- Implantable devices (per FHIR Device resource)
- Encounter records (per FHIR Encounter resource)
- Clinical documents and notes — encounter summary notes (per FHIR DocumentReference and note generation features)
- Scanned documents (TIF, PDF, JPG files stored in patient charts)
- Voice recordings (.wav files attached to encounters)
- Provenance tracking (per FHIR Provenance resource)

**Administrative/billing data** (evidenced by PM features):
- Appointment scheduling data (including patient flow status)
- Insurance information and eligibility verification results
- Claims data (professional and institutional/UB04)
- Claim scrubbing and error information
- Payment, adjustment, and refund records (line-item level)
- Electronic remittance advice
- Insurance contract terms and fee schedules
- Referrals and authorizations
- Collection account data
- Patient statements
- Management reports

**EHI Export format** (from EHI Export Documentation):
- Export is via the "FHIR Data Portability" module, accessible through EHR System Reports
- Output is a ZIP file containing: standard C-CDA R2.1 XML per patient, additional data in JSON format (e.g., "invoice history"), and any files imported into the EHR in their original format (PDF, PNG, etc.) in a `_addt_files` directory
- There is a checkbox to "include all Electronic Healthcare Information (EHI) for each patient in the set"
- The mention of "invoice history" as a JSON export suggests billing/financial data is included in the EHI export

**Notable gaps/uncertainties:**
- The insurance eligibility page references "Practice EHR" in one paragraph, which is a different certified EHR product by a different vendor. This could be a web content error, or could hint at shared technology or white-labeling. However, the PARADIGM product has its own independent CHPL certification and distinct APIs, so this appears to be a copy-paste web error.
- No mention of secure messaging between providers and patients (Direct messaging noted as not widely used by customers in RWT results)
- No explicit mention of patient portal messaging capabilities (though portal exists)
- The vendor does not disclose customer count or market share
- The website's SSL certificate was expired, suggesting limited IT resources for their web presence
- Real World Testing was conducted primarily in sandbox/virtualized environments with small sample sizes (10 requests), not at scale in production — consistent with a very small vendor with limited API adoption

---

## Summary Assessment

PARADIGM is a small-vendor, full-featured ambulatory EHR+PM system with a unified database architecture. Its single-database design means the EHI export scope should encompass both clinical and billing/financial data. The vendor operates their own clearinghouse and provides a vertically integrated suite of services (software, hardware, networking, support, clearinghouse). The product serves small ambulatory practices and billing services, with specialty support for radiology, allergy, anesthesia, chiropractic, and DME billing. Despite its small market presence, the product has comprehensive ONC certification covering 39 criteria.
