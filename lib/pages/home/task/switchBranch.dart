import 'package:flutter/material.dart';

Future<void> switchBranch(BuildContext context) async {
  List<String> branch = ["main","master","sl-svip","main","master"];

  int? i = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('switch branch'),
            children: List.generate(branch.length, (index) {
              return SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, index);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(branch[index],style: const TextStyle(fontSize: 18)),
                ),
              );
            })
        );
      });

  if (i == null) {
    return;
  }
  print("选择了：${i }");
}