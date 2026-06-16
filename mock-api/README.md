# Kartly Mock API

A custom [json-server](https://github.com/typicode/json-server) backend implementing the full
Kartly API contract (auth, products with filtering/sort/paging, cart, promos, wishlist,
addresses, orders, notifications).

## Run

```bash
cd mock-api
npm install          # first time only
npm run dev          # re-seeds db.json then starts the server
# or, separately:
npm run seed         # regenerate db.json
npm start            # start the server on http://localhost:3000
```

Set a different port with `PORT=4000 npm start`.

## Seed data

`generate-db.js` builds the catalog from a **real product dataset**
([DummyJSON](https://dummyjson.com/products)) so every product has genuine e-commerce photos,
titles, brands, descriptions, ratings and reviews — like a real store. It fetches ~194 products
across 24 categories with ~580 real reviews, then adds 1 user, 4 banners, an empty cart, 2
addresses, 5 deterministic past orders, 6 notifications, and 3 promo codes.

> **Note:** seeding requires network access (it fetches from DummyJSON). The product images are
> served from `cdn.dummyjson.com`, so the device running the app also needs internet to load them.
> Re-run `npm run seed` (or `npm run dev`) any time to refresh `db.json`.

- **Demo login:** `demo@kartly.app` / `password123`
- **Promo codes:** `WELCOME10` (10%), `KARTLY15` (15%), `SAVE20` (20%)

## Endpoints

| Method | Path | Notes |
|--------|------|-------|
| POST | `/auth/login` | `{ token, user }` |
| POST | `/auth/register` | `{ token, user }` |
| GET | `/auth/me` | requires `Authorization: Bearer <token>` |
| GET | `/banners` | |
| GET | `/categories` | |
| GET | `/products` | `?categoryId=&q=&minPrice=&maxPrice=&minRating=&brand=&sort=&_page=&_limit=` |
| GET | `/products/:id` | |
| GET | `/products/:id/reviews` | |
| GET | `/cart` | single cart object |
| POST | `/cart/items` | add / merge line item |
| PATCH | `/cart/items/:id` | change quantity |
| DELETE | `/cart/items/:id` | remove line item |
| POST | `/promo/validate` | `{ code, valid, discountPct }` |
| GET/POST/DELETE | `/wishlist`, `/wishlist/:productId` | |
| GET/POST/PUT/DELETE | `/addresses`, `/addresses/:id` | |
| POST/GET | `/orders`, `/orders/:id` | order is computed + cart cleared on POST |
| GET | `/notifications` | |

`sort` accepts: `price_asc`, `price_desc`, `rating`, `newest`, `popularity`.
