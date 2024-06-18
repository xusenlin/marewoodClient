import 'package:marewood_client/models/task.dart';
import 'package:marewood_client/pages/localStores/main.dart';
import 'package:marewood_client/pages/login/login.dart';
import 'package:marewood_client/pages/taskWebView/main.dart';


import './pages/home/main.dart';
import 'package:flutter/material.dart';



class Routes {
  static const String home = '/';
  static const String stores = '/stores';
  static const String login = '/login';
  static const String taskWebView = '/webView';


  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const Home(),
      login: (context) => const Login(),
      stores:(context) => const LocalStores(),
      taskWebView:(context){
        final args = ModalRoute.of(context)?.settings.arguments as Task?;
        if (args != null) {
          return TaskWebView(task: args);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text("WebView route requires an 'task' argument.")),
          );
          throw Exception("WebView route requires an 'task' argument.");
        }
      },
    };
  }

}
