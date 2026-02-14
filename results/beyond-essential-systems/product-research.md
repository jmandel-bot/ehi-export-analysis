# Beyond Essential Systems — Product Research

Researched: 2025-07-14
Developer website: https://www.bes.au/

## Overview

Beyond Essential Systems (BES) is an Australian B-Corp social enterprise founded in 2015, headquartered in Melbourne with offices in Auckland and Suva (Fiji). They have approximately 60+ staff and focus on delivering health IT solutions for low-resource, remote settings — primarily Pacific Island nations (Fiji, Tonga, Samoa, Nauru, Palau, Kiribati, Tuvalu, Papua New Guinea, Federated States of Micronesia) and humanitarian contexts (Syria with MSF). Their partners include The World Bank, WHO, Bill & Melinda Gates Foundation, UNFPA, Australian DFAT, and NZ MFAT. Revenue comes from implementation services and support contracts, not software licensing.

BES is **not** a US-market EHR vendor. Their ONC certification (achieved May 2021) appears strategic — obtaining the minimum required certification ((b)(10) EHI export + privacy/security criteria only) to gain credibility with international donors and partners. The product itself, Tamanu, is a genuinely feature-rich open-source EMR with 18,000+ commits, 139 contributors, and active development (v2.48.0 as of July 2025), but its market is global health/development, not US healthcare.

## Key Sources

- https://www.bes.au/ — corporate homepage; company overview, mission, partner list, team size (~60+), B-Corp status, timeline of country deployments
- https://www.bes.au/products/tamanu/ (redirects from tamanu.io) — comprehensive product page with features, modules, architecture, pricing, usage stats (14M+ encounters, 1.5M+ patients, 3,000 healthcare workers, 9 countries)
- https://www.bes.au/onc-certification/ — ONC mandatory disclosures page; confirms certification details and pricing (free software, $165-$665/month/facility for support)
- https://github.com/beyondessential/tamanu — public monorepo (GPL-3.0/BSL dual-licensed); 18,031 commits, 382 releases, 139 contributors; packages include central-server, facility-server, web-frontend, mobile, patient-portal, database
- https://github.com/beyondessential/tamanu/tree/main/packages/database/src/models — database model directory; ~100+ model files revealing comprehensive data schema
- G2.com — no listing found for Tamanu (consistent with non-US-market product)

## Product: Tamanu EMR

CHPL IDs: 10617

### What It Is

Tamanu is an open-source, patient-level electronic health records system designed for mobile and desktop deployment in low-resource healthcare settings. It provides end-to-end patient management across outpatient, inpatient, emergency, laboratory, and imaging services. The system is built for environments with unreliable internet connectivity — it works offline and syncs when connectivity is available.

The architecture consists of:
- **Central Server** — central data synchronization hub
- **Facility Server** — local server at each healthcare facility
- **Web Frontend (Desktop)** — full-featured web app for hospital/facility use (runs on Chrome)
- **Mobile App** — Android app for clinic-level and community health workers
- **Patient Portal** — recently developed (2024-2025), still emerging

The certified criteria are extremely minimal: only (b)(10) EHI export plus (d) privacy/security and (g)(4)/(g)(5) quality management. No clinical criteria (a), no care coordination (b)(1-3), no patient portal (e)(1), no FHIR API (g)(7-10), and no public health (f) criteria were certified — even though the product actually supports many of these capabilities. This reflects BES's strategic position: they sought minimal ONC certification for international credibility, not US market entry.

### Users & Market

**End users:** Physicians, nurses, midwives, community health workers, lab technicians, pharmacy staff, and hospital administrators in low-resource settings.

**Settings:** National health systems in Pacific Island nations, humanitarian healthcare (MSF/Doctors Without Borders), district hospitals, community health centers, mobile clinics.

**Scale:**
- 14 million+ clinical encounters recorded
- 1.5 million+ patient records
- 3,000+ healthcare workers using the system
- Deployed in 9 countries: Fiji, Tonga, Samoa, Nauru, Palau, Kiribati, Tuvalu, Papua New Guinea, Syria
- Nauru achieved "world-first" — every healthcare facility in the country on a single EMR (2024)
- Scalable to 1,000+ simultaneous facilities

**Go-to-market:** Direct implementation through government partnerships and donor-funded projects. Not sold through channel partners or commercial distribution. BES is both developer and primary implementer.

**Notable deployments:**
- Nauru national EMR (entire country)
- Fiji national deployment
- MSF (Doctors Without Borders) partnership starting 2025
- Aspen Medical (Australian healthcare operator) go-live 2022

### Data It Likely Stores

Based on the product features page and the database model files in the GitHub repository, Tamanu stores an extensive range of clinical and administrative data:

**Core Clinical Data:**
- Patient demographics and identifiers (Patient, PatientAdditionalData, PatientSecondaryId, PatientContact)
- Encounters (Encounter, EncounterHistory, EncounterDiagnosis, EncounterDiet)
- Diagnoses (ICD-10 compatible) (EncounterDiagnosis)
- Clinical notes (Note)
- Vitals and vital logs (Vitals, VitalLog)
- Allergies (PatientAllergy)
- Ongoing conditions / patient issues (PatientCondition, PatientIssue)
- Family history (PatientFamilyHistory)
- Care plans (PatientCarePlan)

