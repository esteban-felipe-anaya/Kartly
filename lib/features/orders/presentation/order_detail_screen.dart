import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/order.dart';
import '../../../shared/widgets/app_network_image.dart';
import '../../../shared/widgets/states.dart';
import '../application/orders_controller.dart';
import 'orders_screen.dart';

const double _maxContentWidth = 720;
const double _thumbSize = 56;

/// Canonical order progress stages used to render the timeline.
const List<String> _stages = ['placed', 'packed', 'shipped', 'delivered'];

/// Detailed view of a single order: status timeline, line items, totals and
/// payment/shipping summary.
class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(orderDetailProvider(orderId));
    return Scaffold(
      appBar: AppBar(title: const Text('Order details')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxContentWidth),
            child: orderAsync.when(
              loading: () => const _DetailSkeleton(),
              error: (e, _) => ErrorView(
                message: '$e',
                onRetry: () => ref.invalidate(orderDetailProvider(orderId)),
              ),
              data: (order) => _OrderDetailBody(order: order),
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderDetailBody extends StatelessWidget {
  const _OrderDetailBody({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(Insets.lg),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Order #${order.id}',
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Gaps.hSm,
            OrderStatusChip(status: order.status),
          ],
        ),
        if (order.createdAt != null) ...[
          Gaps.vSm,
          Text(
            Formatters.dateTime(order.createdAt!),
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
        Gaps.vLg,
        _SectionCard(
          title: 'Status',
          child: _Timeline(order: order),
        ),
        Gaps.vMd,
        _SectionCard(
          title: 'Items',
          child: Column(
            children: [
              for (final item in order.items) _OrderItemRow(item: item),
            ],
          ),
        ),
        Gaps.vMd,
        _SectionCard(
          title: 'Summary',
          child: _TotalsBreakdown(order: order),
        ),
        Gaps.vMd,
        _SectionCard(
          title: 'Payment & shipping',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LabelValue(label: 'Payment', value: order.paymentMethod),
              Gaps.vSm,
              _LabelValue(label: 'Shipping', value: order.shippingMethod),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            Gaps.vMd,
            child,
          ],
        ),
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final statusIndex = _stages.indexOf(order.status);
    final timelineStatuses = order.timeline.map((e) => e.status).toSet();

    return Column(
      children: [
        for (var i = 0; i < _stages.length; i++)
          _TimelineStage(
            stage: _stages[i],
            completed:
                timelineStatuses.contains(_stages[i]) || i <= statusIndex,
            isLast: i == _stages.length - 1,
            date: _dateFor(_stages[i]),
          ),
      ],
    );
  }

  DateTime? _dateFor(String stage) {
    for (final entry in order.timeline) {
      if (entry.status == stage) return entry.date;
    }
    return null;
  }
}

class _TimelineStage extends StatelessWidget {
  const _TimelineStage({
    required this.stage,
    required this.completed,
    required this.isLast,
    required this.date,
  });

  final String stage;
  final bool completed;
  final bool isLast;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final color = completed ? scheme.primary : scheme.outline;
    final label = '${stage[0].toUpperCase()}${stage.substring(1)}';

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                completed
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked,
                color: color,
                size: Insets.xl,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: completed ? scheme.primary : scheme.outlineVariant,
                  ),
                ),
            ],
          ),
          Gaps.hMd,
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : Insets.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: completed ? null : scheme.onSurfaceVariant,
                    ),
                  ),
                  if (date != null) ...[
                    Gaps.xs,
                    Text(
                      Formatters.dateTime(date!),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  const _OrderItemRow({required this.item});

  final OrderItem item;

  String? get _variantSummary {
    if (item.variant.isEmpty) return null;
    return item.variant.entries.map((e) {
      final key = e.key;
      final label = key.isEmpty
          ? e.value
          : '${key[0].toUpperCase()}${key.substring(1)}: ${e.value}';
      return label;
    }).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final variant = _variantSummary;
    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppNetworkImage(
            url: item.image,
            width: _thumbSize,
            height: _thumbSize,
            borderRadius: Radii.mdAll,
          ),
          Gaps.hMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: theme.textTheme.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (variant != null) ...[
                  Gaps.xs,
                  Text(
                    variant,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                Gaps.xs,
                Text(
                  'x${item.qty}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Gaps.hMd,
          Text(
            Formatters.currency(item.priceAtAdd * item.qty),
            style: theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _TotalsBreakdown extends StatelessWidget {
  const _TotalsBreakdown({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _LabelValue(
          label: 'Subtotal',
          value: Formatters.currency(order.subtotal),
        ),
        if (order.discount > 0) ...[
          Gaps.vSm,
          _LabelValue(
            label: 'Discount',
            value: '-${Formatters.currency(order.discount)}',
            valueColor: theme.colorScheme.tertiary,
          ),
        ],
        Gaps.vSm,
        _LabelValue(
          label: 'Shipping',
          value: Formatters.currency(order.shipping),
        ),
        Gaps.vSm,
        _LabelValue(label: 'Tax', value: Formatters.currency(order.tax)),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: Insets.sm),
          child: Divider(),
        ),
        _LabelValue(
          label: 'Total',
          value: Formatters.currency(order.total),
          bold: true,
        ),
      ],
    );
  }
}

class _LabelValue extends StatelessWidget {
  const _LabelValue({
    required this.label,
    required this.value,
    this.bold = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool bold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = bold
        ? theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)
        : theme.textTheme.bodyLarge;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style?.copyWith(color: valueColor)),
      ],
    );
  }
}

class _DetailSkeleton extends StatelessWidget {
  const _DetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Insets.lg),
      children: const [
        ShimmerBox(height: 28, width: 180, borderRadius: Radii.smAll),
        Gaps.vLg,
        ShimmerBox(height: 200, borderRadius: Radii.mdAll),
        Gaps.vMd,
        ShimmerBox(height: 160, borderRadius: Radii.mdAll),
        Gaps.vMd,
        ShimmerBox(height: 160, borderRadius: Radii.mdAll),
      ],
    );
  }
}
