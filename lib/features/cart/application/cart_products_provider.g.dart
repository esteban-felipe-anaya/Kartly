// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartProductsHash() => r'5ec40c4b5a641bc67d7a3beff0eda4da5df92697';

/// Resolves full [Product] details for every product referenced by the cart,
/// keyed by product id. Reuses the cached [productDetailProvider] so line-item
/// thumbnails/titles and order enrichment share the same fetches.
///
/// Copied from [cartProducts].
@ProviderFor(cartProducts)
final cartProductsProvider =
    AutoDisposeFutureProvider<Map<String, Product>>.internal(
      cartProducts,
      name: r'cartProductsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cartProductsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartProductsRef = AutoDisposeFutureProviderRef<Map<String, Product>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
