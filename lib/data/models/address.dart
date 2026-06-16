import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  const Address._();

  const factory Address({
    required String id,
    @Default('Home') String label,
    required String fullName,
    required String line1,
    String? line2,
    required String city,
    required String state,
    required String postalCode,
    @Default('USA') String country,
    String? phone,
    @Default(false) bool isDefault,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  String get singleLine {
    final parts = [line1, if (line2 != null && line2!.isNotEmpty) line2, city, state, postalCode];
    return parts.join(', ');
  }
}
