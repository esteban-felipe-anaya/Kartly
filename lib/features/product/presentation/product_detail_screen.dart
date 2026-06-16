import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/product.dart';
import '../../../data/models/review.dart';
import '../../../shared/widgets/app_buttons.dart';
import '../../../shared/widgets/app_network_image.dart';
import '../../../shared/widgets/price_tag.dart';
import '../../../shared/widgets/product_grid.dart';
import '../../../shared/widgets/quantity_stepper.dart';
import '../../../shared/widgets/rating_stars.dart';
import '../../../shared/widgets/states.dart';
import '../../cart/application/cart_controller.dart';
import '../../wishlist/application/wishlist_controller.dart';
import '../application/product_providers.dart';

const double _galleryHeight = 360;
const double _maxContentWidth = 900;
const int _maxReviews = 5;

/// Full product detail screen: gallery, pricing, variant pickers, add-to-cart,
/// description, reviews and related products.
class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  final PageController _galleryController = PageController();
  int _galleryPage = 0;
  int _qty = 1;
  String? _selectedColor;
  String? _selectedSize;
  bool _variantsInitialized = false;

  @override
  void dispose() {
    _galleryController.dispose();
    super.dispose();
  }

  void _initVariants(Product product) {
    if (_variantsInitialized) return;
    _variantsInitialized = true;
    if (product.variants.color.isNotEmpty) {
      _selectedColor = product.variants.color.first;
    }
    if (product.variants.size.isNotEmpty) {
      _selectedSize = product.variants.size.first;
    }
  }

  Future<void> _addToCart(Product product) async {
    final variant = <String, String>{};
    final color = _selectedColor;
    if (color != null) variant['color'] = color;
    final size = _selectedSize;
    if (size != null) variant['size'] = size;
    try {
      await ref
          .read(cartControllerProvider.notifier)
          .addProduct(product, variant: variant, qty: _qty);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Added to cart')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Could not add to cart: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(productDetailProvider(widget.productId));
    return detail.when(
      loading: () => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: const _DetailSkeleton(),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: ErrorView(
          message: '$e',
          onRetry: () =>
              ref.invalidate(productDetailProvider(widget.productId)),
        ),
      ),
      data: (product) {
        _initVariants(product);
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: Text(product.title, overflow: TextOverflow.ellipsis),
            actions: const [CartButton()],
          ),
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _maxContentWidth),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _Gallery(
                      images: product.images,
                      controller: _galleryController,
                      currentPage: _galleryPage,
                      onPageChanged: (i) => setState(() => _galleryPage = i),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Insets.lg),
                      child: _Details(
                        product: product,
                        qty: _qty,
                        selectedColor: _selectedColor,
                        selectedSize: _selectedSize,
                        onQtyChanged: (v) => setState(() => _qty = v),
                        onColorChanged: (c) =>
                            setState(() => _selectedColor = c),
                        onSizeChanged: (s) => setState(() => _selectedSize = s),
                        onAddToCart: () => _addToCart(product),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Gallery extends StatelessWidget {
  const _Gallery({
    required this.images,
    required this.controller,
    required this.currentPage,
    required this.onPageChanged,
  });

  final List<String> images;
  final PageController controller;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (images.isEmpty) {
      return const SizedBox(
        height: _galleryHeight,
        width: double.infinity,
        child: AppNetworkImage(url: null, height: _galleryHeight),
      );
    }
    return SizedBox(
      height: _galleryHeight,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: images.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, i) => AppNetworkImage(
              url: images[i],
              height: _galleryHeight,
              width: double.infinity,
            ),
          ),
          if (images.length > 1)
            Padding(
              padding: const EdgeInsets.only(bottom: Insets.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < images.length; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin:
                          const EdgeInsets.symmetric(horizontal: Insets.xs / 2),
                      width: i == currentPage ? Insets.md : Insets.sm,
                      height: Insets.sm,
                      decoration: BoxDecoration(
                        color: i == currentPage
                            ? scheme.primary
                            : scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(Radii.pill),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({
    required this.product,
    required this.qty,
    required this.selectedColor,
    required this.selectedSize,
    required this.onQtyChanged,
    required this.onColorChanged,
    required this.onSizeChanged,
    required this.onAddToCart,
  });

  final Product product;
  final int qty;
  final String? selectedColor;
  final String? selectedSize;
  final ValueChanged<int> onQtyChanged;
  final ValueChanged<String> onColorChanged;
  final ValueChanged<String> onSizeChanged;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.brand,
          style: theme.textTheme.labelLarge?.copyWith(color: scheme.primary),
        ),
        Gaps.xs,
        Text(product.title, style: theme.textTheme.headlineSmall),
        Gaps.vSm,
        RatingStars(rating: product.rating, reviewCount: product.reviewCount),
        Gaps.vMd,
        PriceTag(
          price: product.price,
          compareAtPrice: product.compareAtPrice,
          currency: product.currency,
          discountPercent: product.discountPercent,
        ),
        Gaps.vMd,
        _StockIndicator(inStock: product.inStock),
        if (product.variants.color.isNotEmpty) ...[
          Gaps.vLg,
          Text('Color', style: theme.textTheme.titleSmall),
          Gaps.vSm,
          Wrap(
            spacing: Insets.sm,
            runSpacing: Insets.sm,
            children: [
              for (final color in product.variants.color)
                ChoiceChip(
                  label: Text(color),
                  selected: selectedColor == color,
                  onSelected: (_) => onColorChanged(color),
                ),
            ],
          ),
        ],
        if (product.variants.size.isNotEmpty) ...[
          Gaps.vLg,
          Text('Size', style: theme.textTheme.titleSmall),
          Gaps.vSm,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SegmentedButton<String>(
              segments: [
                for (final size in product.variants.size)
                  ButtonSegment<String>(value: size, label: Text(size)),
              ],
              selected: {?selectedSize},
              onSelectionChanged: (selection) =>
                  onSizeChanged(selection.first),
            ),
          ),
        ],
        Gaps.vLg,
        Row(
          children: [
            QuantityStepper(quantity: qty, onChanged: onQtyChanged),
            Gaps.hMd,
            Expanded(
              child: FilledButton.icon(
                onPressed: product.inStock ? onAddToCart : null,
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Add to Cart'),
              ),
            ),
            Gaps.hSm,
            _WishlistButton(productId: product.id),
          ],
        ),
        Gaps.vLg,
        const Divider(),
        Gaps.vMd,
        Text('Description', style: theme.textTheme.titleMedium),
        Gaps.vSm,
        Text(
          product.description.isEmpty
              ? 'No description available.'
              : product.description,
          style: theme.textTheme.bodyMedium,
        ),
        Gaps.vXl,
        Text('Reviews', style: theme.textTheme.titleMedium),
        Gaps.vSm,
        _ReviewsSection(productId: product.id),
        Gaps.vXl,
        Text('You may also like', style: theme.textTheme.titleMedium),
        Gaps.vMd,
        _RelatedSection(productId: product.id),
        Gaps.vLg,
      ],
    );
  }
}

