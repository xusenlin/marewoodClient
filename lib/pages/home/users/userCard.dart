import 'package:flutter/material.dart';
import 'package:marewood_client/models/user.dart';
import 'package:marewood_client/pages/home/users/status.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../../../stores/themeProvider.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user, required this.onChangeData});

  final UseUser user;
  final VoidCallback onChangeData;

  String roleDesc(int val){
    switch (val){
      case 1:
        return "SuperAdministrator";
      case 3:
        return "Administer";
      case 6:
        return "Developer";
      case 10:
        return "Reporter";
      default:
        return "Invalid";
    }
  }


  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    const bodyText = TextStyle(color: Colors.grey);
    var valText = TextStyle(color: themeProvider.themeColor);

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 18),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 18),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text("UserName：${user.username}",
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: Color.fromARGB(255, 3, 7, 18))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Status(status: user.status),
              ),
              // Text('Status:${task.status.toString()}'),
            ],
          ),
          // const Divider(color: Color.fromARGB(255, 229, 231, 235)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Role：', style: bodyText),
                Text(roleDesc(user.role), style: valText),
              ],
            ),

              // updatedAt
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('UpdatedAt：', style: bodyText),
              Text(user.updatedAt, style: valText),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text('#${user.id.toString()}',
                        style: TextStyle(color: themeProvider.themeColor)),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    tooltip: "edit  user",
                    icon: const Icon(Icons.design_services, size: 20),
                    onPressed: () async {
                      TDToast.showText('Under development', context: context);
                    },
                  ),
                  IconButton(
                    tooltip: "delete user",
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () async {
                      TDToast.showText('Under development', context: context);
                    },
                  ),
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
