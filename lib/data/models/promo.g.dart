// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromoResultImpl _$$PromoResultImplFromJson(Map<String, dynamic> json) =>
    _$PromoResultImpl(
      code: json['code'] as String,
      valid: json['valid'] as bool? ?? false,
      discountPct: (json['discountPct'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$PromoResultImplToJson(_$PromoResultImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'valid': instance.valid,
      'discountPct': instance.discountPct,
    };
