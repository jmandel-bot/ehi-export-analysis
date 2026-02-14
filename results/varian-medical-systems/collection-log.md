# Varian Medical Systems — EHI Export Documentation Collection

Collected: 2025-07-14

## Source
- Registered URL: https://varian.com/aria/ehi
- CHPL IDs: 11719 (ARIA CORE 18.3), 11747 (Noona 10)
- Developer: Varian Medical Systems (subsidiary of Siemens Healthineers)

## Navigation Journal

### Step 1: Initial probe
```bash
curl -sI -L "https://varian.com/aria/ehi" -H 'User-Agent: Mozilla/5.0'
```
Result:
- **301** redirect from `https://varian.com/aria/ehi` → `https://cancercare.siemens-healthineers.com/aria/ehi`
- **404** at the final URL
- Content-Type: text/html; charset=UTF-8
- Server: Drupal 11 (Varnish cache)

The registered URL redirects to Siemens Healthineers' Cancer Care domain (Varian was acquired by Siemens Healthineers in 2021), but the destination path does not exist.

### Step 2: Page examination
```bash
curl -sL "https://cancercare.siemens-healthineers.com/aria/ehi" -H 'User-Agent: Mozilla/5.0' -o /tmp/page.html
```
The page is a Drupal 11 "Page not found" error page (136 KB of HTML). The 404 page says:
> "Even a Klystron isn't going to help you find the page for which you were looking."

With alternate recommendations linking to Home and Search.

### Step 3: Checking Wayback Machine
```bash
curl -s "http://web.archive.org/cdx/search/cdx?url=varian.com/aria/ehi*&output=text&limit=20"
curl -s "http://web.archive.org/cdx/search/cdx?url=cancercare.siemens-healthineers.com/aria/ehi*&output=text&limit=20"
curl -s "http://web.archive.org/cdx/search/cdx?url=varian.com/*ehi*&output=text&limit=30"
curl -s "http://web.archive.org/cdx/search/cdx?url=cancercare.siemens-healthineers.com/*ehi*&output=text&limit=30"
```
All queries returned **zero results**. The Wayback Machine has never captured this URL or any EHI-related URL on either domain. This suggests the page may never have been publicly available, or was created very recently and taken down before any archival.

### Step 4: Probing alternative paths on cancercare.siemens-healthineers.com
Tested multiple alternative paths:
```
404 /aria/ehi
404 /ehi
404 /ehi-export
200 /interoperability  (but redirects to /products/interoperability - hardware interop, no EHI content)
404 /compliance
404 /legal
404 /onc
404 /b10
200 /aria  (product page - no EHI content)
200 /products/software  (software listing - no EHI content)
```

### Step 5: Examining the /products/interoperability page
Navigated to `https://cancercare.siemens-healthineers.com/products/interoperability` in browser. Content is about hardware interoperability — Patient Motion Management (MMI interface), Practice Management (ARIA API for third-party integrations), Treatment Delivery (VTI interface), and industry standards (IHE, DICOM). **No mention of EHI export, ONC certification, b(10), or electronic health information export.**

### Step 6: Examining the ARIA CORE product page
```bash
curl -sL "https://cancercare.siemens-healthineers.com/products/software/digital-oncology/oncology-management-systems/aria-core" -H 'User-Agent: Mozilla/5.0'
```
Grepped for EHI/export/certification keywords. Only mentions "Interoperability" in passing. No links to EHI export documentation.

### Step 7: Checking Legal Information and Government Affairs pages
- `/about-us/legal-information` — Contains sub-pages for EU REACH, Intended Use, Copyright, Trademarks, Patents, etc. No EHI content.
- `/about-us/government-affairs` — About government lobbying and reimbursement/Medicare policy. No EHI or ONC certification content.

### Step 8: Checking the Siemens Healthineers compliance page
```bash
curl -sL "https://www.siemens-healthineers.com/company/compliance" -H 'User-Agent: Mozilla/5.0'
```
This is about anti-corruption, business conduct guidelines, supply chain due diligence. No health IT certification or EHI content.

### Step 9: Sitemap analysis
```bash
curl -sL "https://cancercare.siemens-healthineers.com/sitemap.xml"
```
The sitemap contains only 13 URLs — all just locale variants of the homepage. The sitemap does not index any inner pages, making it impossible to discover content through this mechanism.

