# TruBridge, Inc. — EHI Export Documentation Collection

Collected: February 14, 2026

## Source
- Registered URL: https://ehi-export.plt.trubridge.com/
- CHPL IDs: 11540, 11541
- Products: TruBridge EHR, TruBridge Provider EHR, Centriq
- Vendor: TruBridge, Inc.

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://ehi-export.plt.trubridge.com/" -H 'User-Agent: Mozilla/5.0'
```
**Result**: 
- HTTP 200 OK
- Content-Type: text/html
- Content-Length: 3600
- No redirects
- Live, active site served by istio-envoy

### Step 2: Page examination
```bash
curl -sL "https://ehi-export.plt.trubridge.com/" -H 'User-Agent: Mozilla/5.0' > page.html
```
**Result**:
- Static HTML site (3,600 bytes)
- Navigation hub with version-based documentation
- Two main product categories:
  - **TruBridge EHR** (versions 2105-2203)
  - **Centriq** (separate product with CCDA/FHIR exports)
- Uses custom web components but content is in HTML source
- No direct file downloads from main page

### Step 3: Finding the EHI documentation structure

The site is organized as a multi-page documentation site with hierarchical navigation:

**TruBridge EHR versions available:**
- v2105 (earliest)
- v2106, v2107, v2108, v2109
- v2200, v2201, v2202
- v2203 (latest/current)

Each version has identical structure with four main categories:
1. **Clinical Data** - transcriptions, electronic forms, medication history, etc.
2. **Full Database Export** - complete JSON database schema and data dictionary
3. **Images and Documents** - digital signatures, scanned images, VDMS files
4. **Insurance and Eligibility** - 271 messages, prior auth, real-time benefits

**Centriq** (separate product):
- CCDA export documentation
- FHIR R4 bulk export documentation
- Financial data (pipe-delimited format)

### Step 4: Exploring TruBridge EHR v2203 (latest version)

Navigated to: https://ehi-export.plt.trubridge.com/trubridge/v2203/

**Overview page** describes:
- EHI Export feature for single patient or population
- File naming convention schema
- Four export categories

**Full Database Export page** (https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-database/):
- **1.3 MB HTML file** containing complete data dictionary
- **462 database tables** documented
- Each table includes:
  - Table name
  - Description
  - Field definitions with names and descriptions
- **JSON export format specification** provided
- Detailed file naming scheme documented

### Step 5: Exploring Centriq documentation

Navigated to: https://ehi-export.plt.trubridge.com/centriq/

**Centriq Overview**:
- Three export categories: CCDA, FHIR, Financial Data
- Creates ZIP file with export files

**CCDA documentation**:
- Consolidated CDA for encounters/visits
- Template and schema references

**FHIR documentation**:
- FHIR R4 bulk export
- Resource types documented (Patient, Encounter, AllergyIntolerance, etc.)
- Mapping to source systems

**Financial Data**:
- Pipe-delimited format specification
- Field definitions and layouts

### Step 6: Downloaded all documentation pages

Using curl with User-Agent header, downloaded:
- Main index page
- All v2203 TruBridge EHR documentation pages (18 pages)
- All Centriq documentation pages (4 pages)
- Sample older version pages (v2200, v2105) for version comparison

### Step 7: Browser screenshots

Captured screenshots of:
1. Main navigation page
2. Database export data dictionary page
3. TruBridge EHR v2203 overview
4. Centriq overview

## Downloads

### index-main.html (3.6 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/" -H 'User-Agent: Mozilla/5.0' -o index-main.html
```
Verified: HTML document, main navigation hub
Saved to: downloads/index-main.html
Content: Main entry point with links to all products and versions

### trubridge-ehr-v2203-database-export.html (1.3 MB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-database/" -H 'User-Agent: Mozilla/5.0' -o trubridge-ehr-v2203-database-export.html
```
Verified: HTML document, comprehensive data dictionary
Saved to: downloads/trubridge-ehr-v2203-database-export.html
Content: **Complete database schema with 462 tables**, field definitions, JSON format specification, file naming conventions

### v2203-trubridge-v2203.html (6.2 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203.html
```
Verified: HTML document
Saved to: downloads/v2203-trubridge-v2203.html
Content: TruBridge EHR v2203 overview, categories description, file naming convention

### v2203-trubridge-v2203-trubridge-ancillary.html (4.8 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-ancillary/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-ancillary.html
```
Content: Ancillary transcriptions format specification

### v2203-trubridge-v2203-trubridge-ef.html (4.7 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-ef/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-ef.html
```
Content: Electronic forms export format

### v2203-trubridge-v2203-trubridge-rx.html (11 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-rx/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-rx.html
```
Content: Escribe (ePrescribing) messages format

### v2203-trubridge-v2203-trubridge-hh.html (4.3 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-hh/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-hh.html
```
Content: Home health documentation export

### v2203-trubridge-v2203-trubridge-mr.html (4.8 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-mr/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-mr.html
```
Content: Medical records transcriptions format

### v2203-trubridge-v2203-trubridge-mh.html (12 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-mh/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-mh.html
```
Content: Medication history data format and field definitions

### v2203-trubridge-v2203-trubridge-poc.html (5.2 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-poc/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-poc.html
```
Content: Point of care reports format

### v2203-trubridge-v2203-trubridge-dig-sig.html (4.6 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-dig-sig/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-dig-sig.html
```
Content: Digital signature files export format

