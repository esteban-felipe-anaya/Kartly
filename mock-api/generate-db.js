// Generates db.json with realistic seed data for the Kartly mock API.
// Run: node generate-db.js  (or `npm run seed`)
const fs = require('fs');
const path = require('path');

const categories = [
  { id: 'cat_audio', name: 'Audio', icon: 'headphones', image: 'https://picsum.photos/seed/cat_audio/400' },
  { id: 'cat_wearables', name: 'Wearables', icon: 'watch', image: 'https://picsum.photos/seed/cat_wearables/400' },
  { id: 'cat_computers', name: 'Computers', icon: 'laptop', image: 'https://picsum.photos/seed/cat_computers/400' },
  { id: 'cat_phones', name: 'Phones', icon: 'smartphone', image: 'https://picsum.photos/seed/cat_phones/400' },
  { id: 'cat_home', name: 'Smart Home', icon: 'home', image: 'https://picsum.photos/seed/cat_home/400' },
  { id: 'cat_gaming', name: 'Gaming', icon: 'sports_esports', image: 'https://picsum.photos/seed/cat_gaming/400' },
];

const brandsByCat = {
  cat_audio: ['Auralis', 'SonicWave', 'BassForge'],
  cat_wearables: ['PulseFit', 'Chrona', 'VitaBand'],
  cat_computers: ['Nimbus', 'CoreLeaf', 'Quanta'],
  cat_phones: ['Lumen', 'Strato', 'Pixela'],
  cat_home: ['Hearthly', 'Aura', 'Nestify'],
  cat_gaming: ['Voltage', 'ArenaX', 'NitroPlay'],
};

const namesByCat = {
  cat_audio: ['Wireless Noise-Cancelling Headphones', 'True Wireless Earbuds', 'Portable Bluetooth Speaker', 'Studio Over-Ear Headphones', 'Open-Ear Sport Earbuds', 'Hi-Fi Bookshelf Speaker', 'Gaming Headset'],
  cat_wearables: ['Smart Fitness Watch', 'Health Tracker Band', 'GPS Running Watch', 'Hybrid Smartwatch', 'Sleep Tracking Ring'],
  cat_computers: ['Ultrabook 14"', 'Creator Laptop 16"', 'Mechanical Keyboard', 'Wireless Mouse', '4K Monitor 27"', 'USB-C Docking Station'],
  cat_phones: ['Flagship Smartphone', 'Compact Phone', 'Rugged Outdoor Phone', 'Foldable Phone', 'Budget Smartphone'],
  cat_home: ['Smart Thermostat', 'Robot Vacuum', 'Smart Doorbell', 'Smart Bulb 4-Pack', 'Air Purifier', 'Smart Plug'],
  cat_gaming: ['Wireless Game Controller', 'Handheld Console', 'RGB Gaming Mouse', 'Streaming Capture Card', 'VR Headset', 'Arcade Fight Stick'],
};

const colorOptions = ['Black', 'Silver', 'Midnight Blue', 'Graphite', 'White', 'Sage'];
const sizeOptions = ['S', 'M', 'L', 'XL'];

const descriptions = [
  'Engineered for everyday excellence with premium materials and all-day comfort.',
  'A refined design meets powerful performance in a package built to last.',
  'Crafted for people who expect more — reliable, fast, and beautifully made.',
  'Cutting-edge technology wrapped in a minimal, modern aesthetic.',
  'Long battery life, seamless connectivity, and a finish that feels great in hand.',
];

// Deterministic pseudo-random so seeds are stable.
let seed = 42;
function rng() {
  seed = (seed * 1103515245 + 12345) & 0x7fffffff;
  return seed / 0x7fffffff;
}
function pick(arr) { return arr[Math.floor(rng() * arr.length)]; }
function round2(n) { return Math.round(n * 100) / 100; }

