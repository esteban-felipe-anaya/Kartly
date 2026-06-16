// Generates db.json for the Kartly mock API from a REAL product dataset
// (DummyJSON), so every product has genuine e-commerce photos, titles, brands,
// descriptions, ratings and reviews — like a real store.
//
// Requires network access at seed time. Run: node generate-db.js (npm run seed)
const fs = require('fs');
const path = require('path');

const SOURCE = 'https://dummyjson.com/products?limit=0';

// Deterministic pseudo-random so generated orders/dates are stable.
let seed = 42;
function rng() {
  seed = (seed * 1103515245 + 12345) & 0x7fffffff;
  return seed / 0x7fffffff;
}
function pick(arr) {
  return arr[Math.floor(rng() * arr.length)];
}
function round2(n) {
  return Math.round(n * 100) / 100;
}

function titleCase(slug) {
  return slug
    .split('-')
    .map((w) => w.charAt(0).toUpperCase() + w.slice(1))
    .join(' ');
}

// Material icon names (consumed by the Flutter category shortcuts as a fallback
// when no category image is available).
const CATEGORY_ICONS = {
  beauty: 'face_retouching_natural',
  fragrances: 'spa',
  furniture: 'chair',
  groceries: 'shopping_basket',
  'home-decoration': 'home',
  'kitchen-accessories': 'kitchen',
  laptops: 'laptop',
  'mens-shirts': 'checkroom',
  'mens-shoes': 'checkroom',
  'mens-watches': 'watch',
  'mobile-accessories': 'headphones',
  motorcycle: 'two_wheeler',
  'skin-care': 'spa',
  smartphones: 'smartphone',
  'sports-accessories': 'sports_basketball',
  sunglasses: 'visibility',
  tablets: 'tablet_mac',
  tops: 'checkroom',
  vehicle: 'directions_car',
  'womens-bags': 'shopping_bag',
  'womens-dresses': 'checkroom',
  'womens-jewellery': 'diamond',
  'womens-shoes': 'checkroom',
  'womens-watches': 'watch',
};

function iconForSlug(slug) {
  return CATEGORY_ICONS[slug] || 'category';
}

function mapProduct(p) {
  const compareAtPrice = p.discountPercentage
    ? round2(p.price / (1 - p.discountPercentage / 100))
    : null;
  const images = (p.images && p.images.length ? p.images : [p.thumbnail])
    .filter(Boolean)
    .slice(0, 5);
  return {
    id: `prd_${p.id}`,
    title: p.title,
    brand: p.brand || p.title.split(' ')[0],
    categoryId: p.category,
    price: round2(p.price),
    compareAtPrice,
    currency: 'USD',
    rating: round2(p.rating || 0),
    reviewCount: (p.reviews && p.reviews.length) || 0,
    stock: p.stock ?? 0,
    popularity: Math.round((p.rating || 0) * 100 + (p.stock || 0)),
    createdAt: new Date(2025, (p.id % 12), 1 + (p.id % 27)).toISOString(),
    images,
    // The source has no variants; the UI gracefully shows none.
    variants: { color: [], size: [] },
    description: p.description || '',
    tags: p.tags || [],
  };
}

