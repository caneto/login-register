import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String kOnBoardingStatus = 'onBoardingStatus';
  static final String kUser = 'user';

  ///-------------------------
  ///Dedicated methods
  ///------------------------
  static bool? getOnBoardingStatus(SharedPreferences prefs) {
    return prefs.containsKey(kOnBoardingStatus)
        ? prefs.getBool(kOnBoardingStatus)
        : false;
  }

  static Future<bool> setOnBoardingStatus(bool value, SharedPreferences prefs) {
    return prefs.setBool(kOnBoardingStatus, value);
  }

  static String? getUser(SharedPreferences prefs) {
    return prefs.containsKey(kUser) ? prefs.getString(kUser ?? '') : '';
  }

  static Future<bool> setUser(String value, SharedPreferences prefs) {
    return prefs.setString(kUser, value);
  }

  ///Logout
  static Future<bool> logout(SharedPreferences prefs) {
    return prefs.clear();
  }

  ///-----------------
  ///Save boolean values
  ///------------------
  static bool? getBoolean(String key, SharedPreferences prefs) {
    return prefs.containsKey(key) ? prefs.getBool(key) : false;
  }

  static Future<bool> saveBoolean(
      String key, bool value, SharedPreferences prefs) {
    return prefs.setBool(key, value);
  }

  ///--------------------------
  /// SAVE STRINGS
  ///--------------------------
  static String? getString(String key, SharedPreferences prefs) {
    return prefs.getString(key ?? '');
  }

  static Future<bool> setString(
      String key, String value, SharedPreferences prefs) {
    return prefs.setString(key, value);
  }

  ///--------------------------
  /// SAVE INTEGERS
  ///--------------------------
  static int? getInt(String key, SharedPreferences prefs) {
    return prefs.getInt(key);
  }

  static Future<bool> setInt(String key, int value, SharedPreferences prefs) {
    return prefs.setInt(key, value);
  }

  ///--------------------------
  /// SAVE DOUBLE
  ///--------------------------
  static double? getDouble(String key, SharedPreferences prefs) {
    return prefs.getDouble(key);
  }

  static Future<bool> setDouble(
      String key, double value, SharedPreferences prefs) {
    return prefs.setDouble(key, value);
  }
}
