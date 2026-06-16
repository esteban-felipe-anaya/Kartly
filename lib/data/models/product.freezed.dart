// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProductVariants _$ProductVariantsFromJson(Map<String, dynamic> json) {
  return _ProductVariants.fromJson(json);
}

/// @nodoc
mixin _$ProductVariants {
  List<String> get color => throw _privateConstructorUsedError;
  List<String> get size => throw _privateConstructorUsedError;

  /// Serializes this ProductVariants to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductVariants
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductVariantsCopyWith<ProductVariants> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductVariantsCopyWith<$Res> {
  factory $ProductVariantsCopyWith(
    ProductVariants value,
    $Res Function(ProductVariants) then,
  ) = _$ProductVariantsCopyWithImpl<$Res, ProductVariants>;
  @useResult
  $Res call({List<String> color, List<String> size});
}

/// @nodoc
class _$ProductVariantsCopyWithImpl<$Res, $Val extends ProductVariants>
    implements $ProductVariantsCopyWith<$Res> {
  _$ProductVariantsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductVariants
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? color = null, Object? size = null}) {
    return _then(
      _value.copyWith(
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            size: null == size
                ? _value.size
                : size // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductVariantsImplCopyWith<$Res>
    implements $ProductVariantsCopyWith<$Res> {
  factory _$$ProductVariantsImplCopyWith(
    _$ProductVariantsImpl value,
    $Res Function(_$ProductVariantsImpl) then,
  ) = __$$ProductVariantsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> color, List<String> size});
}

/// @nodoc
class __$$ProductVariantsImplCopyWithImpl<$Res>
    extends _$ProductVariantsCopyWithImpl<$Res, _$ProductVariantsImpl>
    implements _$$ProductVariantsImplCopyWith<$Res> {
  __$$ProductVariantsImplCopyWithImpl(
    _$ProductVariantsImpl _value,
    $Res Function(_$ProductVariantsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductVariants
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? color = null, Object? size = null}) {
    return _then(
      _$ProductVariantsImpl(
        color: null == color
            ? _value._color
            : color // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        size: null == size
            ? _value._size
            : size // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductVariantsImpl implements _ProductVariants {
  const _$ProductVariantsImpl({
    final List<String> color = const <String>[],
    final List<String> size = const <String>[],
  }) : _color = color,
       _size = size;

  factory _$ProductVariantsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductVariantsImplFromJson(json);

  final List<String> _color;
  @override
  @JsonKey()
  List<String> get color {
    if (_color is EqualUnmodifiableListView) return _color;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_color);
  }

  final List<String> _size;
  @override
  @JsonKey()
  List<String> get size {
    if (_size is EqualUnmodifiableListView) return _size;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_size);
  }

  @override
  String toString() {
    return 'ProductVariants(color: $color, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductVariantsImpl &&
            const DeepCollectionEquality().equals(other._color, _color) &&
            const DeepCollectionEquality().equals(other._size, _size));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_color),
    const DeepCollectionEquality().hash(_size),
  );

  /// Create a copy of ProductVariants
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductVariantsImplCopyWith<_$ProductVariantsImpl> get copyWith =>
      __$$ProductVariantsImplCopyWithImpl<_$ProductVariantsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductVariantsImplToJson(this);
  }
}

abstract class _ProductVariants implements ProductVariants {
  const factory _ProductVariants({
    final List<String> color,
    final List<String> size,
  }) = _$ProductVariantsImpl;

  factory _ProductVariants.fromJson(Map<String, dynamic> json) =
      _$ProductVariantsImpl.fromJson;

  @override
  List<String> get color;
  @override
  List<String> get size;

  /// Create a copy of ProductVariants
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductVariantsImplCopyWith<_$ProductVariantsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double? get compareAtPrice => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get reviewCount => throw _privateConstructorUsedError;
  int get stock => throw _privateConstructorUsedError;
  int get popularity => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  ProductVariants get variants => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call({
    String id,
    String title,
    String brand,
    String categoryId,
    double price,
    double? compareAtPrice,
    String currency,
    double rating,
    int reviewCount,
    int stock,
    int popularity,
    DateTime? createdAt,
    List<String> images,
    ProductVariants variants,
    String description,
  });

