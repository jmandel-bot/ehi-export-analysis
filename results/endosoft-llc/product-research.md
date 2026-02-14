# EndoSoft, LLC — Product Research

Researched: 2025-07-14
Developer website: https://www.endosoft.com/

## Overview

EndoSoft, LLC is a privately held health IT company headquartered in Schenectady, New York, founded in 1995 by brothers Rakesh Madan and Manish Madan. The company specializes in **endoscopy-focused EHR and procedure documentation software**, primarily serving gastroenterology and other procedural specialties. Their origin story is telling: they started by building software to capture endoscopic images and save them to a computer, eliminating paper printing. That image-capture-plus-procedure-documentation DNA still defines the product line.

EndoSoft has an international presence with offices in the UK (Leicester), the Netherlands (Alphen aan den Rijn), India (Bangalore), Australia (Sydney), China (Suzhou, via Utech Biotechnology partner), Germany (Willich, via Utech Products GmbH), UAE (Abu Dhabi), and Canada (Laval, QC). This is a much larger global footprint than their low-profile US CHPL presence would suggest. They hold ISO 13485:2016 (medical device quality management) and ISO/IEC 27001 (information security) certifications, are HIMSS EHR Association members, and have Department of Defense / VA approvals for EndoVault. They serve hospitals, ambulatory surgery centers (ASCs), and practice-based endoscopy units. Testimonials reference McGill University (Canada), Queen Elizabeth Hospital (UK), and Harvard Vanguard Medical Associates.

The company has four products: **EndoVault** (their flagship on-premise EHR), **Qlinical** (a cloud-based EHR — the certified product here), **Argus AI** (AI-driven NLP procedure documentation), and **Approvon** (procedure order approval workflow, developed with NHS). Specialties served include gastroenterology, oncology, pulmonology, pain management, pathology, general surgery, orthopedics, OB/GYN, otolaryngology, and urology — though endoscopy/GI is clearly the core.

## Product: Qlinical

CHPL ID: 10855
CHPL Product Number: 15.02.05.2721.QLIN.01.01.0.220310
Certified: March 10, 2022

### What It Is

Qlinical is EndoSoft's **cloud-based EHR** and procedure documentation system, positioned as the lighter-weight, lower-cost alternative to their flagship EndoVault product. The vendor describes it as "ideal for small to medium sized practices with limited IT resources" — a subscription-based SaaS offering with no server maintenance required. It runs on its own domain (qlinical.com) with a web login.

