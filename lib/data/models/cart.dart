import 'package:freezed_annotation/freezed_annotation.dart';

import 'promo.dart';

part 'cart.freezed.dart';
part 'cart.g.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    String? id,
    required String productId,
    @Default(<String, String>{}) Map<String, String> variant,
    @Default(1) int qty,
    @Default(0) double priceAtAdd,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
}

@freezed
class Cart with _$Cart {
  const Cart._();

  const factory Cart({
    String? id,
    String? userId,
    @Default(<CartItem>[]) List<CartItem> items,
    PromoResult? promo,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  int get totalQuantity => items.fold(0, (sum, i) => sum + i.qty);
}
