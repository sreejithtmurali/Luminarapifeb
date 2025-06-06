
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/User.dart';

class UserService {
  static const _userKey = 'user';

  /// Save user object to SharedPreferences
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = userToJson(user);
    await prefs.setString(_userKey, userJson);
  }

  /// Get user object from SharedPreferences
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      return userFromJson(userJson);
    }
    return null;
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userKey);
  }

  /// Get access token
  Future<String?> getAccessToken() async {
    final user = await getUser();
    return user?.access;
  }

  /// Get refresh token
  Future<String?> getRefreshToken() async {
    final user = await getUser();
    return user?.refresh;
  }

  /// Logout user by clearing stored data
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
