# Nextech — Product Research

Researched: 2025-02-14
Developer website: https://www.nextech.com

## Overview

Nextech is a specialty EHR and practice management software vendor serving ambulatory practices in five specialty areas: dermatology, ophthalmology, plastic surgery, orthopedics, and med spa/aesthetics. The company positions itself as the leading provider of specialty-specific software solutions and claims over 16,000 medical practices as customers. Nextech has been recognized as the "2024 Best in KLAS: Ambulatory Specialty EHR" and holds AAD's DataDerm Gold Recognition for dermatology EHR.

Nextech offers cloud-based, integrated EHR and practice management platforms tailored to the unique workflows and documentation needs of each specialty. Their systems combine clinical charting with revenue cycle management, patient engagement tools, scheduling, and specialty-specific features (e.g., cosmetic treatment packages, ophthalmology-specific charting like refractions and glaucoma flowsheets, dermatology body diagrams).

## Product: SRS EHR (formerly SRSPro)

CHPL IDs: 11040

### What It Is

SRS EHR is a comprehensive ambulatory specialty EHR and practice management system. Based on the certification criteria (covering clinical data (a)(1)-(a)(14), transitions of care (b)(1)-(b)(2), view/download/transmit (e)(3), public health reporting (f)(1)+(f)(5), and standardized API (g)(7)), this is a full-featured clinical and administrative system.

"SRS" likely stands for "Specialty Record System" or similar, reflecting its multi-specialty ambulatory focus. The system serves the same specialty markets as Nextech's other products (dermatology, ophthalmology, plastic surgery, orthopedics, med spa).

### Data It Likely Stores

Based on the EHI export documentation structure, SRS EHR stores:

**Clinical Data:**
- Patient demographics and guarantor information
- Appointments and scheduling
- Clinical alerts (custom alerts)
- Diagnoses
- Family history
- Smoking status and other social history
- Implantable devices
- Injections and medications
- Orders (labs, imaging, procedures)
- Vitals
- Encounter documentation (structured data capture)
- Lab and diagnostic results
- CCDA-formatted clinical summaries

**Administrative & Practice Management:**
- Insurance information
- Guarantor/billing information
- Appointments and scheduling

**Patient Communications & Documents:**
- Messages (likely internal chart messages and patient communications)
- Documents attached to patient charts

**Custom/Configurable Data:**
- User Defined Fields (UDFs) - customizable demographic and clinical data fields
- Custom alerts

### Notable Features Relevant to EHI

1. **User Defined Fields (UDFs):** Allows practices to capture custom data beyond standard fields - important for EHI because this could include specialty-specific or practice-specific data that might not be obvious from standard export categories.

2. **Messages System:** The export includes "Messages.csv" suggesting an internal messaging or communication system tied to patient charts.

3. **Encounter Data Capture:** XML-based structured encounter documentation suggests templated or flowsheet-based charting.

4. **Document Management:** Separate folder for documents attached to charts, suggesting scanning/faxing/document upload capabilities.

5. **Custom Alerts:** Practice-configurable patient alerts beyond standard clinical alerts.

6. **Specialty-Specific Charting:** While not explicitly detailed in the folder structure, the system serves specialty practices with unique documentation needs (ophthalmology exams, dermatology body diagrams, cosmetic treatment planning).

### Sources
- https://www.nextech.com (main website)
- https://www.nextech.com/compliance/onc-health-it/srspro (ONC compliance page)
- https://www.nextech.com/dermatology (specialty-specific landing page)
- https://www.nextech.com/ophthalmology (specialty-specific landing page)
- SRSPro EHI Export Documentation PDF (reviewed folder structure and data dictionary references)
- CHPL metadata (certification criteria)

---

## Product: Nextech EHR (ICP) — powered by IntelleChartPRO

CHPL IDs: 11724

### What It Is

Nextech EHR (ICP) is a comprehensive ambulatory specialty EHR and practice management system powered by the IntelleChartPRO platform. "ICP" stands for IntelleChartPRO. This appears to be Nextech's primary/flagship EHR platform, distinct from the older SRS system.

