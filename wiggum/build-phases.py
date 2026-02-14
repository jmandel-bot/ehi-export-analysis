#!/usr/bin/env python3
"""Build phased target lists from the master targets.json.

Phases are evaluated in order. Each phase defines filter criteria.
A target matched by an earlier phase is excluded from later phases.
This ensures every target appears in at most one phase.

Usage:
    python3 wiggum/build-phases.py

Outputs:
    work/phases/phase-{N}-{slug}.json   — target list for each phase
    work/phases/manifest.json           — summary of all phases
"""
import json, os, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TARGETS = os.path.join(ROOT, 'work', 'targets.json')
METADIR = os.path.join(ROOT, 'work', 'target-metadata')
OUTDIR = os.path.join(ROOT, 'work', 'phases')

# ── Phase definitions ──────────────────────────────────────────────
#
# Each phase is a dict with:
#   name     — human-readable label
#   slug     — filename-safe identifier
#   filter   — function(idx, target, meta) -> bool
#   description — what this phase captures
#
# Phases are evaluated in order. A target matched by phase N is
# excluded from phases N+1, N+2, etc.

def has_any_criteria(meta, criteria_set):
    """True if any product at this URL has any of the given criteria."""
    for prod in meta.get('products', []):
        if set(prod.get('certified_criteria', [])) & criteria_set:
            return True
    return False

def has_all_criteria(meta, criteria_set):
    """True if any single product at this URL has ALL of the given criteria."""
    for prod in meta.get('products', []):
        if criteria_set <= set(prod.get('certified_criteria', [])):
            return True
    return False

def count_criteria(meta):
    """Max number of certified criteria across all products at this URL."""
    return max(
        (len(prod.get('certified_criteria', [])) for prod in meta.get('products', [])),
        default=0
    )

CPOE = {'170.315 (a)(1)', '170.315 (a)(2)', '170.315 (a)(3)'}
G10 = {'170.315 (g)(10)'}
CLINICAL_A = {f'170.315 (a)({i})' for i in range(1, 15)}
PATIENT_PORTAL = {'170.315 (e)(1)'}
TRANSITIONS = {'170.315 (b)(1)', '170.315 (b)(2)', '170.315 (b)(3)'}

PHASES = [
    {
        'name': 'Comprehensive EHRs',
        'slug': 'comprehensive-ehrs',
        'description': (
            'Products with CPOE certification [(a)(1)-(a)(3)] and '
            'standardized FHIR API [(g)(10)]. These are full-featured EHR '
            'systems with clinical decision support, order entry, and '
            'standards-based API access — the core EHR market.'
        ),
        'filter': lambda idx, target, meta: (
            has_any_criteria(meta, CPOE) and has_any_criteria(meta, G10)
        ),
    },
    {
        'name': 'Clinical systems without FHIR API',
        'slug': 'clinical-no-fhir',
        'description': (
            'Products with clinical criteria [(a)(1)-(a)(14)] but no '
            'standardized FHIR API [(g)(10)]. May be older systems, '
            'specialty EHRs, or products that certified for clinical '
            'functions but not API access.'
        ),
        'filter': lambda idx, target, meta: (
            has_any_criteria(meta, CLINICAL_A)
        ),
    },
    {
        'name': 'API-only and specialty modules',
        'slug': 'api-and-specialty',
        'description': (
            'Products with (g)(10) FHIR API but no clinical (a) criteria, '
            'or products with patient portal, transitions of care, or '
            'other non-clinical certifications. Includes patient portals, '
            'health information exchanges, and middleware.'
        ),
        'filter': lambda idx, target, meta: (
            has_any_criteria(meta, G10 | PATIENT_PORTAL | TRANSITIONS)
        ),
    },
    {
        'name': 'Minimal certification',
        'slug': 'minimal',
        'description': (
            'Products certified only for (b)(10) EHI export plus '
            'infrastructure criteria [(d), (g)(4), (g)(5)]. Minimal '
            'clinical functionality certified — may be niche tools, '
            'compliance-only certifications, or products early in '
            'their certification journey.'
        ),
        'filter': lambda idx, target, meta: True,  # catch-all
    },
]

# ── Build phase lists ──────────────────────────────────────────────

def main():
    with open(TARGETS) as f:
        targets = json.load(f)

    # Load all metadata
    metadata = {}
    for idx in range(len(targets)):
        meta_file = os.path.join(METADIR, f'{idx:04d}.json')
        if os.path.exists(meta_file):
            with open(meta_file) as f:
                metadata[idx] = json.load(f)

    os.makedirs(OUTDIR, exist_ok=True)

    claimed = set()  # indices already assigned to a phase
    manifest = []

    for phase_num, phase_def in enumerate(PHASES, 1):
        matched = []
        for idx, target in enumerate(targets):
            if idx in claimed:
                continue
            meta = metadata.get(idx, {})
            if phase_def['filter'](idx, target, meta):
                matched.append(idx)

        # Build the phase target list (same format as targets.json + index)
        phase_targets = []
        for idx in matched:
            entry = dict(targets[idx])
            entry['original_index'] = idx
            phase_targets.append(entry)
            claimed.add(idx)

        slug = phase_def['slug']
        outfile = os.path.join(OUTDIR, f'phase-{phase_num}-{slug}.json')
        with open(outfile, 'w') as f:
            json.dump(phase_targets, f, indent=2)

        manifest.append({
            'phase': phase_num,
            'name': phase_def['name'],
            'slug': slug,
            'file': f'phase-{phase_num}-{slug}.json',
            'description': phase_def['description'],
            'count': len(phase_targets),
        })

        print(f'Phase {phase_num}: {phase_def["name"]}')
        print(f'  {len(phase_targets)} targets → {outfile}')
        if phase_targets:
            top = phase_targets[:5]
            for t in top:
                print(f'    [{t["original_index"]:3d}] {t["product_count"]:2d} products  {t["developers"][0][:50]}')
            if len(phase_targets) > 5:
                print(f'    ... and {len(phase_targets) - 5} more')
        print()

    unclaimed = set(range(len(targets))) - claimed
    if unclaimed:
        print(f'WARNING: {len(unclaimed)} targets not assigned to any phase')

    with open(os.path.join(OUTDIR, 'manifest.json'), 'w') as f:
        json.dump(manifest, f, indent=2)

    print(f'Manifest: {os.path.join(OUTDIR, "manifest.json")}')
    print(f'Total: {len(targets)} targets across {len(PHASES)} phases')

if __name__ == '__main__':
    main()
