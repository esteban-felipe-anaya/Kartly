import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/design_tokens.dart';
import '../../data/models/product.dart';
import '../../features/cart/application/cart_controller.dart';
import '../../features/wishlist/application/wishlist_controller.dart';
import 'app_network_image.dart';
import 'price_tag.dart';
import 'rating_stars.dart';

/// Reusable product tile used in grids and horizontal rails.
class ProductCard extends ConsumerWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.showWishlist = true,
  });

  final Product product;
  final VoidCallback onTap;
  final bool showWishlist;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final wishlisted = ref.watch(isWishlistedProvider(product.id));

    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                AppNetworkImage(url: product.primaryImage),
                if (product.hasDiscount)
                  Positioned(
                    top: Insets.sm,
                    left: Insets.sm,
                    child: _Badge(label: '-${product.discountPercent}%'),
                  ),
                if (showWishlist)
                  Positioned(
                    top: Insets.xs,
                    right: Insets.xs,
                    child: IconButton.filledTonal(
                      visualDensity: VisualDensity.compact,
                      isSelected: wishlisted,
                      onPressed: () =>
                          ref.read(wishlistControllerProvider.notifier).toggle(product.id),
                      icon: const Icon(Icons.favorite_border_rounded),
                      selectedIcon: const Icon(Icons.favorite_rounded),
                      tooltip: wishlisted ? 'Remove from wishlist' : 'Add to wishlist',
                    ),
                  ),
                if (!product.inStock)
                  Positioned.fill(
                    child: ColoredBox(
                      color: theme.colorScheme.scrim.withValues(alpha: 0.45),
                      child: Center(
                        child: Text(
                          'Out of stock',
                          style: theme.textTheme.labelLarge
                              ?.copyWith(color: theme.colorScheme.onInverseSurface),
                        ),
                      ),
                    ),
                  ),
              ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Insets.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand.toUpperCase(),
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: theme.colorScheme.primary, letterSpacing: 0.5),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Gaps.vSm,
                  RatingStars(rating: product.rating, size: 13, showValue: false),
                  Gaps.vSm,
                  Row(
                    children: [
                      Expanded(
                        child: PriceTag(
                          price: product.price,
                          compareAtPrice: product.compareAtPrice,
                          currency: product.currency,
                          compact: true,
                        ),
                      ),
                      if (product.inStock)
                        IconButton.filled(
                          visualDensity: VisualDensity.compact,
                          onPressed: () => _quickAdd(context, ref),
                          icon: const Icon(Icons.add_shopping_cart_rounded, size: 18),
                          tooltip: 'Add to cart',
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _quickAdd(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(cartControllerProvider.notifier).addProduct(product);
      messenger.showSnackBar(
        SnackBar(content: Text('Added "${product.title}" to cart')),
      );
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('$e')));
    }
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Insets.sm, vertical: 2),
      decoration: BoxDecoration(color: scheme.tertiary, borderRadius: Radii.smAll),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: scheme.onTertiary, fontWeight: FontWeight.w700),
      ),
    );
  }
}
