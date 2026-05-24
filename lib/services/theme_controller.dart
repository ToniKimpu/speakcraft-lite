import 'package:flutter/material.dart';
import 'package:speakcraft/services/share_preference_utils.dart';

/// App-wide theme mode with SharedPreferences persistence.
///
/// Default is [ThemeMode.system]. Lives as a singleton in the service locator
/// (see `service_locator.dart`). The root `MaterialApp` rebuilds via
/// `ValueListenableBuilder<ThemeMode>` whenever this notifier changes.
class ThemeController extends ValueNotifier<ThemeMode> {
  static const _prefsKey = 'app_theme_mode';

  ThemeController._(super.value);

  factory ThemeController.load() {
    final stored = SharedPreferenceUtils.getString(_prefsKey);
    return ThemeController._(_decode(stored));
  }

  Future<void> setMode(ThemeMode mode) async {
    if (value == mode) return;
    value = mode;
    await SharedPreferenceUtils.saveString(_prefsKey, _encode(mode));
  }

  static String _encode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  static ThemeMode _decode(String? raw) {
    switch (raw) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
