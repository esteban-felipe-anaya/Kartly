import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../../../data/models/cart.dart';
import '../../../data/models/product.dart';
import '../../../data/models/promo.dart';
import 'cart_totals.dart';

part 'cart_controller.g.dart';

/// Owns the shopping cart. Syncs to the API and mirrors to local storage so the
/// cart survives app restarts and brief offline periods. The active promo is
/// held client-side and re-attached after every server response.
@Riverpod(keepAlive: true)
class CartController extends _$CartController {
  PromoResult? _promo;

  @override
  Future<Cart> build() async {
    try {
      final cart = await ref.read(cartRepositoryProvider).fetch();
      _cache(cart);
      return cart;
    } catch (e) {
      final cached = _readCache();
      if (cached != null) return cached;
      rethrow;
    }
  }

  Cart _withPromo(Cart cart) => cart.copyWith(promo: _promo);

  void _cache(Cart cart) {
    ref.read(localPrefsProvider).setCartCache(jsonEncode(cart.toJson()));
  }

  Cart? _readCache() {
    final raw = ref.read(localPrefsProvider).cartCache;
    if (raw == null) return null;
    try {
      return Cart.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> _mutate(Future<Cart> Function() op) async {
    state = const AsyncLoading<Cart>().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      final cart = _withPromo(await op());
      _cache(cart);
      return cart;
    });
  }

  Future<void> addProduct(
    Product product, {
    Map<String, String> variant = const {},
    int qty = 1,
  }) =>
      _mutate(() => ref.read(cartRepositoryProvider).addItem(
            productId: product.id,
            variant: variant,
            qty: qty,
            priceAtAdd: product.price,
          ));

  Future<void> updateQty(String itemId, int qty) =>
      _mutate(() => ref.read(cartRepositoryProvider).updateQty(itemId, qty));

  Future<void> removeItem(String itemId) =>
      _mutate(() => ref.read(cartRepositoryProvider).removeItem(itemId));

  /// Validates a promo code against the API and applies it to totals.
  /// Returns the validation result so the UI can show success/failure.
  Future<PromoResult> applyPromo(String code) async {
    final result = await ref.read(cartRepositoryProvider).validatePromo(code);
    _promo = result.valid ? result : null;
    final current = state.valueOrNull;
    if (current != null) {
      final updated = current.copyWith(promo: _promo);
      _cache(updated);
      state = AsyncData(updated);
    }
    return result;
  }

  void clearPromo() {
    _promo = null;
    final current = state.valueOrNull;
    if (current != null) {
      final updated = current.copyWith(promo: null);
      _cache(updated);
      state = AsyncData(updated);
    }
  }

  /// Called after a successful checkout to reset local cart state.
  void reset() {
    _promo = null;
    final empty = Cart(id: state.valueOrNull?.id, items: const [], promo: null);
    _cache(empty);
    state = AsyncData(empty);
  }
}

/// Derived cart totals. Recomputes whenever the cart changes.
@riverpod
CartTotals cartTotals(Ref ref) {
  final cart = ref.watch(cartControllerProvider).valueOrNull;
  if (cart == null) {
    return const CartTotals(
      itemCount: 0,
      subtotal: 0,
      discount: 0,
      shipping: 0,
      tax: 0,
      total: 0,
    );
  }
  return computeCartTotals(cart);
}

/// Total item count for the cart badge.
@riverpod
int cartItemCount(Ref ref) =>
    ref.watch(cartControllerProvider).valueOrNull?.totalQuantity ?? 0;
