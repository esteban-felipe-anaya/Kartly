import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../data/models/product_query.dart';
import '../../../shared/widgets/app_buttons.dart';
import '../../../shared/widgets/product_grid.dart';
import '../../../shared/widgets/states.dart';
import '../application/catalog_providers.dart';
import 'filter_sheet.dart';

/// Product catalog: sortable, filterable grid of products for a category.
class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key, this.categoryId});

  final String? categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(catalogQueryProvider(categoryId).notifier);
    final query = ref.watch(catalogQueryProvider(categoryId));
    final results = ref.watch(catalogResultsProvider(categoryId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: const [CartButton()],
      ),
      body: Column(
        children: [
          _Toolbar(
            sort: query.sort,
            activeFilterCount: query.activeFilterCount,
            onSortChanged: notifier.setSort,
            onFilters: () => showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              showDragHandle: true,
              builder: (_) => CatalogFilterSheet(categoryId: categoryId),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: results.when(
              data: (products) {
                if (products.isEmpty) {
                  return EmptyState(
                    icon: Icons.search_off,
                    title: 'No products found',
                    message: 'Try adjusting filters',
                    action: FilledButton(
                      onPressed: notifier.reset,
                      child: const Text('Reset filters'),
                    ),
                  );
                }
                return ProductGrid(
                  products: products,
                  onTapProduct: (p) => context.push(Routes.product(p.id)),
                );
              },
              loading: ProductGridSkeleton.new,
              error: (e, _) => ErrorView(
                message: '$e',
                onRetry: () => ref.invalidate(catalogResultsProvider(categoryId)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Toolbar extends StatelessWidget {
  const _Toolbar({
    required this.sort,
    required this.activeFilterCount,
    required this.onSortChanged,
    required this.onFilters,
  });

  final ProductSort sort;
  final int activeFilterCount;
  final ValueChanged<ProductSort> onSortChanged;
  final VoidCallback onFilters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.lg, vertical: Insets.sm),
      child: Row(
        children: [
          Expanded(
            child: PopupMenuButton<ProductSort>(
              initialValue: sort,
              onSelected: onSortChanged,
              itemBuilder: (context) => [
                for (final s in ProductSort.values)
                  PopupMenuItem(value: s, child: Text(s.label)),
              ],
              child: InputDecorator(
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(borderRadius: Radii.smAll),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: Insets.md, vertical: Insets.sm),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.sort, size: 18),
                    Gaps.hSm,
                    Expanded(
                      child: Text(
                        sort.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ),
          Gaps.hMd,
          OutlinedButton.icon(
            onPressed: onFilters,
            icon: const Icon(Icons.tune),
            label: activeFilterCount > 0
                ? Badge(
                    label: Text('$activeFilterCount'),
                    child: const Text('Filters'),
                  )
                : const Text('Filters'),
          ),
        ],
      ),
    );
  }
}
