# Epic Systems Corporation - EHI Export Documentation

**Collection Date**: February 13, 2026  
**Source**: https://open.epic.com/EHITables  
**Status**: ✅ Complete

## Contents

- **collection-log.md** - Detailed navigation journal documenting every step taken to find and download the documentation
- **analysis.json** - Structured characterization of the documentation content and EHI coverage
- **downloads/** - Downloaded documentation files
  - `Epic_EHI_Tables.zip` (12.7 MB) - Complete documentation archive
  - `extracted/` - Extracted contents (7,673 HTML table definitions + CSS)
- **screenshot-table-index.png** - Screenshot of the table index page
- **screenshot-table-detail.png** - Screenshot of a sample table detail page

## Quick Summary

**Epic provides exemplary EHI export documentation**:
- 7,673 database tables documented (complete Epic schema)
- TSV (tab-separated value) export format
- Field-level documentation with data types and descriptions
- Publicly accessible, no login required
- Downloadable as a single ZIP file
- Current as of February 2026

**Coverage**: Clinical, billing, insurance, appointments, documents/images, secure messages, audit trails, and all operational data.

**Export Format**: Tab-separated value (TSV) files native to Epic's database structure. Patient exports contain relevant table data as TSV files, with rich documents/images as separate referenced files.

## Key Tables (Examples)

- `PATIENT.htm` - Patient demographics (85 columns)
- `AP_CLAIM.htm` - Managed care claims (133 columns)  
- `ACCT_COVERAGE.htm` - Insurance coverage
- `CAL_MESSAGE_BODY.htm` - Patient-provider messaging
- `DICOM_MANIFEST.htm` - Medical imaging references
- `CLARITY_MEDICATION.htm` - Medication data
- `LAB_CASE_DB_MAIN.htm` - Laboratory results

## Reproducibility

To reproduce this collection:

```bash
# Download the ZIP
curl -L -H 'User-Agent: Mozilla/5.0' \
  -o Epic_EHI_Tables.zip \
  'https://open.epic.com/EHITables/Download'

# Extract
unzip Epic_EHI_Tables.zip
```

No special headers, JavaScript, or navigation required. Direct download works perfectly.
