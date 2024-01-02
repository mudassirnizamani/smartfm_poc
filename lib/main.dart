import 'package:flutter/material.dart';
import 'package:smartfm_poc/config/routes.dart';
import 'package:smartfm_poc/screens/auth.dart';
import 'package:smartfm_poc/screens/home.dart';
import 'package:smartfm_poc/screens/landing.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SmartFm',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        initialRoute: Routes.root,
        routes: {
          Routes.root: (context) => const Landing(),
          Routes.auth: (context) => const Auth(),
          Routes.home: (context) => const Home(),
        });
  }
}
