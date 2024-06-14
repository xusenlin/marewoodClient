
import 'package:flutter/material.dart';

class TabUser extends StatefulWidget {
  const TabUser({super.key});

  @override
  State<TabUser> createState() => TabUserState();
}


class TabUserState extends  State<TabUser>{

  void refresh(){
    print("refreshUser");
  }

  @override
  Widget build(BuildContext context) {
    return const Text("TabUsers");
  }

}