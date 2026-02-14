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
pages, feature lists, press releases, customer case studies, third-party reviews.

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

Then explore. The goal is to understand what this product *is* and what data
it likely stores — so we can later assess whether the EHI export covers
everything. Every product is different, so use your judgment about what matters.

Here are some **starting points** — but these are examples, not a checklist.
Follow whatever threads are interesting for this particular vendor:

### Product Identity
- What is this product? Full EHR? Specialty system? Lab system? Middleware?
- Who uses it? Hospitals? Ambulatory clinics? Behavioral health? Long-term care?
- Is the certified module the whole product or a component of something larger?
- Are there multiple distinct product platforms sharing this certification?
  (e.g., MEDITECH Expanse vs MAGIC — same company, different architectures)

### Data the Product Stores

The common categories for a general-purpose EHR include things like clinical
data, patient portal messaging, billing, scheduling, document management. But
many products are specialized — a behavioral health platform stores assessment
instruments and treatment plans; a dental system stores charting and imaging;
an oncology system stores treatment protocols and tumor registries; a lab
system stores specimen tracking and instrument results.

**Follow the product, not a generic checklist.** If this is a long-term care
EHR, the interesting question is what long-term-care-specific data it stores
(MDS assessments? care plans? ADL tracking? medication administration records?).
If it's a revenue cycle platform, the interesting question is how deep the
financial data goes. If it's a patient engagement tool, explore what
communication and portal features it has.

Some examples of data domains to look for (adapt to the product):
- Clinical data (diagnoses, meds, labs, notes, vitals — the obvious stuff)
- Patient portal / messaging
- Billing / revenue cycle / claims
- Scheduling / appointments
- Document management (scans, faxes, uploads)
- Specialty-specific data (whatever is unique to this product's domain)
- Custom forms / flowsheets / configurable data capture
- Orders and results
- Care coordination / referrals
- Population health / analytics / reporting data
- Any other data the product manages that you discover

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
- Don't try to find definitive answers — educated guesses are fine
- If you can't tell whether billing is built-in or separate, say "unclear"
- But DO follow interesting threads — if you discover something surprising
  about what the product stores, that's exactly what we want to know

## Output

Write `{{OUTPUT_DIR}}/product-research.md`:

```markdown
# {{Vendor Name}} — Product Research

Researched: {{date}}
Developer website: {{url}}

## Overview
(1-2 paragraphs: who is this vendor, what do they make, who are their customers.
how are they situated in the market — size, specialty, geography, customer base)

## Key Sources
(list the URLs you actually visited during research, with a brief note on what
each contained. this is a bibliography for the research, not just a link dump)
- https://www.vendor.com/ — main site, product overview and feature list
- https://www.vendor.com/compliance/onc/ — mandatory disclosures, certification details
- https://www.g2.com/products/vendorproduct — third-party reviews, user feedback
- ...

## Product: {{Product Name A}}

CHPL IDs: ...

### What It Is
(what the product is, who uses it, key capabilities)

### Users & Market
(who uses this product day-to-day? what settings? how many customers?
any notable deployments or case studies?)

### Data It Likely Stores
(what kinds of data this product would have, based on your research.
be specific where you can, honest about uncertainty where you can't)

### Notable Features Relevant to EHI
(patient portal? messaging? billing? custom forms? anything that implies
data that might or might not appear in an EHI export)

---

## Product: {{Product Name B}}
(repeat for each distinct product platform)
```

Group products by distinct platform, not by CHPL version number. MEDITECH
Expanse 2.1 and 2.2 are the same product. MEDITECH Expanse and MEDITECH MAGIC
are different products.

Also write `{{OUTPUT_DIR}}/product-research.json`:

```json
{
  "vendor": "Vendor Name",
  "developer_website": "https://...",
  "research_date": "2025-07-14",
  "products": [
    {
      "name": "Product Name (platform level, e.g. 'MEDITECH Expanse')",
      "chpl_ids": [12345, 12346],
      "type": "full-ehr|specialty-ehr|patient-portal|lab-system|billing-system|middleware|other",
      "target_market": "hospital|ambulatory|behavioral-health|long-term-care|dental|multi-specialty|other",
      "description": "Brief description",
      "data_domains": [
        "clinical-records",
        "patient-portal",
        "billing-claims",
        "scheduling"
      ],
      "broader_product_name": "athenaOne (if the certified module is part of something larger)",
      "notes": "anything else relevant"
    }
  ],
  "sources": [
    {"url": "https://www.vendor.com/product", "note": "main product page with feature list"},
    {"url": "https://www.vendor.com/compliance", "note": "ONC mandatory disclosures"},
    {"url": "https://www.g2.com/products/...", "note": "user reviews"}
  ],
  "notes": "vendor-level notes (e.g., recently acquired by X, product formerly known as Y)"
}
```

**`data_domains`** is a freeform list of strings describing what data the product
stores. Use whatever labels make sense for the product. For a general EHR these
might include things like `"clinical-records"`, `"patient-portal"`, `"messaging"`,
`"billing-claims"`, `"scheduling"`, `"document-management"`. For a specialty
product they might be `"ophthalmology-imaging"`, `"dental-charting"`,
`"behavioral-health-assessments"`, `"mds-assessments"`, `"specimen-tracking"`.
Capture whatever is distinctive about this product.

## Mindset

- **Be curious.** Follow interesting threads. If you discover the vendor was
  recently acquired and the product rebranded, that's worth noting.
- **Be honest about uncertainty.** "The website doesn't mention billing, so it's
  unclear whether billing is built-in or handled externally" is better than
  guessing.
- **Be efficient.** This is reconnaissance, not a deep investigation. Get the
  lay of the land and move on.
- **Subagents** are great for parallelizing work (e.g., researching multiple
  products simultaneously). But after launching a subagent, **never message it
  again** — sending a follow-up message interrupts and derails the running agent.
  Instead, tell each subagent to write its output to a specific file, then use
  `inotifywait` to block until that file appears:
  ```bash
  # Wait for subagent output (blocks until file is created, no polling)
  inotifywait -e create -e moved_to "$(dirname "$OUTPUT_FILE")" --include "$(basename "$OUTPUT_FILE")" --timeout 600
  cat "$OUTPUT_FILE"
  ```
  Launch all subagents with `wait: false`, then inotifywait for each output file.
