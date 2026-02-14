# Flatiron Health / OneOncology — Product Research

Researched: 2025-07-14
Developer website: https://flatiron.com

## Overview

Flatiron Health is a healthtech company focused exclusively on oncology, founded in 2012 and acquired by Roche in 2018 for $1.9 billion (it operates as an "independent affiliate of the Roche Group"). The company has two major business lines: (1) point-of-care technology for community oncology practices, centered around the OncoEMR electronic health record and its companion products, and (2) real-world evidence (RWE) and data products for life sciences companies, researchers, and regulators — built on de-identified data from 5+ million patient records.

Flatiron's point-of-care platform (formerly marketed as "OncoCloud") serves over 4,500 clinicians across 500+ cancer centers, primarily community oncology and hematology practices. OneOncology is a separate company — a network of independent community oncology practices launched in 2018 with Flatiron as its technology partner and $200M from General Atlantic. OneOncology uses Flatiron's technology stack and has its own ONC-certified product ("OneOncology HIE Integration") that is essentially an integration/export layer on top of OncoEMR.

In December 2025, Paradigm Health acquired Flatiron's Clinical Research Business (including OncoTrials), narrowing Flatiron's product focus to the EHR, decision support, analytics, and RWE businesses.

---

## Product: OncoEMR (part of Flatiron OncoCloud / OncologyCloud suite)

CHPL IDs: 11115

### What It Is

OncoEMR® is a cloud-based, oncology-specific electronic health record designed for community oncology and hematology practices. It is the core clinical module of a broader product suite that includes:

- **OncoEMR®** — the EHR itself: clinical documentation, CPOE, e-prescribing, treatment planning
- **OncoBilling®** — integrated practice management, charge capture, claims management, and revenue cycle
- **OncoAnalytics™ / Flatiron Insight™** — analytics dashboards for clinical, operational, and financial data
- **Flatiron Assist™** — clinical decision support that surfaces evidence-based treatment options, NCCN guidelines, and clinical trial matches at the point of care; also handles prior authorization workflows
- **OncoAir™** — mobile app for clinicians to review patient data and take action on the go
- **CareSpace** — patient portal for health information access, bill pay, and care team communication
- **OncoTrials®** — clinical trial matching and management (now sold to Paradigm Health as of Dec 2025)
- **Precision Medicine by Flatiron** — genomic/molecular profiling integration and precision oncology features

The ONC certification (CHPL 11115) covers OncoEMR v2.8 and is extensive: clinical data (a)(1)–(a)(14), transitions of care (b)(1)–(b)(3), patient portal/VDT (e)(1), e-prescribing, public health reporting including cancer registries (f)(1), (f)(4), (f)(5), FHIR APIs (g)(7)–(g)(10), clinical quality measures (c)(1), and EHI export (b)(10). This is a full-featured oncology EHR certification.

### Data It Likely Stores

OncoEMR and its companion products store a comprehensive range of oncology-specific and general clinical data:

**Core Clinical Data:**
- Patient demographics, insurance, contacts
- Diagnoses (ICD), problem lists
- Medications (including complex chemotherapy regimens with dosing, cycles, and administration details)
- Allergies
- Lab results (integrated from external labs)
- Vital signs
- Clinical notes / encounter documentation
- Treatment plans (chemotherapy protocols, regimen details, NCCN-based templates)
- Cancer staging (AJCC staging content embedded)
- Tumor/disease characterization
- Implantable device lists
- Family health history

**Oncology-Specific Data:**
- Chemotherapy orders and administration records (3,000+ NCCN Order Templates)
- Treatment regimens and protocols
- Molecular profiling / genomic test results (integrations with Caris Life Sciences, Foundation Medicine)
- Clinical trial eligibility screening and enrollment data
- Cancer registry reporting data
- Precision medicine / biomarker data
- Immunization records (submitted to registries)
- Electronic case reporting (public health)

**Orders and Prescribing:**
- CPOE for medications, labs, and diagnostic imaging
- Electronic prescribing (including controlled substances via DrFirst)
- Drug-drug and drug-allergy interaction checking
- Prior authorization workflows (via Flatiron Assist)

**Patient Portal / Patient-Facing:**
- Patient health information (view/download/transmit)
- Patient-reported health information capture
- Secure messaging between patients and care teams
- Bill pay

**Billing and Financial:**
- Charge capture
- Claims management and scrubbing
- Electronic remittance advice
- Drug billing and reimbursement tracking
- Revenue cycle analytics
- Billing operations data

**Scheduling and Operations:**
- Appointment scheduling
- Patient visit volumes
- Inbound referral tracking
- Operational dashboards

**Analytics and Reporting:**
- Clinical quality measures (CQMs)
- Value-based care data (MIPS, OCM/EOM reporting)
- Drug usage analytics
- Practice financial/operational performance metrics
- Custom dashboards via Flatiron Insight™

**Documents and Communications:**
- Clinical documents (C-CDAs for transitions of care)
- Scanned/uploaded documents (likely)
- Direct messaging for referrals (via MaxMD)
- HL7 interface data (1,800+ live interfaces with 150+ vendors)

