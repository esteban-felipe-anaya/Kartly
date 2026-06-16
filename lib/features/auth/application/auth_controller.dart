import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../../../data/models/user.dart';

part 'auth_controller.g.dart';

/// Holds the authenticated [User], or `null` when browsing as a guest.
///
/// On startup it attempts to restore a session from the persisted token.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<User?> build() async {
    final tokenStore = ref.watch(tokenStoreProvider);
    final token = await tokenStore.read();
    if (token == null || token.isEmpty) return null;
    try {
      return await ref.read(authRepositoryProvider).me();
    } catch (_) {
      // Stale/invalid token — drop it and continue as guest.
      await tokenStore.clear();
      return null;
    }
  }

  bool get isAuthenticated => state.valueOrNull != null;

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final res = await ref.read(authRepositoryProvider).login(email, password);
      await ref.read(tokenStoreProvider).write(res.token);
      return res.user;
    });
    if (state.hasError) throw state.error!;
  }

  Future<void> register(String name, String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final res = await ref.read(authRepositoryProvider).register(name, email, password);
      await ref.read(tokenStoreProvider).write(res.token);
      return res.user;
    });
    if (state.hasError) throw state.error!;
  }

  Future<void> logout() async {
    await ref.read(tokenStoreProvider).clear();
    state = const AsyncData(null);
  }
}
