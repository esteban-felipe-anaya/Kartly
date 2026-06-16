import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../core/theme/design_tokens.dart';

/// Read-only star rating, optionally annotated with the numeric value and an
/// optional review count.
class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
    this.reviewCount,
    this.size = 16,
    this.showValue = true,
  });

  final double rating;
  final int? reviewCount;
  final double size;
  final bool showValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RatingBarIndicator(
          rating: rating,
          itemCount: 5,
          itemSize: size,
          unratedColor: theme.colorScheme.surfaceContainerHighest,
          itemBuilder: (_, _) => Icon(Icons.star_rounded, color: theme.colorScheme.primary),
        ),
        if (showValue) ...[
          const SizedBox(width: Insets.xs),
          Text(rating.toStringAsFixed(1), style: theme.textTheme.labelMedium),
        ],
        if (reviewCount != null) ...[
          const SizedBox(width: Insets.xs),
          Text(
            '($reviewCount)',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
