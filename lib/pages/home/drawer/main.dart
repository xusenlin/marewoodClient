import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marewood_client/models/sysInfo.dart';
import 'package:marewood_client/pages/home/drawer/theme.dart';
import 'package:marewood_client/pages/home/drawer/top.dart';
import 'package:marewood_client/routes.dart';
import 'package:provider/provider.dart';
import '../../../api/common.dart';
import '../../../stores/themeProvider.dart';
import '../../../stores/userProvider.dart';

class MainDrawer extends StatefulWidget{
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState()  => _DrawerState();

}




class _DrawerState extends State<MainDrawer> {

   SysInfo ? sysInfo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initMainDrawer(context);
    });
  }

  Future<void> _initMainDrawer(BuildContext context) async{
    try{
      var sys = await fetchSysInfo();
      setState(() {
        sysInfo = sys;
      });
    }catch(e){
      if(!context.mounted)return;
      // Navigator.of(context).pop();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //       behavior: SnackBarBehavior.floating,
      //       content: Text(e.toString() )
      //   ),
      // );
    }
  }

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
            if(sysInfo!=null)DrawerTop(sysInfo: sysInfo!),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  ListTile(
                    trailing: Text(sysInfo == null ? "..." : sysInfo?.dependTools["node"], style: greyStyle),
                    title: const Text("Node"),
                  ),
                  ListTile(
                    trailing: Text(sysInfo == null ? "..." : sysInfo?.dependTools["pnpm"], style: greyStyle),
                    title: const Text("Pnpm"),
                  ),
                  ListTile(
                    trailing: Text(sysInfo == null ? "..." : sysInfo?.dependTools["yarn"], style: greyStyle),
                    title: const Text("Yarn"),
                  ),
                  ListTile(
                    trailing: Text(sysInfo == null ? "..." : sysInfo?.dependTools["npm"], style: greyStyle),
                    title: const Text("Npm"),
                  ),
                  ListTile(
                    trailing: Text(sysInfo == null ? "..." : sysInfo?.dependTools["git"], style: greyStyle),
                    title: const Text("Git"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ThemeAction(),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.stores);
                          },
                          tooltip: "local stores",
                          icon: Icon(Icons.admin_panel_settings,
                              size: 24, color: primaryColor)),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Clipboard.setData(
                                const ClipboardData(text: "https://github.com/xusenlin/marewood")
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  width:250,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text('The github url has been copied.')
                              ),
                            );
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
