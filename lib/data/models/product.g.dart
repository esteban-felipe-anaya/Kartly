// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductVariantsImpl _$$ProductVariantsImplFromJson(
  Map<String, dynamic> json,
) => _$ProductVariantsImpl(
  color:
      (json['color'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  size:
      (json['size'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$$ProductVariantsImplToJson(
  _$ProductVariantsImpl instance,
) => <String, dynamic>{'color': instance.color, 'size': instance.size};

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      brand: json['brand'] as String,
      categoryId: json['categoryId'] as String,
      price: (json['price'] as num).toDouble(),
      compareAtPrice: (json['compareAtPrice'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      popularity: (json['popularity'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      variants: json['variants'] == null
          ? const ProductVariants()
          : ProductVariants.fromJson(json['variants'] as Map<String, dynamic>),
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'brand': instance.brand,
      'categoryId': instance.categoryId,
      'price': instance.price,
      'compareAtPrice': instance.compareAtPrice,
      'currency': instance.currency,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'stock': instance.stock,
      'popularity': instance.popularity,
      'createdAt': instance.createdAt?.toIso8601String(),
      'images': instance.images,
      'variants': instance.variants,
      'description': instance.description,
    };
