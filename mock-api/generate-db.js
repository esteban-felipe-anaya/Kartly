// Generates db.json with realistic seed data for the Kartly mock API.
// Run: node generate-db.js  (or `npm run seed`)
const fs = require('fs');
const path = require('path');

// Real, type-matched product photos. These are curated Unsplash CDN image ids
// (each verified to resolve) grouped by product type, so e.g. headphones
// products actually show photos of headphones.
const IMAGE_GROUPS = {
  headphones: ['1505740420928-5e560c06d30e', '1484704849700-f032a568e944', '1583394838336-acd977736f90', '1546435770-a3e426bf472b', '1599669454699-248893623440', '1618366712010-f4ae9c647dcb'],
  earbuds: ['1590658268037-6bf12165a8df', '1606220588913-b3aacb4d2f46', '1631867675167-90a456a90863', '1608156639585-b3a032ef9689'],
  speaker: ['1608043152269-423dbba4e7e1', '1545454675-3531b543be5d', '1589003077984-894e133dabab', '1558537348-c0f8e733989d'],
  smartwatch: ['1523275335684-37898b6baf30', '1579586337278-3befd40fd17a', '1546868871-7041f2a55e12', '1551816230-ef5deaed4a26', '1434493789847-2f02dc6ca35d'],
  laptop: ['1496181133206-80ce9b88a853', '1517336714731-489689fd1ca8', '1593642632823-8f785ba67e45', '1541807084-5c52b6b3adef'],
  keyboard: ['1587829741301-dc798b83add3', '1618384887929-16ec33fab9ef', '1595044426077-d36d9236d54a'],
  mouse: ['1527814050087-3793815479db', '1615663245857-ac93bb7c39e7', '1605773527852-c546a8584ea3'],
  monitor: ['1527443224154-c4a3942d3acf', '1593305841991-05c297ba4575', '1640955014216-75201056c829'],
  smartphone: ['1511707171634-5f897ff02aa9', '1592750475338-74b7b21085ab', '1598327105666-5b89351aff97', '1580910051074-3eb694886505', '1510557880182-3d4d3cba35a5'],
  gaming: ['1592840496694-26d035b52b48', '1606318801954-d46d46d3360a', '1580327344181-c1163234e5a0', '1605901309584-818e25960a8f', '1486401899868-0e435ed85128'],
  smarthome: ['1558002038-1055907df827', '1585060544812-6b45742d762f', '1556228453-efd6c1ff04f6', '1593784991095-a205069470b6'],
};

function unsplash(id, w, h) {
  const crop = h ? `&h=${h}` : '';
  return `https://images.unsplash.com/photo-${id}?auto=format&fit=crop&w=${w}${crop}&q=80`;
}

/// Maps a product to an image group from its name (preferred) or category.
function groupFor(name, categoryId) {
  const n = name.toLowerCase();
  if (n.includes('headphone') || n.includes('headset')) return 'headphones';
  if (n.includes('earbud')) return 'earbuds';
  if (n.includes('speaker')) return 'speaker';
  if (n.includes('keyboard')) return 'keyboard';
  if (n.includes('mouse')) return 'mouse';
  if (n.includes('monitor')) return 'monitor';
  if (n.includes('laptop') || n.includes('ultrabook') || n.includes('dock')) return 'laptop';
  switch (categoryId) {
    case 'cat_audio': return 'headphones';
    case 'cat_wearables': return 'smartwatch';
    case 'cat_computers': return 'laptop';
    case 'cat_phones': return 'smartphone';
    case 'cat_home': return 'smarthome';
    case 'cat_gaming': return 'gaming';
    default: return 'smartphone';
  }
}

/// Three rotated photos for a product (varied across products in the same group).
function productImages(name, categoryId, offset) {
  const group = IMAGE_GROUPS[groupFor(name, categoryId)];
  const start = offset % group.length;
  const rotated = group.slice(start).concat(group.slice(0, start));
  return rotated.slice(0, 3).map((id) => unsplash(id, 600));
}

const CATEGORY_GROUP = {
  cat_audio: 'headphones',
  cat_wearables: 'smartwatch',
  cat_computers: 'laptop',
  cat_phones: 'smartphone',
  cat_home: 'smarthome',
  cat_gaming: 'gaming',
};

function categoryImage(id) {
  return unsplash(IMAGE_GROUPS[CATEGORY_GROUP[id]][0], 400, 400);
}

const categories = [
  { id: 'cat_audio', name: 'Audio', icon: 'headphones', image: categoryImage('cat_audio') },
  { id: 'cat_wearables', name: 'Wearables', icon: 'watch', image: categoryImage('cat_wearables') },
  { id: 'cat_computers', name: 'Computers', icon: 'laptop', image: categoryImage('cat_computers') },
  { id: 'cat_phones', name: 'Phones', icon: 'smartphone', image: categoryImage('cat_phones') },
  { id: 'cat_home', name: 'Smart Home', icon: 'home', image: categoryImage('cat_home') },
  { id: 'cat_gaming', name: 'Gaming', icon: 'sports_esports', image: categoryImage('cat_gaming') },
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
      images: productImages(names[i], cat.id, counter),
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
  { id: 'ban_1', title: 'Summer Audio Sale', subtitle: 'Up to 40% off headphones & speakers', image: unsplash(IMAGE_GROUPS.headphones[1], 1200, 500), ctaProductId: products.find(p => p.categoryId === 'cat_audio').id },
  { id: 'ban_2', title: 'New Wearables', subtitle: 'Track every move in style', image: unsplash(IMAGE_GROUPS.smartwatch[1], 1200, 500), ctaProductId: products.find(p => p.categoryId === 'cat_wearables').id },
  { id: 'ban_3', title: 'Work From Anywhere', subtitle: 'Laptops & desk gear that keep up', image: unsplash(IMAGE_GROUPS.laptop[2], 1200, 500), ctaProductId: products.find(p => p.categoryId === 'cat_computers').id },
  { id: 'ban_4', title: 'Level Up', subtitle: 'Gaming gear for every player', image: unsplash(IMAGE_GROUPS.gaming[1], 1200, 500), ctaProductId: products.find(p => p.categoryId === 'cat_gaming').id },
];

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
