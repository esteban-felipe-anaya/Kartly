import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../../../data/models/product.dart';
import '../../../data/models/product_query.dart';

part 'search_providers.g.dart';

/// Persisted recent search terms (most-recent first, capped at 8).
@Riverpod(keepAlive: true)
class RecentSearches extends _$RecentSearches {
  @override
  List<String> build() => ref.watch(localPrefsProvider).recentSearches;

  Future<void> add(String term) async {
    final trimmed = term.trim();
    if (trimmed.isEmpty) return;
    final next = [trimmed, ...state.where((t) => t.toLowerCase() != trimmed.toLowerCase())]
        .take(8)
        .toList();
    state = next;
    await ref.read(localPrefsProvider).setRecentSearches(next);
  }

  Future<void> clear() async {
    state = const [];
    await ref.read(localPrefsProvider).setRecentSearches(const []);
  }
}

/// Live search results for the given term (empty term → no results).
@riverpod
Future<List<Product>> searchResults(Ref ref, String term) async {
  if (term.trim().isEmpty) return const [];
  return ref
      .watch(catalogRepositoryProvider)
      .products(ProductQuery(q: term.trim(), limit: 50));
}
