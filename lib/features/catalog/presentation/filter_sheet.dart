import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../application/catalog_providers.dart';

const double _kMinPrice = 0;
const double _kMaxPrice = 500;
const List<double> _kRatings = [3.0, 3.5, 4.0, 4.5];

/// Bottom sheet for refining catalog results by price, rating and brand.
class CatalogFilterSheet extends ConsumerStatefulWidget {
  const CatalogFilterSheet({super.key, this.categoryId});

  final String? categoryId;

  @override
  ConsumerState<CatalogFilterSheet> createState() => _CatalogFilterSheetState();
}

class _CatalogFilterSheetState extends ConsumerState<CatalogFilterSheet> {
  late RangeValues _price;
  double? _minRating;
  String? _brand;

  @override
  void initState() {
    super.initState();
    final query = ref.read(catalogQueryProvider(widget.categoryId));
    _price = RangeValues(
      query.minPrice ?? _kMinPrice,
      query.maxPrice ?? _kMaxPrice,
    );
    _minRating = query.minRating;
    _brand = query.brand;
  }

  void _reset() {
    ref.read(catalogQueryProvider(widget.categoryId).notifier).reset();
    Navigator.of(context).pop();
  }

  void _apply() {
    final minPrice = _price.start > _kMinPrice ? _price.start : null;
    final maxPrice = _price.end < _kMaxPrice ? _price.end : null;
    ref.read(catalogQueryProvider(widget.categoryId).notifier).applyFilters(
          minPrice: minPrice,
          maxPrice: maxPrice,
          minRating: _minRating,
          brand: _brand,
          clearBrand: _brand == null,
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: Insets.lg,
        right: Insets.lg,
        bottom: MediaQuery.viewInsetsOf(context).bottom + Insets.lg,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filters',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            Gaps.vLg,
            Text('Price range', style: theme.textTheme.titleMedium),
            RangeSlider(
              values: _price,
              min: _kMinPrice,
              max: _kMaxPrice,
              divisions: 50,
              labels: RangeLabels(
                Formatters.currency(_price.start),
                Formatters.currency(_price.end),
              ),
              onChanged: (v) => setState(() => _price = v),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Formatters.currency(_price.start), style: theme.textTheme.bodyMedium),
                Text(Formatters.currency(_price.end), style: theme.textTheme.bodyMedium),
              ],
            ),
            Gaps.vLg,
            Text('Minimum rating', style: theme.textTheme.titleMedium),
            Gaps.vSm,
            Wrap(
              spacing: Insets.sm,
              children: [
                for (final r in _kRatings)
                  FilterChip(
                    label: Text('${r.toStringAsFixed(1)}+'),
                    avatar: const Icon(Icons.star_rounded, size: 18),
                    selected: _minRating == r,
                    onSelected: (sel) =>
                        setState(() => _minRating = sel ? r : null),
                  ),
              ],
            ),
            Gaps.vLg,
            Text('Brand', style: theme.textTheme.titleMedium),
            Gaps.vSm,
            _BrandFilter(
              categoryId: widget.categoryId,
              selected: _brand,
              onSelected: (b) => setState(() => _brand = b),
            ),
            Gaps.vLg,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _reset,
                    child: const Text('Reset'),
                  ),
                ),
                Gaps.hMd,
                Expanded(
                  child: FilledButton(
                    onPressed: _apply,
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandFilter extends ConsumerWidget {
  const _BrandFilter({
    required this.categoryId,
    required this.selected,
    required this.onSelected,
  });

  final String? categoryId;
  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(categoryBrandsProvider(categoryId)).when(
          data: (brands) {
            if (brands.isEmpty) {
              return Text(
                'No brands available',
                style: Theme.of(context).textTheme.bodyMedium,
              );
            }
            return Wrap(
              spacing: Insets.sm,
              runSpacing: Insets.xs,
              children: [
                for (final b in brands)
                  FilterChip(
                    label: Text(b),
                    selected: selected == b,
                    onSelected: (sel) => onSelected(sel ? b : null),
                  ),
              ],
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.all(Insets.sm),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          error: (e, _) => Text(
            'Could not load brands',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
  }
}
