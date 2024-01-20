import 'package:flutter/material.dart';
import 'package:smartfm_poc/components/bottom_navigator.dart';
import 'package:smartfm_poc/components/cusom_drawer.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigator(),
      appBar: AppBar(title: const Text('Search')),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text('Search'),
      ),
    );
  }
}
