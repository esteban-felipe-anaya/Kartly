import '../../core/network/api_guard.dart';
import '../api/kartly_api.dart';
import '../models/cart.dart';
import '../models/promo.dart';

class CartRepository {
  CartRepository(this._api);

  final KartlyApi _api;

  Future<Cart> fetch() => guard(() => _api.getCart());

  Future<Cart> addItem({
    required String productId,
    required Map<String, String> variant,
    required int qty,
    required double priceAtAdd,
  }) =>
      guard(() => _api.addCartItem({
            'productId': productId,
            'variant': variant,
            'qty': qty,
            'priceAtAdd': priceAtAdd,
          }));

  Future<Cart> updateQty(String itemId, int qty) =>
      guard(() => _api.updateCartItem(itemId, {'qty': qty}));

  Future<Cart> removeItem(String itemId) => guard(() => _api.removeCartItem(itemId));

  Future<PromoResult> validatePromo(String code) =>
      guard(() => _api.validatePromo({'code': code}));
}
