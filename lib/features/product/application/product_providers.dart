import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../../../data/models/product.dart';
import '../../../data/models/product_query.dart';
import '../../../data/models/review.dart';

part 'product_providers.g.dart';

@riverpod
Future<Product> productDetail(Ref ref, String id) =>
    ref.watch(catalogRepositoryProvider).product(id);

@riverpod
Future<List<Review>> productReviews(Ref ref, String id) =>
    ref.watch(catalogRepositoryProvider).reviews(id);

/// Other products in the same category (excludes the current product).
@riverpod
Future<List<Product>> relatedProducts(Ref ref, String id) async {
  final product = await ref.watch(productDetailProvider(id).future);
  final siblings = await ref
      .watch(catalogRepositoryProvider)
      .products(ProductQuery(categoryId: product.categoryId, limit: 12));
  return siblings.where((p) => p.id != id).take(10).toList();
}
