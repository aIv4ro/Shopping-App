import 'package:shared_preferences/shared_preferences.dart';

const tokenKey = 'token';

class SharedPreferencesClient {
  static late final SharedPreferences _instance;
  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  static Future<bool> unsetToken() => _instance.remove(tokenKey);
  static Future<bool> setToken(String token) =>
      _instance.setString(tokenKey, token);
  static String? getToken() => _instance.getString(tokenKey);
}
