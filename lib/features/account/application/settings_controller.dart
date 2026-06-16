import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';

part 'settings_controller.g.dart';

/// Persisted theme mode (light / dark / system).
@riverpod
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() {
    final stored = ref.watch(localPrefsProvider).themeMode;
    return switch (stored) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    await ref.read(localPrefsProvider).setThemeMode(mode.name);
  }
}

/// Supported locales. `null` means follow the system locale.
const supportedLocales = <Locale>[Locale('en'), Locale('es')];

@riverpod
class LocaleController extends _$LocaleController {
  @override
  Locale? build() {
    final code = ref.watch(localPrefsProvider).locale;
    if (code == null || code.isEmpty) return null;
    return Locale(code);
  }

  Future<void> set(Locale? locale) async {
    state = locale;
    await ref.read(localPrefsProvider).setLocale(locale?.languageCode);
  }
}
