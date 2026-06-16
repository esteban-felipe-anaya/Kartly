// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isWishlistedHash() => r'8d34eea937ae1fd8a78ca466aeb442ebf9f619c5';

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

/// Whether a given product is currently wishlisted.
///
/// Copied from [isWishlisted].
@ProviderFor(isWishlisted)
const isWishlistedProvider = IsWishlistedFamily();

/// Whether a given product is currently wishlisted.
///
/// Copied from [isWishlisted].
class IsWishlistedFamily extends Family<bool> {
  /// Whether a given product is currently wishlisted.
  ///
  /// Copied from [isWishlisted].
  const IsWishlistedFamily();

  /// Whether a given product is currently wishlisted.
  ///
  /// Copied from [isWishlisted].
  IsWishlistedProvider call(String productId) {
    return IsWishlistedProvider(productId);
  }

  @override
  IsWishlistedProvider getProviderOverride(
    covariant IsWishlistedProvider provider,
  ) {
    return call(provider.productId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isWishlistedProvider';
}

/// Whether a given product is currently wishlisted.
///
/// Copied from [isWishlisted].
class IsWishlistedProvider extends AutoDisposeProvider<bool> {
  /// Whether a given product is currently wishlisted.
  ///
  /// Copied from [isWishlisted].
  IsWishlistedProvider(String productId)
    : this._internal(
        (ref) => isWishlisted(ref as IsWishlistedRef, productId),
        from: isWishlistedProvider,
        name: r'isWishlistedProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isWishlistedHash,
        dependencies: IsWishlistedFamily._dependencies,
        allTransitiveDependencies:
            IsWishlistedFamily._allTransitiveDependencies,
        productId: productId,
      );

  IsWishlistedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  Override overrideWith(bool Function(IsWishlistedRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: IsWishlistedProvider._internal(
        (ref) => create(ref as IsWishlistedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsWishlistedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsWishlistedProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsWishlistedRef on AutoDisposeProviderRef<bool> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _IsWishlistedProviderElement extends AutoDisposeProviderElement<bool>
    with IsWishlistedRef {
  _IsWishlistedProviderElement(super.provider);

  @override
  String get productId => (origin as IsWishlistedProvider).productId;
}

String _$wishlistControllerHash() =>
    r'a21b43b96df16097480e00f44e8ffed6901cff62';

/// Set of wishlisted product ids. Optimistically updates then syncs the API.
///
/// Copied from [WishlistController].
@ProviderFor(WishlistController)
final wishlistControllerProvider =
    AsyncNotifierProvider<WishlistController, Set<String>>.internal(
      WishlistController.new,
      name: r'wishlistControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$wishlistControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WishlistController = AsyncNotifier<Set<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
