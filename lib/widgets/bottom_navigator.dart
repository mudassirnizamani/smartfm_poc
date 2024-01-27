import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;

    void onTap(int index) {
      setState(() {
        selectedIndex = index;
      });
      if (index == 0) {
        Navigator.pushNamed(context, "/home");
      } else if (index == 1) {
        Navigator.pushNamed(context, "/search");
      } else if (index == 2) {
        Navigator.pushNamed(context, "/library");
      }
    }

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          label: 'Library',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onTap,
    );
  }
}
