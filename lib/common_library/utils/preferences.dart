import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences?> load() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<bool> setString(String key, String value) async {
    return (await load())!.setString(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    return (await load())!.setInt(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    return (await load())!.setDouble(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    return (await load())!.setBool(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    return (await load())!.setStringList(key, value);
  }

  static Future<String?> getString(String key, {String? def}) async {
    return (await load())!.getString(key) ?? def;
  }

  static Future<int?> getInt(String key, {int? def}) async {
    return (await load())!.getInt(key) ?? def;
  }

  static Future<double?> getDouble(String key, {double? def}) async {
    return (await load())!.getDouble(key) ?? def;
  }

  static Future<bool?> getBool(String key, {bool? def}) async {
    return (await load())!.getBool(key) ?? def;
  }

  static Future<List<String>?> getStringList(String key,
      {List<String>? def}) async {
    return (await load())!.getStringList(key) ?? def;
  }

  static Future<bool> remove(String key) async {
    return (await load())!.remove(key);
  }

  static Future<bool> removeAll() async {
    return (await load())!.clear();
  }
}
