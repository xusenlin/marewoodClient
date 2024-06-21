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
  final  _taskKey = GlobalKey<TaskListState>();
  final  _repoKey = GlobalKey<TabRepositoriesState>();
  final  _userKey = GlobalKey<TabUserState>();

  static const List<String> _tabName = [
    "Task","Repositories","Users"
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _callChildRefresh() {
    switch (_selectedIndex){
      case 0:
        _taskKey.currentState?.refresh();
      case 1:
        _repoKey.currentState?.refresh();
      case 2:
        _userKey.currentState?.refresh();
    }

  }

  void clickFloatingButton(){
    switch (_selectedIndex){
      case 0:
        Navigator.pushNamed(context, Routes.taskEdit);
      case 1:
      case 2:
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabContent = [
      TabTask(key: _taskKey),TabRepositories(key: _repoKey),TabUser(key: _userKey)
    ];
    var userProvider = Provider.of<UserProvider>(context);
    var user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(_tabName[_selectedIndex]),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'refresh') {
                  _callChildRefresh();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'refresh',
                  child: ListTile(
                    leading: Icon(Icons.refresh),
                    title: Text('Refresh'),
                  ),
                ),
              ],
            ),
          ]
      ),
      body: SafeArea(
          child: user == null ?
              Center(
                  child:ElevatedButton( onPressed: () { Navigator.pushNamed(context, Routes.login); },
                  child: const Text("Please log in"))
              )
              :  tabContent[_selectedIndex]),
      drawer: const MainDrawer(),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => clickFloatingButton(),
        tooltip: 'Increment',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}