Based on the certification criteria (similar to SRS: clinical data (a)(1)-(a)(14), transitions of care (b)(1)-(b)(2)+(b)(11), patient portal (e)(1), public health (f)(5), and standardized API (g)(7)+(g)(9)+(g)(10)), this is a full-featured system. Notably, it includes (e)(1) patient-facing portal capabilities (not just view/download/transmit) and more advanced API criteria including (g)(9) multi-patient services and (g)(10) standardized API for patient/population services.

Like SRS, this system serves specialty ambulatory practices in dermatology, ophthalmology, plastic surgery, orthopedics, and med spa markets.

### Data It Likely Stores

Based on the EHI export documentation structure, Nextech EHR (ICP) stores:

**Clinical Data:**
- Patient demographics
- Appointments
- Clinical alerts
- Encounter documentation (structured chart notes + CCDA)
- Diagnoses, medications, problems
- Laboratory results
- Procedures
- Referrals
- Specialty-specific data:
  - Refractions (ophthalmology)
  - Glaucoma flowsheets (ophthalmology)
  - Specialty medications

**Administrative & Practice Management:**
- Insurance and authorizations
- Scheduling/appointments

**Patient Communications:**
- Patient communications (portal-based)
- Internal communications (staff-to-staff)
- Secure messages (patient portal messages)
- ToDos/tasks (task management system)

**Documents & Imaging:**
- Documents folder with metadata
- Organized by document type and date
- Stored as JPG images with accompanying metadata files

**Legal/Compliance:**
- Signed consents (PDFs organized by consent template/location)
- Example: "Informed Consent for Cataract Surgery (OD).pdf"

**Correspondence:**
- Letters (separate folder for patient correspondence)

### Notable Features Relevant to EHI

1. **Patient Portal Integration:** The (e)(1) certification and presence of "Secure Messages" folder indicate a patient-facing portal with bidirectional messaging. This means patient-initiated communications are part of EHI.

2. **Task Management System:** "ToDos.json" suggests a task/workflow management system. Tasks assigned to patients or about patient care could be considered EHI.

3. **Multiple Communication Channels:**
   - Patient Communications (portal-based)
   - Internal Communications (staff)
   - Secure Messages (portal)
   - This suggests multiple overlapping communication systems that all might contain EHI.

4. **Specialty-Specific Clinical Data:** Explicit folders for specialty data like refractions and glaucoma flowsheets indicate deep specialty-specific functionality. For practices using these features, this data is critical clinical information.

5. **Document Management with Metadata:** Documents stored as images with separate metadata files, organized by type and date. The metadata likely includes document type, date, provider, notes, etc.

6. **Consent Management:** Structured consent tracking with PDFs of signed forms, organized by consent type and location/side (e.g., OD/OS for ophthalmology).

7. **Letters/Correspondence:** Separate tracking of letters suggests templated correspondence functionality (referral letters, treatment summaries, patient letters).

8. **Dual Format Encounters:** Each encounter exports both a structured CCDA and a formatted PDF chart note, suggesting the system maintains both discrete data and rendered documentation.

9. **IntelleChartPRO-Specific Features:** The documentation notes some features are "IntelleChartPRO only customers," suggesting there may be feature tiers or product variants (possibly Nextech Select/NexCloud as a different tier or deployment model).

### Broader Product Context

The certified module is "Nextech EHR (powered by IntelleChartPRO)," but Nextech also offers:
- **Nextech Select / NexCloud:** Mentioned in EHI documentation as a separate product line with its own data dictionary. Relationship to ICP is unclear (possibly a different deployment model, feature tier, or legacy product).
- **Practice Management:** The system includes billing, scheduling, and revenue cycle management integrated with the clinical EHR.
- **Patient Portal:** Patient engagement features including secure messaging, appointment requests, forms, and potentially payment/billing access.
- **AI Scribe (Cora Scribe):** Advertised as "First Look: AI Scribe Built for Ophthalmology" - ambient clinical documentation tool. Unclear if scribe-generated notes are stored separately or integrated into standard encounter notes.

