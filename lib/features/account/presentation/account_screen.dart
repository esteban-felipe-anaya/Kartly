import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../data/models/user.dart';
import '../../../shared/widgets/app_buttons.dart';
import '../../../shared/widgets/app_network_image.dart';
import '../../auth/application/auth_controller.dart';

/// Account hub: profile header plus navigation into orders, addresses, etc.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    await ref.read(authControllerProvider.notifier).logout();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Signed out')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final user = auth.valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: const [NotificationsButton(), CartButton()],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(Insets.lg),
            children: [
              if (user != null)
                _ProfileHeader(user: user)
              else
                const _GuestHeader(),
              Gaps.vLg,
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _AccountTile(
                      icon: Icons.receipt_long,
                      title: 'My Orders',
                      onTap: () => context.push(Routes.orders),
                    ),
                    _AccountTile(
                      icon: Icons.favorite_border,
                      title: 'Wishlist',
                      onTap: () => context.go(Routes.wishlist),
                    ),
                    _AccountTile(
                      icon: Icons.location_on_outlined,
                      title: 'Addresses',
                      onTap: () => context.push(Routes.addresses),
                    ),
                    _AccountTile(
                      icon: Icons.credit_card,
                      title: 'Payment methods',
                      onTap: () => context.push(Routes.paymentMethods),
                    ),
                    _AccountTile(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      onTap: () => context.push(Routes.notifications),
                    ),
                    _AccountTile(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () => context.push(Routes.settings),
                    ),
                  ],
                ),
              ),
              if (user != null) ...[
                Gaps.vLg,
                FilledButton.tonalIcon(
                  onPressed: () => _logout(context, ref),
                  icon: const Icon(Icons.logout),
                  label: const Text('Log out'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasAvatar = user.avatar != null && user.avatar!.isNotEmpty;
    final initials = user.name.isNotEmpty ? user.name[0].toUpperCase() : '?';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: hasAvatar
                  ? AppNetworkImage(
                      url: user.avatar,
                      width: 64,
                      height: 64,
                      borderRadius: const BorderRadius.all(Radius.circular(Radii.pill)),
                    )
                  : Text(
                      initials,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
            ),
            Gaps.hLg,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: theme.textTheme.titleLarge),
                  Gaps.vSm,
                  Text(
                    user.email,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GuestHeader extends StatelessWidget {
  const _GuestHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("You're browsing as a guest", style: theme.textTheme.titleLarge),
            Gaps.vSm,
            Text(
              'Sign in to track orders and sync your wishlist.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Gaps.vLg,
            FilledButton(
              onPressed: () => context.push(Routes.login),
              child: const Text('Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  const _AccountTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
