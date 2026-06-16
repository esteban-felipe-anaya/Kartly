import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../data/models/product.dart';
import '../../../shared/widgets/app_buttons.dart';
import '../../../shared/widgets/product_grid.dart';
import '../../../shared/widgets/states.dart';
import '../../product/application/product_providers.dart';
import '../application/wishlist_controller.dart';

/// Shows the user's saved products, resolved from their wishlisted ids.
class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        actions: const [CartButton()],
      ),
      body: wishlist.when(
        data: (ids) => _WishlistBody(ids: ids),
        loading: () => const ProductGridSkeleton(),
        error: (e, _) => ErrorView(
          message: '$e',
          onRetry: () => ref.invalidate(wishlistControllerProvider),
        ),
      ),
    );
  }
}

class _WishlistBody extends ConsumerWidget {
  const _WishlistBody({required this.ids});

  final Set<String> ids;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ids.isEmpty) {
      return EmptyState(
        icon: Icons.favorite_border_rounded,
        title: 'No saved items',
        message: 'Tap the heart on any product to save it',
        action: FilledButton(
          onPressed: () => context.go(Routes.home),
          child: const Text('Browse products'),
        ),
      );
    }

    final products = <Product>[];
    var anyLoading = false;
    for (final id in ids) {
      final product = ref.watch(productDetailProvider(id)).valueOrNull;
      if (product != null) {
        products.add(product);
      } else {
        anyLoading = true;
      }
    }

    if (products.isEmpty && anyLoading) {
      return const ProductGridSkeleton();
    }

    return ProductGrid(
      products: products,
      onTapProduct: (p) => context.push(Routes.product(p.id)),
    );
  }
}
