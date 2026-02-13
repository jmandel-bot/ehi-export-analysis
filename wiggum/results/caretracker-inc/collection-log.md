# CareTracker, Inc. (Amazing Charts) — EHI Export Documentation Collection Log

## Source
- **Developer**: CareTracker, Inc.
- **Product**: Amazing Charts
- **CHPL IDs**: 11492, 11608, 11646, 11720
- **Registered URL**: https://amazingcharts.com/hubfs/Amazing-Charts-EHI-Export-Documentation-V1_0-1-1.pdf?hsLang=en

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://amazingcharts.com/hubfs/Amazing-Charts-EHI-Export-Documentation-V1_0-1-1.pdf?hsLang=en" -H 'User-Agent: Mozilla/5.0'
```

**Result**: Direct PDF download. Single HTTP/2 200 response (no redirects).
- Content-Type: `application/pdf`
- Content-Length: `195305` (190.7 KB)
- Server: Cloudflare (fronting HubSpot HubFS CDN via CloudFront)
- Last-Modified: `Thu, 29 May 2025 20:02:47 GMT`
- x-robots-tag: `all` (publicly indexed)
- x-hs-cfworker-meta: `{"resolver":"HubFsResolver"}` — HubSpot file storage
- CF-Cache-Status: HIT (cached at Cloudflare edge)

The registered URL is a **direct link to the PDF** hosted on HubSpot's file storage (HubFS). No navigation, no accordion, no SPA — just download the file.

### Step 2: Download and verification

No page examination needed — the URL returns a PDF directly.

```bash
curl -sL "https://amazingcharts.com/hubfs/Amazing-Charts-EHI-Export-Documentation-V1_0-1-1.pdf?hsLang=en" \
  -H 'User-Agent: Mozilla/5.0' \
  -o downloads/Amazing-Charts-EHI-Export-Documentation-V1_0-1-1.pdf
```

Verification:
- `file` output: `PDF document, version 1.7 (zip deflate encoded)`
- File size: 195,305 bytes
- Pages: 8
- Author: Kathiresan Palanisamy
- Creator: Microsoft® Word for Microsoft 365
- Created: Mon Oct 16 13:52:55 2023 UTC
- Modified: Mon Oct 16 13:58:07 2023 UTC

### Step 3: Content examination

Extracted text with `pdftotext`. The PDF is titled:
> **Amazing Charts EHI Export: Folder Organization and Data Format Specification – v1.0**

The document describes:
1. Two export scenarios: single patient and patient population
2. Patient population can be filtered by Provider, All Active Patients, All Patients, or Encounter Range
3. Per-patient folders with timestamp naming
4. Export format options: `.csv`, `.json`, or `.xml`
5. A "Documents" subfolder for imported items, images, and related documents (original format preserved)
6. 44 data classes with full column heading listings

## Downloads

### Amazing-Charts-EHI-Export-Documentation-V1_0-1-1.pdf (190.7 KB)

```bash
curl -sL -H 'User-Agent: Mozilla/5.0' \
  -o downloads/Amazing-Charts-EHI-Export-Documentation-V1_0-1-1.pdf \
  'https://amazingcharts.com/hubfs/Amazing-Charts-EHI-Export-Documentation-V1_0-1-1.pdf?hsLang=en'
```

- Verified: PDF document, version 1.7, 8 pages
- Saved to: `downloads/Amazing-Charts-EHI-Export-Documentation-V1_0-1-1.pdf`

## Obstacles & Notes

- **None**. This was the simplest possible case: a direct PDF download from a HubSpot-hosted URL.
- No anti-bot protection beyond Cloudflare (which passed without issue).
- No special headers required (User-Agent works fine but may not even be needed).
- The `?hsLang=en` query parameter is a HubSpot language parameter; the PDF downloads with or without it.
- The PDF was last modified May 29, 2025 (recently updated), though the creation date is October 2023 and the version remains v1.0.

## Data Classes Found (44 total)

1. Addendum
2. Advance Directives
3. Alerts
4. Allergies and Intolerances Pending
5. Allergies and Intolerances
6. Assesments [sic]
7. Billing History
8. Care Team Members
9. Clinical Notes
10. Demographic Immunization
11. Email
12. Family History
13. Functional Status
14. Goals
15. Health Concerns
16. Health Insurance
17. HM Rules Ignored
18. HM Rules
19. Immunizations
20. Implantable device
21. Imported Items
22. Injections
23. Lab Tests
24. List Problem Pending
25. List Problem
26. Medications Pending
27. Medications
28. Next Of Kin
29. Occupation and Industry History
30. Orders
31. Patient Demographics
32. Patient Generated Data
33. Patient Health Information Capture
34. Patient Record Release
35. Plan of Treatment
36. Procedures
37. Referrals
38. Risk Factors
39. Scheduling
40. Smoking Statuses
41. Tracked Data
42. Travel History
43. User Defined Fields
44. Vital Signs
