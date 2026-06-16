// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      productId: json['productId'] as String,
      title: json['title'] as String? ?? '',
      image: json['image'] as String?,
      variant:
          (json['variant'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
      qty: (json['qty'] as num?)?.toInt() ?? 1,
      priceAtAdd: (json['priceAtAdd'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'title': instance.title,
      'image': instance.image,
      'variant': instance.variant,
      'qty': instance.qty,
      'priceAtAdd': instance.priceAtAdd,
    };

_$OrderTimelineEntryImpl _$$OrderTimelineEntryImplFromJson(
  Map<String, dynamic> json,
) => _$OrderTimelineEntryImpl(
  status: json['status'] as String,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$$OrderTimelineEntryImplToJson(
  _$OrderTimelineEntryImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'date': instance.date?.toIso8601String(),
};

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
  id: json['id'] as String,
  userId: json['userId'] as String?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <OrderItem>[],
  addressId: json['addressId'] as String?,
  shippingMethod: json['shippingMethod'] as String? ?? 'standard',
  paymentMethod: json['paymentMethod'] as String? ?? 'card',
  promo: json['promo'] == null
      ? null
      : PromoResult.fromJson(json['promo'] as Map<String, dynamic>),
  subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
  discount: (json['discount'] as num?)?.toDouble() ?? 0,
  shipping: (json['shipping'] as num?)?.toDouble() ?? 0,
  tax: (json['tax'] as num?)?.toDouble() ?? 0,
  total: (json['total'] as num?)?.toDouble() ?? 0,
  status: json['status'] as String? ?? 'placed',
  timeline:
      (json['timeline'] as List<dynamic>?)
          ?.map((e) => OrderTimelineEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <OrderTimelineEntry>[],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'items': instance.items,
      'addressId': instance.addressId,
      'shippingMethod': instance.shippingMethod,
      'paymentMethod': instance.paymentMethod,
      'promo': instance.promo,
      'subtotal': instance.subtotal,
      'discount': instance.discount,
      'shipping': instance.shipping,
      'tax': instance.tax,
      'total': instance.total,
      'status': instance.status,
      'timeline': instance.timeline,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
