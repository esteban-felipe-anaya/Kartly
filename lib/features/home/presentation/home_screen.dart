import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../data/models/category.dart';
import '../../../data/models/home_banner.dart';
import '../../../data/models/product.dart';
import '../../../shared/widgets/app_buttons.dart';
import '../../../shared/widgets/app_network_image.dart';
import '../../../shared/widgets/product_grid.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/states.dart';
import '../../catalog/application/catalog_providers.dart';
import '../application/home_providers.dart';

/// Home landing screen: banner carousel, category shortcuts and product rails.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kartly',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        actions: const [NotificationsButton(), CartButton()],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(bannersProvider)
            ..invalidate(categoriesProvider)
            ..invalidate(featuredProductsProvider)
            ..invalidate(dealsProvider)
            ..invalidate(newArrivalsProvider);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: Insets.xxl),
          children: [
            Gaps.vMd,
            const _BannerCarousel(),
            Gaps.vMd,
            const _CategoryShortcuts(),
            SectionHeader(
              title: 'Featured',
              actionLabel: 'See all',
              onAction: () => context.go(Routes.catalog),
            ),
            _ProductRailSection(provider: featuredProductsProvider),
            const SectionHeader(title: 'Deals'),
            _ProductRailSection(provider: dealsProvider),
            const SectionHeader(title: 'New Arrivals'),
            _ProductRailSection(provider: newArrivalsProvider),
          ],
        ),
      ),
    );
  }
}

/// Autoplaying promotional banner carousel.
class _BannerCarousel extends ConsumerWidget {
  const _BannerCarousel();

  static const double _height = 180;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(bannersProvider).when(
          data: (banners) {
            if (banners.isEmpty) return const SizedBox.shrink();
            return CarouselSlider.builder(
              itemCount: banners.length,
              options: CarouselOptions(
                height: _height,
                viewportFraction: 0.9,
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayInterval: const Duration(seconds: 5),
              ),
              itemBuilder: (context, index, _) => _BannerCard(banner: banners[index]),
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.lg),
            child: ShimmerBox(height: _height, borderRadius: Radii.lgAll),
          ),
          error: (e, _) => SizedBox(
            height: _height,
            child: ErrorView(
              message: '$e',
              onRetry: () => ref.invalidate(bannersProvider),
            ),
          ),
        );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.banner});

  final HomeBanner banner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final card = Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.xs),
      child: ClipRRect(
        borderRadius: Radii.lgAll,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppNetworkImage(url: banner.image),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.65),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Insets.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    banner.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gaps.xs,
                  Text(
                    banner.subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final ctaId = banner.ctaProductId;
    if (ctaId == null) return card;
    return GestureDetector(
      onTap: () => context.push(Routes.product(ctaId)),
      child: card,
    );
  }
}

/// Horizontal row of circular category shortcuts.
class _CategoryShortcuts extends ConsumerWidget {
  const _CategoryShortcuts();

  static const double _height = 104;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(categoriesProvider).when(
          data: (categories) {
            if (categories.isEmpty) return const SizedBox.shrink();
            return SizedBox(
              height: _height,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
                itemCount: categories.length,
                separatorBuilder: (_, _) => Gaps.hMd,
                itemBuilder: (context, i) => _CategoryChip(category: categories[i]),
              ),
            );
          },
          loading: () => SizedBox(
            height: _height,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              itemCount: 6,
              separatorBuilder: (_, _) => Gaps.hMd,
              itemBuilder: (_, _) => const SizedBox(
                width: 64,
                child: ShimmerBox(borderRadius: Radii.lgAll),
              ),
            ),
          ),
          error: (_, _) => const SizedBox.shrink(),
        );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: Radii.lgAll,
      onTap: () => context.push('${Routes.catalog}?categoryId=${category.id}'),
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: scheme.secondaryContainer,
              child: Icon(_iconFor(category.icon), color: scheme.onSecondaryContainer),
            ),
            Gaps.xs,
            Text(
              category.name,
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(String icon) {
    switch (icon) {
      case 'headphones':
        return Icons.headphones;
      case 'watch':
        return Icons.watch;
      case 'laptop':
        return Icons.laptop;
      case 'smartphone':
        return Icons.smartphone;
      case 'home':
        return Icons.home;
      case 'sports_esports':
        return Icons.sports_esports;
      default:
        return Icons.category;
    }
  }
}

/// A product rail backed by a [FutureProvider] of products.
class _ProductRailSection extends ConsumerWidget {
  const _ProductRailSection({required this.provider});

  final AutoDisposeFutureProvider<List<Product>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(provider).when(
          data: (products) {
            if (products.isEmpty) return const SizedBox.shrink();
            return ProductRail(
              products: products,
              onTapProduct: (p) => context.push(Routes.product(p.id)),
            );
          },
          loading: ProductRailSkeleton.new,
          error: (e, _) => SizedBox(
            height: 300,
            child: ErrorView(
              message: '$e',
              onRetry: () => ref.invalidate(provider),
            ),
          ),
        );
  }
}
