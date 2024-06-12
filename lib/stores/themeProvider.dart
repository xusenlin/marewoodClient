import 'package:flutter/material.dart';
import 'package:marewood_client/stores/system.dart';

class ThemeProvider extends ChangeNotifier {
  Color _themeColor = Colors.blue;

  Color get themeColor => _themeColor;

  ThemeProvider() {
    _initializeTheme();
  }

  Future<void> _initializeTheme() async {
    Color? c = await SystemStore.getThemeColor();
    if (c != null) {
      _themeColor = c;
    }else{
      _themeColor = Colors.blue;
    }
    notifyListeners();
  }

  void setTheme(Color themeColor) async {
    _themeColor = themeColor;
    await SystemStore.setThemeColor(themeColor);
    notifyListeners();
  }
}