### Sources
- https://www.nextech.com (main website)
- https://www.nextech.com/dermatology (specialty-specific landing page)
- https://www.nextech.com/ophthalmology (specialty-specific landing page with AI Scribe mention)
- Nextech EHR (powered by IntelleChartPRO) EHI Export Documentation PDF (reviewed folder structure)
- CHPL metadata (certification criteria)
- Spike analysis notes referencing data dictionary structure

---

## Vendor-Level Notes

### Product Relationship Uncertainty

Nextech appears to have at least three product lines with separate EHI documentation:
1. SRS EHR (CHPL 11040)
2. Nextech EHR powered by IntelleChartPRO (CHPL 11724)
3. Nextech Select / NexCloud (no CHPL ID identified, separate EHI documentation exists)

The relationship between these products is unclear from public documentation:
- Are SRS and ICP different platforms serving different specialties? (No - both seem to serve all five specialties)
- Is SRS a legacy product being phased out in favor of ICP? (Possible - ICP has more advanced certification criteria including patient portal)
- Is Nextech Select/NexCloud a deployment variant (on-prem vs cloud) or a different product tier?

For EHI completeness assessment, this matters because:
- If a practice uses multiple Nextech products (e.g., ICP for clinical + separate PM system), EHI export from one product might not capture everything
- If practices are migrated from SRS to ICP, historical data storage locations might differ

### Specialty-Specific Data Considerations

Because Nextech serves five distinct specialties with very different clinical needs:
- **Ophthalmology:** Refractions, glaucoma flowsheets, OCT imaging, visual fields, lens calculations, surgical planning for cataracts/refractive surgery
- **Dermatology:** Body diagrams, lesion tracking, Mohs surgery documentation, cosmetic treatment tracking, photography
- **Plastic Surgery:** Before/after photography, surgical planning, cosmetic vs reconstructive tracking, implant tracking
- **Orthopedics:** Joint-specific exams, imaging (X-ray, MRI), surgical hardware tracking, physical therapy orders
- **Med Spa/Aesthetics:** Treatment packages, product inventory, cosmetic outcome tracking, pricing/quotes for non-covered services

The EHI export folders visible in documentation are somewhat generic (appointments, diagnoses, documents, etc.). The specialty-specific data likely lives in:
- Encounter structured data (the XML/JSON encounter files)
- Custom fields (UDFs in SRS)
- Specialty flowsheets (like glaucoma flowsheet in ICP)
- Documents/imaging folders

During Phase 2 EHI assessment, the question will be whether specialty-specific charting features (e.g., dermatology body diagrams, plastic surgery before/after photo matching, ophthalmology surgical planning) are fully captured in the export or whether some visual/graphical data representations are lost.

### Integrated Practice Management

Both products emphasize "EHR & Practice Management" integration. The EHI exports show insurance and guarantor information, but the full scope of financial data is unclear:
- Are billing/claims stored in the same database as clinical data?
- Does the export include appointment scheduling details (patient requests, waitlists, cancellation history)?
- Are financial transactions, payment history, and patient balances included?

Under ONC rules, administrative data that is "about the individual" could be EHI. For a specialty practice doing high-volume cosmetic procedures, treatment packages, and cash-pay services, the financial/quote/package data might be clinically relevant (what treatment was proposed vs performed, patient's understanding of treatment plan, insurance vs self-pay decisions).

### Marketing vs Operational Features

Nextech's website emphasizes practice growth and revenue optimization:
- Cosmetic quotes and packages
- Inventory management
- Patient engagement/retention
- Analytics and reporting

These features generate data about patients (e.g., marketing communications sent, package purchases, product inventory used in treatments). Whether this data is considered EHI depends on whether it's "about the individual" and clinically relevant. Phase 2 assessment should consider whether such data is included in exports.
