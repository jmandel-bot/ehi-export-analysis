# TruBridge, Inc. - EHI Export Documentation Collection Summary

**Collection Date:** February 14, 2026  
**Collector:** Automated documentation crawler  
**Status:** ✅ Complete and successful

## Target Information

- **Vendor:** TruBridge, Inc.
- **Products:** TruBridge EHR, TruBridge Provider EHR, Centriq
- **CHPL IDs:** 11540, 11541
- **Documentation URL:** https://ehi-export.plt.trubridge.com/
- **URL Status:** Active and accessible (HTTP 200)

## Collection Results

### Files Downloaded: 34

**Documentation files:** 29 HTML files  
**Screenshots:** 4 PNG files  
**Metadata:** 1 JSON manifest  

**Total size:** 3.0 MB

### Key Artifacts

1. **TruBridge EHR v2203 Database Dictionary** (1.3 MB)
   - 462 database tables fully documented
   - Complete field definitions
   - JSON export format specification
   
2. **Clinical Data Format Specifications** (18 pages)
   - Transcriptions, electronic forms, medication history
   - ePrescribing messages, point of care reports
   - Images and document formats
   
3. **Centriq Product Documentation** (4 pages)
   - CCDA export specification
   - FHIR R4 bulk export with resource mappings
   - Financial data pipe-delimited format (29 KB comprehensive spec)

4. **Version History** 
   - v2105 (earliest) through v2203 (latest)
   - Sample documentation from v2200 and v2105 for comparison

## Documentation Quality: Exemplary ⭐⭐⭐⭐⭐

This vendor provides **best-in-class EHI export documentation**:

### Strengths

✅ **Comprehensive coverage** - 462 database tables documented  
✅ **Field-level detail** - Every field has name and description  
✅ **Format specifications** - JSON schema, CCDA, FHIR R4, pipe-delimited  
✅ **Version management** - 9 versions documented (2105-2203)  
✅ **No authentication** - Fully public, no login required  
✅ **Well-organized** - Clear hierarchical navigation  
✅ **Machine-readable** - Structured HTML tables  
✅ **Fast access** - No rate limiting, responsive server  
✅ **Multiple products** - Both TruBridge EHR and Centriq documented  
✅ **File naming conventions** - Clearly specified  

### Export Format Coverage

| Format | Product | Description |
|--------|---------|-------------|
| JSON | TruBridge EHR | Complete database export with schema |
| CCDA | Centriq | Consolidated CDA for encounters |
| FHIR R4 | Centriq | Bulk export with 20+ resource types |
| Pipe-delimited | Centriq | Financial data with field specs |
| XML | Both | Insurance eligibility (271 format) |
| Various | Both | Images, PDFs, transcriptions |

## Access Characteristics

- **Authentication required:** No
- **Browser required:** No (all content via curl)
- **JavaScript required:** No (content in HTML source)
- **Anti-bot measures:** None
- **Navigation complexity:** Multi-page (well-organized)
- **Redirects:** None
- **Final URL:** https://ehi-export.plt.trubridge.com/ (same as registered)

## Reproducibility

All downloads fully reproducible using standard curl commands with User-Agent header.

Complete navigation journal with all curl commands: `collection-log.md`  
Machine-readable download manifest: `download-manifest.json`  
Individual file documentation: `downloads/README.md`

## Notable Findings

1. **Database Export Excellence**: The 1.3 MB database dictionary documenting 462 tables represents one of the most comprehensive database export specifications observed. Each table includes table description and field-level definitions.

2. **Multi-Product Support**: Unlike many vendors who provide separate documentation sites, TruBridge consolidates documentation for multiple products (TruBridge EHR and Centriq) in one well-organized site.

3. **Version History**: Excellent version management with 9 versions accessible, allowing customers to match documentation to their installed version.

4. **Format Diversity**: Supports multiple export formats appropriately matched to data types (JSON for database, CCDA/FHIR for clinical, pipe-delimited for financial).

5. **No Barriers**: The documentation site has zero access barriers - no login, no JavaScript requirements, no rate limiting, fast response times. This represents exemplary compliance with the public accessibility requirement.

## Compliance Assessment

**Overall Assessment: Excellent**

TruBridge, Inc. demonstrates best-practice compliance with 21st Century Cures Act § 170.315(b)(10) EHI Export documentation requirements:

✅ Public documentation available without access restrictions  
✅ Comprehensive data dictionary provided  
✅ Export format specifications clearly documented  
✅ File format and structure described  
✅ Multiple EHI categories covered (clinical, administrative, financial)  
✅ Version-specific documentation available  
✅ Multiple export format options documented  

This vendor sets the standard for public EHI export documentation accessibility and completeness.

## Files

```
trubridge-inc/
├── SUMMARY.md (this file)
├── collection-log.md (detailed navigation journal)
├── download-manifest.json (machine-readable metadata)
├── chpl-metadata.json (CHPL product information)
└── downloads/
    ├── README.md (archive documentation)
    ├── index-main.html (main navigation page)
    ├── trubridge-ehr-v2203-database-export.html (1.3 MB data dictionary)
    ├── v2203-*.html (18 format specification pages)
    ├── centriq-*.html (4 product pages)
    ├── v2200-*.html (2 version comparison pages)
    ├── v2105-*.html (1 earliest version page)
    └── screenshot-*.png (4 screenshots)
```

## Next Steps

This collection is complete and ready for:
- Analysis and comparison with other vendor documentation
- Data dictionary extraction and normalization
- Format specification parsing
- Compliance assessment reporting
- Best practice identification

---

**Collection completed successfully with no obstacles encountered.**
