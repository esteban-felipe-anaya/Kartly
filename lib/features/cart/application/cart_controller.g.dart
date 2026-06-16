// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartTotalsHash() => r'c5ff05cf421228a5dbc177e3a399b2023b37907b';

/// Derived cart totals. Recomputes whenever the cart changes.
///
/// Copied from [cartTotals].
@ProviderFor(cartTotals)
final cartTotalsProvider = AutoDisposeProvider<CartTotals>.internal(
  cartTotals,
  name: r'cartTotalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartTotalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartTotalsRef = AutoDisposeProviderRef<CartTotals>;
String _$cartItemCountHash() => r'17068b902f1b0833068644415a47533e3968cd27';

/// Total item count for the cart badge.
///
/// Copied from [cartItemCount].
@ProviderFor(cartItemCount)
final cartItemCountProvider = AutoDisposeProvider<int>.internal(
  cartItemCount,
  name: r'cartItemCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartItemCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartItemCountRef = AutoDisposeProviderRef<int>;
String _$cartControllerHash() => r'a317cb8a3ce43e4cb699c3c39cff7f249e9c24b0';

/// Owns the shopping cart. Syncs to the API and mirrors to local storage so the
/// cart survives app restarts and brief offline periods. The active promo is
/// held client-side and re-attached after every server response.
///
/// Copied from [CartController].
@ProviderFor(CartController)
final cartControllerProvider =
    AsyncNotifierProvider<CartController, Cart>.internal(
      CartController.new,
      name: r'cartControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cartControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CartController = AsyncNotifier<Cart>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
