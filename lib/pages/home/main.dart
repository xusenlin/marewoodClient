import 'dart:core';

import './tabContent/users.dart';
import './tabContent/repositories.dart';
import 'task/task.dart';
import '../../routes.dart';
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
    );
  }
}