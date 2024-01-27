import 'package:flutter/material.dart';
import 'package:smartfm_poc/config/app_theme.dart';
import 'package:smartfm_poc/config/routes.dart';
import 'package:smartfm_poc/screens/create_audio_book.dart';
import 'package:smartfm_poc/screens/auth.dart';
import 'package:smartfm_poc/screens/home.dart';
import 'package:smartfm_poc/screens/landing.dart';
import 'package:smartfm_poc/screens/library.dart';
import 'package:smartfm_poc/screens/profile.dart';
import 'package:smartfm_poc/screens/search.dart';
import 'package:smartfm_poc/screens/studio.dart';

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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: Routes.root,
      routes: {
        Routes.root: (context) => const Landing(),
        Routes.auth: (context) => const Auth(),
        Routes.home: (context) => const Home(),
        Routes.library: (context) => const Library(),
        Routes.search: (context) => const Search(),
        Routes.profile: (context) => const Profile(),
        Routes.studio: (context) => const Studio(),
        Routes.createAudioBook: (context) => const CreateAudioBook()
      },
    );
  }
}
