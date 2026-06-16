/// Sort options supported by the catalog (mirrors the mock API `sort` param).
enum ProductSort {
  relevance('', 'Relevance'),
  priceAsc('price_asc', 'Price: Low to High'),
  priceDesc('price_desc', 'Price: High to Low'),
  rating('rating', 'Top Rated'),
  newest('newest', 'Newest'),
  popularity('popularity', 'Most Popular');

  const ProductSort(this.value, this.label);
  final String value;
  final String label;
}

/// Immutable description of a catalog query: search term, filters, sort, paging.
class ProductQuery {
  const ProductQuery({
    this.categoryId,
    this.q,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.brand,
    this.sort = ProductSort.relevance,
    this.page = 1,
    this.limit = 20,
  });

  final String? categoryId;
  final String? q;
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;
  final String? brand;
  final ProductSort sort;
  final int page;
  final int limit;

  ProductQuery copyWith({
    String? categoryId,
    bool clearCategory = false,
    String? q,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    String? brand,
    bool clearBrand = false,
    ProductSort? sort,
    int? page,
    int? limit,
  }) {
    return ProductQuery(
      categoryId: clearCategory ? null : (categoryId ?? this.categoryId),
      q: q ?? this.q,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      brand: clearBrand ? null : (brand ?? this.brand),
      sort: sort ?? this.sort,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  Map<String, dynamic> toQueryMap() => {
        if (categoryId != null) 'categoryId': categoryId,
        if (q != null && q!.isNotEmpty) 'q': q,
        if (minPrice != null) 'minPrice': minPrice,
        if (maxPrice != null) 'maxPrice': maxPrice,
        if (minRating != null) 'minRating': minRating,
        if (brand != null) 'brand': brand,
        if (sort.value.isNotEmpty) 'sort': sort.value,
        '_page': page,
        '_limit': limit,
      };

  /// Count of active filters (excludes search/category/sort) — for badge UI.
  int get activeFilterCount =>
      (minPrice != null ? 1 : 0) +
      (maxPrice != null ? 1 : 0) +
      (minRating != null ? 1 : 0) +
      (brand != null ? 1 : 0);
}
