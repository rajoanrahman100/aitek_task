import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();

  static Future<bool> isKeyExists(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(key);
    } catch (e) {
      return false;
    }
  }

  static Future<String?> read(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> readBool(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> write(String key, String value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.setString(key, value);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> writeBool(String key, bool value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.setBool(key, value);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> remove(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.remove(key);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> removeAll() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.clear();
    } catch (e) {
      return false;
    }
  }
}
