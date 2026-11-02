#!/usr/bin/env bash
# Aldi Product API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./product.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/aldi/product" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=fiches-produits/filets-danchois-marines-6806.html
