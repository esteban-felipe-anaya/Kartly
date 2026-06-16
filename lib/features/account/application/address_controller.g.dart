// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$defaultAddressHash() => r'01c9c6d1a77006e5e526f99995d819e860017939';

/// The default address (explicitly flagged, or the first one) for checkout.
///
/// Copied from [defaultAddress].
@ProviderFor(defaultAddress)
final defaultAddressProvider = AutoDisposeProvider<Address?>.internal(
  defaultAddress,
  name: r'defaultAddressProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$defaultAddressHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DefaultAddressRef = AutoDisposeProviderRef<Address?>;
String _$addressControllerHash() => r'8d650bbe262468eb6470af429616398102947f16';

/// See also [AddressController].
@ProviderFor(AddressController)
final addressControllerProvider =
    AsyncNotifierProvider<AddressController, List<Address>>.internal(
      AddressController.new,
      name: r'addressControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$addressControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AddressController = AsyncNotifier<List<Address>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
