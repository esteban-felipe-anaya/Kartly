import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/address.dart';
import '../../../shared/widgets/states.dart';
import '../../account/application/address_controller.dart';
import '../../cart/application/cart_controller.dart';
import '../../cart/application/cart_totals.dart';
import '../application/checkout_controller.dart';

const double _maxContentWidth = 720;

/// Checkout flow: choose address, shipping and payment, review the order
/// summary, then place the order.
class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  bool _placing = false;

  Future<void> _placeOrder() async {
    if (_placing) return;
    setState(() => _placing = true);
    try {
      final order =
          await ref.read(checkoutControllerProvider.notifier).placeOrder();
      if (!mounted) return;
      context.go(Routes.orderSuccess(order.id));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => _placing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkout = ref.watch(checkoutControllerProvider);
    final totals = ref.watch(cartTotalsProvider);
    final canPlace = checkout.addressId != null && !totals.isEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxContentWidth),
            child: ListView(
              padding: const EdgeInsets.all(Insets.lg),
              children: [
                _SectionCard(
                  title: 'Delivery address',
                  child: _AddressSection(selectedId: checkout.addressId),
                ),
                Gaps.vMd,
                _SectionCard(
                  title: 'Shipping method',
                  child: _ShippingSection(selected: checkout.shipping),
                ),
                Gaps.vMd,
                _SectionCard(
                  title: 'Payment method',
                  child: _PaymentSection(selected: checkout.payment),
                ),
                Gaps.vMd,
                _SectionCard(
                  title: 'Order summary',
                  child: _OrderSummary(totals: totals),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _PlaceOrderBar(
        enabled: canPlace,
        placing: _placing,
        total: totals.total,
        onPressed: _placeOrder,
      ),
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

class _AddressSection extends ConsumerWidget {
  const _AddressSection({required this.selectedId});

  final String? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final addressesAsync = ref.watch(addressControllerProvider);
    return addressesAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(Insets.lg),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => ErrorView(
        message: '$e',
        onRetry: () => ref.invalidate(addressControllerProvider),
      ),
      data: (addresses) {
        if (addresses.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You have no saved addresses yet.',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              Gaps.vMd,
              FilledButton.icon(
                onPressed: () => context.push(Routes.addressNew),
                icon: const Icon(Icons.add_location_alt_outlined),
                label: const Text('Add address'),
              ),
            ],
          );
        }
        return RadioGroup<String>(
          groupValue: selectedId,
          onChanged: (value) {
            if (value != null) {
              ref
                  .read(checkoutControllerProvider.notifier)
                  .selectAddress(value);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final Address address in addresses)
                RadioListTile<String>(
                  value: address.id,
                  contentPadding: EdgeInsets.zero,
                  title: Text(address.label),
                  subtitle: Text(address.singleLine),
                ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => context.push(Routes.addressNew),
                  icon: const Icon(Icons.add),
                  label: const Text('Add new address'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ShippingSection extends ConsumerWidget {
  const _ShippingSection({required this.selected});

  final ShippingMethod selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RadioGroup<ShippingMethod>(
      groupValue: selected,
      onChanged: (value) {
        if (value != null) {
          ref.read(checkoutControllerProvider.notifier).selectShipping(value);
        }
      },
      child: Column(
        children: [
          for (final method in ShippingMethod.values)
            RadioListTile<ShippingMethod>(
              value: method,
              contentPadding: EdgeInsets.zero,
              title: Text(method.label),
              secondary: Text(Formatters.currency(method.fee)),
            ),
        ],
      ),
    );
  }
}

class _PaymentSection extends ConsumerWidget {
  const _PaymentSection({required this.selected});

  final PaymentMethod selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        RadioGroup<PaymentMethod>(
          groupValue: selected,
          onChanged: (value) {
            if (value != null) {
              ref
                  .read(checkoutControllerProvider.notifier)
                  .selectPayment(value);
            }
          },
          child: Column(
            children: [
              for (final method in PaymentMethod.values)
                RadioListTile<PaymentMethod>(
                  value: method,
                  contentPadding: EdgeInsets.zero,
                  title: Text(method.label),
                ),
            ],
          ),
        ),
        if (selected == PaymentMethod.card) ...[
          Gaps.vMd,
          const _MockCardForm(),
        ],
      ],
    );
  }
}

class _MockCardForm extends StatelessWidget {
  const _MockCardForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Card number',
            hintText: '1234 5678 9012 3456',
            border: OutlineInputBorder(),
          ),
        ),
        Gaps.vMd,
        Row(
          children: [
            const Expanded(
              child: TextField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: 'Expiry',
                  hintText: 'MM/YY',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Gaps.hMd,
            const Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'CVC',
                  hintText: '123',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OrderSummary extends StatelessWidget {
  const _OrderSummary({required this.totals});

  final CartTotals totals;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _SummaryRow(
          label: 'Subtotal',
          value: Formatters.currency(totals.subtotal),
        ),
        if (totals.discount > 0) ...[
          Gaps.vSm,
          _SummaryRow(
            label: 'Discount',
            value: '-${Formatters.currency(totals.discount)}',
            valueColor: theme.colorScheme.tertiary,
          ),
        ],
        Gaps.vSm,
        _SummaryRow(
          label: 'Shipping',
          value: Formatters.currency(totals.shipping),
        ),
        Gaps.vSm,
        _SummaryRow(label: 'Tax', value: Formatters.currency(totals.tax)),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: Insets.sm),
          child: Divider(),
        ),
        _SummaryRow(
          label: 'Total',
          value: Formatters.currency(totals.total),
          bold: true,
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
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

class _PlaceOrderBar extends StatelessWidget {
  const _PlaceOrderBar({
    required this.enabled,
    required this.placing,
    required this.total,
    required this.onPressed,
  });

  final bool enabled;
  final bool placing;
  final double total;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 8,
      color: theme.colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: (enabled && !placing) ? onPressed : null,
              child: placing
                  ? const SizedBox(
                      width: Insets.xl,
                      height: Insets.xl,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('Place order • ${Formatters.currency(total)}'),
            ),
          ),
        ),
      ),
    );
  }
}
