import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/storesViewer.dart';

class LocalStores extends StatefulWidget {
  const LocalStores({super.key});

  @override
  LocalStoresState createState() => LocalStoresState();
}

class LocalStoresState extends State<LocalStores> {
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
    return Scaffold(
      appBar: AppBar(title: const Text("LocalStores")),
      body:
        _prefs ==null?const Center(child: CircularProgressIndicator()):StoresViewer(prefs: _prefs!)
    );
  }
}
