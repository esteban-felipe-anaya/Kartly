import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/notification.dart';
import '../../../shared/widgets/states.dart';
import '../application/notifications_controller.dart';

/// Lists in-app notifications; unread entries are visually emphasized.
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () =>
                ref.read(notificationsControllerProvider.notifier).markAllRead(),
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: notifications.when(
        data: (list) {
          if (list.isEmpty) {
            return const EmptyState(
              icon: Icons.notifications_off_outlined,
              title: 'No notifications',
              message: "You're all caught up.",
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(Insets.lg),
            itemCount: list.length,
            itemBuilder: (context, i) => _NotificationTile(
              notification: list[i],
              onTap: () => ref
                  .read(notificationsControllerProvider.notifier)
                  .markRead(list[i].id),
            ),
          );
        },
        loading: () => const _NotificationsSkeleton(),
        error: (e, _) => ErrorView(
          message: '$e',
          onRetry: () => ref.invalidate(notificationsControllerProvider),
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification, required this.onTap});

  final AppNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final unread = !notification.read;

    return Card(
      margin: const EdgeInsets.only(bottom: Insets.md),
      color: unread ? scheme.primaryContainer : null,
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          unread ? Icons.circle : Icons.circle_outlined,
          size: 14,
          color: unread ? scheme.primary : scheme.outline,
        ),
        title: Text(
          notification.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: unread ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (notification.body.isNotEmpty) ...[
              Gaps.xs,
              Text(notification.body),
            ],
            if (notification.date != null) ...[
              Gaps.xs,
              Text(
                Formatters.date(notification.date!),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
        isThreeLine: notification.body.isNotEmpty,
      ),
    );
  }
}

class _NotificationsSkeleton extends StatelessWidget {
  const _NotificationsSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(Insets.lg),
      itemCount: 6,
      itemBuilder: (_, _) => const Padding(
        padding: EdgeInsets.only(bottom: Insets.md),
        child: ShimmerBox(height: 84, borderRadius: Radii.lgAll),
      ),
    );
  }
}
