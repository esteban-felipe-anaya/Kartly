// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_banner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HomeBanner _$HomeBannerFromJson(Map<String, dynamic> json) {
  return _HomeBanner.fromJson(json);
}

/// @nodoc
mixin _$HomeBanner {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String? get ctaProductId => throw _privateConstructorUsedError;

  /// Serializes this HomeBanner to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeBanner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeBannerCopyWith<HomeBanner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeBannerCopyWith<$Res> {
  factory $HomeBannerCopyWith(
    HomeBanner value,
    $Res Function(HomeBanner) then,
  ) = _$HomeBannerCopyWithImpl<$Res, HomeBanner>;
  @useResult
  $Res call({
    String id,
    String title,
    String subtitle,
    String image,
    String? ctaProductId,
  });
}

/// @nodoc
class _$HomeBannerCopyWithImpl<$Res, $Val extends HomeBanner>
    implements $HomeBannerCopyWith<$Res> {
  _$HomeBannerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeBanner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? image = null,
    Object? ctaProductId = freezed,
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
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            image: null == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String,
            ctaProductId: freezed == ctaProductId
                ? _value.ctaProductId
                : ctaProductId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeBannerImplCopyWith<$Res>
    implements $HomeBannerCopyWith<$Res> {
  factory _$$HomeBannerImplCopyWith(
    _$HomeBannerImpl value,
    $Res Function(_$HomeBannerImpl) then,
  ) = __$$HomeBannerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String subtitle,
    String image,
    String? ctaProductId,
  });
}

/// @nodoc
class __$$HomeBannerImplCopyWithImpl<$Res>
    extends _$HomeBannerCopyWithImpl<$Res, _$HomeBannerImpl>
    implements _$$HomeBannerImplCopyWith<$Res> {
  __$$HomeBannerImplCopyWithImpl(
    _$HomeBannerImpl _value,
    $Res Function(_$HomeBannerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeBanner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? image = null,
    Object? ctaProductId = freezed,
  }) {
    return _then(
      _$HomeBannerImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        image: null == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String,
        ctaProductId: freezed == ctaProductId
            ? _value.ctaProductId
            : ctaProductId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeBannerImpl implements _HomeBanner {
  const _$HomeBannerImpl({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    this.ctaProductId,
  });

  factory _$HomeBannerImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeBannerImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String image;
  @override
  final String? ctaProductId;

  @override
  String toString() {
    return 'HomeBanner(id: $id, title: $title, subtitle: $subtitle, image: $image, ctaProductId: $ctaProductId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeBannerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.ctaProductId, ctaProductId) ||
                other.ctaProductId == ctaProductId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, subtitle, image, ctaProductId);

  /// Create a copy of HomeBanner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeBannerImplCopyWith<_$HomeBannerImpl> get copyWith =>
      __$$HomeBannerImplCopyWithImpl<_$HomeBannerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeBannerImplToJson(this);
  }
}

abstract class _HomeBanner implements HomeBanner {
  const factory _HomeBanner({
    required final String id,
    required final String title,
    required final String subtitle,
    required final String image,
    final String? ctaProductId,
  }) = _$HomeBannerImpl;

  factory _HomeBanner.fromJson(Map<String, dynamic> json) =
      _$HomeBannerImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get image;
  @override
  String? get ctaProductId;

  /// Create a copy of HomeBanner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeBannerImplCopyWith<_$HomeBannerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