const products = [];
let counter = 1000;
for (const cat of categories) {
  const names = namesByCat[cat.id];
  // ~6-7 products per category -> ~40 total
  for (let i = 0; i < names.length; i++) {
    counter += 1;
    const id = `prd_${counter}`;
    const price = round2(29 + rng() * 470);
    const hasDiscount = rng() > 0.45;
    const compareAtPrice = hasDiscount ? round2(price * (1.1 + rng() * 0.4)) : null;
    const rating = round2(3.5 + rng() * 1.5);
    const hasColors = rng() > 0.3;
    const hasSizes = cat.id === 'cat_wearables' || rng() > 0.7;
    products.push({
      id,
      title: names[i],
      brand: pick(brandsByCat[cat.id]),
      categoryId: cat.id,
      price,
      compareAtPrice,
      currency: 'USD',
      rating,
      reviewCount: Math.floor(20 + rng() * 600),
      stock: Math.floor(rng() * 80),
      popularity: Math.floor(rng() * 1000),
      createdAt: new Date(2025, 0, 1 + Math.floor(rng() * 300)).toISOString(),
      images: [
        `https://picsum.photos/seed/${id}a/600`,
        `https://picsum.photos/seed/${id}b/600`,
        `https://picsum.photos/seed/${id}c/600`,
      ],
      variants: {
        color: hasColors ? colorOptions.slice(0, 2 + Math.floor(rng() * 3)) : [],
        size: hasSizes ? sizeOptions.slice(0, 2 + Math.floor(rng() * 3)) : [],
      },
      description: `${pick(descriptions)} ${pick(descriptions)}`,
    });
  }
}

const reviewAuthors = ['Alex M.', 'Priya S.', 'Jordan L.', 'Mei C.', 'Tom B.', 'Sara K.', 'Diego R.', 'Nina P.'];
const reviewComments = [
  'Exceeded my expectations. Would buy again.',
  'Solid build quality and great value for the price.',
  'Works perfectly, shipping was fast.',
  'Good overall but the battery could be better.',
  'Absolutely love it — highly recommend!',
  'Decent product, does what it promises.',
];
const reviews = [];
let reviewId = 1;
for (const p of products) {
  const n = 2 + Math.floor(rng() * 4);
  for (let i = 0; i < n; i++) {
    reviews.push({
      id: `rev_${reviewId++}`,
      productId: p.id,
      user: pick(reviewAuthors),
      rating: Math.max(1, Math.min(5, Math.round(p.rating + (rng() - 0.5) * 2))),
      comment: pick(reviewComments),
      date: new Date(2025, Math.floor(rng() * 12), 1 + Math.floor(rng() * 27)).toISOString(),
    });
  }
}

const banners = [
  { id: 'ban_1', title: 'Summer Audio Sale', subtitle: 'Up to 40% off headphones & speakers', image: 'https://picsum.photos/seed/banner1/1200/500', ctaProductId: products.find(p => p.categoryId === 'cat_audio').id },
  { id: 'ban_2', title: 'New Wearables', subtitle: 'Track every move in style', image: 'https://picsum.photos/seed/banner2/1200/500', ctaProductId: products.find(p => p.categoryId === 'cat_wearables').id },
  { id: 'ban_3', title: 'Work From Anywhere', subtitle: 'Laptops & desk gear that keep up', image: 'https://picsum.photos/seed/banner3/1200/500', ctaProductId: products.find(p => p.categoryId === 'cat_computers').id },
  { id: 'ban_4', title: 'Level Up', subtitle: 'Gaming gear for every player', image: 'https://picsum.photos/seed/banner4/1200/500', ctaProductId: products.find(p => p.categoryId === 'cat_gaming').id },
];

const user = {
  id: 'usr_1',
  name: 'Jamie Rivera',
  email: 'demo@kartly.app',
  password: 'password123',
  avatar: 'https://picsum.photos/seed/avatar/200',
};

const addresses = [
  { id: 'adr_1', userId: 'usr_1', label: 'Home', fullName: 'Jamie Rivera', line1: '742 Evergreen Terrace', line2: 'Apt 3', city: 'Springfield', state: 'OR', postalCode: '97477', country: 'USA', phone: '+1 555 0101', isDefault: true },
  { id: 'adr_2', userId: 'usr_1', label: 'Work', fullName: 'Jamie Rivera', line1: '500 Market Street', line2: 'Suite 1200', city: 'Portland', state: 'OR', postalCode: '97204', country: 'USA', phone: '+1 555 0199', isDefault: false },
];

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
    items.push({ productId: p.id, title: p.title, image: p.images[0], variant: {}, qty, priceAtAdd: p.price });
  }
  const shipping = 9.99;
  const tax = round2(subtotal * 0.08);
  const total = round2(subtotal + shipping + tax);
  const statusIndex = Math.min(orderStatuses.length - 1, Math.floor(rng() * orderStatuses.length));
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
  { id: 'ntf_2', title: 'Flash sale started', body: 'Audio gear up to 40% off for 24 hours.', read: false, date: new Date(2026, 5, 13).toISOString() },
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
console.log(`Seeded db.json: ${products.length} products, ${reviews.length} reviews, ${orders.length} orders.`);
