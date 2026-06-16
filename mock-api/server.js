// Custom json-server for Kartly.
// Implements the full API contract: auth, products with filtering, cart, promo,
// wishlist, addresses, orders, notifications.
// Run: node server.js  (or `npm start`).  Seed first with `npm run seed`.
const jsonServer = require('json-server');
const path = require('path');

const server = jsonServer.create();
const router = jsonServer.router(path.join(__dirname, 'db.json'));
const db = router.db; // lowdb instance
const middlewares = jsonServer.defaults();

const PORT = process.env.PORT || 3000;
const TOKEN = 'mock-jwt-token-kartly';

server.use(middlewares);
server.use(jsonServer.bodyParser);

function publicUser(u) {
  if (!u) return null;
  const { password, ...rest } = u;
  return rest;
}

// ---- Auth -----------------------------------------------------------------
server.post('/auth/login', (req, res) => {
  const { email, password } = req.body || {};
  const user = db.get('users').find({ email }).value();
  if (!user || (password && user.password !== password)) {
    return res.status(401).jsonp({ message: 'Invalid email or password' });
  }
  res.jsonp({ token: TOKEN, user: publicUser(user) });
});

server.post('/auth/register', (req, res) => {
  const { name, email, password } = req.body || {};
  if (!email || !password) {
    return res.status(400).jsonp({ message: 'Email and password are required' });
  }
  const existing = db.get('users').find({ email }).value();
  if (existing) {
    return res.status(409).jsonp({ message: 'Email already registered' });
  }
  const user = {
    id: `usr_${Date.now()}`,
    name: name || 'New User',
    email,
    password,
    avatar: 'https://picsum.photos/seed/newuser/200',
  };
  db.get('users').push(user).write();
  res.status(201).jsonp({ token: TOKEN, user: publicUser(user) });
});

server.get('/auth/me', (req, res) => {
  const auth = req.headers.authorization || '';
  if (!auth.includes(TOKEN)) return res.status(401).jsonp({ message: 'Unauthorized' });
  const user = db.get('users').first().value();
  res.jsonp({ user: publicUser(user) });
});

// ---- Products (custom filtering / sort / pagination) ----------------------
server.get('/products', (req, res) => {
  let items = db.get('products').value().slice();
  const q = req.query;
  if (q.categoryId) items = items.filter((p) => p.categoryId === q.categoryId);
  if (q.brand) items = items.filter((p) => p.brand.toLowerCase() === String(q.brand).toLowerCase());
  if (q.q) {
    const needle = String(q.q).toLowerCase();
    items = items.filter(
      (p) => p.title.toLowerCase().includes(needle) || p.brand.toLowerCase().includes(needle),
    );
  }
  if (q.minPrice) items = items.filter((p) => p.price >= Number(q.minPrice));
  if (q.maxPrice) items = items.filter((p) => p.price <= Number(q.maxPrice));
  if (q.minRating) items = items.filter((p) => p.rating >= Number(q.minRating));

  switch (q.sort) {
    case 'price_asc': items.sort((a, b) => a.price - b.price); break;
    case 'price_desc': items.sort((a, b) => b.price - a.price); break;
    case 'rating': items.sort((a, b) => b.rating - a.rating); break;
    case 'newest': items.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt)); break;
    case 'popularity': items.sort((a, b) => b.popularity - a.popularity); break;
    default: break;
  }

  const total = items.length;
  const page = Number(q._page) || 1;
  const limit = Number(q._limit) || total;
  const start = (page - 1) * limit;
  const paged = items.slice(start, start + limit);
  res.setHeader('X-Total-Count', total);
  res.jsonp(paged);
});

// ---- Promo ----------------------------------------------------------------
server.post('/promo/validate', (req, res) => {
  const code = String((req.body || {}).code || '').toUpperCase();
  const promo = db.get('promos').find({ code }).value();
  if (!promo) return res.jsonp({ code, valid: false, discountPct: 0 });
  res.jsonp({ code, valid: true, discountPct: promo.discountPct });
});

