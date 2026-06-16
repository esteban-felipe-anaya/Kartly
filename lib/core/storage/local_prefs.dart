import 'package:shared_preferences/shared_preferences.dart';

/// Thin typed wrapper over [SharedPreferences] for non-sensitive persisted
/// state: theme mode, locale, and the offline cart cache.
class LocalPrefs {
  LocalPrefs(this._prefs);

  final SharedPreferences _prefs;

  static const _kThemeMode = 'kartly_theme_mode';
  static const _kLocale = 'kartly_locale';
  static const _kCartCache = 'kartly_cart_cache';
  static const _kOnboarded = 'kartly_onboarded';
  static const _kRecentSearches = 'kartly_recent_searches';

  String? get themeMode => _prefs.getString(_kThemeMode);
  Future<void> setThemeMode(String value) => _prefs.setString(_kThemeMode, value);

  String? get locale => _prefs.getString(_kLocale);
  Future<void> setLocale(String? value) =>
      value == null ? _prefs.remove(_kLocale) : _prefs.setString(_kLocale, value);

  String? get cartCache => _prefs.getString(_kCartCache);
  Future<void> setCartCache(String json) => _prefs.setString(_kCartCache, json);

  bool get onboarded => _prefs.getBool(_kOnboarded) ?? false;
  Future<void> setOnboarded(bool value) => _prefs.setBool(_kOnboarded, value);

  List<String> get recentSearches => _prefs.getStringList(_kRecentSearches) ?? const [];
  Future<void> setRecentSearches(List<String> values) =>
      _prefs.setStringList(_kRecentSearches, values);
}
