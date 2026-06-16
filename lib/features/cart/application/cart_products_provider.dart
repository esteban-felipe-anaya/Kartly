import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/product.dart';
import '../../product/application/product_providers.dart';
import 'cart_controller.dart';

part 'cart_products_provider.g.dart';

/// Resolves full [Product] details for every product referenced by the cart,
/// keyed by product id. Reuses the cached [productDetailProvider] so line-item
/// thumbnails/titles and order enrichment share the same fetches.
@riverpod
Future<Map<String, Product>> cartProducts(Ref ref) async {
  final cart = await ref.watch(cartControllerProvider.future);
  final ids = cart.items.map((i) => i.productId).toSet();
  final entries = await Future.wait(
    ids.map((id) async {
      try {
        final product = await ref.watch(productDetailProvider(id).future);
        return MapEntry(id, product);
      } catch (_) {
        return null;
      }
    }),
  );
  return {
    for (final entry in entries)
      if (entry != null) entry.key: entry.value,
  };
}
