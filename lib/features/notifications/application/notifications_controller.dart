import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../../../data/models/notification.dart';

part 'notifications_controller.g.dart';

@Riverpod(keepAlive: true)
class NotificationsController extends _$NotificationsController {
  @override
  Future<List<AppNotification>> build() =>
      ref.watch(notificationRepositoryProvider).fetch();

  /// Marks one notification read locally (the mock API is read-only here).
  void markRead(String id) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData([
      for (final n in current) if (n.id == id) n.copyWith(read: true) else n,
    ]);
  }

  void markAllRead() {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData([for (final n in current) n.copyWith(read: true)]);
  }
}

@riverpod
int unreadNotificationCount(Ref ref) {
  final list = ref.watch(notificationsControllerProvider).valueOrNull ?? const [];
  return list.where((n) => !n.read).length;
}
