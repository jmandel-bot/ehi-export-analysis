# eClinicalWorks, LLC — EHI Export Documentation Collection Log

## Source
- **CHPL IDs**: 11299, 11456
- **Products**: eClinicalWorks
- **Registered URL**: https://ehi.eclinicalworks.com/ehiexport/tableindex.html

## Navigation Journal

### Step 1: Initial probe

```bash
curl -sI -L "https://ehi.eclinicalworks.com/ehiexport/tableindex.html" -H 'User-Agent: Mozilla/5.0'
```

**Result**: Direct HTTP 200, no redirects.
- Content-Type: text/html
- Content-Length: 133604 bytes (131 KB)
- Last-Modified: Sat, 31 Jan 2026 02:04:46 GMT
- Server behind Azure Application Gateway (ApplicationGatewayAffinity cookie)
- No anti-bot protection encountered

### Step 2: Page examination

```bash
curl -sL "https://ehi.eclinicalworks.com/ehiexport/tableindex.html" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
wc -c /tmp/page.html  # 133604 bytes
```

The page is **static HTML** — no JavaScript SPA, no framework, no lazy loading. All content is present in the HTML source. The page renders without JavaScript.

**Page structure**:
- Title: "EHI Export Schema"
- Header paragraph citing 45 CFR §170.315(b)(10) certification
- Description paragraph explaining the documentation provides: table name, description, column names, column descriptions, data types, and primary keys
- Note about scanned documents being in a separate folder
- Note about datetime defaults ('1900-01-01' or '0000-00-00')
- Disclaimer about proprietary codes (CPT) and SSN sensitivity
- "Last reviewed: 01/27/2026"
- Alphabetical list of 1,466 hyperlinked table names, each linking to `tables/{tablename}.html`

### Step 3: Finding the EHI section

No navigation required. The registered URL IS the documentation index page. It's a dedicated EHI export documentation subdomain (ehi.eclinicalworks.com) purpose-built for this content.

### Step 4: Identified downloadable assets

No ZIP/PDF/XLSX downloads offered. The documentation is a set of 1,466 individual HTML pages:
- 1 index page: `tableindex.html`
- 1,466 table detail pages: `tables/{tablename}.html`

Each table page contains:
- Table name and description
- Column-level detail: column name, data type, description
- Primary key indicators where applicable

Example table page structure (allergies.html):
- Table: "allergies"
- Description: "This table stores information about patients' allergies, including the drug causing the allergy, the type of allergy, and its status."
- Columns with data types (int, varchar, smallint, char, etc.) and descriptions

No additional downloadable files (no ZIPs, no PDFs). No links to external resources beyond the eclinicalworks.com mandatory disclosures page.

### Step 5: No obstacles encountered

- No anti-bot protection
- No JavaScript required
- No login wall
- No accordion/hidden content
- No Cloudflare challenge
- curl with User-Agent header works perfectly
- All 1,466 table pages are directly accessible

## Downloads

### tableindex.html (131 KB)
```bash
curl -sL "https://ehi.eclinicalworks.com/ehiexport/tableindex.html" -H 'User-Agent: Mozilla/5.0' \
  -o /home/exedev/EHI/wiggum/results/eclinicalworks-llc/downloads/tableindex.html
```
Verified: HTML document, UTF-8 Unicode text, 133,604 bytes

### tables/ directory (1,466 HTML files, 8.3 MB total)
```bash
# Extract all table page URLs from the index
grep -oP 'href="tables/[^"]*\.html"' tableindex.html | sed 's/href="//;s/"//' | sort -u > table_pages.txt
# Prefix each with the base URL
sed 's|^|https://ehi.eclinicalworks.com/ehiexport/|' table_pages.txt > full_urls.txt
# Download all pages
wget -q --no-clobber -P tables/ -i full_urls.txt --header='User-Agent: Mozilla/5.0'
```
Verified: 1,466 HTML files downloaded, total size 8,520,274 bytes (8.1 MB)

## Obstacles & Notes

- **No obstacles at all.** This is one of the most accessible EHI export documentation sites. Dedicated subdomain, static HTML, no protection, complete content.
- The site sits behind Azure Application Gateway but presents no access issues.
- Last reviewed date is 01/27/2026, indicating active maintenance.
- The note about "scanned documents included in a separate folder" suggests the actual patient export includes a documents folder alongside the database tables, but no sample export is provided.
- The SSN sensitivity warning suggests the export includes raw PII without redaction.
