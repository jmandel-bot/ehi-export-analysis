#!/usr/bin/env python3
"""Build phased target lists from CHPL bulk data.

Filters at the PRODUCT level, then groups by URL. The same URL can appear
in multiple phases with disjoint product subsets.

Usage:
    python3 wiggum/build-phases.py

Outputs:
    work/phases/phase-{N}-{slug}.json   — target list for each phase
    work/phases/manifest.json           — summary of all phases
"""
import json, os
from collections import defaultdict

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BULK = os.path.join(ROOT, 'chpl-data', 'all-active-listings.json')
OUTDIR = os.path.join(ROOT, 'work', 'phases')
METADIR = os.path.join(ROOT, 'work', 'target-metadata')
TARGETS = os.path.join(ROOT, 'work', 'targets.json')

# ── Criteria sets ────────────────────────────────────────────
CPOE = {'170.315 (a)(1)', '170.315 (a)(2)', '170.315 (a)(3)'}
G10 = {'170.315 (g)(10)'}

def has_any(criteria, target_set):
    return bool(criteria & target_set)

# ── Phase definitions ────────────────────────────────────────
# Each phase filters at the product level.
# Products claimed by an earlier phase are excluded from later ones.

PHASES = [
    {
        'name': 'Comprehensive EHRs',
        'slug': 'comprehensive-ehrs',
        'description': 'CPOE + FHIR API (g)(10), no additional software for b(10). '
                       'Full-featured EHRs with their own EHI export.',
        'filter': lambda p: (
            has_any(p['criteria'], CPOE) and
            has_any(p['criteria'], G10) and
            not p['has_addl_software']
        ),
    },
    {
        'name': 'CPOE systems without FHIR API',
        'slug': 'cpoe-no-fhir',
        'description': 'CPOE certified but no (g)(10), no additional software for b(10). '
                       'EHRs with order entry that handle their own EHI export.',
        'filter': lambda p: (
            has_any(p['criteria'], CPOE) and
            not has_any(p['criteria'], G10) and
            not p['has_addl_software']
        ),
    },
    {
        'name': 'Comprehensive EHRs (additional software)',
        'slug': 'comprehensive-addl-sw',
        'description': 'CPOE + (g)(10) but b(10) requires additional software. '
                       'Full EHRs that rely on another product for EHI export.',
        'filter': lambda p: (
            has_any(p['criteria'], CPOE) and
            has_any(p['criteria'], G10) and
            p['has_addl_software']
        ),
    },
    {
        'name': 'CPOE systems (additional software)',
        'slug': 'cpoe-addl-sw',
        'description': 'CPOE but b(10) requires additional software.',
        'filter': lambda p: (
            has_any(p['criteria'], CPOE) and
            p['has_addl_software']
        ),
    },
    {
        'name': 'Other certified products',
        'slug': 'other',
        'description': 'Everything else: no CPOE. Patient portals, lab systems, '
                       'specialty modules, minimal certifications.',
        'filter': lambda p: True,  # catch-all
    },
]

# ── Extract products from bulk data ──────────────────────────

def load_products():
    with open(BULK) as f:
        listings = json.load(f)

    products = []
    for l in listings:
        b10 = None
        for cr in l.get('certificationResults', []):
            if cr.get('criterion', {}).get('number') == '170.315 (b)(10)' and cr.get('success'):
                b10 = cr
                break
        if not b10:
            continue

        criteria = set()
        for cr in l.get('certificationResults', []):
            if cr.get('success'):
                criteria.add(cr.get('criterion', {}).get('number', ''))

        url = b10.get('exportDocumentation', '')
        if not url:
            continue

        products.append({
            'id': l['id'],
            'developer': l.get('developer', {}).get('name', ''),
            'product': l.get('product', {}).get('name', ''),
            'version': l.get('version', {}).get('version', ''),
            'url': url,
            'criteria': criteria,
            'has_addl_software': len(b10.get('additionalSoftware', [])) > 0,
            'additional_software': [
                {'name': a.get('name', ''), 'version': a.get('version', '')}
                for a in b10.get('additionalSoftware', [])
            ],
        })

    return products

# ── Build URL-to-original-index mapping ──────────────────────

def load_url_index_map():
    """Map URL -> original index in targets.json (for metadata lookup)."""
    with open(TARGETS) as f:
        targets = json.load(f)
    return {t['url']: idx for idx, t in enumerate(targets)}

# ── Group products into URL-based targets ────────────────────

def group_by_url(products, url_index_map):
    """Group products by URL, producing target entries."""
    by_url = defaultdict(list)
    for p in products:
        by_url[p['url']].append(p)

    targets = []
    for url, prods in sorted(by_url.items(), key=lambda x: -len(x[1])):
        targets.append({
            'url': url,
            'developers': sorted(set(p['developer'] for p in prods)),
            'products': sorted(set(p['product'] for p in prods)),
            'chpl_ids': sorted(set(p['id'] for p in prods)),
            'product_count': len(prods),
            'original_index': url_index_map.get(url),
        })

    return targets

# ── Main ─────────────────────────────────────────────────────

def main():
    products = load_products()
    url_index_map = load_url_index_map()
    os.makedirs(OUTDIR, exist_ok=True)

    print(f'Total b(10) products with URLs: {len(products)}')
    print(f'  No additional software: {sum(1 for p in products if not p["has_addl_software"])}')
    print(f'  With additional software: {sum(1 for p in products if p["has_addl_software"])}')
    print()

    claimed = set()  # product IDs already assigned
    manifest = []

    for phase_num, phase_def in enumerate(PHASES, 1):
        matched = [p for p in products if p['id'] not in claimed and phase_def['filter'](p)]
        for p in matched:
            claimed.add(p['id'])

        targets = group_by_url(matched, url_index_map)

        slug = phase_def['slug']
        outfile = os.path.join(OUTDIR, f'phase-{phase_num}-{slug}.json')
        with open(outfile, 'w') as f:
            json.dump(targets, f, indent=2)

        manifest.append({
            'phase': phase_num,
            'name': phase_def['name'],
            'slug': slug,
            'file': f'phase-{phase_num}-{slug}.json',
            'description': phase_def['description'],
            'product_count': len(matched),
            'url_count': len(targets),
        })

        print(f'Phase {phase_num}: {phase_def["name"]}')
        print(f'  {len(matched)} products, {len(targets)} URLs')
        for t in targets[:5]:
            print(f'    {t["product_count"]:2d} products  {t["developers"][0][:50]}')
        if len(targets) > 5:
            print(f'    ... and {len(targets) - 5} more')
        print()

    unclaimed = [p for p in products if p['id'] not in claimed]
    if unclaimed:
        print(f'WARNING: {len(unclaimed)} products not assigned to any phase')

    with open(os.path.join(OUTDIR, 'manifest.json'), 'w') as f:
        json.dump(manifest, f, indent=2)

    print(f'Manifest: {os.path.join(OUTDIR, "manifest.json")}')

if __name__ == '__main__':
    main()