async function main() {
  console.log(`Fetching real products from ${SOURCE} ...`);
  const res = await fetch(SOURCE);
  if (!res.ok) throw new Error(`Failed to fetch products: HTTP ${res.status}`);
  const data = await res.json();
  const source = data.products || [];
  if (source.length === 0) throw new Error('No products returned from source');

  const products = source.map(mapProduct);

  // Reviews: use the dataset's real reviews.
  const reviews = [];
  let reviewId = 1;
  for (const p of source) {
    for (const r of p.reviews || []) {
      reviews.push({
        id: `rev_${reviewId++}`,
        productId: `prd_${p.id}`,
        user: r.reviewerName || 'Anonymous',
        rating: r.rating,
        comment: r.comment,
        date: r.date,
      });
    }
  }

  // Categories: one per distinct category, imaged with a representative product.
  const catImage = new Map();
  for (const p of products) {
    if (!catImage.has(p.categoryId) && p.images[0]) {
      catImage.set(p.categoryId, p.images[0]);
    }
  }
  const categories = [...catImage.keys()].sort().map((slug) => ({
    id: slug,
    name: titleCase(slug),
    icon: iconForSlug(slug),
    image: catImage.get(slug),
  }));

  // Banners: feature a few real products.
  function featured(slug, fallbackIndex) {
    return products.find((p) => p.categoryId === slug) || products[fallbackIndex];
  }
  const bannerSpecs = [
    { slug: 'smartphones', title: 'Latest Smartphones', subtitle: 'Flagship phones at sharp prices' },
    { slug: 'laptops', title: 'Work From Anywhere', subtitle: 'Powerful laptops & tablets' },
    { slug: 'fragrances', title: 'Signature Scents', subtitle: 'Fragrances they will remember' },
    { slug: 'sunglasses', title: 'Summer Styles', subtitle: 'Sunglasses & seasonal picks' },
  ];
  const banners = bannerSpecs.map((b, i) => {
    const p = featured(b.slug, i);
    return {
      id: `ban_${i + 1}`,
      title: b.title,
      subtitle: b.subtitle,
      image: p.images[0],
      ctaProductId: p.id,
    };
  });

  const user = {
    id: 'usr_1',
    name: 'Jamie Rivera',
    email: 'demo@kartly.app',
    password: 'password123',
    avatar: 'https://i.pravatar.cc/200?img=12',
  };

  const addresses = [
    { id: 'adr_1', userId: 'usr_1', label: 'Home', fullName: 'Jamie Rivera', line1: '742 Evergreen Terrace', line2: 'Apt 3', city: 'Springfield', state: 'OR', postalCode: '97477', country: 'USA', phone: '+1 555 0101', isDefault: true },
    { id: 'adr_2', userId: 'usr_1', label: 'Work', fullName: 'Jamie Rivera', line1: '500 Market Street', line2: 'Suite 1200', city: 'Portland', state: 'OR', postalCode: '97204', country: 'USA', phone: '+1 555 0199', isDefault: false },
  ];

  // Past orders built from real products.
  const orderStatuses = ['placed', 'packed', 'shipped', 'delivered'];
  const orders = [];
  for (let i = 1; i <= 5; i++) {
    const itemCount = 1 + Math.floor(rng() * 3);
    const items = [];
    let subtotal = 0;
    for (let j = 0; j < itemCount; j++) {
      const p = pick(products);
      const qty = 1 + Math.floor(rng() * 2);
      subtotal += p.price * qty;
      items.push({
        productId: p.id,
        title: p.title,
        image: p.images[0],
        variant: {},
        qty,
        priceAtAdd: p.price,
      });
    }
    const shipping = 9.99;
    const tax = round2(subtotal * 0.08);
    const total = round2(subtotal + shipping + tax);
    const statusIndex = Math.min(
      orderStatuses.length - 1,
      Math.floor(rng() * orderStatuses.length),
    );
    orders.push({
      id: `ord_${1000 + i}`,
      userId: 'usr_1',
      items,
      addressId: 'adr_1',
      shippingMethod: 'standard',
      paymentMethod: 'card',
      promo: null,
      subtotal: round2(subtotal),
      discount: 0,
      shipping,
      tax,
      total,
      status: orderStatuses[statusIndex],
      timeline: orderStatuses.slice(0, statusIndex + 1).map((s, idx) => ({
        status: s,
        date: new Date(2026, 4, 1 + i + idx).toISOString(),
      })),
      createdAt: new Date(2026, 4, 1 + i).toISOString(),
    });
  }

  const notifications = [
    { id: 'ntf_1', title: 'Order delivered', body: 'Your order ord_1001 was delivered. Enjoy!', read: false, date: new Date(2026, 5, 14).toISOString() },
    { id: 'ntf_2', title: 'Flash sale started', body: 'Top categories up to 40% off for 24 hours.', read: false, date: new Date(2026, 5, 13).toISOString() },
    { id: 'ntf_3', title: 'Back in stock', body: 'An item on your wishlist is available again.', read: true, date: new Date(2026, 5, 11).toISOString() },
    { id: 'ntf_4', title: 'Welcome to Kartly', body: 'Thanks for joining. Here is 10% off your first order: WELCOME10.', read: true, date: new Date(2026, 5, 1).toISOString() },
    { id: 'ntf_5', title: 'Order shipped', body: 'Your order ord_1004 is on its way.', read: false, date: new Date(2026, 5, 10).toISOString() },
    { id: 'ntf_6', title: 'Price drop', body: 'A product you viewed just dropped in price.', read: true, date: new Date(2026, 5, 8).toISOString() },
  ];

  const promos = [
    { code: 'WELCOME10', discountPct: 10 },
    { code: 'SAVE20', discountPct: 20 },
    { code: 'KARTLY15', discountPct: 15 },
  ];

  const db = {
    users: [user],
    banners,
    categories,
    products,
    reviews,
    cart: { id: 'cart_1', userId: 'usr_1', items: [], promo: null },
    wishlist: [],
    addresses,
    orders,
    notifications,
    promos,
  };

  fs.writeFileSync(path.join(__dirname, 'db.json'), JSON.stringify(db, null, 2));
  console.log(
    `Seeded db.json: ${products.length} real products, ${categories.length} categories, ` +
      `${reviews.length} reviews, ${orders.length} orders.`,
  );
}

main().catch((err) => {
  console.error('Seeding failed:', err.message);
  process.exit(1);
});
