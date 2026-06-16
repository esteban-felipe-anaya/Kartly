import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/cart.dart';
import '../../../data/models/product.dart';
import '../../../shared/widgets/app_network_image.dart';
import '../../../shared/widgets/quantity_stepper.dart';
import '../../../shared/widgets/states.dart';
import '../application/cart_controller.dart';
import '../application/cart_products_provider.dart';
import '../application/cart_totals.dart';

const double _maxContentWidth = 720;
const double _thumbSize = 64;

/// Shopping cart: line items with quantity controls, promo code entry,
/// totals breakdown and checkout call-to-action.
class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  final TextEditingController _promoController = TextEditingController();
  bool _applyingPromo = false;

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  Future<void> _applyPromo() async {
    final code = _promoController.text.trim();
    if (code.isEmpty || _applyingPromo) return;
    setState(() => _applyingPromo = true);
    try {
      final result =
          await ref.read(cartControllerProvider.notifier).applyPromo(code);
      if (!mounted) return;
      final message = result.valid
          ? 'Promo applied: ${result.discountPct.toStringAsFixed(0)}% off'
          : 'Invalid promo code';
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
      if (result.valid) _promoController.clear();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Could not apply promo: $e')));
    } finally {
      if (mounted) setState(() => _applyingPromo = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartAsync = ref.watch(cartControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxContentWidth),
            child: cartAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => ErrorView(
                message: '$e',
                onRetry: () => ref.invalidate(cartControllerProvider),
              ),
              data: (cart) => cart.items.isEmpty
                  ? const _EmptyCart()
                  : _buildCartBody(cart),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCartBody(Cart cart) {
    final totals = ref.watch(cartTotalsProvider);
    final products = ref.watch(cartProductsProvider).valueOrNull ?? const {};
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(Insets.lg),
            children: [
              for (final item in cart.items)
                _CartItemRow(
                  key: ValueKey(item.id ?? item.productId),
                  item: item,
                  product: products[item.productId],
                  onQtyChanged: (v) {
                    final id = item.id;
                    if (id != null) {
                      ref
                          .read(cartControllerProvider.notifier)
                          .updateQty(id, v);
                    }
                  },
                  onRemove: () {
                    final id = item.id;
                    if (id != null) {
                      ref
                          .read(cartControllerProvider.notifier)
                          .removeItem(id);
                    }
                  },
                ),
              Gaps.vLg,
              _PromoSection(
                controller: _promoController,
                applying: _applyingPromo,
                promo: cart.promo?.valid ?? false ? cart.promo!.code : null,
                onApply: _applyPromo,
                onClear: () =>
                    ref.read(cartControllerProvider.notifier).clearPromo(),
              ),
              Gaps.vLg,
              _TotalsCard(totals: totals),
            ],
          ),
        ),
        _CheckoutBar(enabled: cart.items.isNotEmpty),
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.shopping_cart_outlined,
      title: 'Your cart is empty',
      message: 'Browse products and add them here',
      action: FilledButton(
        onPressed: () => context.go(Routes.home),
        child: const Text('Start shopping'),
      ),
    );
  }
}

class _CartItemRow extends StatelessWidget {
  const _CartItemRow({
    super.key,
    required this.item,
    required this.product,
    required this.onQtyChanged,
    required this.onRemove,
  });

  final CartItem item;
  final Product? product;
  final ValueChanged<int> onQtyChanged;
  final VoidCallback onRemove;

  String get _title => product?.title ?? item.productId;

  String? get _variantSummary {
    if (item.variant.isEmpty) return null;
    return item.variant.entries.map((e) {
      final label = e.key.isEmpty
          ? e.value
          : '${e.key[0].toUpperCase()}${e.key.substring(1)}: ${e.value}';
      return label;
    }).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final variant = _variantSummary;
    return Dismissible(
      key: ValueKey('dismiss_${item.id ?? item.productId}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemove(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: Radii.lgAll,
        ),
        child: Icon(Icons.delete_outline, color: theme.colorScheme.onErrorContainer),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: Insets.md),
        child: Padding(
          padding: const EdgeInsets.all(Insets.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppNetworkImage(
                url: product?.primaryImage,
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
                      _title,
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
                    Gaps.vSm,
                    Text(
                      Formatters.currency(item.priceAtAdd),
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Gaps.vSm,
                    QuantityStepper(
                      dense: true,
                      quantity: item.qty,
                      onChanged: onQtyChanged,
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Remove item',
                onPressed: onRemove,
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PromoSection extends StatelessWidget {
  const _PromoSection({
    required this.controller,
    required this.applying,
    required this.promo,
    required this.onApply,
    required this.onClear,
  });

  final TextEditingController controller;
  final bool applying;
  final String? promo;
  final VoidCallback onApply;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => onApply(),
                decoration: const InputDecoration(
                  labelText: 'Promo code',
                  helperText: 'Try WELCOME10, SAVE20 or KARTLY15',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Gaps.hMd,
            Padding(
              padding: const EdgeInsets.only(top: Insets.sm),
              child: FilledButton.tonal(
                onPressed: applying ? null : onApply,
                child: applying
                    ? const SizedBox(
                        width: Insets.lg,
                        height: Insets.lg,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Apply'),
              ),
            ),
          ],
        ),
        if (promo != null) ...[
          Gaps.vSm,
          Align(
            alignment: Alignment.centerLeft,
            child: InputChip(
              label: Text('Promo: $promo'),
              avatar: Icon(Icons.local_offer_outlined,
                  color: theme.colorScheme.primary),
              onDeleted: onClear,
            ),
          ),
        ],
      ],
    );
  }
}

class _TotalsCard extends StatelessWidget {
  const _TotalsCard({required this.totals});

  final CartTotals totals;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          children: [
            _TotalsRow(
              label: 'Subtotal',
              value: Formatters.currency(totals.subtotal),
            ),
            if (totals.discount > 0) ...[
              Gaps.vSm,
              _TotalsRow(
                label: 'Discount',
                value: '-${Formatters.currency(totals.discount)}',
                valueColor: theme.colorScheme.tertiary,
              ),
            ],
            Gaps.vSm,
            _TotalsRow(
              label: 'Shipping',
              value: Formatters.currency(totals.shipping),
            ),
            Gaps.vSm,
            _TotalsRow(label: 'Tax', value: Formatters.currency(totals.tax)),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: Insets.sm),
              child: Divider(),
            ),
            _TotalsRow(
              label: 'Total',
              value: Formatters.currency(totals.total),
              bold: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _TotalsRow extends StatelessWidget {
  const _TotalsRow({
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
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            value,
            key: ValueKey(value),
            style: style?.copyWith(color: valueColor),
          ),
        ),
      ],
    );
  }
}

class _CheckoutBar extends StatelessWidget {
  const _CheckoutBar({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 8,
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed:
                enabled ? () => context.push(Routes.checkout) : null,
            child: const Text('Proceed to checkout'),
          ),
        ),
      ),
    );
  }
}
