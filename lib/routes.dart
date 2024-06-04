import './pages/home/main.dart';
import './pages/test.dart';
import 'package:flutter/material.dart';



class Routes {
  static const String home = '/';
  static const String test = '/test';


  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const Home(),
      test:(context) => const Test(),
    };
  }
}
