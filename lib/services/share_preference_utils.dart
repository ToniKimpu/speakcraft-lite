import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get _instance {
    assert(_prefs != null,
        'SharedPreferenceUtils.init() must be called before use.');
    return _prefs!;
  }

  static Future<void> saveString(String key, String value) async {
    await _instance.setString(key, value);
  }

  static String? getString(String key) => _instance.getString(key);

  static Future<void> saveInt(String key, int value) async {
    await _instance.setInt(key, value);
  }

  static int? getInt(String key) => _instance.getInt(key);

  static Future<void> saveBool(String key, bool value) async {
    await _instance.setBool(key, value);
  }

  static bool? getBool(String key) => _instance.getBool(key);

  static Future<void> remove(String key) async => _instance.remove(key);

  static Future<void> clear() async => _instance.clear();
}