### Step 10: Site search
Attempted the site's built-in search at `/search?keys=EHI+export`. The search is a Drupal JS-driven widget that requires client-side interaction. The search page loads at `/node/390` but returns "Start typing to search" with no results pre-populated.

### Step 11: Checking subdomains
- `d8-prod.varian.com` — Returns 401 (password-protected staging/production Drupal site)
- `go.varian.com` — Marketing automation domain; redirects all paths to the homepage
- `www.myvarian.com` — Customer portal requiring login (Salesforce-based); returns 302 to login page
- `webapps.varian.com` — Certificate manager, requires login

### Step 12: Web search
- DuckDuckGo: `site:varian.com "EHI export" ARIA` — No results
- DuckDuckGo: `varian ARIA "electronic health information" export "b(10)"` — No results
- DuckDuckGo: `site:cancercare.siemens-healthineers.com EHI` — No EHI-related results (only homepage, login page, customer services, Eclipse)
- DuckDuckGo: `varian "EHI export" ARIA "data dictionary"` — Results are all for other vendors (Aarista, Flatiron, Sightview), not Varian
- Bing: `"varian.com/aria/ehi"` — No relevant results; only generic Varian pages
- Google: Blocked by CAPTCHA

### Step 13: Checking siemens-healthineers.com paths
```
404 https://www.siemens-healthineers.com/ehi
404 https://www.siemens-healthineers.com/aria/ehi
404 https://www.siemens-healthineers.com/products/aria/ehi
404 https://www.siemens-healthineers.com/ehi-export
```

### Step 14: Checking cybersecurity and resources pages
- `/resources-support/cybersecurity-at-varian` — No EHI, export, or certification content
- `/resources-support` — No downloadable PDFs or documents related to EHI export

## Downloads

No EHI export documentation files were found.

### 404-page-screenshot.png (294 KB)
Screenshot of the 404 page at the registered URL.
Saved to: downloads/404-page-screenshot.png
Content: Browser screenshot showing "Page not found" error at https://cancercare.siemens-healthineers.com/aria/ehi

## Access Summary
- Registered URL: https://varian.com/aria/ehi
- Final URL (after redirect): https://cancercare.siemens-healthineers.com/aria/ehi
- Status: **dead** (404 after redirect)
- Required browser: No (curl confirmed 404)
- Navigation complexity: N/A — page does not exist
- Anti-bot issues: TrustArc cookie consent banner on all pages (cosmetic only, does not block content)

## Obstacles & Dead Ends

### The URL has never existed
The registered CHPL URL `https://varian.com/aria/ehi` returns 404. More significantly:
- The Wayback Machine has **zero captures** of this URL or any EHI-related URL on varian.com or cancercare.siemens-healthineers.com
- No web search engine has indexed any EHI export documentation from Varian
- The cancercare.siemens-healthineers.com sitemap indexes only the homepage (13 locale variants)
- The `d8-prod.varian.com` staging server is password-protected (401)

This strongly suggests the EHI export documentation page was **never created** or was created and immediately taken down before any archival. The URL may have been registered with CHPL in anticipation of creating the page.

### Domain transition complicates discovery
Varian was acquired by Siemens Healthineers, and the varian.com domain now redirects to cancercare.siemens-healthineers.com. The path `/aria/ehi` was presumably planned for the new domain but was never set up.

### Customer portal may contain documentation
The MyVarian portal (www.myvarian.com) is a Salesforce-based customer portal requiring login. It's possible that EHI export documentation exists behind this login wall, but this would violate the ONC requirement that EHI export documentation be publicly accessible. This is a significant compliance concern.

### Certification dates
- ARIA CORE (CHPL 11719): Certified 2025-11-26 — CHPL product number `15.04.04.2496.ARIA.18.08.1.251126`
- Noona (CHPL 11747): Certified 2026-01-01 — CHPL product number `15.04.04.2496.Noon.10.05.0.260101`

Both certifications are very recent. The documentation may not yet have been published at the registered URL.

## Conclusion
**No EHI export documentation was found.** The registered URL returns 404, no alternative locations were discovered on any Varian or Siemens Healthineers domain, and no cached/archived version exists. This represents a compliance gap — certified EHR products are required to make their EHI export documentation publicly accessible at the URL registered with CHPL.
