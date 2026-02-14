# Varian Medical Systems — Product Research

Researched: 2025-07-14
Developer website: https://www.varian.com/oncology/products/software

## Overview

Varian Medical Systems is a major oncology technology company, now a subsidiary of Siemens Healthineers (acquired in 2021 for ~$16.4 billion). Varian is the global leader in radiation therapy equipment and software, with a dominant market share in linear accelerators (linacs) and oncology information systems. Their products are used in radiation oncology, medical oncology, and surgical oncology departments across thousands of cancer centers worldwide — from community hospitals to major academic medical centers.

Varian's software portfolio centers on the ARIA platform, which is an Oncology Information System (OIS) / oncology-specific EHR. ARIA manages the clinical, administrative, and financial workflows of cancer treatment departments. The newer "ARIA CORE" is the evolution of the legacy "ARIA OIS" platform, designed to unify radiation oncology, medical oncology, and systemic therapy management into a single system. Noona is a separate patient engagement/patient-reported outcomes (PRO) platform that Varian acquired (originally developed by Finnish company Noona Healthcare) and integrated into the ARIA ecosystem.

## Key Sources

- https://www.varian.com — Main website (now branded Siemens Healthineers Cancer Care). Product navigation, overview of full portfolio including radiotherapy, brachytherapy, adaptive therapy, and software products.
- https://www.varian.com/products/software/digital-oncology/oncology-management-systems/aria-core — ARIA CORE product page. Describes it as "a complete continuum of care for all of oncology" with unified workflows, single sign-on, and integration with Eclipse treatment planning and Noona.
- https://www.varian.com/products/software/digital-oncology/legacy-solutions/aria-oncology-information-system — Legacy ARIA OIS product page. Very detailed feature list: treatment plan review, image review, health assessment, scheduling, charge posting, financial management, data archiving, electronic documentation, RT chart auditing.
- https://www.varian.com/products/software/digital-oncology/legacy-solutions/aria-ois-for-medical-oncology — ARIA OIS for Medical Oncology. Details chemotherapy order management (300+ regimens), clinical trial management, toxicity tracking, cancer staging, charge capture with HCPCS/CPT codes.
- https://www.varian.com/products/software/digital-oncology/oncology-management-systems/aria-systemic-therapy-management — ARIA Systemic Therapy Management (STM). Cloud-native module for chemotherapy, immunotherapy, hormone therapy, and theranostics medication management.
- https://www.varian.com/products/software/patient-engagement/noona — Noona product page. Patient engagement platform with ePROs, symptom reporting, questionnaires, appointment sharing, treatment information delivery. Available in 12 languages on iOS and Android.
- https://www.varian.com/products/software/analytics/aria-core-insights — ARIA CORE Insights analytics platform. Cloud-native, integrates data from ARIA CORE, Eclipse, STM, and Noona.
- https://www.varian.com/products/software/digital-oncology/aria-core-for-theranostics — ARIA CORE for Theranostics page showing how ARIA CORE, STM, Noona, and ARIA CORE Insights work together for radiopharmaceutical therapy workflows.

## Product: ARIA CORE

CHPL IDs: 11719

### What It Is

ARIA CORE is Varian's next-generation oncology information system (OIS) — essentially a specialty EHR purpose-built for cancer care. It evolved from the legacy ARIA OIS platform and is designed to be a comprehensive clinical, administrative, and workflow management system for radiation oncology, medical oncology, and surgical oncology departments. The product name "ARIA CORE" represents the unified platform; it has additional modules including ARIA CORE Mobile (mobile access), ARIA Systemic Therapy Management (cloud-native chemotherapy/immunotherapy module), and connects to ARIA CORE Insights (analytics) and Noona (patient engagement).

ARIA CORE is certified for a broad range of ONC criteria: clinical data (a)(1)-(5), (a)(12), (a)(14); transitions of care (b)(1)-(3); patient portal (e)(1); FHIR APIs (g)(7), (g)(9), (g)(10); and public health (h)(1). This indicates it functions as a full clinical EHR within its oncology domain — not just a treatment planning tool.

### Users & Market

