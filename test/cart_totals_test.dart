import 'package:flutter_test/flutter_test.dart';
import 'package:kartly/data/models/cart.dart';
import 'package:kartly/data/models/promo.dart';
import 'package:kartly/features/cart/application/cart_totals.dart';

void main() {
  group('computeCartTotals', () {
    test('empty cart yields all-zero totals and no shipping', () {
      final totals = computeCartTotals(const Cart(items: []));
      expect(totals.itemCount, 0);
      expect(totals.subtotal, 0);
      expect(totals.shipping, 0);
      expect(totals.total, 0);
      expect(totals.isEmpty, isTrue);
    });

    test('sums line items and applies flat shipping + 8% tax', () {
      final cart = Cart(
        items: const [
          CartItem(productId: 'a', qty: 2, priceAtAdd: 50), // 100
          CartItem(productId: 'b', qty: 1, priceAtAdd: 25), // 25
        ],
      );
      final totals = computeCartTotals(cart);
      expect(totals.itemCount, 3);
      expect(totals.subtotal, 125);
      expect(totals.discount, 0);
      expect(totals.shipping, 9.99);
      expect(totals.tax, closeTo(10, 0.001)); // 125 * 0.08
      expect(totals.total, closeTo(144.99, 0.001)); // 125 + 9.99 + 10
    });

    test('applies a valid promo discount before tax', () {
      final cart = Cart(
        items: const [CartItem(productId: 'a', qty: 1, priceAtAdd: 200)],
        promo: const PromoResult(code: 'SAVE20', valid: true, discountPct: 20),
      );
      final totals = computeCartTotals(cart);
      expect(totals.subtotal, 200);
      expect(totals.discount, 40); // 20% of 200
      // taxable = 160 -> tax = 12.80
      expect(totals.tax, closeTo(12.8, 0.001));
      // total = 160 + 9.99 + 12.80
      expect(totals.total, closeTo(182.79, 0.001));
    });

    test('ignores an invalid promo', () {
      final cart = Cart(
        items: const [CartItem(productId: 'a', qty: 1, priceAtAdd: 100)],
        promo: const PromoResult(code: 'NOPE', valid: false, discountPct: 50),
      );
      final totals = computeCartTotals(cart);
      expect(totals.discount, 0);
      expect(totals.total, closeTo(100 + 9.99 + 8, 0.001));
    });
  });
}
