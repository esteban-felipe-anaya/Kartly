import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../shared/widgets/product_grid.dart';
import '../../../shared/widgets/states.dart';
import '../application/search_providers.dart';

/// Full-text product search with recent-term suggestions.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final SearchController _controller = SearchController();
  String _term = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit(String value) {
    final term = value.trim();
    if (term.isEmpty) {
      setState(() => _term = '');
      return;
    }
    ref.read(recentSearchesProvider.notifier).add(term);
    setState(() => _term = term);
  }

  void _runTerm(String term) {
    _controller.text = term;
    _submit(term);
  }

  void _clear() {
    _controller.clear();
    setState(() => _term = '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Insets.lg),
            child: SearchBar(
              controller: _controller,
              hintText: 'Search products or brands',
              leading: const Icon(Icons.search),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: Insets.lg),
              ),
              onSubmitted: _submit,
              trailing: [
                if (_controller.text.isNotEmpty)
                  IconButton(
                    tooltip: 'Clear',
                    icon: const Icon(Icons.close),
                    onPressed: _clear,
                  ),
              ],
            ),
          ),
          Expanded(
            child: _term.isEmpty
                ? _RecentSearches(onSelect: _runTerm)
                : _Results(term: _term),
          ),
        ],
      ),
    );
  }
}

class _Results extends ConsumerWidget {
  const _Results({required this.term});

  final String term;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(searchResultsProvider(term)).when(
          data: (products) {
            if (products.isEmpty) {
              return EmptyState(
                icon: Icons.search_off,
                title: 'No results for "$term"',
                message: 'Try a different search term',
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
            onRetry: () => ref.invalidate(searchResultsProvider(term)),
          ),
        );
  }
}

class _RecentSearches extends ConsumerWidget {
  const _RecentSearches({required this.onSelect});

  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recents = ref.watch(recentSearchesProvider);

    if (recents.isEmpty) {
      return const EmptyState(
        icon: Icons.search,
        title: 'Search Kartly',
        message: 'Find products by name or brand',
      );
    }

    return ListView(
      padding: const EdgeInsets.all(Insets.lg),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Recent searches',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            TextButton(
              onPressed: () => ref.read(recentSearchesProvider.notifier).clear(),
              child: const Text('Clear'),
            ),
          ],
        ),
        Gaps.vSm,
        Wrap(
          spacing: Insets.sm,
          runSpacing: Insets.xs,
          children: [
            for (final term in recents)
              ActionChip(
                avatar: const Icon(Icons.history, size: 18),
                label: Text(term),
                onPressed: () => onSelect(term),
              ),
          ],
        ),
      ],
    );
  }
}
