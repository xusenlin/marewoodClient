import 'package:flutter/material.dart';
import 'package:marewood_client/pages/home/drawer/top.dart';
import 'package:marewood_client/routes.dart';
import 'package:provider/provider.dart';
import '../../../stores/themeProvider.dart';
import '../../../stores/userProvider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const greyStyle = TextStyle(fontSize: 13, color: Colors.grey);
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    var themeProvider = Provider.of<ThemeProvider>(context);
    final primaryColor = themeProvider.themeColor;

    return Drawer(
        width: 300,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            const DrawerTop(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  ListTile(
                    trailing: Text("v16.15.1", style: greyStyle),
                    title: Text("Node"),
                  ),
                  ListTile(
                    trailing: Text("7.33.6", style: greyStyle),
                    title: Text("Pnpm"),
                  ),
                  ListTile(
                    trailing: Text("1.22.19", style: greyStyle),
                    title: Text("Yarn"),
                  ),
                  ListTile(
                    trailing: Text("8.11.0", style: greyStyle),
                    title: Text("Npm"),
                  ),
                  ListTile(
                    trailing: Text("2.36.6", style: greyStyle),
                    title: Text("Git"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          themeProvider.setTheme(Colors.blue);
                        },
                        tooltip: "Change to blue",
                        icon: const Icon(Icons.panorama_fish_eye_outlined,
                            size: 24, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: () {
                          themeProvider.setTheme( Colors.green);
                        },
                        tooltip: "Change to green",
                        icon: const Icon(Icons.panorama_fish_eye_outlined,
                            size: 24, color: Colors.green),
                      ),
                      IconButton(
                        onPressed: () {
                          themeProvider.setTheme(Colors.deepPurple);
                        },
                        tooltip: "Change to deepPurple",
                        icon: const Icon(Icons.panorama_fish_eye_outlined,
                            size: 24, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.stores);
                          },
                          tooltip: "local stores",
                          icon: Icon(Icons.store_mall_directory,
                              size: 24, color: primaryColor)),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.stores);
                          },
                          tooltip: "copy github url",
                          icon: Icon(Icons.copy_all,
                              size: 24, color: primaryColor)),
                      IconButton(
                          onPressed: () async {
                            userProvider.removeUser();
                            Navigator.of(context).pop();
                          },
                          tooltip: "login out",
                          icon: Icon(Icons.login_outlined,
                              size: 24, color: primaryColor)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