**Medications & Pharmacy:**
- Prescriptions (Prescription, EncounterPrescription, PatientOngoingPrescription, EncounterPausePrescription)
- Medication administration records (MedicationAdministrationRecord, MedicationAdministrationRecordDose)
- Medication dispensing (MedicationDispense)
- Pharmacy orders (PharmacyOrder, PharmacyOrderPrescription)
- Drug reference data (ReferenceDrug, ReferenceDrugFacility, ReferenceMedicationTemplate)

**Laboratory:**
- Lab requests and logs (LabRequest via directory, LabRequestLog, LabRequestAttachment)
- Lab tests and results (LabTest via directory, LabTestType)
- Lab test panels (LabTestPanel, LabTestPanelLabTestTypes, LabTestPanelRequest)

**Imaging:**
- Imaging requests (ImagingRequest directory)
- Imaging request areas (ImagingRequestArea directory)
- Imaging results (ImagingResult)
- Imaging area and type external codes (ImagingAreaExternalCode, ImagingTypeExternalCode)

**Procedures:**
- Procedures (Procedure directory)
- Procedure assistant clinicians (ProcedureAssistantClinician)
- Procedure surveys (ProcedureTypeSurvey, ProcedureSurveyResponse)

**Immunizations:**
- Administered vaccines (AdministeredVaccine)
- Certifiable vaccines (CertifiableVaccine)
- Scheduled vaccines (ScheduledVaccine)
- Vaccine certificates with VDS (CertificateNotification)
- Patient VRS (Vaccine Registration System) data (PatientVRSData)

**Birth & Death Records:**
- Birth data (PatientBirthData)
- Death data (PatientDeathData, ContributingDeathCause, DeathRevertLog)

**Scheduling & Location:**
- Appointments (Appointment, AppointmentSchedule, AppointmentProcedureType)
- Facilities and departments (Facility, Department)
- Locations and bed management (Location, LocationAssignment, LocationAssignmentTemplate, LocationGroup)
- Discharges (Discharge)
- Triage (Triage)

**Programs & Registries:**
- Program registries (ProgramRegistry, ProgramRegistryClinicalStatus, ProgramRegistryCondition, ProgramRegistryConditionCategory)
- Patient program registration (PatientProgramRegistration, PatientProgramRegistrationCondition)
- Configurable surveys/forms (Survey, SurveyResponse, SurveyResponseAnswer, SurveyScreenComponent, Program, ProgramDataElement)

**Referrals & Care Coordination:**
- Referrals (Referral)
- Patient communications (PatientCommunication)
- Tasks (Task, TaskDesignation, TaskTemplate, TaskTemplateDesignation)

**Invoicing:**
- Invoices (Invoice directory — actively developed with recent commits for insurance, pending lab/imaging requests)

**Documents & Attachments:**
- Document metadata (DocumentMetadata)
- Attachments (Attachment)
- Assets (Asset)

**User & Access Management:**
- Users and roles (User, Role, Permission, UserDesignation, UserFacility, UserPreference)
- Access logs and audit trails (AccessLog, ChangeLog)
- User login tracking (UserLoginAttempt, OneTimeLogin, RefreshToken)
- Portal users (PortalUser, PortalOneTimeToken, PortalSurveyAssignment)

**Reporting & Analytics:**
- Report definitions and requests (ReportDefinition, ReportDefinitionVersion, ReportRequest)
- DHIS2 integration push logs (DHIS2PushLog)

**Sync Infrastructure:**
- Sync state tracking (SyncDeviceTick, SyncLookup, SyncLookupTick, SyncQueuedDevice, SyncSession)

**Internationalization:**
- Translated strings (TranslatedString)
- Templates (Template)
- Settings (Setting)
- Signer data for certificates (Signer)

### Notable Features Relevant to EHI

**Patient Portal (emerging):** A `patient-portal` package exists in the codebase with `PortalUser`, `PortalOneTimeToken`, and `PortalSurveyAssignment` models. This is under active development ("Patient Portal Epic" PR from ~5 months ago). Portal data would be relevant to EHI export completeness.

**Configurable Surveys/Forms:** Tamanu has a sophisticated survey/form system (Program, Survey, SurveyResponse, SurveyResponseAnswer, ProgramDataElement) that allows configurable data collection for vertical health programs (NCD screening, antenatal care, etc.). This is a significant data domain that could contain arbitrary clinical data.

**Invoicing:** An Invoice model with recent active development (insurance integration, pending lab/imaging request invoicing). Financial data is typically relevant to EHI.

**FHIR Integration:** The codebase has a `fhir` subdirectory under models with active development, including receiving lab results via FHIR. While FHIR APIs weren't certified, the product has them — and FHIR-mediated data flows mean data could enter or leave the system through these interfaces.

**Offline/Sync Architecture:** The facility-server + central-server sync architecture means patient data exists in multiple locations simultaneously. The EHI export would need to capture the authoritative copy from the central server.

**Audit Trail:** AccessLog and ChangeLog models suggest comprehensive audit logging, which is itself patient-related data potentially subject to EHI export.

**DHIS2 Integration:** Data flows to DHIS2 (health data warehouse) for aggregate reporting. The push logs track what was sent.

**Open Source Advantage:** Because the codebase is fully public, the data model can be definitively verified against the EHI export documentation — unlike proprietary vendors where we must infer data domains from marketing materials.

---
