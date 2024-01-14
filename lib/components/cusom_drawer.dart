import 'package:flutter/material.dart';
import 'package:smartfm_poc/config/routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  void navigate(String route, BuildContext context) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () => navigate(Routes.home, context),
          ),
          ListTile(
            title: const Text('Library'),
            onTap: () => navigate(Routes.library, context),
          ),
        ],
      ),
    );
  }
}
