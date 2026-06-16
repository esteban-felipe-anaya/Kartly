// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bannersHash() => r'6ab12938ce86d90efdfa0d72ef796be4a4d070bf';

/// See also [banners].
@ProviderFor(banners)
final bannersProvider = AutoDisposeFutureProvider<List<HomeBanner>>.internal(
  banners,
  name: r'bannersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bannersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BannersRef = AutoDisposeFutureProviderRef<List<HomeBanner>>;
String _$categoriesHash() => r'201f7ce59276c1ed01fad5ee7aa3a6e39a553365';

/// See also [categories].
@ProviderFor(categories)
final categoriesProvider = AutoDisposeFutureProvider<List<Category>>.internal(
  categories,
  name: r'categoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoriesRef = AutoDisposeFutureProviderRef<List<Category>>;
String _$catalogResultsHash() => r'50d9c1940a60c11325f929740c3aaa65918d2821';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [catalogResults].
@ProviderFor(catalogResults)
const catalogResultsProvider = CatalogResultsFamily();

/// See also [catalogResults].
class CatalogResultsFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [catalogResults].
  const CatalogResultsFamily();

  /// See also [catalogResults].
  CatalogResultsProvider call(String? categoryId) {
    return CatalogResultsProvider(categoryId);
  }

  @override
  CatalogResultsProvider getProviderOverride(
    covariant CatalogResultsProvider provider,
  ) {
    return call(provider.categoryId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'catalogResultsProvider';
}

/// See also [catalogResults].
class CatalogResultsProvider extends AutoDisposeFutureProvider<List<Product>> {
  /// See also [catalogResults].
  CatalogResultsProvider(String? categoryId)
    : this._internal(
        (ref) => catalogResults(ref as CatalogResultsRef, categoryId),
        from: catalogResultsProvider,
        name: r'catalogResultsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$catalogResultsHash,
        dependencies: CatalogResultsFamily._dependencies,
        allTransitiveDependencies:
            CatalogResultsFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  CatalogResultsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final String? categoryId;

  @override
  Override overrideWith(
    FutureOr<List<Product>> Function(CatalogResultsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CatalogResultsProvider._internal(
        (ref) => create(ref as CatalogResultsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Product>> createElement() {
    return _CatalogResultsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CatalogResultsProvider && other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CatalogResultsRef on AutoDisposeFutureProviderRef<List<Product>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;
}

class _CatalogResultsProviderElement
    extends AutoDisposeFutureProviderElement<List<Product>>
    with CatalogResultsRef {
  _CatalogResultsProviderElement(super.provider);

  @override
  String? get categoryId => (origin as CatalogResultsProvider).categoryId;
}

String _$categoryBrandsHash() => r'05e29bc33408abe33c44ab1174a8166ece8b60be';

/// Distinct brands available within a category, for the filter sheet.
///
/// Copied from [categoryBrands].
@ProviderFor(categoryBrands)
const categoryBrandsProvider = CategoryBrandsFamily();

/// Distinct brands available within a category, for the filter sheet.
///
/// Copied from [categoryBrands].
class CategoryBrandsFamily extends Family<AsyncValue<List<String>>> {
  /// Distinct brands available within a category, for the filter sheet.
  ///
  /// Copied from [categoryBrands].
  const CategoryBrandsFamily();

  /// Distinct brands available within a category, for the filter sheet.
  ///
  /// Copied from [categoryBrands].
  CategoryBrandsProvider call(String? categoryId) {
    return CategoryBrandsProvider(categoryId);
  }

  @override
  CategoryBrandsProvider getProviderOverride(
    covariant CategoryBrandsProvider provider,
  ) {
    return call(provider.categoryId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'categoryBrandsProvider';
}

/// Distinct brands available within a category, for the filter sheet.
///
/// Copied from [categoryBrands].
class CategoryBrandsProvider extends AutoDisposeFutureProvider<List<String>> {
  /// Distinct brands available within a category, for the filter sheet.
  ///
  /// Copied from [categoryBrands].
  CategoryBrandsProvider(String? categoryId)
    : this._internal(
        (ref) => categoryBrands(ref as CategoryBrandsRef, categoryId),
        from: categoryBrandsProvider,
        name: r'categoryBrandsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$categoryBrandsHash,
        dependencies: CategoryBrandsFamily._dependencies,
        allTransitiveDependencies:
            CategoryBrandsFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  CategoryBrandsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final String? categoryId;

  @override
  Override overrideWith(
    FutureOr<List<String>> Function(CategoryBrandsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategoryBrandsProvider._internal(
        (ref) => create(ref as CategoryBrandsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _CategoryBrandsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryBrandsProvider && other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CategoryBrandsRef on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;
}

class _CategoryBrandsProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with CategoryBrandsRef {
  _CategoryBrandsProviderElement(super.provider);

  @override
  String? get categoryId => (origin as CategoryBrandsProvider).categoryId;
}

String _$catalogQueryHash() => r'57689a7147c01892295ae596bb4b5daf698ba817';

abstract class _$CatalogQuery
    extends BuildlessAutoDisposeNotifier<ProductQuery> {
  late final String? categoryId;

  ProductQuery build(String? categoryId);
}

/// Mutable catalog query, seeded with an optional category. Drives [catalogResults].
///
/// Copied from [CatalogQuery].
@ProviderFor(CatalogQuery)
const catalogQueryProvider = CatalogQueryFamily();

/// Mutable catalog query, seeded with an optional category. Drives [catalogResults].
///
/// Copied from [CatalogQuery].
class CatalogQueryFamily extends Family<ProductQuery> {
  /// Mutable catalog query, seeded with an optional category. Drives [catalogResults].
  ///
  /// Copied from [CatalogQuery].
  const CatalogQueryFamily();

  /// Mutable catalog query, seeded with an optional category. Drives [catalogResults].
  ///
  /// Copied from [CatalogQuery].
  CatalogQueryProvider call(String? categoryId) {
    return CatalogQueryProvider(categoryId);
  }

  @override
  CatalogQueryProvider getProviderOverride(
    covariant CatalogQueryProvider provider,
  ) {
    return call(provider.categoryId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'catalogQueryProvider';
}

/// Mutable catalog query, seeded with an optional category. Drives [catalogResults].
///
/// Copied from [CatalogQuery].
class CatalogQueryProvider
    extends AutoDisposeNotifierProviderImpl<CatalogQuery, ProductQuery> {
  /// Mutable catalog query, seeded with an optional category. Drives [catalogResults].
  ///
  /// Copied from [CatalogQuery].
  CatalogQueryProvider(String? categoryId)
    : this._internal(
        () => CatalogQuery()..categoryId = categoryId,
        from: catalogQueryProvider,
        name: r'catalogQueryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$catalogQueryHash,
        dependencies: CatalogQueryFamily._dependencies,
        allTransitiveDependencies:
            CatalogQueryFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  CatalogQueryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final String? categoryId;

  @override
  ProductQuery runNotifierBuild(covariant CatalogQuery notifier) {
    return notifier.build(categoryId);
  }

  @override
  Override overrideWith(CatalogQuery Function() create) {
    return ProviderOverride(
      origin: this,
      override: CatalogQueryProvider._internal(
        () => create()..categoryId = categoryId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CatalogQuery, ProductQuery>
  createElement() {
    return _CatalogQueryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CatalogQueryProvider && other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CatalogQueryRef on AutoDisposeNotifierProviderRef<ProductQuery> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;
}

class _CatalogQueryProviderElement
    extends AutoDisposeNotifierProviderElement<CatalogQuery, ProductQuery>
    with CatalogQueryRef {
  _CatalogQueryProviderElement(super.provider);

  @override
  String? get categoryId => (origin as CatalogQueryProvider).categoryId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