**Users**: Radiation oncologists, medical oncologists, radiation therapists, oncology nurses, nurse practitioners, medical physicists, dosimetrists, clinic schedulers, billing staff, practice managers. The SED description lists "Registered nurses, nurse practitioners, therapist, medical doctors."

**Settings**: Hospital-based cancer centers, freestanding radiation oncology clinics, academic medical centers, community oncology practices, proton therapy centers. Varian linacs are installed in thousands of facilities worldwide; ARIA is the standard OIS paired with Varian treatment machines.

**Market position**: Varian is the dominant player in radiation oncology technology globally. Their linacs (TrueBeam, Halcyon, Edge) and OIS (ARIA) together form the standard workflow in most radiation oncology departments. The ARIA install base is estimated at 5,000+ sites worldwide. As a Siemens Healthineers company, they have massive enterprise sales reach.

**Notable**: ARIA is typically deployed alongside Varian treatment delivery hardware. It's often the "system of record" for the radiation oncology department even when the hospital uses a general-purpose EHR (like Epic or Cerner) for the rest of the organization. ARIA integrates with those systems via HL7 and DICOM interfaces. The product page specifically mentions an "ARIA Epic Product Brief" and interoperability features.

### Data It Likely Stores

ARIA CORE stores an exceptionally deep dataset specific to oncology care:

**Clinical Records (Core)**:
- Patient demographics
- Diagnoses (ICD-9, ICD-10, ICD-O oncology codes)
- Cancer staging (automated AJCC staging)
- Medications and drug orders
- Lab results and vital signs
- Allergies
- Clinical notes and assessments
- Problem lists
- Performance status scores (ECOG, Karnofsky, GOG, Lansky)

**Radiation Therapy-Specific Data**:
- Treatment plans (prescriptions, dose calculations, field configurations)
- Treatment delivery records (actual delivered doses per fraction)
- Treatment schedules and fractionation schemes
- Machine parameters and delivery data
- Image-guided therapy images (MV, kV, CBCT, CT, MR, PET)
- Quality assurance records and chart audits
- Treatment overrides and modification history
- Physics QA data
- Dose-volume histograms
- Plan approval chains with e-signatures

**Medical Oncology-Specific Data**:
- Chemotherapy regimens (300+ disease-specific protocols)
- Dose calculations (m², /kg, AUC-based)
- Drug interaction checks and dose limits
- Treatment modification rules
- Toxicity management and adverse event documentation
- Chemotherapy administration records
- Pharmacy orders

**Clinical Trials**:
- Protocol management
- Patient screening and enrollment
- Scheduling
- Case Report Form auto-generation
- Trial-specific documentation

**Scheduling**:
- Patient appointments
- Resource/machine scheduling
- Staff scheduling
- Recurring appointment management
- Outlook synchronization

**Billing/Financial**:
- Charge capture (automatic for completed activities)
- HCPCS, CPT, and custom billing codes
- ICD code verification for reimbursement
- Technical/professional charge splitting
- RVU tracking
- Productivity analysis
- Export to billing systems
- Centricity Physician Office integration (practice management)
- Advanced Claim Edits (ACE) with oncology-specific logic

**Document Management**:
- Electronic documentation with audit trails
- Scanned documents and additional files
- Patient photos
- Date-stamped e-signatures
- Templates for clinical documentation
- Voice dictation support

**Imaging**:
- Multi-modality image storage and review (MV, kV, CT, CBCT, MR, PET)
- DICOM image management
- Image comparison and matching (automatic, manual, fiducial)
- Treatment verification images

**Data Exchange/Interoperability**:
- HL7 interfaces (inbound and outbound)
- DICOM interfaces
- FHIR/SMART on FHIR APIs (certified)
- Custom interface support
- Real-time or scheduled data synchronization

**Analytics Data** (via ARIA CORE Insights):
- Operational KPIs
- Treatment outcome metrics
- Resource utilization data
- Cross-system unified data (Eclipse, STM, Noona)

### Notable Features Relevant to EHI

1. **Deep specialty data**: ARIA stores radiation therapy delivery data that has no equivalent in a general EHR — treatment machine parameters, beam configurations, dose distributions, QA measurements. These are critical health data for radiation oncology patients.