  $ProductVariantsCopyWith<$Res> get variants;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? brand = null,
    Object? categoryId = null,
    Object? price = null,
    Object? compareAtPrice = freezed,
    Object? currency = null,
    Object? rating = null,
    Object? reviewCount = null,
    Object? stock = null,
    Object? popularity = null,
    Object? createdAt = freezed,
    Object? images = null,
    Object? variants = null,
    Object? description = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            brand: null == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            compareAtPrice: freezed == compareAtPrice
                ? _value.compareAtPrice
                : compareAtPrice // ignore: cast_nullable_to_non_nullable
                      as double?,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            reviewCount: null == reviewCount
                ? _value.reviewCount
                : reviewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            stock: null == stock
                ? _value.stock
                : stock // ignore: cast_nullable_to_non_nullable
                      as int,
            popularity: null == popularity
                ? _value.popularity
                : popularity // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            variants: null == variants
                ? _value.variants
                : variants // ignore: cast_nullable_to_non_nullable
                      as ProductVariants,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductVariantsCopyWith<$Res> get variants {
    return $ProductVariantsCopyWith<$Res>(_value.variants, (value) {
      return _then(_value.copyWith(variants: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
    _$ProductImpl value,
    $Res Function(_$ProductImpl) then,
  ) = __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String brand,
    String categoryId,
    double price,
    double? compareAtPrice,
    String currency,
    double rating,
    int reviewCount,
    int stock,
    int popularity,
    DateTime? createdAt,
    List<String> images,
    ProductVariants variants,
    String description,
  });

  @override
  $ProductVariantsCopyWith<$Res> get variants;
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
    _$ProductImpl _value,
    $Res Function(_$ProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? brand = null,
    Object? categoryId = null,
    Object? price = null,
    Object? compareAtPrice = freezed,
    Object? currency = null,
    Object? rating = null,
    Object? reviewCount = null,
    Object? stock = null,
    Object? popularity = null,
    Object? createdAt = freezed,
    Object? images = null,
    Object? variants = null,
    Object? description = null,
  }) {
    return _then(
      _$ProductImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        brand: null == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        compareAtPrice: freezed == compareAtPrice
            ? _value.compareAtPrice
            : compareAtPrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        reviewCount: null == reviewCount
            ? _value.reviewCount
            : reviewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        stock: null == stock
            ? _value.stock
            : stock // ignore: cast_nullable_to_non_nullable
                  as int,
        popularity: null == popularity
            ? _value.popularity
            : popularity // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        variants: null == variants
            ? _value.variants
            : variants // ignore: cast_nullable_to_non_nullable
                  as ProductVariants,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl extends _Product {
  const _$ProductImpl({
    required this.id,
    required this.title,
    required this.brand,
    required this.categoryId,
    required this.price,
    this.compareAtPrice,
    this.currency = 'USD',
    this.rating = 0,
    this.reviewCount = 0,
    this.stock = 0,
    this.popularity = 0,
    this.createdAt,
    final List<String> images = const <String>[],
    this.variants = const ProductVariants(),
    this.description = '',
  }) : _images = images,
       super._();

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String brand;
  @override
  final String categoryId;
  @override
  final double price;
  @override
  final double? compareAtPrice;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey()
  final int reviewCount;
  @override
  @JsonKey()
  final int stock;
  @override
  @JsonKey()
  final int popularity;
  @override
  final DateTime? createdAt;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @JsonKey()
  final ProductVariants variants;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'Product(id: $id, title: $title, brand: $brand, categoryId: $categoryId, price: $price, compareAtPrice: $compareAtPrice, currency: $currency, rating: $rating, reviewCount: $reviewCount, stock: $stock, popularity: $popularity, createdAt: $createdAt, images: $images, variants: $variants, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.compareAtPrice, compareAtPrice) ||
                other.compareAtPrice == compareAtPrice) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.popularity, popularity) ||
                other.popularity == popularity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.variants, variants) ||
                other.variants == variants) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    brand,
    categoryId,
    price,
    compareAtPrice,
    currency,
    rating,
    reviewCount,
    stock,
    popularity,
    createdAt,
    const DeepCollectionEquality().hash(_images),
    variants,
    description,
  );

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(this);
  }
}

abstract class _Product extends Product {
  const factory _Product({
    required final String id,
    required final String title,
    required final String brand,
    required final String categoryId,
    required final double price,
    final double? compareAtPrice,
    final String currency,
    final double rating,
    final int reviewCount,
    final int stock,
    final int popularity,
    final DateTime? createdAt,
    final List<String> images,
    final ProductVariants variants,
    final String description,
  }) = _$ProductImpl;
  const _Product._() : super._();

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get brand;
  @override
  String get categoryId;
  @override
  double get price;
  @override
  double? get compareAtPrice;
  @override
  String get currency;
  @override
  double get rating;
  @override
  int get reviewCount;
  @override
  int get stock;
  @override
  int get popularity;
  @override
  DateTime? get createdAt;
  @override
  List<String> get images;
  @override
  ProductVariants get variants;
  @override
  String get description;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
