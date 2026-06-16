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

`generate-db.js` produces deterministic seed data: 1 user, 6 categories, ~35 products (multiple
images, variants, ratings, stock), ~118 reviews, 4 banners, an empty cart, 2 addresses, 5 past
orders, 6 notifications, and 3 promo codes.

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
