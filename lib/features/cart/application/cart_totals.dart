import '../../../data/models/cart.dart';

/// Pure, immutable breakdown of a cart's monetary totals.
/// Kept free of Flutter/Riverpod imports so it is trivially unit-testable.
class CartTotals {
  const CartTotals({
    required this.itemCount,
    required this.subtotal,
    required this.discount,
    required this.shipping,
    required this.tax,
    required this.total,
  });

  final int itemCount;
  final double subtotal;
  final double discount;
  final double shipping;
  final double tax;
  final double total;

  bool get isEmpty => itemCount == 0;
}

double _round2(double v) => (v * 100).roundToDouble() / 100;

/// Computes cart totals from line items and an optional validated promo.
///
/// - subtotal = Σ priceAtAdd × qty
/// - discount = subtotal × promo.discountPct% (only when the promo is valid)
/// - shipping = flat fee when the cart is non-empty, else 0
/// - tax = (subtotal − discount) × taxRate
/// - total = subtotal − discount + shipping + tax
CartTotals computeCartTotals(
  Cart cart, {
  double shippingFlat = 9.99,
  double taxRate = 0.08,
}) {
  final itemCount = cart.items.fold<int>(0, (sum, i) => sum + i.qty);
  final subtotal = cart.items.fold<double>(0, (sum, i) => sum + i.priceAtAdd * i.qty);

  final promo = cart.promo;
  final discount = (promo != null && promo.valid)
      ? subtotal * (promo.discountPct / 100)
      : 0.0;

  final shipping = itemCount == 0 ? 0.0 : shippingFlat;
  final taxable = subtotal - discount;
  final tax = taxable * taxRate;
  final total = taxable + shipping + tax;

  return CartTotals(
    itemCount: itemCount,
    subtotal: _round2(subtotal),
    discount: _round2(discount),
    shipping: _round2(shipping),
    tax: _round2(tax),
    total: _round2(total),
  );
}
