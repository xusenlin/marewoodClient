
import 'package:flutter/material.dart';

import '../../../routes.dart';


class User {
  final String name;
  final int age;

  User({required this.name, required this.age});
}

class TabTask extends  StatelessWidget{
  const TabTask({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
          onPressed: ()async {
            await Navigator.pushNamed(context, Routes.test,arguments: User(name: 'John Doe', age: 30));
          },
          child: const Text('Go to Test Page'),
        ),
      );
  }
}