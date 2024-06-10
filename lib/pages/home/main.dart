import 'dart:core';

import '../../routes.dart';
import 'users/main.dart';
import 'repo/main.dart';
import 'task/main.dart';
import 'package:flutter/material.dart';

import './bottomNavBar.dart';
import 'leftDrawer.dart';

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
  void initState() {
    super.initState();
    // await UserStore.removeUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabName[_selectedIndex]),
      ),
      body: SafeArea(child: _tabContent[_selectedIndex]),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       Navigator.pushNamed(context, Routes.test);
      //     },
      //     child: const Text('Go to Test Page'),
      //   ),
      // ),
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