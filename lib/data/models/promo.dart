import 'package:freezed_annotation/freezed_annotation.dart';

part 'promo.freezed.dart';
part 'promo.g.dart';

@freezed
class PromoResult with _$PromoResult {
  const factory PromoResult({
    required String code,
    @Default(false) bool valid,
    @Default(0) double discountPct,
  }) = _PromoResult;

  factory PromoResult.fromJson(Map<String, dynamic> json) => _$PromoResultFromJson(json);
}
