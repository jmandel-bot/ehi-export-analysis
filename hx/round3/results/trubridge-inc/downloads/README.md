# TruBridge, Inc. - EHI Export Documentation Archive

Downloaded: February 14, 2026  
Source: https://ehi-export.plt.trubridge.com/

## Contents

This archive contains complete EHI export documentation for TruBridge products:
- **TruBridge EHR** (v2105 through v2203)
- **Centriq** (EHR product with CCDA/FHIR exports)

## Key Files

### TruBridge EHR v2203 (Latest Version)

**Primary Documentation:**
- `trubridge-ehr-v2203-database-export.html` (1.3 MB) - **462 database tables** fully documented with field definitions and JSON export format specification
- `v2203-trubridge-v2203.html` - Overview and file naming conventions

**Clinical Data Exports:**
- `v2203-*-ancillary.html` - Ancillary transcriptions
- `v2203-*-ef.html` - Electronic forms
- `v2203-*-rx.html` - Escribe ePrescribing messages
- `v2203-*-hh.html` - Home health documentation
- `v2203-*-mr.html` - Medical records transcriptions
- `v2203-*-mh.html` - Medication history
- `v2203-*-poc.html` - Point of care reports

**Images and Documents:**
- `v2203-*-dig-sig.html` - Digital signatures
- `v2203-*-efm.html` - Electronic file maintenance
- `v2203-*-fidx.html` - File index
- `v2203-*-flpd.html` - Patient data files
- `v2203-*-vdms.html` - VDMS document management

**Insurance and Eligibility:**
- `v2203-*-rx-epa.html` - Electronic prior authorization
- `v2203-*-rx-271.html` - Escribe 271 eligibility
- `v2203-*-pc-271.html` - Patient Connect 271
- `v2203-*-rx-rtb.html` - Real-time benefits
- `v2203-*-271.html` - TruBridge EHR 271 format

### Centriq Product Documentation

- `centriq-overview.html` - Product overview
- `centriq-ccda.html` - Consolidated CDA export specification
- `centriq-fhir.html` - FHIR R4 bulk export with resource mappings
- `centriq-financial.html` (29 KB) - Pipe-delimited financial data with comprehensive field definitions

### Version Comparison

- `v2200-overview.html` & `trubridge-ehr-v2200-database-export.html` - Version 2200 for comparison
- `v2105-overview.html` - Earliest documented version (v2105)

### Screenshots

- `screenshot-01-main-page.png` - Main navigation hub
- `screenshot-02-database-export.png` - Database dictionary page
- `screenshot-03-v2203-overview.png` - v2203 overview with categories
- `screenshot-04-centriq-overview.png` - Centriq product overview

## Documentation Quality

This vendor provides **exemplary EHI export documentation**:

✅ Complete database schema (462 tables, 1.3 MB of documentation)  
✅ Field-level definitions for all data elements  
✅ JSON export format with schema specification  
✅ Multiple export formats (JSON, CCDA, FHIR R4, pipe-delimited)  
✅ Version history (9 versions documented)  
✅ No authentication required  
✅ Fast, accessible, well-organized  
✅ Machine-readable HTML format  

## Export Formats

**TruBridge EHR:**
- Database: JSON format with structured schema
- Clinical documents: Various text/XML formats
- Images: Original file formats (PDF, images)
- Insurance data: XML (271 format)

**Centriq:**
- Clinical: CCDA XML and FHIR R4 JSON
- Financial: Pipe-delimited text format

## How to Reproduce

All files were downloaded using curl with standard User-Agent header:

```bash
curl -sL 'https://ehi-export.plt.trubridge.com/[path]' -H 'User-Agent: Mozilla/5.0' -o filename.html
```

No authentication, browser automation, or special access required.

## Reproducibility

See `../collection-log.md` for complete navigation journal with all curl commands used.  
See `../download-manifest.json` for machine-readable download metadata.
