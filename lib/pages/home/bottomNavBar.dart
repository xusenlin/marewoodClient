import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });


  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Task',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.source),
          label: 'Repositories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Users',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: primaryColor,
      onTap: onItemTapped,
    );
  }
}