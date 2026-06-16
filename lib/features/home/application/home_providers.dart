import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../../../data/models/product.dart';
import '../../../data/models/product_query.dart';

part 'home_providers.g.dart';

@riverpod
Future<List<Product>> featuredProducts(Ref ref) => ref
    .watch(catalogRepositoryProvider)
    .products(const ProductQuery(sort: ProductSort.popularity, limit: 10));

@riverpod
Future<List<Product>> newArrivals(Ref ref) => ref
    .watch(catalogRepositoryProvider)
    .products(const ProductQuery(sort: ProductSort.newest, limit: 10));

/// Discounted products (filtered client-side since the API has no `onSale` flag).
@riverpod
Future<List<Product>> deals(Ref ref) async {
  final products = await ref
      .watch(catalogRepositoryProvider)
      .products(const ProductQuery(sort: ProductSort.popularity, limit: 50));
  return products.where((p) => p.hasDiscount).take(10).toList();
}
