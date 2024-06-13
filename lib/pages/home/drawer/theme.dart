import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../stores/themeProvider.dart';

class ThemeAction extends StatelessWidget {
  const ThemeAction({super.key});

  static const List<Color> themeColors = [
    Colors.blue,
    Colors.green,
    Colors.deepPurple,
  ];

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    var iconList = themeColors.map((Color c) {
      return IconButton(
        onPressed: () {
          themeProvider.setTheme(c);
        },
        icon: Icon(
          themeProvider.themeColor.value == c.value
              ? Icons.radio_button_checked
              : Icons.radio_button_unchecked,
          size: 24,
          color: c,
        ),
      );
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: iconList,
    );
  }
}
