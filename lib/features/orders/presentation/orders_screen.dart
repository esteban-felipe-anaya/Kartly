import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/order.dart';
import '../../../shared/widgets/states.dart';
import '../application/orders_controller.dart';

const double _maxContentWidth = 720;

/// Resolves a background color for an order-status chip.
Color statusColor(ColorScheme scheme, String status) {
  switch (status) {
    case 'packed':
      return scheme.tertiary;
    case 'shipped':
      return scheme.primary;
    case 'delivered':
      return scheme.primary;
    case 'cancelled':
      return scheme.error;
    case 'placed':
    default:
      return scheme.secondary;
  }
}

/// A compact status chip tinted by order status.
class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = statusColor(scheme, status);
    final label = status.isEmpty
        ? status
        : '${status[0].toUpperCase()}${status.substring(1)}';
    return Chip(
      label: Text(label),
      labelStyle: TextStyle(color: color),
      backgroundColor: color.withValues(alpha: 0.12),
      side: BorderSide(color: color.withValues(alpha: 0.4)),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

/// Order history list.
class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxContentWidth),
            child: ordersAsync.when(
              loading: () => const _OrdersSkeleton(),
              error: (e, _) => ErrorView(
                message: '$e',
                onRetry: () => ref.invalidate(ordersControllerProvider),
              ),
              data: (orders) {
                if (orders.isEmpty) {
                  return EmptyState(
                    icon: Icons.receipt_long_outlined,
                    title: 'No orders yet',
                    message: 'Your past orders will appear here',
                    action: FilledButton(
                      onPressed: () => context.go(Routes.home),
                      child: const Text('Start shopping'),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(Insets.lg),
                  itemCount: orders.length,
                  itemBuilder: (context, index) =>
                      _OrderCard(order: orders[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final created = order.createdAt;
    return Card(
      margin: const EdgeInsets.only(bottom: Insets.md),
      child: InkWell(
        borderRadius: Radii.mdAll,
        onTap: () => context.push(Routes.orderDetail(order.id)),
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Order #${order.id}',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Gaps.hSm,
                  OrderStatusChip(status: order.status),
                ],
              ),
              if (created != null) ...[
                Gaps.vSm,
                Text(
                  Formatters.date(created),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              Gaps.vSm,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${order.items.length} items',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    Formatters.currency(order.total),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrdersSkeleton extends StatelessWidget {
  const _OrdersSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Insets.lg),
      children: const [
        ShimmerBox(height: 96, borderRadius: Radii.mdAll),
        Gaps.vMd,
        ShimmerBox(height: 96, borderRadius: Radii.mdAll),
        Gaps.vMd,
        ShimmerBox(height: 96, borderRadius: Radii.mdAll),
        Gaps.vMd,
        ShimmerBox(height: 96, borderRadius: Radii.mdAll),
      ],
    );
  }
}
