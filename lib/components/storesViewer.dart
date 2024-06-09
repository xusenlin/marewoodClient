import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoresViewer extends StatelessWidget {
  final SharedPreferences prefs;

  const StoresViewer({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: prefs.getKeys().map((String key) {
        return ListTile(
          title: Text(key),
          subtitle: Text(prefs.get(key).toString()),
        );
      }).toList(),
    );
  }
}