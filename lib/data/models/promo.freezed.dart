// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PromoResult _$PromoResultFromJson(Map<String, dynamic> json) {
  return _PromoResult.fromJson(json);
}

/// @nodoc
mixin _$PromoResult {
  String get code => throw _privateConstructorUsedError;
  bool get valid => throw _privateConstructorUsedError;
  double get discountPct => throw _privateConstructorUsedError;

  /// Serializes this PromoResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PromoResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PromoResultCopyWith<PromoResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromoResultCopyWith<$Res> {
  factory $PromoResultCopyWith(
    PromoResult value,
    $Res Function(PromoResult) then,
  ) = _$PromoResultCopyWithImpl<$Res, PromoResult>;
  @useResult
  $Res call({String code, bool valid, double discountPct});
}

/// @nodoc
class _$PromoResultCopyWithImpl<$Res, $Val extends PromoResult>
    implements $PromoResultCopyWith<$Res> {
  _$PromoResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PromoResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? valid = null,
    Object? discountPct = null,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            valid: null == valid
                ? _value.valid
                : valid // ignore: cast_nullable_to_non_nullable
                      as bool,
            discountPct: null == discountPct
                ? _value.discountPct
                : discountPct // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PromoResultImplCopyWith<$Res>
    implements $PromoResultCopyWith<$Res> {
  factory _$$PromoResultImplCopyWith(
    _$PromoResultImpl value,
    $Res Function(_$PromoResultImpl) then,
  ) = __$$PromoResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, bool valid, double discountPct});
}

/// @nodoc
class __$$PromoResultImplCopyWithImpl<$Res>
    extends _$PromoResultCopyWithImpl<$Res, _$PromoResultImpl>
    implements _$$PromoResultImplCopyWith<$Res> {
  __$$PromoResultImplCopyWithImpl(
    _$PromoResultImpl _value,
    $Res Function(_$PromoResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PromoResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? valid = null,
    Object? discountPct = null,
  }) {
    return _then(
      _$PromoResultImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        valid: null == valid
            ? _value.valid
            : valid // ignore: cast_nullable_to_non_nullable
                  as bool,
        discountPct: null == discountPct
            ? _value.discountPct
            : discountPct // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PromoResultImpl implements _PromoResult {
  const _$PromoResultImpl({
    required this.code,
    this.valid = false,
    this.discountPct = 0,
  });

  factory _$PromoResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromoResultImplFromJson(json);

  @override
  final String code;
  @override
  @JsonKey()
  final bool valid;
  @override
  @JsonKey()
  final double discountPct;

  @override
  String toString() {
    return 'PromoResult(code: $code, valid: $valid, discountPct: $discountPct)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromoResultImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.valid, valid) || other.valid == valid) &&
            (identical(other.discountPct, discountPct) ||
                other.discountPct == discountPct));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, valid, discountPct);

  /// Create a copy of PromoResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PromoResultImplCopyWith<_$PromoResultImpl> get copyWith =>
      __$$PromoResultImplCopyWithImpl<_$PromoResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromoResultImplToJson(this);
  }
}

abstract class _PromoResult implements PromoResult {
  const factory _PromoResult({
    required final String code,
    final bool valid,
    final double discountPct,
  }) = _$PromoResultImpl;

  factory _PromoResult.fromJson(Map<String, dynamic> json) =
      _$PromoResultImpl.fromJson;

  @override
  String get code;
  @override
  bool get valid;
  @override
  double get discountPct;

  /// Create a copy of PromoResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PromoResultImplCopyWith<_$PromoResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
