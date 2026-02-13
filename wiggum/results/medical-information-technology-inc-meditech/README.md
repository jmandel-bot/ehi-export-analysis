# MEDITECH EHI Export Documentation Collection

**Vendor**: Medical Information Technology, Inc. (MEDITECH)  
**Collection Date**: February 13, 2026  
**Status**: ✅ Complete

## Summary

MEDITECH provides exceptionally comprehensive EHI export documentation covering their entire product portfolio from legacy MAGIC systems to modern Expanse 2.2. The documentation is split into two distinct configurations based on platform version and implementation.

## Key Findings

### Two Export Configurations

**Configuration 1** (Newer Platforms: Expanse, 6.15, etc.)
- Document-centric approach
- Electronic Chart documents exported as images/PDFs in organized folder hierarchies
- Includes FHIR US Core resources (JSON) and C-CDA documents (XML)
- Supplemental reports for financial, immunization, population health, utilization review

**Configuration 2** (Older Platforms: 6.08 Ambulatory, Client/Server, MAGIC)
- Database-centric approach
- **Structured patient data exported as CSV files**
- Detailed data dictionaries documenting 106-196 tables with field-level mappings
- Includes FHIR and C-CDA like Config 1

### Data Coverage

✅ **Clinical Data**: Comprehensive (labs, imaging, vitals, medications, allergies, problems, immunizations, procedures, diagnoses)  
✅ **Secure Messages**: Provider-patient messages documented  
✅ **Billing/Financial**: Patient accounting transactions, claims, payments, finance charges  
✅ **Insurance**: Coverage, eligibility, authorizations, copays, deductibles  
✅ **Appointments/Scheduling**: Appointments and visit tracking  
✅ **Documents/Images**: Extensive document repository with categorized images and PDFs  
❌ **Audit Trails**: Not explicitly documented

### CSV Data Dictionary Highlights

Configuration 2 provides the most detailed structured data specifications:

- **Client/Server Acute & Ambulatory**: 196 tables documented
- **MPM 6.08 Ambulatory**: 106 tables documented
- **MAGIC Acute & Ambulatory**: Similar comprehensive coverage

Key table categories:
- `Adm*` tables: Admissions, visits, employers, insurance
- `Apr*` tables: Ambulatory patient records, encounters, messages, results
- `Arm*` tables: Authorization and referral management
- `Pbr*` tables: Patient billing and revenue (claims, transactions, payments)
- `Rxm*` tables: Prescriptions and medication orders
- `Sch*` tables: Scheduling and appointments
- `Mri*` tables: Medical records integration (patients, immunizations, devices, insurance)

## Files Collected

### Documentation Pages (HTML)
- `downloads/ehiexport_main.html` - Landing page explaining both configurations
- `downloads/ehiexportconfig1.html` - Configuration 1 specifications (29 KB)
- `downloads/ehiexportconfig2.html` - Configuration 2 specifications (23 KB)

### CSV Data Dictionaries (PDF)
- `downloads/config2_cs_acute_ambulatory_csv.pdf` - Client/Server data dictionary (257 KB, 20 pages)
- `downloads/config2_magic_acute_ambulatory_csv.pdf` - MAGIC data dictionary (355 KB, 20 pages)
- `downloads/config2_mpm608_ambulatory_csv.pdf` - MPM 6.08 data dictionary (246 KB, 19 pages)

### Analysis Files
- `collection-log.md` - Detailed navigation and collection process
- `analysis.json` - Structured metadata and characterization
- `README.md` - This file

**Total Size**: 964 KB

## Notable Characteristics

### Strengths

1. **Dual approach serves different needs**: Document-centric for human review, CSV-centric for data analysis
2. **Beyond FHIR**: CSV exports provide granular database-level data not available through FHIR APIs
3. **Field-level mappings**: Each CSV table documented with human-readable field names mapped to actual column names
4. **Platform coverage**: Documentation spans 15+ years of MEDITECH platforms
5. **Non-clinical data**: Extensive billing, financial, insurance, and administrative data coverage
6. **Machine-readable metadata**: Table of Contents.ndjson with FHIR DocumentReference resources
7. **Well-organized**: Clear structure, easy navigation, no authentication barriers

### Observations

- Configuration 2's CSV approach is particularly valuable for researchers and data analysts who need structured, queryable data
- The documentation explicitly notes that export content varies by organization's configuration and usage
- Financial data is notably comprehensive, including line-item transactions, payment distributions, and finance charges
- Provider-patient secure messages are included, which is uncommon in many EHI exports
- No audit trail data documented, which limits accountability/transparency

## Access Information

**URL**: https://home.meditech.com/en/d/restapiresources/pages/ehiexport.htm  
**Authentication**: None required  
**Anti-bot**: None  
**Download method**: Simple curl with User-Agent header

## Reproducibility

See `collection-log.md` for step-by-step instructions to reproduce this collection.
