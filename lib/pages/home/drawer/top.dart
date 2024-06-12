import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/arcClipper.dart';
import '../../../config/app.dart';
import '../../../stores/userProvider.dart';

class DrawerTop extends StatelessWidget{
  const DrawerTop({super.key});

  @override
  Widget build(BuildContext context) {

    const greyStyle = TextStyle(fontSize: 13, color: Colors.grey);
    final primaryColor = Theme.of(context).primaryColor;
    var userProvider = Provider.of<UserProvider>(context);
    var user = userProvider.user;

    return  Stack(
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
              Text(
                user == null ? "Not logged in" :user.username,
                style: const TextStyle(
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
            child:  const Column(
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
    );
  }
}