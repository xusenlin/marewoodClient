import 'package:marewood_client/pages/localStores/main.dart';
import 'package:marewood_client/pages/login/login.dart';

import './pages/home/main.dart';
import 'package:flutter/material.dart';



class Routes {
  static const String home = '/';
  static const String stores = '/stores';
  static const String login = '/login';


  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const Home(),
      login: (context) => const Login(),
      stores:(context) => const LocalStores(),
    };
  }

}
