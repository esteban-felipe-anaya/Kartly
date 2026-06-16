import 'package:flutter/material.dart';

import '../../core/theme/design_tokens.dart';

/// Compact +/- quantity control used in the cart and product detail.
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.min = 1,
    this.max = 99,
    this.dense = false,
  });

  final int quantity;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final iconSize = dense ? 18.0 : 22.0;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(Radii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            iconSize: iconSize,
            visualDensity: dense ? VisualDensity.compact : null,
            onPressed: quantity > min ? () => onChanged(quantity - 1) : null,
            icon: const Icon(Icons.remove_rounded),
            tooltip: 'Decrease quantity',
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Text(
              '$quantity',
              key: ValueKey(quantity),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          IconButton(
            iconSize: iconSize,
            visualDensity: dense ? VisualDensity.compact : null,
            onPressed: quantity < max ? () => onChanged(quantity + 1) : null,
            icon: const Icon(Icons.add_rounded),
            tooltip: 'Increase quantity',
          ),
        ],
      ),
    );
  }
}
