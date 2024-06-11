import 'package:flutter/material.dart';
import 'package:marewood_client/config/app.dart';
import 'package:marewood_client/routes.dart';

import '../../components/arcClipper.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const greyStyle = TextStyle(fontSize: 13, color: Colors.grey);
    final primaryColor = Theme.of(context).primaryColor;

    return Drawer(
        width: 300,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 230,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      // opacity: 0.6,
                      alignment: Alignment.bottomRight,
                      image: AssetImage("assets/img/bg.png"), // 替换为实际的图片URL
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 26,
                        child: Image.asset("assets/img/logo.png", width: 30),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Admin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    right: 18,
                    bottom: 0,
                    child: Container(
                      width: 300 - 18*2,
                      height: 80,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                      ),
                      child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("$appName $appVersion",
                            style:
                            TextStyle(color: Colors.white, fontSize: 12)),
                        Text("https://github.com/xusenlin/marewood",
                            style: greyStyle),
                      ]),
                    ),
                    // Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    // children: [
                    //   Text("$appName $appVersion",
                    //       style:
                    //       TextStyle(color: Colors.white, fontSize: 12)),
                    //   Text("https://github.com/xusenlin/marewood",
                    //       style: greyStyle),
                    // ])
                ),
                Positioned(
                    left: 0,
                    bottom: 0,
                    child: ClipPath(
                      clipper: ArcClipper(),
                      child: Container(
                        width: 300,
                        height: 30,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
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
                          // changePrimaryColor(Colors.red);
                        },
                        tooltip: "Change to Red",
                        icon: const Icon(Icons.panorama_fish_eye_outlined,
                            size: 24, color: Colors.red),
                      ),
                      IconButton(
                        onPressed: () {
                          // changePrimaryColor(Colors.green);
                        },
                        tooltip: "Change to Green",
                        icon: const Icon(Icons.panorama_fish_eye_outlined,
                            size: 24, color: Colors.green),
                      ),
                      IconButton(
                        onPressed: () {
                          // changePrimaryColor(Colors.blue);
                        },
                        tooltip: "Change to Blue",
                        icon: const Icon(Icons.panorama_fish_eye_outlined,
                            size: 24, color: Colors.blue),
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
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.stores);
                          },
                          tooltip: "login out",
                          icon: Icon(Icons.login_outlined,
                              size: 24, color: primaryColor)),
                    ],
                  ),
                ],
              ),
              // child: Center(
              //     child: ElevatedButton(
              //       onPressed: () {
              //         // Navigator.pushNamed(context, Routes.test);
              //       },
              //       child: const Text('Logout'),
              //     )
              // )
            ),
          ],
        ));
  }
}
