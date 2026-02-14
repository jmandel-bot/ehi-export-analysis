# Astronaut, LLC — Product Research

Researched: 2026-02-14
Developer website: https://astronautehr.com

## Overview

Astronaut, LLC is a very small, employee-owned EHR vendor based in Houston, Texas, founded in 2009 by Ignacio Valdes, MD, MS — a board-certified Psychiatrist and Clinical Informatics specialist. The company has approximately 4-5 named employees (CEO, President, two software engineers, Director of Training). Their product, Astronaut EHR, is built on top of **VistA** (the Veterans Affairs health information system) and uses a customized version of **CPRS** (Computerized Patient Record System) called **Astro-CPRS** as its clinical client.

The company serves inpatient hospitals, outpatient clinics, and Partial Hospitalization Programs (PHP) / Community Mental Health Centers (CMHC), with a strong focus on **Psychiatry and behavioral health**. The website reports approximately 34,000 patient records in the system. Astronaut operates as a cloud-hosted, multi-tenant network ("Astronaut Networks") where multiple clinics share infrastructure. The product was previously marketed as "Astronaut VistA" at astronautvista.com before rebranding to Astronaut EHR at astronautehr.com.

The company achieved ONC Meaningful Use MACRA/MIPS certification on February 1, 2022, for both inpatient and outpatient settings.

## Product: Astronaut

CHPL ID: 10809
CHPL Product Number: 15.02.05.3099.ASTR.01.00.1.220201
Version: 1709

### What It Is

