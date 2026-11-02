<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Aldi Scraper API by Piloterr – scrape Aldi data as JSON" width="100%"></a>
</p>

# Aldi Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Aldi Scraper API** lets you extract public data from Aldi as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Aldi Product API** — Aldi Product API: fetch full product page data from an Aldi URL or path slug.
- **Aldi Search API** — Aldi Search API: list products from an Aldi category page URL or path across FR, DE, NL and Canarias shops.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Aldi Product API](#aldi-product-api) | `/v2/aldi/product` | 1 | Aldi Product API |
| [Aldi Search API](#aldi-search-api) | `/v2/aldi/search` | 1 | Aldi Search API |

## Table of contents

- [How it works](#how-it-works)
- [Aldi Product API](#aldi-product-api)
- [Aldi Search API](#aldi-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Aldi Product API

Aldi Product API: fetch full product page data from an Aldi URL or path slug. Returns pricing, images, description, category and cooling flags.

`GET | POST https://api.piloterr.com/v2/aldi/product` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Aldi product page URL or site path slug. |
| `region` | string | — | Target country when `query` is a path only (default: `fr`). Ignored for full product URLs. |
| `return_page_source` | boolean | — | When `true`, return the raw HTML page source as `{"result": "..."}` instead of structured JSON. Defaults to `false`. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/aldi/product",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "fiches-produits/filets-danchois-marines-6806.html",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type AldiProduct = {
  url?: string;
  brand?: string;
  price?: number;
  title?: string;
  images?: string[];
  category?: string;
  currency?: string;
  image_url?: string;
  is_cooling?: boolean;
  product_id?: string;
  sales_unit?: string;
  description?: string;
  product_slug?: string;
  short_description?: string;
};

const params = new URLSearchParams({
  "query": "fiches-produits/filets-danchois-marines-6806.html",
});

const response = await fetch(`https://api.piloterr.com/v2/aldi/product?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as AldiProduct;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/aldi/product
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "fiches-produits/filets-danchois-marines-6806.html"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "url": "https://www.aldi.fr/fiches-produits/filets-danchois-marines-6806.html",
  "brand": "GOLDEN SEAFOOD®",
  "price": 1.99,
  "title": "FILETS D'ANCHOIS MARINÉS",
  "images": [
    "https://s7g10.scene7.com/is/image/aldinord/6806.main.1.fr_fr.All.anchois",
    "https://s7g10.scene7.com/is/image/aldinord/6806_FILETS_ANCHOIS_MARINES_AIL"
  ],
  "category": "73-poisson",
  "currency": "EUR",
  "image_url": "https://s7g10.scene7.com/is/image/aldinord/6806.main.1.fr_fr.All.anchois",
  "is_cooling": true,
  "product_id": "6806",
  "sales_unit": "100 g",
  "description": "Pêche durable selon le référentiel MSC.",
  "product_slug": "filets-danchois-marines-6806",
  "short_description": "Au choix : Nature, ail et persil ou à la provençale."
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `url` | string |  |
| `brand` | string |  |
| `price` | number |  |
| `title` | string |  |
| `images` | string[] |  |
| `category` | string |  |
| `currency` | string |  |
| `image_url` | string |  |
| `is_cooling` | boolean |  |
| `product_id` | string |  |
| `sales_unit` | string |  |
| `description` | string |  |
| `product_slug` | string |  |
| `short_description` | string |  |

## Aldi Search API

Aldi Search API: list products from an Aldi category page URL or path across FR, DE, NL and Canarias shops. Returns prices, thumbnails and pagination.

`GET | POST https://api.piloterr.com/v2/aldi/search` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Aldi category page URL or site path. |
| `region` | string | — | Target country when `query` is a path only (default: `fr`). |
| `page` | number | — | 1-based page number override (default: read from URL or `1`). |
| `return_page_source` | boolean | — | When `true`, return the raw HTML page source as `{"result": "..."}` instead of structured JSON. Defaults to `false`. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/aldi/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "produits/viande-poisson/poisson-crustace.html",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type AldiSearch = {
  results?: {
    url?: string;
    brand?: string;
    price?: number;
    title?: string;
    images?: string[];
    category?: string;
    currency?: string;
    image_url?: string;
    product_id?: string;
    sales_unit?: string;
    product_slug?: string;
    short_description?: string;
  }[];
  pagination?: {
    next?: unknown;
    page?: number;
    per_page?: number;
    total_pages?: number;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "produits/viande-poisson/poisson-crustace.html",
});

const response = await fetch(`https://api.piloterr.com/v2/aldi/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as AldiSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/aldi/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "produits/viande-poisson/poisson-crustace.html"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "url": "https://www.aldi.fr/fiches-produits/dos-de-cabillaud-9855.html",
      "brand": "GOLDEN SEAFOOD®",
      "price": 9.99,
      "title": "Dos de cabillaud",
      "images": [
        "https://s7g10.scene7.com/is/image/aldinord/9855.main.01.freezer.gp2024",
        "https://s7g10.scene7.com/is/image/aldinord/Label_peche_durable_msc"
      ],
      "category": "Viandes et poissons > Poissons et crustacés",
      "currency": "EUR",
      "image_url": "https://s7g10.scene7.com/is/image/aldinord/9855.main.01.freezer.gp2024",
      "product_id": "9855",
      "sales_unit": "540G",
      "product_slug": "dos-de-cabillaud-9855",
      "short_description": "Régalez-vous avec notre délicieux dos de cabillaud…"
    }
  ],
  "pagination": {
    "next": null,
    "page": 1,
    "per_page": 46,
    "total_pages": 1,
    "total_results": 46
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].url` | string |  |
| `results[].brand` | string |  |
| `results[].price` | number |  |
| `results[].title` | string |  |
| `results[].images` | string[] |  |
| `results[].category` | string |  |
| `results[].currency` | string |  |
| `results[].image_url` | string |  |
| `results[].product_id` | string |  |
| `results[].sales_unit` | string |  |
| `results[].product_slug` | string |  |
| `results[].short_description` | string |  |
| `pagination` | object |  |
| `pagination.next` | object |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.total_results` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Product | Search |
|---|---|---|
| cURL (Bash) | [`product`](examples/curl/product.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`product`](examples/php/product.php) | [`search`](examples/php/search.php) |
| C# | [`product`](examples/csharp/Product.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`product`](examples/go/product.go) | [`search`](examples/go/search.go) |
| Java | [`product`](examples/java/ProductExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`product`](examples/ruby/product.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`product`](examples/nodejs/product.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Aldi plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Aldi?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/aldi/product` **1**, `/v2/aldi/search` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Aldi API return?

Each endpoint returns structured JSON: **Aldi Product** — `url`, `brand`, `price`, `title`, `images`, `category`; **Aldi Search** — `results[]`, `results[].url`, `results[].brand`, `results[].price`, `results[].title`, `results[].images`.

### How do I paginate Aldi results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Can I target a specific country or language?

Yes, use `region` — see the parameter tables above for accepted values.

### Can I get the raw HTML instead of JSON?

Yes. Set `return_page_source=true` and the response becomes `{"result": "..."}` with the page source.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [Amazon Scraper API](https://github.com/piloterr/amazon-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Aldi is a trademark of its respective owner. This repository is not affiliated with or endorsed by Aldi. Examples are released under the MIT license.</sub>
