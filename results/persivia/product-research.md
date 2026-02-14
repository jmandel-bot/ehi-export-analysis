# Persivia — Product Research

Researched: 2025-07-14
Developer website: https://persivia.com/

## Overview

Persivia is a healthcare IT company founded in 2015, headquartered in Marlborough, Massachusetts. The company builds CareSpace®, an AI-driven population health management and care coordination platform designed to help healthcare organizations succeed in value-based care (VBC) models. Persivia is **not a traditional EHR vendor** — its platform sits alongside and integrates with existing EHRs (80+ supported), aggregating clinical, claims, and other data into a unified longitudinal patient record, then applying AI/ML/NLP to generate actionable insights for providers and care managers.

Persivia serves a diverse customer base: ACOs, physician groups, hospitals and health systems, Medicare Advantage plans, payers, employers, and state public health departments. The company claims to support 200+ hospitals, 1,200+ users, and 20M+ patients across 180M+ encounters. Notable customers include McLaren Physician Partners, Prime Healthcare, St. John's Riverside Hospital, and the Massachusetts and Iowa Departments of Public Health. Persivia is Gartner-recognized for Health Data Management, AI-enabled Solutions, and Population Health.

---

## Product: Persivia Platform (CareSpace®)

CHPL IDs: 10918 (v4.0), 11149 (v3.5)

### What It Is

The Persivia Platform, branded as **CareSpace®**, is an end-to-end AI-driven digital health platform focused on population health management, care coordination, quality reporting, and risk adjustment. It is **not a primary EHR** for clinical charting or order entry — rather, it integrates bi-directionally with the provider's existing EHR(s) and layers on population health capabilities.

The platform consists of several key components:

1. **CareSpace®** — The overarching Population Health Cloud platform and care management workbench
2. **Data Cloud** — A lakehouse-based data aggregation and management layer that builds a Unified Data Model (UDM) from multiple sources
3. **Persivia CareTrak®** — An EHR-agnostic point-of-care tool that embeds inside provider EHRs via single sign-on, delivering alerts, care gaps, HCC coding suggestions, and a full patient view
4. **Soliton®** — The proprietary AI engine powering predictive analytics, NLP, and ML across all modules
5. **SmartLab™** — An Electronic Test Orders & Results (ETOR) system used by hospitals, labs, and state public health departments (in production with MA DPH and Iowa DPH for 15+ years)

The platform has two ONC-certified versions:
- **v4.0** (CHPL 10918): Certified for a narrower set — CDS criteria (c)(1-3), EHI export (b)(10), and supporting (d)/(g) criteria. Appears focused on CDS and quality measures.
- **v3.5** (CHPL 11149): Certified for a broader set including clinical data (a)(1-2, 5, 12, 14), transitions of care (b)(1), clinical information reconciliation (b)(11), CDS (c)(1-4), FHIR APIs (g)(7, 9), and direct messaging (h)(1). This version has meaningful clinical data management certification.

Target users include care managers, quality managers, CDI teams, physicians (via CareTrak embedded in their EHR), population health analysts, and risk adjustment coders.

### Data It Likely Stores

Persivia's platform is fundamentally a **data aggregation and analytics system**, which means it ingests, normalizes, and stores large volumes of patient data from many sources. The Unified Data Model (UDM) builds a Longitudinal Patient Record (LPR) per patient from:

**Clinical data (aggregated from EHRs and other sources):**
- Patient demographics
- Diagnoses / problem lists
- Medications / medication lists
- Allergies
- Lab results (both aggregated from EHRs and directly via SmartLab ETOR)
- Vitals
- Clinical notes / unstructured text (processed by NLP)
- Immunizations
- Procedures

**Claims and administrative data:**
- Claims data (from payers/clearinghouses)
- Eligibility information
- Administrative data

**Care management data (created within CareSpace):**
- Care plans and goals
- Care pathways (200+ built-in evidence-based pathways)
- Care management workflows and tasks
- Assessments (custom forms, SDOH screenings)
- Care coordination notes
- Transitions of care records
- Referral tracking

**Quality and risk data:**
- eCQM measure calculations and submissions (MIPS, MSSP, ACO REACH, HEDIS, etc.)
- HCC/RAF risk adjustment coding (NLP-extracted from notes, claimed 98% accuracy)
- Quality gaps and care gaps
- Risk stratification scores
- Predictive cost models

**Patient engagement data:**
- Patient portal activity
- Patient-reported data (via patient app — Android & iOS)
- Remote Patient Monitoring (RPM) data from 300+ home devices
- Messaging (bidirectional — text, audio, video between patients and care teams)
- Appointment scheduling
- Automated reminders and nudges

**Public health reporting data:**
- Lab orders and results (SmartLab — HL7 2.3.1/2.5.1)
- Electronic case reports
- Syndromic surveillance data

**HIE / real-time feeds:**
- ADT (admission/discharge/transfer) notifications from HIEs
- SDOH (Social Determinants of Health) data

### Notable Features Relevant to EHI

1. **Data aggregation is the core function.** The platform ingests and stores data from potentially dozens of EHRs and other systems per customer. The LPR (Longitudinal Patient Record) may contain far more data than any single source system. This raises the question: does the EHI export include all aggregated data, or only data originating within CareSpace itself?

2. **Care management workflows create original data.** Care plans, tasks, assessments, care coordination notes, and custom forms are created natively within CareSpace — these are not aggregated from EHRs. This data must appear in EHI exports.

3. **Patient engagement / messaging.** CareSpace includes a patient portal, patient app, and bidirectional messaging (text/audio/video). Messages and patient-reported data are original to the platform.

4. **Quality and risk adjustment calculations.** HCC codes extracted by NLP, quality measure calculations, risk scores, and care gaps are generated by the platform. Whether these derived/calculated data are "electronic health information" for export purposes is an interesting question.

5. **EHI export format is XML/CCD (QRDA Cat I).** The mandatory disclosure page says v4.0 exports in QRDA Cat I XML format, and v3.5 exports as "XML-based CCD file." Both QRDA Cat I and CCD are structured clinical document formats with limited scope — they typically capture the USCDI/C-CDA data elements (demographics, problems, meds, allergies, vitals, labs, procedures, etc.) but would NOT capture care management notes, messaging, custom assessments, quality calculations, risk scores, claims data, RPM data, or other platform-specific data. This is a significant potential gap.

6. **SmartLab (ETOR) is a distinct sub-product** used by state public health departments for lab reporting. It has its own data (lab orders/results) that may or may not be included in the platform-level EHI export.

7. **Custom forms and workflows.** Persivia mentions implementing "custom forms and workflows" for customers (one testimonial mentions custom forms deployed in about a week). Data captured via custom forms would need to be in the EHI export.

### Sources

- https://persivia.com/ — Main homepage / product overview
- https://persivia.com/our-story/ — Company history and mission
- https://persivia.com/patient-engagement/ — Patient engagement features
- https://persivia.com/meaningful-use-certification-language/ — ONC certification disclosures and EHI export documentation
- Customer testimonials on homepage (McLaren Physician Partners, Prime Healthcare, St. John's Riverside Hospital, MA DPH, Iowa DPH)
