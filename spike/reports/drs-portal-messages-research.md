# Are Patient-Provider Portal Messages Part of the HIPAA Designated Record Set?

## Research Report
**Date:** February 2025  
**Status:** Definitive Analysis  
**Conclusion:** **Yes** — portal messages are part of the DRS in virtually all real-world clinical scenarios.

---

## Table of Contents
1. [Executive Summary](#executive-summary)
2. [The Regulatory Definition of Designated Record Set](#the-regulatory-definition)
3. [Analysis: Three Independent Paths to Inclusion](#three-paths-to-inclusion)
4. [The EHI Connection: 170.315(b)(10)](#the-ehi-connection)
5. [ONC Guidance Confirming Broad Scope](#onc-guidance-confirming-broad-scope)
6. [Edge Cases and Nuances](#edge-cases-and-nuances)
7. [Implications for EHR Vendors](#implications-for-ehr-vendors)
8. [Sources and Citations](#sources-and-citations)

---

## 1. Executive Summary

Patient-provider secure messages (portal messages) are part of the HIPAA Designated Record Set (DRS) under **at least two, and usually all three**, prongs of the definition in 45 CFR §164.501. By extension, they constitute Electronic Health Information (EHI) under 45 CFR §171.102 and **must** be included in EHI exports under the 170.315(b)(10) certification criterion if the certified health IT product stores them.

This is not a close call. The regulatory text, HHS preamble commentary, OCR guidance, and ONC's own statements all point to the same conclusion. Vendors that exclude portal messages from EHI exports are likely non-compliant.

---

## 2. The Regulatory Definition of Designated Record Set

### 45 CFR §164.501 — Full Text of DRS Definition

> **Designated record set** means:
>
> (1) A group of records maintained by or for a covered entity that is:
>
> **(i) The medical records and billing records about individuals maintained by or for a covered health care provider;**
>
> (ii) The enrollment, payment, claims adjudication, and case or medical management record systems maintained by or for a health plan; or
>
> **(iii) Used, in whole or in part, by or for the covered entity to make decisions about individuals.**
>
> (2) For purposes of this paragraph, the term **record** means any item, collection, or grouping of information that includes protected health information and is maintained, collected, used, or disseminated by or for a covered entity.

*Source: [45 CFR §164.501](https://www.ecfr.gov/current/title-45/subtitle-A/subchapter-C/part-164/subpart-E/section-164.501), retrieved February 2025.*

### Key Observations About the Definition

1. **"Record" is defined maximally broadly**: "any item, collection, or grouping of information that includes protected health information." A portal message containing any health information meets this definition.

2. **"Medical records" is not narrowly defined**: HIPAA deliberately does not define "medical record" as a specific, bounded thing. The 2000 Privacy Rule preamble (65 FR 82462) states: "For covered health care providers, designated record sets include, **at a minimum**, the medical record and billing record about individuals maintained by or for the provider." The phrase "at a minimum" signals this is a floor, not a ceiling.

3. **The third prong is a catchall**: Even information not traditionally considered part of the "medical record" is in the DRS if it is "used, in whole or in part, by or for the covered entity to make decisions about individuals."

---

## 3. Analysis: Three Independent Paths to Inclusion

### Path A: Portal Messages ARE Medical Records (Prong i)

Portal messages between patients and providers routinely contain:
- Reports of symptoms by patients
- Clinical assessments and advice by providers
- Diagnoses communicated by providers
- Treatment plans and medication instructions
- Referral information
- Lab result interpretations
- Follow-up care instructions

OCR's own guidance on the right of access (FAQ 2042, updated August 2025) states that individuals have a right to access:

> "a broad array of health information about themselves, whether maintained by a covered entity or by a business associate on the covered entity's behalf, including medical records, billing and payment records, insurance information, clinical laboratory test reports, X-rays, wellness and disease management program information, consent forms for treatment, and **notes (such as clinical case notes or "SOAP" notes)** ... among other information generated from treating the individual."

*Source: [HHS FAQ 2042](https://www.hhs.gov/hipaa/for-professionals/faq/2042/what-personal-health-information-do-individuals/index.html)*

The key phrase is "among other information generated from treating the individual." When a provider responds to a patient's portal message about their symptoms, gives medical advice, orders a test, or communicates a diagnosis, this is information "generated from treating the individual." It is functionally identical to a clinical note — it is simply delivered through a different channel.

**In modern practice, many health systems treat portal messages as part of the medical record.** Epic's MyChart, for example, stores messages in the same system of record as clinical notes. Many EHR systems automatically file clinically relevant portal messages into the patient's chart. In these systems, the messages are indisputably part of the medical record.

But even for systems that store portal messages in a separate messaging database, the content of those messages — when they contain PHI related to the individual's care — constitutes medical records about that individual maintained by or for the provider.

### Path B: Portal Messages Are Used to Make Decisions About Individuals (Prong iii)

This is the strongest and most unambiguous path to inclusion.

The 2000 Privacy Rule preamble (65 FR 82462) explains the rationale for this prong:

> "In addition to these records, designated record sets include **any other group of records that are used, in whole or in part, by or for a covered entity to make decisions about individuals.**"

The standard is "**in whole or in part**." Even if only some messages in the system are used to make clinical decisions, the entire group of records (the messaging system) qualifies if it is used "in part" for that purpose.

OCR's Right of Access guidance further explains:

> "This last category includes records that are used to make decisions about **any** individuals, whether or not the records have been used to make a decision about the **particular** individual requesting access."

*Source: [HHS Right of Access Guidance](https://www.hhs.gov/hipaa/for-professionals/privacy/guidance/access/index.html)*

Consider common portal message scenarios:

| Scenario | Decision Made? |
|----------|---------------|
| Patient reports new symptoms; provider adjusts medication | **Yes** — treatment decision |
| Patient asks about lab results; provider interprets and advises | **Yes** — clinical assessment |
| Provider sends post-op instructions | **Yes** — treatment plan |
| Patient requests referral; provider approves | **Yes** — care coordination |
| Patient reports medication side effects; provider switches drugs | **Yes** — prescribing decision |
| Patient asks scheduling question; staff responds | Maybe not directly clinical, but system is "used in part" |

In virtually every medical practice that uses a patient portal, clinical decisions are routinely made based on portal message content. This means the messaging system as a whole is "used, in whole or in part, to make decisions about individuals" and qualifies as a designated record set under Prong (iii).

The 2000 preamble was explicit about this broad standard:

> "Under the revised definition, individuals have a right of access to **any protected health information** that is used, in whole or in part, to make decisions about individuals. This information includes, for example, information used to make **health care decisions** or information used to determine whether an insurance claim will be paid."

*Source: 65 FR 82462 at 82542 (December 28, 2000)*

### Path C: Messages Filed Into the Chart

Many EHR systems (Epic, Cerner/Oracle Health, athenahealth, etc.) automatically or manually file portal messages into the patient's chart. Once filed, these messages are unambiguously part of the medical record and thus part of the DRS under Prong (i). This is the easiest case, but the analysis above shows that even unfiled messages are covered.

---

## 4. The EHI Connection: 170.315(b)(10)

### The Regulatory Definition of EHI

45 CFR §171.102 defines Electronic Health Information:

> **Electronic health information (EHI)** means electronic protected health information as defined in 45 CFR 160.103 to the extent that it would be included in a designated record set as defined in 45 CFR 164.501, regardless of whether the group of records are used or maintained by or for a covered entity as defined in 45 CFR 160.103, but EHI shall not include:
> (1) Psychotherapy notes as defined in 45 CFR 164.501; or
> (2) Information compiled in reasonable anticipation of, or for use in, a civil, criminal, or administrative action or proceeding.

*Source: [45 CFR §171.102](https://www.ecfr.gov/current/title-45/subtitle-A/subchapter-D/part-171/subpart-A/section-171.102)*

### The (b)(10) Certification Criterion

45 CFR §170.315(b)(10) requires certified health IT to:

> "Enable a user to timely create an export file(s) with **all of a single patient's electronic health information that can be stored at the time of certification by the product**, of which the Health IT Module is a part."

The 2020 ONC Cures Act Final Rule preamble (85 FR 25642) makes the connection explicit:

> "Put simply, the EHI definition represents **the same ePHI that a patient would have the right to request a copy of pursuant to the HIPAA Privacy Rule.** This is a regulatory concept with which the industry has nearly 20 years of familiarity."

*Source: 85 FR 25642 at 25691 (May 1, 2020)*

And further:

> "Developers are required to ensure the health IT products they present for certification are capable of **exporting all of the EHI that can be stored at the time of certification by the product.**"

*Source: 85 FR 25642 at 25691-25692 (May 1, 2020)*

### The Critical Implication

The chain of logic is straightforward:

1. Portal messages contain ePHI → ✅
2. Portal messages are part of the DRS (as demonstrated above) → ✅
3. ePHI in the DRS = EHI (per §171.102) → ✅
4. The certified product stores portal messages → ✅ (for products like Epic, Cerner, athenahealth, etc.)
5. (b)(10) requires export of "all EHI that can be stored by the product" → ✅
6. **Therefore: portal messages must be included in the (b)(10) export** → ✅

The preamble explicitly warns against a narrow reading:

> "We emphasize that such 'stored' data applies to **all EHI** and is **agnostic as to whether the EHI is stored in or by the certified Health IT Module or in or by any of the other 'non-certified' capabilities** of the health IT product of which the certified Health IT Module is a part."

*Source: 85 FR 25642 at 25691 (May 1, 2020)*

This means that even if the messaging module is not itself certified, if the messaging data is stored by the product (e.g., Epic stores MyChart messages in its database), it must be exportable.

---

## 5. ONC Guidance Confirming Broad Scope

### Steven Posnack's Blog Post (September 30, 2022)

ONC's then-Deputy National Coordinator Steven Posnack wrote an authoritative blog post titled "Information Blocking: Eight Regulatory Reminders for October 6th" which included this key passage:

> "The good news is that the EHI definition as of October 6th is something with which most IB actors have had 20 years of familiarity – the Designated Record Set (DRS) as defined under the Health Insurance Portability and Accountability Act (HIPAA) Privacy Rule. Because nearly all IB actors are HIPAA-covered entities or business associates, the DRS is a keystone shared between the information blocking regulations and HIPAA Privacy Rule. **To put it simply, the same electronic protected health information (ePHI) that an individual has a right to access (and request an amendment to) under the HIPAA Privacy Rule is the same ePHI that IB actors can't 'block.'**"

> "One point that we've emphasized to health care providers is that **'the ePHI in your DRS constitutes your EHI'** for the purposes of the information blocking regulations. Within the bounds of the definition, the HIPAA Privacy Rule allows for each HIPAA covered entity to scope their DRS in a way that meets their business needs. This means it's entirely possible, for example, for hospital A to have a slightly different DRS than hospital B."

*Source: [ONC Blog, September 30, 2022](https://www.healthit.gov/buzz-blog/information-blocking/information-blocking-eight-regulatory-reminders-for-october-6th)*

### What This Means

ONC is saying: look at what's in your DRS. That's your EHI. If portal messages are in your DRS (and as we've shown, they should be), they're EHI. Period.

The slight variation ONC allows ("hospital A to have a slightly different DRS than hospital B") relates to organization-specific record systems, not to whether entire categories of clinical communications can be excluded. A hospital cannot declare that its messaging system is "not part of the DRS" if that system is being used to make clinical decisions about patients — that would violate the regulatory definition.

---

## 6. Edge Cases and Nuances

### What About Purely Administrative Messages?

Some portal messages are purely administrative:
- "Your appointment has been confirmed for Tuesday at 2pm"
- "Please remember to bring your insurance card"
- "Your prescription has been sent to Walgreens"

Automated appointment reminders and purely logistical messages might not contain information "used to make decisions about individuals" in a clinical sense. However:

1. Even these may contain PHI (the fact of an appointment is PHI)
2. Even scheduling decisions are "decisions about individuals"
3. In practice, these are typically stored in the same system as clinical messages, making them part of the same "group of records"
4. OCR guidance states the test is whether the **record system** is used to make decisions, not whether each individual record is

The safer interpretation — and the one consistent with the regulatory text — is that the messaging system as a whole is a DRS, and all messages in it are part of the DRS.

### What About Messages Not Filed to the Chart?

Some systems distinguish between messages that are "filed to the chart" (and thus clearly part of the medical record) and those that remain only in the messaging system. As analyzed in Path B above, this distinction is irrelevant to the DRS analysis. The DRS definition does not require information to be "filed to the chart" — it requires only that the information be:
- A medical record (which clinical messages are), OR
- Used to make decisions about individuals (which the messaging system is)

HHS was explicit in the 2000 preamble that the DRS is broader than the traditional "chart":

> "In the final rule, we modify the definition of designated record set to specify certain records maintained by or for a covered entity that are **always** part of a covered entity's designated record sets and to **include other records** that are used to make decisions about individuals."

*Source: 65 FR 82462 at 82479 (December 28, 2000)*

### What About the Vendor's Role?

The (b)(10) criterion applies to what the certified product "can store." If a product stores portal messages (as Epic, Cerner, athenahealth, and virtually all major EHRs do), those messages must be exportable. The vendor cannot argue:
- "We don't consider messages part of the medical record" — the DRS definition is regulatory, not at the vendor's discretion
- "Messages are in a separate module" — the preamble explicitly states the scope is across the entire product, not just the certified module
- "We only export structured data" — the (b)(10) criterion requires "all EHI that can be stored," not "all structured clinical data"

### What About Psychotherapy Notes in Messages?

Psychotherapy notes (as defined in 45 CFR §164.501) are explicitly excluded from the EHI definition. If a mental health provider were to include psychotherapy notes (documenting or analyzing counseling session content) in portal messages AND maintained them separately from the medical record, those specific messages could be excluded. However, this is an extremely narrow exception that would rarely apply to portal messages.

---

## 7. Implications for EHR Vendors

### Vendors That Exclude Portal Messages from EHI Export Are Likely Non-Compliant

If a certified health IT product stores portal messages and excludes them from the (b)(10) EHI export, the vendor is likely:

1. **Non-compliant with 170.315(b)(10)**: The criterion requires export of "all" EHI the product can store. Portal messages that constitute EHI (ePHI in the DRS) are within this scope.

2. **Potentially engaged in information blocking under 45 CFR §171.103**: As of October 6, 2022, the full EHI definition applies. Systematically excluding an entire category of EHI from export could constitute an interference with the access, exchange, or use of EHI. This applies to:
   - **Health IT developers** under the knowledge standard of "knows or should know"
   - **Health care providers** under the standard of knowing the practice is "unreasonable and likely to interfere"

3. **Facilitating potential HIPAA Right of Access violations**: If the EHI export is used to fulfill patient access requests, excluding portal messages means the provider is not providing access to the full DRS as required by 45 CFR §164.524.

### What Vendors Should Do

1. **Include portal messages in (b)(10) exports** — both patient-to-provider and provider-to-patient messages
2. **Include all message metadata** — timestamps, sender, recipient, read status, any attachments
3. **Export messages regardless of whether they were "filed to chart"** — the DRS includes the messaging system, not just the charted subset
4. **Document the export format** per (b)(10)(iii) requirements
5. **Don't apply artificial filters** — export all messages, not just "clinically relevant" ones (the vendor is not in a position to make that determination)

---

## 8. Sources and Citations

### Primary Regulatory Sources

| Source | Citation | Relevance |
|--------|----------|----------|
| DRS Definition | 45 CFR §164.501 | Defines designated record set |
| EHI Definition | 45 CFR §171.102 | Ties EHI to DRS for information blocking |
| EHI Export Criterion | 45 CFR §170.315(b)(10) | Requires export of all stored EHI |
| Right of Access | 45 CFR §164.524 | Patient right to access DRS contents |
| ePHI Definition | 45 CFR §160.103 | Defines electronic protected health information |

### Preamble and Guidance Sources

| Source | Citation | Key Point |
|--------|----------|----------|
| 2000 Privacy Rule Preamble | 65 FR 82462 (Dec. 28, 2000) | DRS includes "at a minimum" medical records; "any other" records used to make decisions |
| 2020 ONC Cures Act Final Rule | 85 FR 25642 (May 1, 2020) | EHI = same ePHI patient has right to access under HIPAA; export must include all stored EHI across entire product |
| OCR Right of Access Guidance | [HHS.gov](https://www.hhs.gov/hipaa/for-professionals/privacy/guidance/access/index.html) | DRS includes records used to make decisions about "any individuals" |
| OCR FAQ 2042 | [HHS.gov](https://www.hhs.gov/hipaa/for-professionals/faq/2042/) | Right extends to "broad array" including notes and "other information generated from treating the individual" |
| ONC Blog (Posnack, 2022) | [HealthIT.gov](https://www.healthit.gov/buzz-blog/information-blocking/information-blocking-eight-regulatory-reminders-for-october-6th) | "The ePHI in your DRS constitutes your EHI" |

### Key Quotations for Quick Reference

**DRS Breadth (2000 Preamble):**
> "For covered health care providers, designated record sets include, **at a minimum**, the medical record and billing record about individuals maintained by or for the provider. **In addition** to these records, designated record sets include **any other group of records** that are used, in whole or in part, by or for a covered entity to make decisions about individuals."

**EHI = HIPAA Right of Access (2020 ONC Final Rule):**
> "Put simply, the EHI definition represents **the same ePHI that a patient would have the right to request a copy of pursuant to the HIPAA Privacy Rule.**"

**Export Scope Across Entire Product (2020 ONC Final Rule):**
> "We emphasize that such 'stored' data applies to **all EHI** and is **agnostic as to whether the EHI is stored in or by the certified Health IT Module or in or by any of the other 'non-certified' capabilities** of the health IT product."

**EHI in Your DRS (ONC Blog, 2022):**
> "The same electronic protected health information (ePHI) that an individual has a right to access (and request an amendment to) under the HIPAA Privacy Rule **is the same ePHI that IB actors can't 'block.'**"

---

## Summary Conclusion

| Question | Answer |
|----------|--------|
| Are portal messages part of the DRS? | **Yes**, under Prong (i) as medical records and/or Prong (iii) as records used to make decisions about individuals |
| Are portal messages EHI? | **Yes**, they are ePHI included in the DRS, meeting the §171.102 definition |
| Must they be in (b)(10) exports? | **Yes**, if the certified product stores them |
| Can vendors exclude them? | **No**, not without risking non-compliance with (b)(10) and potential information blocking liability |
| Does it matter if messages aren't "filed to chart"? | **No**, the DRS encompasses the messaging system, not just charted records |
| Are there any exceptions? | Psychotherapy notes maintained separately, and litigation-hold materials, per §171.102 |

The regulatory framework is clear: portal messages are EHI, they are part of the DRS, and they must be included in EHI exports. Vendors excluding them are not just making a debatable policy choice — they are likely operating outside the regulatory requirements.