Qlinical is certified for a very minimal set of ONC criteria: only **(b)(10)** (EHI export) plus **(d)** security/privacy infrastructure criteria and **(g)(4)**/**(g)(5)** (quality management/accessibility). It has **no clinical criteria** [(a)(1)–(a)(14)], **no transitions of care** [(b)(1)–(b)(3)], **no patient portal** [(e)(1)], **no public health reporting** [(f)(1)–(f)(7)], and **no FHIR API** [(g)(7)–(g)(10)] certifications. This means the certified module is purely the EHI export function, not a broadly-certified EHR. Qlinical appears to function as a complete specialty EHR in practice but chose to certify only for the minimum required criteria.

### Users & Market

Qlinical targets **small to medium procedural practices** — endoscopy units, GI practices, and other procedural specialties — that want cloud-based access without on-premise infrastructure. The product is marketed as a budget-friendly alternative to EndoVault ("cutting edge workflow with cost savings embedded"). The vendor advertises subscription-based pricing.

The qlinical.com site is a simple product site with a login portal, feature pages, and ONC certification disclosures. There is no publicly available customer count or case study for Qlinical specifically (the vendor testimonials on endosoft.com reference EndoVault, not Qlinical). Given the minimal marketing investment on the Qlinical site compared to EndoVault, Qlinical is likely a smaller product in terms of install base.

### Modules & Functionality

Based on the qlinical.com feature pages and the endosoft.com Qlinical product page, the product includes:

**Consultation Module:**
- Progress notes (chief complaints, history of present illness, recommendations)
- History evaluation (indications for exam, allergies, patient history, medications, prior anesthesia complications)
- Patient consent form generation (with tablet signature capture)
- Referral letter generation (print or email)
- Discharge summary (email or print)
- Image management within consultation

**Imaging Module:**
- HD image and video capture from endoscopy equipment
- One-click capture
- Diagram/annotation tools (label image locations on built-in anatomical diagrams)
- Image findings and notes

**Procedure Documentation Module:**
- Procedure report generation (PDF output)
- Quality of care indicators input
- Custom picklists for common procedures
- Image management within procedure reports
- Direct email of reports to patients

**Electronic Nursing Record (ENR):**
- Listed as a separate module on the endosoft.com Qlinical page
- Nursing history: pre-procedure, intra-procedure, and post-procedure
- Medication reconciliation
- Automatic vital signs recording
- Patient tracking
- Nursing discharge evaluation
- "Proprietary Documentation & Quality Reporting Compliance"

**Scheduling:**
- Cloud-based appointment scheduling
- Custom alerts

**Invoicing:**
- Listed as a navigation item on qlinical.com
- The consultation page mentions "Create your invoice with a click of a button!"
- However, the invoicing page itself shows imaging/procedure content instead (appears to be a broken or placeholder page)
- Nature and depth of invoicing/billing capabilities is unclear from available materials

**AI Integration:**
- Argus AI is described as "embedded in Qlinical" on the endosoft.com product page
- This would add voice-activated NLP procedure documentation and automated quality metric capture
- MedGPT generative AI chart review may also be available

**E-Prescribing:**
- Listed as a feature on the endosoft.com Qlinical page ("E-Prescriptions")

### Data & Content

Based on what the product pages describe, Qlinical stores:

**Clinical Data:**
- Patient demographics and history
- Allergies
- Medications and medication reconciliation
- Vital signs (including automatic capture from devices)
- Patient consent forms (with electronic signatures)
- Progress notes / consultation notes
- History of present illness, chief complaints
- Indications for exams
- Prior anesthesia complications

**Procedure Data (core strength):**
- Complete procedure reports
- Procedure findings
- Quality of care indicators / quality metrics
- Diagnoses
- Recommendations

**Imaging/Media:**
- HD endoscopic images
- Endoscopic video
- Image annotations and diagrams
- Image-to-location mappings on anatomical diagrams

**Nursing Records:**
- Pre-procedure, intra-procedure, and post-procedure nursing documentation
- Patient tracking data
- Discharge evaluations

**Administrative/Other:**
- Appointment scheduling data
- Referral letters
- Discharge summaries
- Invoicing data (though scope is unclear)
- Prescriptions (e-prescribing mentioned)

**EHI Export Page (qlinical.com/ephi/)** lists these exportable data sections: Allergies, Encounter, Immunizations, Medications, Plan of treatment, Referral reason, Active problems, Reason for visit, Implants, Health concerns, Procedures, Functional status, Results, Social history, Vitals, Goals, Discharge instructions, Assessments, Cognitive status, Media, Diagnostic Report, Documents, Service Request. Export is available as C-CDA XML or FHIR bulk export (ndjson). This list suggests Qlinical stores a broader set of clinical data than the marketing pages explicitly describe — notably immunizations, implants, functional/cognitive status, social history, goals, and results appear in the export but are not prominently marketed.

**Notable gaps/uncertainties:**
- The website does not clearly describe billing or claims functionality — "invoicing" is mentioned but the invoicing page appears broken/misloaded, and it's unclear whether this is simple charge capture, invoice generation, or full claims management
- No mention of lab ordering or results interfaces (though "Results" appears in the EHI export list)
- No mention of patient portal or patient-facing features (consistent with no (e)(1) certification)
- No mention of CPOE beyond what EndoVault offers
- No mention of HL7/FHIR interoperability with hospital EHRs for Qlinical specifically (EndoVault features page discusses HL7 interfaces, but it's unclear if Qlinical has the same)
- Inventory management is listed as an EndoVault ENR feature but not mentioned for Qlinical's ENR

### Relationship to EndoVault

Qlinical appears to be a cloud-native re-implementation or cloud-hosted version of EndoSoft's core endoscopy documentation capabilities, stripped down for smaller practices. EndoVault is the full-featured, on-premise product with patient portal, CPOE, PACS integration, DICOM viewer, inventory management, and extensive HL7/FHIR interfaces. Qlinical offers the core procedure documentation and image capture workflow in a simpler cloud package. They are separate products with separate websites, separate CHPL certifications, and different target markets — but built by the same company with shared DNA. Argus AI is embedded in both.

---

## Notes

- EndoSoft's website is heavy on marketing but many pages redirect to the homepage (disclosure/cost, specialty pages, Argus page all redirected). The actual feature detail is spread across endosoft.com and qlinical.com.
- No third-party reviews were found for Qlinical specifically on G2, Capterra, or KLAS. EndoSoft/EndoVault may have reviews but they were not accessible during this research.
- The mandatory_disclosures_url field in CHPL metadata is empty, which is unusual. The qlinical.com site references "Qlinical EHR Disclosures" but that link also redirects to the homepage.
- The company's international footprint (UK, Netherlands, India, Australia, China, Germany, UAE, Canada) suggests a much larger operation than a typical small US EHR vendor, though much of the international business may be EndoVault-focused and UK/NHS-oriented.
