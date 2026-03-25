import 'package:shared_preferences/shared_preferences.dart';

class CacheHepler {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    
    return _preferences!.setString(key, value);
  }

  static String? getString(String key) {

    return _preferences!.getString(key);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    
    return _preferences!.setStringList(key, value);
  }

  static List<String>? getStringList(String key) {
    return _preferences!.getStringList(key);
  }

  static Future<bool> remove(String key) async {

    return _preferences!.remove(key);
  }

  static Future<bool> clear() async {
    return _preferences!.clear();
  }


}