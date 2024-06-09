import 'package:marewood_client/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SystemStore {
  static const keyPrefix = 'system.';

  static const addressKey = "${keyPrefix}address";

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
}