**Audit and Security:**
- Audit logs (via Splunk)
- Access control records
- Accounting of disclosures

### Notable Features Relevant to EHI

- **The (b)(10) EHI export relies on Snowflake, AWS Aurora (PostgreSQL), and AWS S3** — suggesting the export is a bulk data extract from cloud data warehousing infrastructure, not a simple database dump. This is a significant architectural detail.
- **1,800+ live interfaces with 150+ vendors** — the system is highly integrated, meaning data flows in and out from many external sources.
- **OncoBilling® is part of the suite** — billing/claims data should be considered part of the product's data footprint, even though billing is a separate module.
- **CareSpace patient portal** — patient-facing data (messages, bill pay, health information access) is part of the product.
- **Flatiron's RWE business** uses de-identified data extracted from OncoEMR. The data model is clearly rich enough to support real-world evidence research, implying extensive structured data capture.
- **OncoTrials** clinical research data was part of the suite until Dec 2025 acquisition by Paradigm — unclear whether existing trial data remains in OncoEMR instances or was migrated.

### Sources

- https://flatiron.com — main vendor website
- https://flatiron.com/oncology/oncology-ehr — OncoEMR product page
- https://flatiron.com/oncology — Point of Care solutions overview
- https://flatiron.com/certification/ — ONC certification mandatory disclosures
- https://flatiron.com/about-us — Company page
- https://resources.flatiron.com/press/press-release/flatiron-health-unveils-new-features-and-enhancements-to-the-oncologycloud-software-platform — 2015 press release on OncoCloud
- https://ehrguide.org/ehr-reviews/oncoemr-reviews-pros-and-cons/ — Third-party review
- https://healthcare.toolsinfo.com/tool/flatiron-oncoemr — Feature comparison site
- https://intuitionlabs.ai/software/pdfs/flatiron-oncologycloud.pdf — OncologyCloud overview (AI-generated but useful)
- https://intuitionlabs.ai/software/pdfs/oncoemr.pdf — OncoEMR overview (AI-generated but useful)

---

## Product: OneOncology HIE Integration

CHPL IDs: 11640

### What It Is

OneOncology HIE Integration is a minimally-certified product (v1, certified May 2025) from OneOncology, LLC — a network of independent community oncology practices. It is **not a standalone EHR**. Its certification page explicitly states "Additional Software Used: OncoEMR," confirming it is an integration layer built on top of Flatiron Health's OncoEMR.

The certification is extremely narrow: only (b)(10) EHI Export plus security/infrastructure criteria ((d) and (g)(4)–(g)(5)). No clinical criteria, no patient portal, no FHIR APIs. This appears to be a purpose-built module to satisfy the ONC EHI export requirement for OneOncology's network practices, which use OncoEMR as their underlying EHR.

OneOncology is a network/platform company, not a traditional EHR vendor. It was launched in 2018 by three oncology practices (Tennessee Oncology, New York Cancer & Blood Specialists, and West Cancer Center) with Flatiron Health as the technology partner. General Atlantic took a majority stake in 2018. OneOncology connects practices via shared technology (primarily Flatiron's OncoCloud suite), provides operational support, analytics, and clinical research infrastructure.

### Data It Likely Stores

As an integration/export layer, the OneOncology HIE Integration product likely does not store primary clinical data itself — it accesses data from OncoEMR and other sources within the OneOncology network to produce EHI exports. The data it handles would include:

- **All data domains from OncoEMR** (since it relies on OncoEMR as additional software)
- **Potentially aggregated or networked data** from across OneOncology practices (clinical, operational, financial analytics)
- **HIE (Health Information Exchange) data** — as the name suggests, this may involve data exchanged across the OneOncology network's practices

The key question for EHI completeness is whether this product's export covers the same data scope as OncoEMR's (b)(10) export, or whether it's a distinct export covering network-level or aggregated data.

### Notable Features Relevant to EHI

- **Certified only for (b)(10) + security** — this is a single-purpose certification for EHI export
- **Depends on OncoEMR** — the underlying data is from Flatiron's EHR
- **Separate developer entity** — listed under "Flatiron Health, OneOncology, LLC" which suggests a joint development or licensing arrangement
- **Very new** — certified May 2025, version 1.0, suggesting this is a recently built compliance tool
- **OneOncology has its own CTO** (Andy Corts) who signed the mandatory disclosure letter — indicating some organizational independence from Flatiron

### Sources

- https://www.oneoncology.com — OneOncology main website
- https://www.oneoncology.com/certifications — OneOncology HIE Integration certification page
- https://www.oneoncology.com/about — About OneOncology
- https://www.oneoncology.com/assets/pdf/Certificates/MandatoryDisclosureLetterSigned2025.pdf — Mandatory disclosure letter
- https://nycancer.com/news/oneoncology-flatiron-cancer-docs-aim-boost — Press coverage of OneOncology launch
- https://www.hcinnovationgroup.com/analytics-ai/big-data/news/13030713/flatiron-health-to-power-community-oncology-startup — Healthcare Innovation coverage
