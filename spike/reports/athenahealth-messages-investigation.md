# athenahealth EHI Export: Patient-Provider Secure Messages Investigation

**Date:** 2025-01-24  
**Verdict: NO — Patient-provider secure messages (portal messages) are NOT included in athenahealth's EHI export.**

---

## Executive Summary

athenahealth's EHI export covers data from **athenaClinicals** (clinical EHR data) and **athenaCollector** (billing/demographic data), but does **NOT** include data from **athenaCommunicator** (the patient portal/messaging module). Secure messages between patients and providers exist in the athenaOne platform and have a full API, but they are excluded from all four EHI export types.

---

## Evidence

### 1. EHI Export Overview Page Explicitly Scopes to Clinicals + Collector

The [EHI Exports Overview](https://docs.athenahealth.com/athenaone-dataexports/guides/welcome-exports) states:

> "Includes patients' health information as managed and exported from **athenaClinicals**, as well as demographic, billing information as managed and exported from **athenaCollector** for customers in the Ambulatory and Inpatient settings."

No mention of athenaCommunicator anywhere on this page.

### 2. All Four Export Types Exhaustively Checked — No Messages

#### Ambulatory Clinical EHI Export (60+ datasets)
Complete dataset list checked — includes allergies, encounters, labs, meds, procedures, imaging, notes, letters, patient cases, etc. **Zero datasets for secure messages, portal messages, or communications.**

Searched the full PDF data dictionary (`ambulatory-clinical-ehi-export.pdf`, 534KB) for: `secure message`, `patient portal`, `athenaCommunicator`, `phone message`, `inbox`, `communicator` — **zero matches**.

#### Ambulatory Collector EHI Export (15 datasets)
Appointments, Claims, Demographics, Payments, Insurance, Referrals. **No messaging datasets.**

#### Inpatient Clinical EHI Export (38 datasets)
Admin Documents, Admission H&P, Discharge Summary, Flowsheets, Nursing Notes, Orders, etc. **No messaging datasets.**

#### Inpatient Collector EHI Export (16 datasets)
Same as Ambulatory Collector + Visit Charges. **No messaging datasets.**

### 3. Secure Messages API Exists But Is Separate from EHI Export

athenahealth has a full [Secure Messages API](https://docs.athenahealth.com/api/api-ref/secure-messages) under the Patient section with these endpoints:

- `GET /v1/{practiceid}/patients/{patientid}/securemessage/{messagethreadid}` — Get all messages from a thread
- `GET /v1/{practiceid}/patients/{patientid}/securemessage/inboxmessages` — Get inbox messages
- `GET /v1/{practiceid}/patients/{patientid}/securemessage/sentmessages` — Get sent messages  
- `GET /v1/{practiceid}/patients/{patientid}/securemessage/archivedmessages` — Get archived messages
- `POST .../reply` — Submit replies
- `POST` — Send message to provider or patient
- `PUT` — Mark as read, archive/unarchive

The API description states:
> "Secure Messages are web-based, available to the patients via the Patient Portal, which gives patients secure and convenient access to their health information. Patients can use secure message client (custom or built into the Patient Portal), based on this API, to send (and receive replies) secure messages to their provider."

Output fields include: `brandid`, `documentid`, `enterpriseid`, `messagelist` (array), `messagetype`, `subject`.

### 4. Secure Messages Require athenaCommunicator — Which Has No EHI Export

The [Products Needed by API](https://docs.athenahealth.com/api/guides/products-needed-api) page explicitly states:

> "**Patient Secure Messaging** — Endpoints that reference /securemessage/ or /patientsecuremessage/ found within the Patient section require **athenaCommunicator**."

And:

> "athenaCommunicator is required for clients who use the full version of the Patient Portal."

The EHI Export documentation site has **no Communicator EHI Export section** — only Clinical and Collector exports for both Ambulatory and Inpatient.

### 5. Release Notes Are Empty — No Recent Additions

The [Release Notes](https://docs.athenahealth.com/athenaone-dataexports/guides/release-notes) page says:
> "This feature is set to be released within 2023. The link to a detailed release note will be added to this page shortly before the release period."

No actual release notes or change logs have been published, suggesting no new datasets (including messages) have been added since initial release.

---

## Datasets Checked That Are NOT Messages

Several datasets might seem like they could contain messages but don't:

| Dataset | What It Actually Contains |
|---------|-------------------------|
| **Letters** | Clinical letters (referral letters, follow-up letters) — physical/faxed correspondence, not portal messages. Has document attachments. |
| **Letter Action Notes** | Action notes attached to letter documents. |
| **Patient Cases** | Administrative/workflow documents (tasks, tracking items). Fields: createddate, description, assignedto, status, actionnote. Not portal messages. |
| **Admin Documents** | Administrative documents (insurance cards, consent forms, etc.). |
| **Clinical Documents** | Clinical documents including mental health consult documents. |
| **Encounter Phone Call Checklists** | Pre-admission and post-discharge phone call checklists — structured clinical workflows, not free-text messages. |
| **Other CCDAs** | C-CDA XML documents — standardized clinical summaries. |
| **Document Type - Phone Message** (API only, NOT in EHI export) | "Messages typically received over fax, e.g., including messages with notes that patients were triaged or treated over phone." These are internal staff documents, not patient portal messages. |

---

## Closest Things to Messaging in the EHI Export

1. **Letters** — The closest analog. Contains clinical correspondence (likely printed/faxed letters between providers or to patients). Includes document attachments.
2. **Letter Action Notes** — Notes about actions taken on letters.
3. **Patient Cases** — Internal workflow/task tracking that can have action notes. Could theoretically capture some communication context but is not message content.
4. **Encounter Phone Call Checklists** — Structured documentation of phone calls, but these are clinical workflow items, not bidirectional patient-provider messaging.

---

## Architecture of the Gap

athenaOne has three core modules:
- **athenaClinicals** → Clinical EHI Export ✅
- **athenaCollector** → Collector EHI Export ✅  
- **athenaCommunicator** → **No EHI Export** ❌

The Secure Messages API exists and can retrieve full message threads, inbox, sent, and archived messages. But this API is not used by the EHI export feature. The EHI export only pulls from athenaClinicals and athenaCollector data stores.

---

## Conclusion

**Definitive NO**: Patient-provider secure messages / portal messages are **not included** in any of athenahealth's four EHI export types. The data exists in the athenaCommunicator module and is accessible via the Secure Messages API, but athenaCommunicator has no corresponding EHI export. This is a significant gap in athenahealth's EHI export completeness, as portal messages are part of the HIPAA Designated Record Set and arguably constitute EHI under the 21st Century Cures Act.
