import 'dart:convert';

import 'package:marewood_client/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserStore {
  static const keyPrefix = 'user';

  // 存储 user
  static Future<void> setUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    var json = jsonEncode(user);
    await prefs.setString(keyPrefix,json);
    await prefs.setString("$keyPrefix.token",user.token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("$keyPrefix.token");
  }
  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var userJson = prefs.getString(keyPrefix);
    if(userJson==null){
      return null;
    }
    return User.fromJson(jsonDecode(userJson));
  }

  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyPrefix);
    await prefs.remove("$keyPrefix.token");
  }
}