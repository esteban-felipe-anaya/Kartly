import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/route_paths.dart';
import '../../core/theme/design_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../core/utils/responsive.dart';
import '../../features/cart/application/cart_controller.dart';

/// One top-level navigation destination.
class _Dest {
  const _Dest(this.label, this.icon, this.selectedIcon);
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

const _destinations = <_Dest>[
  _Dest('Home', Icons.home_outlined, Icons.home_rounded),
  _Dest('Shop', Icons.grid_view_outlined, Icons.grid_view_rounded),
  _Dest('Search', Icons.search_outlined, Icons.search_rounded),
  _Dest('Wishlist', Icons.favorite_border_rounded, Icons.favorite_rounded),
  _Dest('Account', Icons.person_outline_rounded, Icons.person_rounded),
];

/// Adaptive shell that hosts the five primary branches:
/// - mobile  → bottom [NavigationBar]
/// - tablet  → compact [NavigationRail]
/// - desktop → extended [NavigationRail] (+ persistent cart side panel on XL)
class AppNavigationScaffold extends StatelessWidget {
  const AppNavigationScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;

    if (size == ScreenSize.mobile) {
      return Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
          destinations: [
            for (final d in _destinations)
              NavigationDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.selectedIcon),
                label: d.label,
              ),
          ],
        ),
      );
    }

    final extended = size == ScreenSize.desktop;
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: extended,
            minExtendedWidth: 200,
            labelType: extended ? null : NavigationRailLabelType.all,
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: _goBranch,
            leading: _RailLeading(extended: extended),
            destinations: [
              for (final d in _destinations)
                NavigationRailDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: Text(d.label),
                ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: navigationShell),
          if (context.showSideCart) ...[
            const VerticalDivider(width: 1),
            const SizedBox(width: 320, child: _CartSidePanel()),
          ],
        ],
      ),
    );
  }
}

class _RailLeading extends StatelessWidget {
  const _RailLeading({required this.extended});
  final bool extended;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Insets.lg),
      child: extended
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Row(
                children: [
                  Icon(Icons.shopping_bag_rounded, color: theme.colorScheme.primary),
                  Gaps.hSm,
                  Text('Kartly',
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                ],
              ),
            )
          : Icon(Icons.shopping_bag_rounded, color: theme.colorScheme.primary),
    );
  }
}

/// Compact persistent cart summary shown on extra-wide screens.
class _CartSidePanel extends ConsumerWidget {
  const _CartSidePanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final totals = ref.watch(cartTotalsProvider);
    final count = ref.watch(cartItemCountProvider);

    return Material(
      color: theme.colorScheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(Insets.lg),
            child: Row(
              children: [
                Icon(Icons.shopping_cart_outlined, color: theme.colorScheme.primary),
                Gaps.hSm,
                Text('Your Cart', style: theme.textTheme.titleMedium),
                const Spacer(),
                Text('$count items', style: theme.textTheme.labelMedium),
              ],
            ),
          ),
          const Divider(height: 1),
          if (totals.isEmpty)
            const Expanded(
              child: Center(child: Text('Your cart is empty')),
            )
          else
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Insets.lg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _row(theme, 'Subtotal', totals.subtotal),
                    if (totals.discount > 0) _row(theme, 'Discount', -totals.discount),
                    _row(theme, 'Shipping', totals.shipping),
                    _row(theme, 'Tax', totals.tax),
                    const Divider(),
                    _row(theme, 'Total', totals.total, emphasize: true),
                    Gaps.vMd,
                    FilledButton(
                      onPressed: () => context.push(Routes.checkout),
                      child: const Text('Checkout'),
                    ),
                    Gaps.vSm,
                    OutlinedButton(
                      onPressed: () => context.push(Routes.cart),
                      child: const Text('View cart'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _row(ThemeData theme, String label, double value, {bool emphasize = false}) {
    final style = emphasize
        ? theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)
        : theme.textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(Formatters.currency(value), style: style),
        ],
      ),
    );
  }
}
