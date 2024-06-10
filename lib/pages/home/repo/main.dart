import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/storesViewer.dart';

class TabRepositories extends StatefulWidget {
  const TabRepositories({super.key});

  @override
  _TabRepositoriesState createState() => _TabRepositoriesState();
}

class _TabRepositoriesState extends State<TabRepositories> {
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefs = prefs;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_prefs == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return StoresViewer(prefs: _prefs!);
    }
  }
}