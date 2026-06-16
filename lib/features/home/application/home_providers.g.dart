// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$featuredProductsHash() => r'61852f38bab54380b2f23c942e77baf2284cfb72';

/// See also [featuredProducts].
@ProviderFor(featuredProducts)
final featuredProductsProvider =
    AutoDisposeFutureProvider<List<Product>>.internal(
      featuredProducts,
      name: r'featuredProductsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$featuredProductsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeaturedProductsRef = AutoDisposeFutureProviderRef<List<Product>>;
String _$newArrivalsHash() => r'28b92bb93e2b0304cfef3b7b340ee33c5561d04d';

/// See also [newArrivals].
@ProviderFor(newArrivals)
final newArrivalsProvider = AutoDisposeFutureProvider<List<Product>>.internal(
  newArrivals,
  name: r'newArrivalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$newArrivalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NewArrivalsRef = AutoDisposeFutureProviderRef<List<Product>>;
String _$dealsHash() => r'a68d96e93430f0590d55566c8dff67a627c683a7';

/// Discounted products (filtered client-side since the API has no `onSale` flag).
///
/// Copied from [deals].
@ProviderFor(deals)
final dealsProvider = AutoDisposeFutureProvider<List<Product>>.internal(
  deals,
  name: r'dealsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dealsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DealsRef = AutoDisposeFutureProviderRef<List<Product>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