Astronaut is a **full-featured EHR built on top of VistA** (the open-source version of the VA's health information system), with a customized clinical client called **Astro-CPRS**. VistA is a comprehensive health information system with deep capabilities in clinical documentation, pharmacy, lab, scheduling, and more — Astronaut has adapted and extended it for the private-sector behavioral health market.

The product is cloud-hosted and browser-based ("100% browser" per the website; full virtualization announced July 2017). Prior to that, it appears a native Windows client installer was distributed (evidenced by SourceForge download links for `astronaut_clients.BETA.16.09.02.exe`). The product is described as "enterprise-grade" though it targets small to mid-size practices.

The certified module encompasses the entire Astronaut EHR product — there is no separate product platform. The certification covers both inpatient and outpatient settings.

### Users & Market

**Target users:** Psychiatrists, Nurse Practitioners, Physician Assistants, and their supervisors. Also used by clinical staff, billers, and office managers.

**Clinical settings:**
- Outpatient mental health / behavioral health clinics
- Partial Hospitalization Programs (PHP)
- Community Mental Health Centers (CMHC)
- Inpatient psychiatric facilities
- Some general outpatient clinics

**Named customers** (from news releases):
- Washington County Behavioral Health (geographic area, telemedicine) — October 2016
- NP Care (home mental health, complex mental health patients) — June 2016
- Kinghaven Partial Hospitalization Program — June 2016
- Daystars PHP in Stafford, TX — January 2016
- MSP-Healthcare (Arizona, EPCS-focused) — April 2016
- Operations in Pennsylvania, Oregon, and West Virginia mentioned — 2015

**Scale:** Very small. 34,000 patient records total is mentioned on the website. The vendor serves a niche market of behavioral health practices. No publicly available third-party review data was accessible (G2 and Capterra both returned bot-verification walls).

**Testimonial user:** Jennifer Lableu, NP — praised the system for speed: "Each appointment is done when they walk out of the room." Office manager Jenny Salvador also referenced in news.

### Modules & Functionality

Being VistA-based, Astronaut inherits VistA's comprehensive architecture. The following modules and features are specifically described in vendor materials:

**Clinical Documentation / Charting:**
- Clinical notes with several proprietary efficiency features:
  - **Touch Note™** — mentioned as a charting shortcut
  - **Rocket Note™** — "eliminates the approximately 11 step process of forwarding a clinical note for follow-up visits" (Nov 2016)
  - **Turbo Supervision™** — workflow for supervising NPs/PAs, with "Next Patient/Previous patient advance on a clinical list" (Dec 2015, upgraded Aug 2016)
  - **List Signaling™** — mentioned as productivity feature
- Customizable templates, including a "full set of standard PHP/CMHC templates" (Feb 2017)
- Patient consent gathering integrated into notes (Sept 2016)
- Attachments to notes

**CPOE (Computerized Provider Order Entry):**
- Certified for medications (a)(1), lab (a)(2), and diagnostic imaging (a)(3)
- Drug-drug, drug-allergy interaction checks (a)(4)

**Electronic Prescribing:**
- Certified for (b)(3) e-prescribing
- Uses **NewCrop** (DrFirst) for e-prescribing via the **Surescripts** network
- **EPCS** (Electronic Prescribing of Controlled Substances) — highlighted since 2015, critical for psychiatry (controlled substance prescribing is core to psychiatric practice)
- Original e-prescribing system was the "George Lilly/Newcrop/Oroville eRx system," upgraded Dec 2015 for national network support

**Scheduling:**
- Integrated, single sign-on appointment scheduling in CPRS (Feb 2017)
- Previously used separate VistA Clinical Scheduling application

**Billing:**
- **Inpatient billing lists** in Astro-CPRS (Jan 2016) — "Easily exportable to your favorite billing software"
- **Full integrated billing** for both inpatient and outpatient announced July 2020 ("Astronaut Integrated Billing Available")
- ICD-10 support added October 2015
- COVID-19 ICD/CPT codes added July 2020
- Billing lists with accuracy checks/workflow completion (July 2016)

**Patient Demographics:**
- Certified for (a)(5) demographics
- vCardDAV demographics support for drag-and-drop patient registration (Nov 2015)
- Demographic import from smartphone/email

**Supervision & Multi-Provider Workflows:**
- Turbo Supervision™ — a major differentiator, optimized for psychiatrist supervision of NPs and PAs
- "Comprehensive paperless distance supervision" for both inpatient and outpatient (Aug 2015)

**Telemedicine:**
- Telemed support added November 2015
- Patient Skype-ID, phone number, email recorded at registration
- Washington County Behavioral Health uses it telemedically

**Decision Support:**
- Certified for (b)(11) Decision Support Interventions

**Clinical Quality Measures:**
- Certified for (c)(1) CQM Record and Export
- 16 CQMs certified, heavily weighted toward behavioral health:
  - Depression screening (CMS2), antidepressant management (CMS128), substance use disorder (CMS137), dementia cognitive assessment (CMS149), PHQ-9 depression tool (CMS159), adult suicide risk assessment (CMS161), child/adolescent suicide risk assessment (CMS177)
  - Also general measures: BMI (CMS69), tobacco use (CMS138), blood pressure (CMS165), immunizations (CMS117), high-risk medications in elderly (CMS156)

**Transitions of Care:**
- Certified for (b)(1) — C-CDA generation
- Uses **WorldVistA Opensource CDA Documents Generator** for C-CDA output

**Interoperability:**
- Direct messaging via (h)(1) Direct Project
- FHIR API via (g)(10) — SMART on FHIR
- Custom REST API for patient lookup and C-CDA retrieval

**Security & Administration:**
- Multi-factor authentication for Astro-CPRS, Scheduling, system administration, and ePrescribing
- Audit logging, emergency access, encryption
- Signing PIN for documents

### Data & Content

Based on the certified criteria, API documentation, and vendor materials, Astronaut stores:

**Clinical Data (confirmed via API data sections and certification):**
- Patient demographics (name, DOB, SSN, gender, race, ethnicity, language, address, phone, email, Skype ID, marital status, religious affiliation)
- Allergies (medication allergies)
- Problems / diagnoses (ICD-10)
- Medications (active, historical)
- Lab results / lab orders
- Vital signs
- Immunizations
- Procedures
- Social history (including smoking status)
- Encounters
- Assessments
- Plan of treatment
- Goals
- Health concerns
- Clinical documents/notes
- Evaluations
- Family health history (certified (a)(12))
- Implantable device list (certified (a)(14))
- Unique Device Identifiers

**Operational Data:**
- Scheduling / appointments
- Billing lists (inpatient and outpatient) with ICD/CPT codes
- Patient consents
- Provider orders (medications, labs, imaging)
- Clinical quality measure data
- Audit logs

**Prescription Data:**
- E-prescribing records (via NewCrop/Surescripts)
- Controlled substance prescriptions (EPCS)

**As a VistA-based system**, the underlying database (likely a MUMPS/Caché/GT.M globals-based FileMan database) potentially stores significantly more data than is surfaced through the API or the website's feature descriptions. VistA systems typically maintain extensive data in hundreds of FileMan files covering radiology, surgery, pharmacy, laboratory, scheduling, billing, and many other domains. However, it is unclear how much of VistA's full data model Astronaut actually uses vs. what is dormant from the inherited codebase.

**What's unclear:**
- Whether there is a patient portal (no certification for (e)(1) View/Download/Transmit — the (e)(3) certification is for Patient Health Information Capture, suggesting some patient-facing data intake, but no full portal)
- The depth of billing integration — the 2016 billing lists were "exportable to your favorite billing software," but full integrated billing was announced in 2020. Whether this means claim submission, ERA processing, or just charge capture is unclear
- Whether the system stores imaging data directly or only references/orders
- Whether lab data is from integrated lab instruments or only manually entered or received results

**Additional software dependency:** NewCrop (DrFirst) is listed as required additional software, with a monthly charge for NewCrop and Surescripts network access. This means some prescription data may live in both Astronaut and the NewCrop system.

---

## Key Observations for EHI Export Assessment

1. **VistA heritage is critical.** As a VistA-based system, the underlying data model is far richer than what the small vendor's website reveals. VistA systems have hundreds of data files. The EHI export must cover not just the API-surfaced clinical data but all data stored in the VistA database.

2. **Behavioral health focus means specific data types.** Psychiatric assessments, PHQ-9 scores, suicide risk assessments, substance use disorder treatment data, supervision records, and PHP/CMHC program data are core to this product.

3. **Billing integration is relatively recent** (full integration 2020). The export should cover billing/claims data if it's stored in the system.

4. **Small scale.** 34,000 patient records and a handful of named customers suggest a very small deployment footprint. This may mean the export tooling is simpler/less mature.

5. **NewCrop dependency.** E-prescribing data flows through a third-party system (DrFirst/NewCrop). Whether the EHI export includes prescription data that lives in NewCrop vs. only what's stored locally in VistA is a question for Phase 2.
