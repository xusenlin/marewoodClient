import '../../components/webView.dart';
import 'package:flutter/material.dart';



class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page '),
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