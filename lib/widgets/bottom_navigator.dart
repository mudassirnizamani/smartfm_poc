import 'package:flutter/material.dart';
import 'package:smartfm_poc/config/routes.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    int setCurrentIndex() {
      String? currentRoute = ModalRoute.of(context)?.settings.name;

      if (currentRoute == Routes.library) {
        return 1;
      } else if (currentRoute == Routes.search) {
        return 2;
      } else if (currentRoute == Routes.profile) {
        return 3;
      } else {
        return 0;
      }
    }

    int selectedIndex = setCurrentIndex();

    void onTap(int index) {
      setState(() {
        selectedIndex = index;
      });

      if (index == 0) {
        Navigator.pushNamed(context, Routes.home);
      } else if (index == 1) {
        Navigator.pushNamed(context, Routes.library);
      } else if (index == 2) {
        Navigator.pushNamed(context, Routes.search);
      } else if (index == 3) {
        Navigator.pushNamed(context, Routes.profile);
      }
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 5.0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_3),
          label: "",
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onTap,
    );
  }
}
