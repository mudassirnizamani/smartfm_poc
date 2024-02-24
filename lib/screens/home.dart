import 'package:flutter/material.dart';
import 'package:smartfm_poc/widgets/audio_books_list.dart';
import 'package:smartfm_poc/widgets/bottom_navigator.dart';
import 'package:smartfm_poc/widgets/cusom_drawer.dart';
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
              icon: const Icon(Icons.search),
              onPressed: () => Navigator.pushNamed(context, Routes.search),
            ),
            tooltip: 'Open shopping cart',
            onPressed: () {},
          ),
        ],
        automaticallyImplyLeading: false,
        title: const Text("Hello Mudassir!"),
      ),
      drawer: const CustomDrawer(),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AudioBooksList(
            heading: "Recommended for you",
          ),
          AudioBooksList(
            heading: "Recommended for you",
          ),
        ],
      ),
    );
  }
}
