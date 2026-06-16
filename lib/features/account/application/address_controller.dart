import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../../../data/models/address.dart';

part 'address_controller.g.dart';

@Riverpod(keepAlive: true)
class AddressController extends _$AddressController {
  @override
  Future<List<Address>> build() => ref.watch(addressRepositoryProvider).fetch();

  Future<void> add(Map<String, dynamic> body) async {
    await ref.read(addressRepositoryProvider).create(body);
    ref.invalidateSelf();
    await future;
  }

  Future<void> edit(String id, Map<String, dynamic> body) async {
    await ref.read(addressRepositoryProvider).update(id, body);
    ref.invalidateSelf();
    await future;
  }

  Future<void> remove(String id) async {
    await ref.read(addressRepositoryProvider).delete(id);
    ref.invalidateSelf();
    await future;
  }
}

/// The default address (explicitly flagged, or the first one) for checkout.
@riverpod
Address? defaultAddress(Ref ref) {
  final addresses = ref.watch(addressControllerProvider).valueOrNull ?? const [];
  if (addresses.isEmpty) return null;
  return addresses.firstWhere((a) => a.isDefault, orElse: () => addresses.first);
}
