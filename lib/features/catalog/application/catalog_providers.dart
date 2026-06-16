import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../../../data/models/category.dart';
import '../../../data/models/home_banner.dart';
import '../../../data/models/product.dart';
import '../../../data/models/product_query.dart';

part 'catalog_providers.g.dart';

@riverpod
Future<List<HomeBanner>> banners(Ref ref) =>
    ref.watch(catalogRepositoryProvider).banners();

@riverpod
Future<List<Category>> categories(Ref ref) =>
    ref.watch(catalogRepositoryProvider).categories();

/// Mutable catalog query, seeded with an optional category. Drives [catalogResults].
@riverpod
class CatalogQuery extends _$CatalogQuery {
  @override
  ProductQuery build(String? categoryId) => ProductQuery(categoryId: categoryId);

  void setSort(ProductSort sort) => state = state.copyWith(sort: sort, page: 1);

  void setSearch(String? q) => state = state.copyWith(q: q ?? '', page: 1);

  void applyFilters({
    double? minPrice,
    double? maxPrice,
    double? minRating,
    String? brand,
    bool clearBrand = false,
  }) {
    state = ProductQuery(
      categoryId: state.categoryId,
      q: state.q,
      sort: state.sort,
      minPrice: minPrice,
      maxPrice: maxPrice,
      minRating: minRating,
      brand: clearBrand ? null : brand,
    );
  }

  void reset() => state = ProductQuery(categoryId: state.categoryId, sort: state.sort);
}

@riverpod
Future<List<Product>> catalogResults(Ref ref, String? categoryId) {
  final query = ref.watch(catalogQueryProvider(categoryId));
  return ref.watch(catalogRepositoryProvider).products(query);
}

/// Distinct brands available within a category, for the filter sheet.
@riverpod
Future<List<String>> categoryBrands(Ref ref, String? categoryId) async {
  final products = await ref
      .watch(catalogRepositoryProvider)
      .products(ProductQuery(categoryId: categoryId, limit: 200));
  final brands = products.map((p) => p.brand).toSet().toList()..sort();
  return brands;
}
