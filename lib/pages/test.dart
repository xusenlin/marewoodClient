import '../../components/webView.dart';
import 'package:flutter/material.dart';
import 'home/tabContent/task.dart';


class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page ${user.name}'),
      ),
      body:WebView(),
      // Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       // Navigator.pushNamed(context, Routes.home);
      //       Navigator.pop(context,Routes.home);
      //     },
      //     child: const Text('Go to Home Page'),
      //   ),
      // ),
    );
  }
}