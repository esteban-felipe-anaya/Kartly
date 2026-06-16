import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class ProductVariants with _$ProductVariants {
  const factory ProductVariants({
    @Default(<String>[]) List<String> color,
    @Default(<String>[]) List<String> size,
  }) = _ProductVariants;

  factory ProductVariants.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantsFromJson(json);
}

@freezed
class Product with _$Product {
  const Product._();

  const factory Product({
    required String id,
    required String title,
    required String brand,
    required String categoryId,
    required double price,
    double? compareAtPrice,
    @Default('USD') String currency,
    @Default(0) double rating,
    @Default(0) int reviewCount,
    @Default(0) int stock,
    @Default(0) int popularity,
    DateTime? createdAt,
    @Default(<String>[]) List<String> images,
    @Default(ProductVariants()) ProductVariants variants,
    @Default('') String description,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  bool get inStock => stock > 0;
  bool get hasDiscount => compareAtPrice != null && compareAtPrice! > price;
  int get discountPercent =>
      hasDiscount ? (((compareAtPrice! - price) / compareAtPrice!) * 100).round() : 0;
  String? get primaryImage => images.isNotEmpty ? images.first : null;
}
