import 'package:flutter/material.dart';
import 'package:marewood_client/config/app.dart';
import 'package:marewood_client/routes.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const greyStyle = TextStyle(fontSize: 13,color: Colors.grey);

    return Drawer(
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset("assets/img/logo.png", width: 60),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Chip(label: Text("$appName $appVersion")),
                    ),
                    const Text("https://github.com/xusenlin/marewood",style: greyStyle),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          ListTile(
                            trailing: Text("v16.15.1",style: greyStyle),
                            title: Text("Node"),
                          ),
                          ListTile(
                            trailing: Text("7.33.6",style: greyStyle),
                            title: Text("Pnpm"),
                          ),
                          ListTile(
                            trailing: Text("1.22.19",style: greyStyle),
                            title: Text("Yarn"),
                          ),
                          ListTile(
                            trailing: Text("8.11.0",style: greyStyle),
                            title: Text("Npm"),
                          ),
                          ListTile(
                            trailing: Text("2.36.6",style: greyStyle),
                            title: Text("Git"),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Text("Admin",style: TextStyle(color: Colors.deepPurple)),
                          // const SizedBox(height: 60),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, Routes.stores);
                                  },
                                  tooltip: "local stores",
                                  icon: const Icon(Icons.store_mall_directory,size: 30,color: Colors.grey)
                              ),
                              IconButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, Routes.stores);
                                  },
                                  tooltip: "copy github url",
                                  icon: const Icon(Icons.copy_all,size: 30,color: Colors.grey)
                              ),
                              IconButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, Routes.stores);
                                  },
                                  tooltip: "login out",
                                  icon: const Icon(Icons.login_outlined,size: 30,color: Colors.grey)
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, Routes.stores);
                                  },
                                  tooltip: "local stores",
                                  icon: const Icon(Icons.store_mall_directory,size: 30,color: Colors.grey)
                              ),
                              IconButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, Routes.stores);
                                  },
                                  tooltip: "copy github url",
                                  icon: const Icon(Icons.copy_all,size: 30,color: Colors.grey)
                              ),
                              IconButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, Routes.stores);
                                  },
                                  tooltip: "login out",
                                  icon: const Icon(Icons.login_outlined,size: 30,color: Colors.grey)
                              ),
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
                )
            )
      )
    );
  }
}
