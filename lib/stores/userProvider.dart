import 'package:flutter/material.dart';
import 'package:marewood_client/models/user.dart';
import 'package:marewood_client/stores/user.dart';

class UserProvider extends ChangeNotifier {
  User ? _user;

  User? get user => _user;

  UserProvider() {
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    User? u = await UserStore.getUser();
    if (u != null) {
      _user = u;
      notifyListeners();
    }
  }

  void setUser(User user) async {
    _user = user;
    await UserStore.setUser(user);
    notifyListeners(); // 通知依赖此数据模型的组件进行更新
  }

  void removeUser() async {
    _user = null;
    await UserStore.removeUser();
    notifyListeners(); // 通知依赖此数据模型的组件进行更新
  }
}