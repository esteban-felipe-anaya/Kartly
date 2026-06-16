import 'package:flutter/material.dart';

import '../../core/theme/design_tokens.dart';
import '../../core/utils/responsive.dart';
import '../../data/models/product.dart';
import 'product_card.dart';
import 'states.dart';

const double _cardAspectRatio = 0.62;

SliverGridDelegate _gridDelegate(BuildContext context) =>
    SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: context.productGridColumns,
      crossAxisSpacing: Insets.md,
      mainAxisSpacing: Insets.md,
      childAspectRatio: _cardAspectRatio,
    );

/// Responsive product grid (2 / 3 / 4+ columns by screen size). Scrollable.
class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.products,
    required this.onTapProduct,
    this.padding = const EdgeInsets.all(Insets.lg),
    this.physics,
    this.shrinkWrap = false,
  });

  final List<Product> products;
  final void Function(Product product) onTapProduct;
  final EdgeInsets padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      gridDelegate: _gridDelegate(context),
      itemCount: products.length,
      itemBuilder: (context, i) => ProductCard(
        product: products[i],
        onTap: () => onTapProduct(products[i]),
      ),
    );
  }
}

/// Sliver variant for use inside a [CustomScrollView].
class SliverProductGrid extends StatelessWidget {
  const SliverProductGrid({
    super.key,
    required this.products,
    required this.onTapProduct,
  });

  final List<Product> products;
  final void Function(Product product) onTapProduct;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: _gridDelegate(context),
      itemCount: products.length,
      itemBuilder: (context, i) => ProductCard(
        product: products[i],
        onTap: () => onTapProduct(products[i]),
      ),
    );
  }
}

/// Shimmer placeholder matching the product grid layout.
class ProductGridSkeleton extends StatelessWidget {
  const ProductGridSkeleton({super.key, this.itemCount = 8});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(Insets.lg),
      gridDelegate: _gridDelegate(context),
      itemCount: itemCount,
      itemBuilder: (_, _) => const ShimmerBox(borderRadius: Radii.lgAll),
    );
  }
}

/// Horizontal scrolling rail of product cards (home/related sections).
class ProductRail extends StatelessWidget {
  const ProductRail({
    super.key,
    required this.products,
    required this.onTapProduct,
    this.height = 300,
    this.cardWidth = 180,
  });

  final List<Product> products;
  final void Function(Product product) onTapProduct;
  final double height;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
        itemCount: products.length,
        separatorBuilder: (_, _) => Gaps.hMd,
        itemBuilder: (context, i) => SizedBox(
          width: cardWidth,
          child: ProductCard(
            product: products[i],
            onTap: () => onTapProduct(products[i]),
          ),
        ),
      ),
    );
  }
}

class ProductRailSkeleton extends StatelessWidget {
  const ProductRailSkeleton({super.key, this.height = 300, this.cardWidth = 180});
  final double height;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
        itemCount: 5,
        separatorBuilder: (_, _) => Gaps.hMd,
        itemBuilder: (_, _) =>
            SizedBox(width: cardWidth, child: const ShimmerBox(borderRadius: Radii.lgAll)),
      ),
    );
  }
}
