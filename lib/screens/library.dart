import 'package:flutter/material.dart';
import 'package:smartfm_poc/widgets/cusom_drawer.dart';

import '../widgets/bottom_navigator.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigator(),
      appBar: AppBar(title: const Text('Library')),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text('Library'),
      ),
    );
  }
}
