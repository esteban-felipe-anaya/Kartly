import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';

part 'wishlist_controller.g.dart';

/// Set of wishlisted product ids. Optimistically updates then syncs the API.
@Riverpod(keepAlive: true)
class WishlistController extends _$WishlistController {
  @override
  Future<Set<String>> build() async {
    final ids = await ref.read(wishlistRepositoryProvider).fetch();
    return ids.toSet();
  }

  Future<void> toggle(String productId) async {
    final current = {...(state.valueOrNull ?? <String>{})};
    final repo = ref.read(wishlistRepositoryProvider);
    final wasIn = current.contains(productId);

    // Optimistic update.
    if (wasIn) {
      current.remove(productId);
    } else {
      current.add(productId);
    }
    state = AsyncData(current);

    try {
      if (wasIn) {
        await repo.remove(productId);
      } else {
        await repo.add(productId);
      }
    } catch (e) {
      // Roll back on failure.
      final rolledBack = {...current};
      if (wasIn) {
        rolledBack.add(productId);
      } else {
        rolledBack.remove(productId);
      }
      state = AsyncData(rolledBack);
      rethrow;
    }
  }
}

/// Whether a given product is currently wishlisted.
@riverpod
bool isWishlisted(Ref ref, String productId) =>
    ref.watch(wishlistControllerProvider).valueOrNull?.contains(productId) ?? false;
