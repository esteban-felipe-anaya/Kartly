import '../../core/network/api_guard.dart';
import '../api/kartly_api.dart';

class WishlistRepository {
  WishlistRepository(this._api);

  final KartlyApi _api;

  Future<List<String>> fetch() => guard(() => _api.getWishlist());

  Future<void> add(String productId) =>
      guard(() => _api.addWishlist({'productId': productId}));

  Future<void> remove(String productId) => guard(() => _api.removeWishlist(productId));
}