class _StockIndicator extends StatelessWidget {
  const _StockIndicator({required this.inStock});

  final bool inStock;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final color = inStock ? Colors.green.shade700 : scheme.error;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          inStock ? Icons.check_circle_outline : Icons.cancel_outlined,
          size: Insets.lg,
          color: color,
        ),
        Gaps.hSm,
        Text(
          inStock ? 'In stock' : 'Out of stock',
          style: theme.textTheme.labelLarge?.copyWith(color: color),
        ),
      ],
    );
  }
}

class _WishlistButton extends ConsumerWidget {
  const _WishlistButton({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlisted = ref.watch(isWishlistedProvider(productId));
    return IconButton.filledTonal(
      tooltip: wishlisted ? 'Remove from wishlist' : 'Add to wishlist',
      onPressed: () =>
          ref.read(wishlistControllerProvider.notifier).toggle(productId),
      icon: Icon(wishlisted ? Icons.favorite : Icons.favorite_border),
    );
  }
}

class _ReviewsSection extends ConsumerWidget {
  const _ReviewsSection({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final reviews = ref.watch(productReviewsProvider(productId));
    return reviews.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(Insets.lg),
        child: Center(
          child: SizedBox(
            width: Insets.xl,
            height: Insets.xl,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
      error: (e, _) => Text(
        'Could not load reviews.',
        style: theme.textTheme.bodySmall
            ?.copyWith(color: theme.colorScheme.error),
      ),
      data: (reviews) {
        if (reviews.isEmpty) {
          return Text(
            'No reviews yet.',
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          );
        }
        final shown = reviews.take(_maxReviews).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final review in shown) _ReviewTile(review: review),
            if (reviews.length > shown.length)
              Padding(
                padding: const EdgeInsets.only(top: Insets.sm),
                child: Text(
                  'Showing ${shown.length} of ${reviews.length} reviews',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: Insets.sm),
      child: Padding(
        padding: const EdgeInsets.all(Insets.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(review.user, style: theme.textTheme.titleSmall),
                ),
                if (review.date != null)
                  Text(
                    Formatters.date(review.date!),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
            Gaps.vSm,
            RatingStars(rating: review.rating, size: 14),
            if (review.comment.isNotEmpty) ...[
              Gaps.vSm,
              Text(review.comment, style: theme.textTheme.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }
}

class _RelatedSection extends ConsumerWidget {
  const _RelatedSection({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final related = ref.watch(relatedProductsProvider(productId));
    return related.when(
      loading: () => const ProductRailSkeleton(),
      error: (e, _) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
        child: Text(
          'Could not load related products.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
        ),
      ),
      data: (products) {
        if (products.isEmpty) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: ProductRail(
            products: products,
            onTapProduct: (p) => context.push(Routes.product(p.id)),
          ),
        );
      },
    );
  }
}

class _DetailSkeleton extends StatelessWidget {
  const _DetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxContentWidth),
        child: ListView(
          children: const [
            ShimmerBox(height: _galleryHeight, borderRadius: BorderRadius.zero),
            Padding(
              padding: EdgeInsets.all(Insets.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 120, height: 16),
                  Gaps.vSm,
                  ShimmerBox(width: 240, height: 28),
                  Gaps.vMd,
                  ShimmerBox(width: 160, height: 20),
                  Gaps.vLg,
                  ShimmerBox(width: 140, height: 24),
                  Gaps.vLg,
                  ShimmerBox(height: 48),
                  Gaps.vLg,
                  ShimmerBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
