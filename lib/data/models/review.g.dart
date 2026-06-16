// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
  id: json['id'] as String,
  productId: json['productId'] as String?,
  user: json['user'] as String,
  rating: (json['rating'] as num?)?.toDouble() ?? 0,
  comment: json['comment'] as String? ?? '',
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'user': instance.user,
      'rating': instance.rating,
      'comment': instance.comment,
      'date': instance.date?.toIso8601String(),
    };
