import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../../../data/models/order.dart';
import '../../account/application/address_controller.dart';
import '../../cart/application/cart_controller.dart';
import '../../cart/application/cart_products_provider.dart';
import '../../orders/application/orders_controller.dart';

part 'checkout_controller.g.dart';

/// Shipping options offered at checkout.
enum ShippingMethod {
  standard('standard', 'Standard (3–5 days)', 9.99),
  express('express', 'Express (1–2 days)', 19.99);

  const ShippingMethod(this.id, this.label, this.fee);
  final String id;
  final String label;
  final double fee;
}

enum PaymentMethod {
  card('card', 'Credit / Debit Card'),
  cod('cod', 'Cash on Delivery');

  const PaymentMethod(this.id, this.label);
  final String id;
  final String label;
}

/// Immutable checkout selections.
class CheckoutState {
  const CheckoutState({
    this.addressId,
    this.shipping = ShippingMethod.standard,
    this.payment = PaymentMethod.card,
  });

  final String? addressId;
  final ShippingMethod shipping;
  final PaymentMethod payment;

  CheckoutState copyWith({
    String? addressId,
    ShippingMethod? shipping,
    PaymentMethod? payment,
  }) =>
      CheckoutState(
        addressId: addressId ?? this.addressId,
        shipping: shipping ?? this.shipping,
        payment: payment ?? this.payment,
      );
}

@riverpod
class CheckoutController extends _$CheckoutController {
  @override
  CheckoutState build() {
    // Pre-select the default address if one exists.
    final defaultAddr = ref.watch(defaultAddressProvider);
    return CheckoutState(addressId: defaultAddr?.id);
  }

  void selectAddress(String id) => state = state.copyWith(addressId: id);
  void selectShipping(ShippingMethod m) => state = state.copyWith(shipping: m);
  void selectPayment(PaymentMethod m) => state = state.copyWith(payment: m);

  /// Builds the order from the current cart + selections, places it, clears the
  /// cart, and refreshes order history. Returns the created [Order].
  Future<Order> placeOrder() async {
    final cart = ref.read(cartControllerProvider).valueOrNull;
    if (cart == null || cart.items.isEmpty) {
      throw StateError('Cannot place an order with an empty cart.');
    }
    final products = await ref.read(cartProductsProvider.future);

    final body = <String, dynamic>{
      'items': [
        for (final item in cart.items)
          {
            'productId': item.productId,
            'title': products[item.productId]?.title ?? '',
            'image': products[item.productId]?.primaryImage,
            'variant': item.variant,
            'qty': item.qty,
            'priceAtAdd': item.priceAtAdd,
          },
      ],
      'addressId': state.addressId,
      'shippingMethod': state.shipping.id,
      'paymentMethod': state.payment.id,
      'promo': cart.promo?.toJson(),
    };

    final order = await ref.read(orderRepositoryProvider).place(body);
    ref.read(cartControllerProvider.notifier).reset();
    ref.invalidate(ordersControllerProvider);
    return order;
  }
}
