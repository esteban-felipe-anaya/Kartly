import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_banner.freezed.dart';
part 'home_banner.g.dart';

/// Home carousel banner. Named [HomeBanner] (not `Banner`) to avoid clashing
/// with Flutter's built-in [Banner] widget.
@freezed
class HomeBanner with _$HomeBanner {
  const factory HomeBanner({
    required String id,
    required String title,
    required String subtitle,
    required String image,
    String? ctaProductId,
  }) = _HomeBanner;

  factory HomeBanner.fromJson(Map<String, dynamic> json) => _$HomeBannerFromJson(json);
}
