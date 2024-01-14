import 'package:flutter/material.dart';
import 'package:smartfm_poc/components/bottom_navigator.dart';
import 'package:smartfm_poc/components/cusom_drawer.dart';
import 'package:smartfm_poc/config/routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigator(),
      appBar: AppBar(
        elevation: 13.0,
        actions: <Widget>[
          IconButton(
            icon: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            tooltip: 'Open shopping cart',
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          onPressed: () {
            Navigator.pushNamed(context, Routes.profile);
          },
        ),
      ),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
