import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback click;

  const IconWithText({super.key, required this.icon, required this.text, required this.click});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: click, icon: Icon(icon, size: 24.0)),
        SizedBox(
          width: 70, // 限制宽度
          child: Text(
            text,
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.visible,
            maxLines: 2,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}