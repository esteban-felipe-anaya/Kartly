// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeBannerImpl _$$HomeBannerImplFromJson(Map<String, dynamic> json) =>
    _$HomeBannerImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      image: json['image'] as String,
      ctaProductId: json['ctaProductId'] as String?,
    );

Map<String, dynamic> _$$HomeBannerImplToJson(_$HomeBannerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'image': instance.image,
      'ctaProductId': instance.ctaProductId,
    };
