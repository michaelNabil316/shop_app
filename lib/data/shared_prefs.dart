import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences? pref;

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static dynamic getData(String key) {
    return pref!.get(key);
  }

  static saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return pref!.setString(key, value);
    }
    if (value is int) {
      return pref!.setInt(key, value);
    }
    if (value is bool) {
      return pref!.setBool(key, value);
    } else {
      return pref!.setDouble(key, value);
    }
  }

  static Future<bool> removeData(String key) async {
    return await pref!.remove(key);
  }
}
