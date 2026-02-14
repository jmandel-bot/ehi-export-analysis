# Phase 1: Product Research

You are researching an EHR vendor and their certified products to understand what
data their systems store. This context will later be used to evaluate whether
their EHI (Electronic Health Information) export documentation is complete.

## Your Target

**Developer**: {{DEVELOPERS}}
**Product(s)**: {{PRODUCTS}}
**CHPL IDs**: {{CHPL_IDS}}

**EHI Documentation URL**: {{URL}} (for reference — you'll use this in Phase 2, not now)
**Output directory**: {{OUTPUT_DIR}}
**CHPL metadata**: `{{OUTPUT_DIR}}/chpl-metadata.json` — read this first.

## Background

Under ONC's Cures Act rule 170.315(b)(10), certified EHR systems must support
export of **all electronic health information that can be stored at the time of
certification by the product, of which the Health IT Module is a part.**

The certified module might be called "athenaClinicals" but the *product* is
"athenaOne" — which also includes billing, patient portal messaging, and
scheduling. We need to understand the full product to later assess export
completeness.

## What To Do

Research the vendor and their products. Be quick and exploratory — spend a few
minutes per product, not an hour. Use the web freely: vendor website, product
pages, feature lists, press releases, customer case studies. Third-party sources
like G2, KLAS, Capterra, or Definitive Healthcare often reveal more about real
usage and data capabilities than vendor marketing — check at least one if available.

Start by reading `chpl-metadata.json`. It has several useful starting points:

- **`developer.website`** — the vendor's main website. Start your research here.
- **`mandatory_disclosures_url`** — the ONC-required compliance/disclosure page.
  Often has product descriptions and is sometimes more informative than the
  marketing site about what the product actually does.
- **`sed_intended_user_description`** — sometimes populated with hints about the
  target users (e.g., "Eye Care providers", "Clinical prescribers and staff",
  "Ambulatory"). Can be empty.
- **`products[]`** — the list of certified products, with their names, versions,
  and `certified_criteria`. The criteria are a strong signal:
  - `(a)(1)`–`(a)(14)` = clinical data capabilities
  - `(b)(1)`–`(b)(3)` = transitions of care / clinical information exchange
  - `(e)(1)` = patient portal / view-download-transmit
  - `(f)(1)`–`(f)(7)` = public health reporting
  - `(g)(7)`–`(g)(10)` = API access / FHIR
  A product certified for only `(b)(10)` + `(f)(4)` is very different from one
  certified for 25+ criteria across clinical, portal, and API categories.

Do NOT query the CHPL API or visit chpl.healthit.gov — everything you need
from CHPL is already in this file.

Then explore. The goal is to understand what this product *is* and what it
does — so we can later assess whether the EHI export covers everything.
Every product is different, so use your judgment about what matters.

Here are some **starting points** — but these are examples, not a checklist.
Follow whatever threads are interesting for this particular vendor:

### Product Identity
- What is this product? Full EHR? Specialty system? Lab system? Middleware?
- Who uses it? Hospitals? Ambulatory clinics? Behavioral health? Long-term care?
- Is the certified module the whole product or a component of something larger?
- Are there multiple distinct product platforms sharing this certification?
  (e.g., MEDITECH Expanse vs MAGIC — same company, different architectures)

### Modules, Features, and Data

**Follow the product, not a generic checklist.** Different products do very
different things. Report what you actually find described in vendor materials,
reviews, documentation, and feature lists.

The kinds of things to look for (adapt to the product):
- What modules and features does the vendor describe?
- What workflows does the product support?
- What integrations and data exchange does it do?
- What's specialty-specific about it?
- What do users say about it in reviews?

Don't speculate about what data it "probably" stores. If the vendor's feature
page describes integrated billing with claim scrubbing, report that. If the
website doesn't mention billing at all, report that absence. Evidence over
inference.

### Market Position & Users
- How big is this vendor? Startup? Mid-size? Enterprise? Publicly traded?
- How many customers / clinicians / sites use this product? (often on their
  website or in press releases — rough numbers are fine)
- What's their go-to-market? Direct sales? Channel partners? Part of a larger
  health system vendor? Government contracts?
- Who are the actual end users? Physicians? Nurses? Billing staff? Practice
  managers? Patients? All of the above?
- What clinical settings? Solo practices? Multi-site groups? Critical access
  hospitals? Academic medical centers? FQHCs?
- Any notable customers or case studies that reveal what the product does in
  practice?

### Product Ecosystem & Business Context
- Does the vendor have multiple products that integrate? (e.g., separate billing
  module, separate patient portal, separate analytics platform)
- Is this a white-label or resold product? (some small vendors resell larger platforms)
- Any recent acquisitions, mergers, or name changes that affect what product
  this really is? (e.g., "formerly known as X", "acquired by Y in 2023")
- Is the product cloud-hosted, on-premise, or hybrid? (affects data architecture)
- Any partnerships or integrations that imply data exchange (e.g., "integrates
  with Surescripts for e-prescribing" means prescription data flows through)

### Don't Over-Research
- A few minutes per product is enough
- If the vendor website is sparse or unhelpful, say so and move on
- Report what you found, not what you imagine. Note gaps in your research.
- If you can't tell whether billing is built-in or separate, say "unclear"
- But DO follow interesting threads — if you discover something surprising
  about what the product stores, that's exactly what we want to know

## Output

Two files: a narrative report and a source manifest.

### `{{OUTPUT_DIR}}/product-research.md`

This is the primary deliverable — a narrative research report thorough enough
that someone could later create structured summaries without going back to the
original sources.

```markdown
# {{Vendor Name}} — Product Research

Researched: {{date}}
Developer website: {{url}}

## Overview
(1-2 paragraphs: who is this vendor, what do they make, who are their customers.
how are they situated in the market — size, specialty, geography, customer base.
include acquisition history, rebranding, parent companies if relevant.)

## Product: {{Product Name A}}

CHPL IDs: ...

### What It Is
(what the product is, who uses it, key capabilities. is the certified module
the whole product or part of something larger?)

### Users & Market
(who uses this product day-to-day? what settings? how many customers?
any notable deployments or case studies?)

### Modules & Functionality
(what does the product actually do? what modules, features, and workflows
did you find described in vendor materials, reviews, and documentation?
report what you found, not what you imagine. cite where you learned it.
this section is critical — it establishes what the product does so we
can later assess whether the EHI export covers it all.)

### Data & Content
(what data, records, and content does the product manage, based on what
you found? e.g., if the vendor's feature page says "integrated billing
with claim scrubbing", that tells us it stores claims data. if a review
says "we use it for patient messaging", that tells us it stores messages.
report the evidence, not guesses. note where information was thin or
ambiguous — "the website doesn't mention billing" is more useful than
"it probably stores billing data".)

---

## Product: {{Product Name B}}
(repeat for each distinct product platform)
```

Group products by distinct platform, not by CHPL version number. MEDITECH
Expanse 2.1 and 2.2 are the same product. MEDITECH Expanse and MEDITECH MAGIC
are different products.

### `{{OUTPUT_DIR}}/sources.json`

A manifest of everything you reviewed during research:

```json
{
  "research_date": "2025-07-14",
  "sources": [
    {
      "url": "https://www.vendor.com/product",
      "type": "vendor-website",
      "note": "main product page — feature list, screenshots, pricing tiers"
    },
    {
      "url": "https://www.vendor.com/compliance",
      "type": "mandatory-disclosures",
      "note": "ONC disclosures — confirms product modules, lists certified criteria"
    },
    {
      "url": "https://www.g2.com/products/...",
      "type": "third-party-review",
      "note": "user reviews — 4.2/5, 200 reviews, common praise for scheduling"
    }
  ]
}
```

Keep it simple — just URL, type, and a brief note on what you found there.

## Mindset

- **Be curious.** Follow interesting threads. If you discover the vendor was
  recently acquired and the product rebranded, that's worth noting.
- **Be honest about uncertainty.** "The website doesn't mention billing, so it's
  unclear whether billing is built-in or handled externally" is better than
  guessing.
- **Be efficient.** This is reconnaissance, not a deep investigation. Get the
  lay of the land and move on.
- **Use subagents** if you have them — e.g., research multiple products in parallel.
