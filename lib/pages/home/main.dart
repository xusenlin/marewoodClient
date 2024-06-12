import 'dart:core';
import 'package:marewood_client/stores/userProvider.dart';
import 'package:provider/provider.dart';
import '../../routes.dart';
import 'users/main.dart';
import 'repo/main.dart';
import 'task/main.dart';
import 'package:flutter/material.dart';
import './bottomNavBar.dart';
import './drawer/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomePageState();
}


class _HomePageState extends State<Home> {

  int _selectedIndex = 0;


  static const List<Widget> _tabContent = [
    TabTask(),TabRepositories(),TabUsers()
  ];

  static const List<String> _tabName = [
    "Task","Repositories","Users"
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    var userProvider = Provider.of<UserProvider>(context);
    var user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(_tabName[_selectedIndex]),
      ),
      body: SafeArea(
          child: user == null ?
              Center(
                  child:ElevatedButton( onPressed: () { Navigator.pushNamed(context, Routes.login); },
                  child: const Text("Please log in"))
              )
              :  _tabContent[_selectedIndex]),
      drawer: const LeftDrawer(),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          print('Floating Action Button Pressed!');
        },
        tooltip: 'Increment',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}