2. **Billing/financial integration**: ARIA has built-in charge capture and posting, with the Centricity/ACE practice management integration. Financial data for oncology services flows through ARIA.

3. **Legacy vs. CORE architecture**: The transition from legacy ARIA OIS to ARIA CORE is ongoing. The legacy system is on-premise; ARIA STM (a CORE module) is cloud-native. Data may span both architectures.

4. **Tight hardware integration**: ARIA is the control/record system for Varian treatment machines. Treatment delivery data (machine logs, actual delivered doses) flows directly from the linac into ARIA.

5. **Image storage**: ARIA stores and manages a large volume of medical images — not just clinical photos but treatment planning images and verification images. This is a significant data domain.

6. **Clinical trial data**: Embedded clinical trial management means ARIA may store research protocol data alongside clinical data.

7. **Patient portal**: Certified for (e)(1), indicating patient-facing data access capabilities.

8. **Data archiving**: Supports DICOM and XML archival, suggesting structured data export capabilities exist.

---

## Product: Noona

CHPL IDs: 11747

### What It Is

Noona is an oncology-focused patient engagement platform — essentially a patient portal and remote symptom monitoring application. Originally developed by Finnish startup Noona Healthcare, it was acquired by Varian and is now marketed as part of the ARIA CORE digital oncology ecosystem. Noona is a mobile/web application that connects cancer patients with their care teams for symptom reporting, treatment information sharing, and clinical communication.

Noona's certification is narrow: (b)(10) EHI export, (e)(1) patient portal/VDT, and basic security/platform criteria. It's not a clinical EHR — it's a patient-facing companion application that feeds data into the broader ARIA ecosystem.

### Users & Market

**Primary users**: Cancer patients (via mobile app on iOS/Android, available in 12 languages) and their care teams (oncology nurses, nurse practitioners, oncologists who review patient-reported data).

**Settings**: Deployed at cancer centers that use ARIA CORE, but can also integrate with other Hospital Information Systems (HIS). The product page explicitly states it works with "ARIA CORE or other Hospital Information Systems."

**Market**: Sold as an add-on to ARIA CORE deployments. Specific install base numbers not available, but marketed globally (12 language support, country-specific Varian website versions for Australia, Brazil, Japan, Finland, etc.).

### Data It Likely Stores

**Patient-Reported Outcomes (ePROs)**:
- Symptom reports and severity scores
- Quality of life questionnaire responses
- Oncology-specific standardized questionnaires
- Free-text patient messages
- Photos of visual side effects (e.g., skin reactions, wound healing)

**Treatment Information (received from ARIA/HIS)**:
- Upcoming appointment details and reminders
- Patient education materials
- Test results (shared from clinic)
- Clinical reports

**Communication Data**:
- Patient-to-care-team messaging
- Automated administrative communications (appointment reminders, questionnaire distribution)
- Document sharing

**Engagement/Usage Analytics**:
- Patient adoption and usage metrics
- Symptom trend data over time
- Care staff efficiency metrics
- Real-time dashboards on Noona utilization

**Patient Account Data**:
- Patient profiles and preferences
- Language preferences
- Notification settings
- Consent records

### Notable Features Relevant to EHI

1. **ePRO data is unique to Noona**: Patient-reported symptom data, photos, and questionnaire responses originate in Noona and may not exist in ARIA CORE. This is a key data domain for EHI completeness.

2. **Bidirectional data flow with ARIA**: Noona receives appointment and treatment data from ARIA, and sends ePRO/symptom data back. The EHI export needs to account for data that originates in each system.

3. **Cloud-native**: Noona is a cloud application, unlike legacy ARIA which is on-premise. This architectural difference may affect how EHI export works.

4. **Patient-facing**: As a patient portal, Noona stores data from the patient's perspective — their own reports, their view of their care. Patient portal data is explicitly called out in (e)(1) certification.

5. **Messaging**: While not a full secure messaging system like a general EHR patient portal, Noona enables digital communication between patients and care teams, which constitutes health information.

6. **Photo/image data**: Patients can submit photos of side effects, which is clinical data that may be relevant to EHI.
