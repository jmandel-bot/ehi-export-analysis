# Stage 1: Fetch Export Documentation URLs from CHPL

You are fetching EHI export documentation URLs from the ONC CHPL API for a batch
of certified health IT products.

## Context

Under 170.315(b)(10), certified EHR vendors must publish documentation about their
Electronic Health Information (EHI) export capability. Each certified product listing
in CHPL contains an `exportDocumentation` field with a URL to this documentation.

The CHPL API key is: `12909a978483dfb8ecd0596c98ae9094`

## Your Batch

Your batch file is at: `{{BATCH_FILE}}`

It contains a JSON array of objects with `{id, developer, product}` for each
CHPL listing you need to fetch.

## Task

For each listing ID in your batch:

1. Fetch the details:
   ```
   curl -s "https://chpl.healthit.gov/rest/certified_products/{{ID}}/details" \
     -H 'accept: application/json' \
     -H 'api-key: 12909a978483dfb8ecd0596c98ae9094'
   ```

2. Extract from the response:
   - `.certificationResults[] | select(.criterion.number == "170.315 (b)(10)")` 
   - The `exportDocumentation` field (the URL we want)
   - The `success` field (whether they passed certification)
   - Any `additionalSoftware` listed

3. Add a 0.3s delay between requests to be polite to the API.

## Output

Write results to: `{{OUTPUT_FILE}}`

Format: JSON array of objects:
```json
[
  {
    "chpl_id": 12345,
    "developer": "Vendor Name",
    "product": "Product Name",
    "export_documentation_url": "https://...",
    "b10_success": true,
    "additional_software": ["InterSystems IRIS 2022.1.4"]
  }
]
```

If a fetch fails, include the entry with `"export_documentation_url": null` and
add an `"error"` field describing what happened. Don't let one failure stop the batch.

## Important

- Some products may not have the b(10) criterion at all (edge case) — record as null
- The API occasionally returns HTML instead of JSON — retry once if this happens
- Save the raw JSON responses to `{{RAW_DIR}}/{{ID}}-details.json` as a cache
