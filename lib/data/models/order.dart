import 'package:freezed_annotation/freezed_annotation.dart';

import 'promo.dart';

part 'order.freezed.dart';
part 'order.g.dart';

enum OrderStatus { placed, packed, shipped, delivered, cancelled }

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String productId,
    @Default('') String title,
    String? image,
    @Default(<String, String>{}) Map<String, String> variant,
    @Default(1) int qty,
    @Default(0) double priceAtAdd,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
}

@freezed
class OrderTimelineEntry with _$OrderTimelineEntry {
  const factory OrderTimelineEntry({
    required String status,
    DateTime? date,
  }) = _OrderTimelineEntry;

  factory OrderTimelineEntry.fromJson(Map<String, dynamic> json) =>
      _$OrderTimelineEntryFromJson(json);
}

@freezed
class Order with _$Order {
  const factory Order({
    required String id,
    String? userId,
    @Default(<OrderItem>[]) List<OrderItem> items,
    String? addressId,
    @Default('standard') String shippingMethod,
    @Default('card') String paymentMethod,
    PromoResult? promo,
    @Default(0) double subtotal,
    @Default(0) double discount,
    @Default(0) double shipping,
    @Default(0) double tax,
    @Default(0) double total,
    @Default('placed') String status,
    @Default(<OrderTimelineEntry>[]) List<OrderTimelineEntry> timeline,
    DateTime? createdAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
