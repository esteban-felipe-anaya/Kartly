import 'package:flutter/material.dart';

import '../../core/theme/design_tokens.dart';
import '../../core/utils/formatters.dart';

/// Displays a price, optionally with a struck-through compare-at price and a
/// discount percentage chip.
class PriceTag extends StatelessWidget {
  const PriceTag({
    super.key,
    required this.price,
    this.compareAtPrice,
    this.currency = 'USD',
    this.discountPercent,
    this.mainStyle,
    this.compact = false,
  });

  final double price;
  final double? compareAtPrice;
  final String currency;
  final int? discountPercent;
  final TextStyle? mainStyle;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final hasDiscount = compareAtPrice != null && compareAtPrice! > price;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: Insets.sm,
      runSpacing: Insets.xs,
      children: [
        Text(
          Formatters.currency(price, currencyCode: currency),
          style: mainStyle ??
              (compact ? theme.textTheme.titleSmall : theme.textTheme.titleMedium)
                  ?.copyWith(fontWeight: FontWeight.w700),
        ),
        if (hasDiscount)
          Text(
            Formatters.currency(compareAtPrice!, currencyCode: currency),
            style: theme.textTheme.bodySmall?.copyWith(
              decoration: TextDecoration.lineThrough,
              color: scheme.onSurfaceVariant,
            ),
          ),
        if (hasDiscount && (discountPercent ?? 0) > 0 && !compact)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Insets.sm, vertical: 2),
            decoration: BoxDecoration(
              color: scheme.tertiaryContainer,
              borderRadius: Radii.smAll,
            ),
            child: Text(
              '-$discountPercent%',
              style: theme.textTheme.labelSmall?.copyWith(
                color: scheme.onTertiaryContainer,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}
