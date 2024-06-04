import 'package:flutter/material.dart';
import 'package:marewood_client/config/app.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Image.asset("assets/img/logo.png", width: 60),
                ),
                const Text("$appName $appVersion"),
                const Text("https://github.com/xusenlin/marewood"),
                const Divider(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ListView(
                      children: const [
                        ListTile(
                          trailing: Text("v16.15.1"),
                          title: Text("Node"),
                        ),
                        ListTile(
                          trailing: Text("7.33.6"),
                          title: Text("Pnpm"),
                        ),
                        ListTile(
                          trailing: Text("1.22.19"),
                          title: Text("Yarn"),
                        ),
                        ListTile(
                          trailing: Text("8.11.0"),
                          title: Text("Npm"),
                        ),
                        ListTile(
                          trailing: Text("git version 2.36.6"),
                          title: Text("Git"),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),

              ],
          )
      )
    );
  }
}
