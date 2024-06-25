import 'package:flutter/material.dart';

void showConfirmationDialog(BuildContext context,String title,String content,VoidCallback ok) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // 关闭对话框
            },
          ),
          TextButton(
            child: const Text('Continue'),
            onPressed: ()  {
              ok();
              Navigator.of(context).pop(); // 关闭对话框
            },
          ),
        ],
      );
    },
  );
}