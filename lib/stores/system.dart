import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class SystemStore {
  static const keyPrefix = 'system';

  static const addressKey = "$keyPrefix.address";
  static const themeColorKey = "$keyPrefix.theme";

  static Future<void> setAddress(String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(addressKey,address);
  }
  static Future<String?> getAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(addressKey);
  }
  static Future<void> removeAddress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(addressKey);
  }

  static Future<void> setThemeColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(themeColorKey,color.value);
  }
  static Future<Color?> getThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    var colorValue = prefs.getInt(themeColorKey);
    if(colorValue==null){
      return null;
    }
    return Color(colorValue);
  }

  static Future<void> removeThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(themeColorKey);
  }


}