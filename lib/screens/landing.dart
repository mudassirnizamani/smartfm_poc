import 'package:flutter/material.dart';
import 'package:smartfm_poc/config/routes.dart';
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

  NavigatorState _getNavigator() => Navigator.of(context);

  Future<void> _checkAuth() async {
    final user = await UserStorage.getUser();
    final navigator = _getNavigator();

    if (user == null) {
      navigator.pushNamedAndRemoveUntil(Routes.auth, (route) => false);
    } else {
      navigator.pushNamedAndRemoveUntil(Routes.home, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
