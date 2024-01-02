import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfm_poc/models/user.dart';
import 'package:smartfm_poc/storage/user_storage.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  _checkAuth() async {
    final user = await UserStorage().getUser();

    if (user == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/auth', ModalRoute.withName('/auth'));
    }

    Navigator.pushNamedAndRemoveUntil(
        context, '/home', ModalRoute.withName('/home'));
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
