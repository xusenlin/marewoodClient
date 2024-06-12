import 'package:flutter/material.dart';
import 'package:marewood_client/models/user.dart';

class UserProvider extends ChangeNotifier {
  User ? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners(); // 通知依赖此数据模型的组件进行更新
  }

  void removeUser() {
    _user = null;
    notifyListeners(); // 通知依赖此数据模型的组件进行更新
  }
}