### v2203-trubridge-v2203-trubridge-efm.html (5.3 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-efm/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-efm.html
```
Content: Electronic file maintenance document export

### v2203-trubridge-v2203-trubridge-fidx.html (5.4 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-fidx/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-fidx.html
```
Content: File index export format

### v2203-trubridge-v2203-trubridge-flpd.html (6.2 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-flpd/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-flpd.html
```
Content: Patient data files export format

### v2203-trubridge-v2203-trubridge-vdms.html (4.7 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-vdms/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-vdms.html
```
Content: VDMS (document management system) export format

### v2203-trubridge-v2203-trubridge-rx-epa.html (17 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-rx-epa/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-rx-epa.html
```
Content: Escribe electronic prior authorization format and field definitions

### v2203-trubridge-v2203-trubridge-rx-271.html (4.8 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-rx-271/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-rx-271.html
```
Content: Escribe 271 eligibility response format

### v2203-trubridge-v2203-trubridge-pc-271.html (4.8 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-pc-271/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-pc-271.html
```
Content: Patient Connect 271 eligibility format

### v2203-trubridge-v2203-trubridge-rx-rtb.html (11 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-rx-rtb/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-rx-rtb.html
```
Content: Real-time benefit check data format

### v2203-trubridge-v2203-trubridge-271.html (4.8 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2203/trubridge-271/" -H 'User-Agent: Mozilla/5.0' -o v2203-trubridge-v2203-trubridge-271.html
```
Content: TruBridge EHR 271 eligibility format

### centriq-overview.html (5.1 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/centriq/" -H 'User-Agent: Mozilla/5.0' -o centriq-overview.html
```
Content: Centriq EHI Export overview, export categories, ZIP file structure

### centriq-ccda.html (9.6 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/centriq/centriq-ccda/" -H 'User-Agent: Mozilla/5.0' -o centriq-ccda.html
```
Content: Consolidated CDA export format specification

### centriq-fhir.html (8.3 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/centriq/centriq-fhir/" -H 'User-Agent: Mozilla/5.0' -o centriq-fhir.html
```
Content: FHIR R4 bulk export specification with resource mappings

### centriq-financial.html (29 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/centriq/centriq-financial/" -H 'User-Agent: Mozilla/5.0' -o centriq-financial.html
```
Content: Financial data pipe-delimited format with comprehensive field definitions

### trubridge-ehr-v2200-database-export.html (1.2 MB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2200/trubridge-database/" -H 'User-Agent: Mozilla/5.0' -o trubridge-ehr-v2200-database-export.html
```
Content: Version 2200 database dictionary (for version comparison)

### v2200-overview.html (6.2 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2200/" -H 'User-Agent: Mozilla/5.0' -o v2200-overview.html
```
Content: TruBridge EHR v2200 overview

### v2105-overview.html (6.2 KB)
```bash
curl -sL "https://ehi-export.plt.trubridge.com/trubridge/v2105/" -H 'User-Agent: Mozilla/5.0' -o v2105-overview.html
```
Content: TruBridge EHR v2105 (earliest version) overview

### Screenshots (4 files)
- screenshot-01-main-page.png (60 KB) - Main navigation hub
- screenshot-02-database-export.png (66 KB) - Database export data dictionary page
- screenshot-03-v2203-overview.png (74 KB) - TruBridge EHR v2203 overview with categories
- screenshot-04-centriq-overview.png (63 KB) - Centriq product overview

## Access Summary
- **Final URL**: https://ehi-export.plt.trubridge.com/ (no redirects)
- **Status**: ✅ **found** - fully accessible, comprehensive documentation
- **Required browser**: No (all content accessible via curl)
- **Navigation complexity**: multi_page (well-organized hierarchical navigation)
- **Anti-bot issues**: None (standard User-Agent header sufficient)

## Documentation Quality Assessment

**Excellent documentation quality:**
- ✅ Complete data dictionary with 462 tables fully documented
- ✅ JSON export format with schema definition
- ✅ File naming conventions clearly specified
- ✅ Multiple export formats documented (JSON, CCDA, FHIR, pipe-delimited)
- ✅ Version history available (9 versions from 2105 to 2203)
- ✅ Both products documented (TruBridge EHR and Centriq)
- ✅ Field-level definitions provided
- ✅ Machine-readable format (HTML tables easily parseable)
- ✅ No login required
- ✅ Stable URLs
- ✅ Fast loading times

## Key Findings

1. **Comprehensive Database Schema**: The database export documentation is exceptional - 1.3MB of structured table and field definitions covering 462 database tables.

2. **Multiple Export Formats**: 
   - TruBridge EHR uses JSON for database export
   - Centriq uses CCDA, FHIR R4, and pipe-delimited formats
   - Multiple specialized formats for different data types

3. **Version Management**: Excellent version tracking with 9 versions documented, allowing customers to access documentation matching their installed version.

4. **Structured Data**: All documentation is in HTML with semantic markup, making it easily parseable for automated processing.

5. **No Proprietary Dependencies**: All exports use standard or well-documented formats (JSON, CCDA, FHIR R4).

## Obstacles & Dead Ends

**None encountered.**

The documentation site is:
- Well-organized
- Fully accessible without authentication
- Fast and responsive
- Standards-compliant HTML
- No JavaScript requirements for content access
- No rate limiting or anti-bot measures

This is an exemplary implementation of public EHI export documentation.