// ---- Cart -----------------------------------------------------------------
function getCart() {
  return db.get('cart').value();
}
function writeCart(cart) {
  db.set('cart', cart).write();
  return cart;
}

server.get('/cart', (req, res) => res.jsonp(getCart()));

server.post('/cart/items', (req, res) => {
  const cart = getCart();
  const { productId, variant = {}, qty = 1, priceAtAdd } = req.body || {};
  const variantKey = JSON.stringify(variant);
  const existing = cart.items.find(
    (i) => i.productId === productId && JSON.stringify(i.variant || {}) === variantKey,
  );
  if (existing) {
    existing.qty += qty;
  } else {
    cart.items.push({
      id: `ci_${Date.now()}`,
      productId,
      variant,
      qty,
      priceAtAdd,
    });
  }
  res.status(201).jsonp(writeCart(cart));
});

server.patch('/cart/items/:id', (req, res) => {
  const cart = getCart();
  const item = cart.items.find((i) => i.id === req.params.id);
  if (!item) return res.status(404).jsonp({ message: 'Item not found' });
  if (typeof req.body.qty === 'number') item.qty = req.body.qty;
  if (item.qty <= 0) cart.items = cart.items.filter((i) => i.id !== item.id);
  res.jsonp(writeCart(cart));
});

server.delete('/cart/items/:id', (req, res) => {
  const cart = getCart();
  cart.items = cart.items.filter((i) => i.id !== req.params.id);
  res.jsonp(writeCart(cart));
});

// ---- Wishlist -------------------------------------------------------------
server.get('/wishlist', (req, res) => res.jsonp(db.get('wishlist').value()));

server.post('/wishlist', (req, res) => {
  const { productId } = req.body || {};
  const list = db.get('wishlist').value();
  if (!list.includes(productId)) {
    db.set('wishlist', [...list, productId]).write();
  }
  res.status(201).jsonp({ productId });
});

server.delete('/wishlist/:productId', (req, res) => {
  const list = db.get('wishlist').value().filter((id) => id !== req.params.productId);
  db.set('wishlist', list).write();
  res.jsonp({ ok: true });
});

// ---- Orders ---------------------------------------------------------------
server.post('/orders', (req, res) => {
  const { items = [], addressId, shippingMethod = 'standard', paymentMethod = 'card', promo = null } = req.body || {};
  const subtotal = items.reduce((sum, i) => sum + i.priceAtAdd * i.qty, 0);
  const discount = promo && promo.discountPct ? (subtotal * promo.discountPct) / 100 : 0;
  const shipping = shippingMethod === 'express' ? 19.99 : 9.99;
  const taxable = subtotal - discount;
  const tax = Math.round(taxable * 0.08 * 100) / 100;
  const total = Math.round((taxable + shipping + tax) * 100) / 100;
  const now = new Date().toISOString();
  const order = {
    id: `ord_${Date.now()}`,
    userId: 'usr_1',
    items,
    addressId,
    shippingMethod,
    paymentMethod,
    promo,
    subtotal: Math.round(subtotal * 100) / 100,
    discount: Math.round(discount * 100) / 100,
    shipping,
    tax,
    total,
    status: 'placed',
    timeline: [{ status: 'placed', date: now }],
    createdAt: now,
  };
  db.get('orders').push(order).write();
  // Clear the cart after a successful order.
  writeCart({ ...getCart(), items: [], promo: null });
  res.status(201).jsonp(order);
});

// Everything else falls through to the default json-server router
// (GET /banners, /categories, /products/:id, /reviews, /addresses CRUD,
//  GET /orders, GET /orders/:id, /notifications, and the rewritten
//  /products/:id/reviews route from routes.json).
const rewriter = jsonServer.rewriter(require('./routes.json'));
server.use(rewriter);
server.use(router);

server.listen(PORT, () => {
  console.log(`Kartly mock API running at http://localhost:${PORT}`);
});
