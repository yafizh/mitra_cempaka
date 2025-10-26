import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferences {
  static const keyIsLoggedIn = 'is_logged_in';
  static const keyUsername = 'username';
  static const keyAccessToken = 'access_token';

  static Future<void> setLoggedIn(String username, String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsLoggedIn, true);
    await prefs.setString(keyUsername, username);
    await prefs.setString(keyAccessToken, accessToken);
  }

  static Future<void> setLoggedOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsLoggedIn, false);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsLoggedIn) ?? false;
  }

  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUsername) ?? '';
  }

  static Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyAccessToken) ?? '';
  }
}
