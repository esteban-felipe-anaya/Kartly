import 'package:flutter/material.dart';

import 'design_tokens.dart';

/// Builds the centralized Material 3 [ThemeData] for Kartly.
///
/// When platform [dynamicScheme]s are available (Android 12+, some desktops)
/// they are used; otherwise we fall back to a scheme derived from the brand
/// [kSeedColor].
class AppTheme {
  const AppTheme._();

  static ThemeData light(ColorScheme? dynamicScheme) =>
      _build(dynamicScheme ?? _fallback(Brightness.light), Brightness.light);

  static ThemeData dark(ColorScheme? dynamicScheme) =>
      _build(dynamicScheme ?? _fallback(Brightness.dark), Brightness.dark);

  static ColorScheme _fallback(Brightness brightness) =>
      ColorScheme.fromSeed(seedColor: kSeedColor, brightness: brightness);

  static ThemeData _build(ColorScheme scheme, Brightness brightness) {
    final harmonized = scheme.brightness == brightness
        ? scheme
        : scheme.copyWith(brightness: brightness);
    return ThemeData(
      useMaterial3: true,
      colorScheme: harmonized,
      scaffoldBackgroundColor: harmonized.surface,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: harmonized.surface,
        surfaceTintColor: harmonized.surfaceTint,
        scrolledUnderElevation: 3,
      ),
      cardTheme: CardThemeData(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: harmonized.surfaceContainerLow,
        shape: const RoundedRectangleBorder(borderRadius: Radii.lgAll),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 48),
          shape: const RoundedRectangleBorder(borderRadius: Radii.mdAll),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 48),
          shape: const RoundedRectangleBorder(borderRadius: Radii.mdAll),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: Radii.mdAll,
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Insets.lg,
          vertical: Insets.md,
        ),
      ),
      chipTheme: const ChipThemeData(
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: Insets.sm),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: harmonized.surfaceContainer,
        elevation: 3,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.xl)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: harmonized.outlineVariant,
        space: Insets.lg,
      ),
    );
  }
}
