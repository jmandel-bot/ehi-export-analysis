# Draft LinkedIn Post

---

**Exploring EHI Export documentation across certified EHR vendors — looking for health IT policy collaborators**

I've been digging into the [CHPL API](https://chpl.healthit.gov/) to systematically examine how certified EHR vendors document their [170.315(b)(10) Electronic Health Information Export](https://www.healthit.gov/test-method/electronic-health-information-export) capability — the Cures Act requirement that EHRs support export of a patient's complete electronic health information.

Some early findings from surveying ~16 major vendors across inpatient, ambulatory, and long-tail:

📦 **Documentation formats vary enormously** — from Epic's downloadable ZIP of 7,673 table definitions ([open.epic.com/EHITables](https://open.epic.com/EHITables)) to single-page PDFs. All are publicly accessible as required, but discoverability and depth differ wildly.

🔍 **No vendor provides sample export files.** Across all 16 vendors examined, not one offers example exports, test data, or a developer sandbox for EHI export processing. A developer receiving an export file for the first time has only schema documentation to work from.

❓ **Open question on scope:** The [ONC Final Rule](https://www.federalregister.gov/documents/2020/05/01/2020-07419/21st-century-cures-act-interoperability-information-blocking-and-the-onc-health-it-certification) ties EHI to the HIPAA Designated Record Set ([45 CFR §164.501](https://www.ecfr.gov/current/title-45/subtitle-A/subchapter-C/part-164/subpart-E/section-164.501)), and the preamble states the export must cover "all EHI... agnostic as to whether the EHI is stored in or by the certified Health IT Module or in or by any of the other 'non-certified' capabilities of the health IT product."

In practice, some vendors appear to export full database schemas (clinical + billing + admin + messaging), while others scope more narrowly to clinical data. I'm trying to understand where the boundaries are — for example, how should patient-provider portal messages be treated? They're stored by the product and arguably fall within the DRS under Prong (iii) ("used, in whole or in part, to make decisions about individuals"), but I'd love input from people closer to the policy.

🤝 **Looking for collaborators** who work in health IT policy, ONC certification, or EHI/information blocking compliance. I'm building an open dataset characterizing EHI export documentation across all 927 b(10)-certified products in CHPL and would welcome:
- Policy expertise on DRS scope questions
- Practitioner perspectives on what exports look like in the real world
- Developer experiences processing EHI export files

Happy to share what I've collected so far. DMs open.

#HealthIT #Interoperability #CuresAct #EHI #ONC #HIPAA #InformationBlocking

---
