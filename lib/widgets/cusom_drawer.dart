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
      child: ListView(
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
