import 'package:flutter/material.dart';
import 'package:smartfm_poc/config/routes.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 200,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.studio);
              },
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                elevation: 3,
                fixedSize: const Size(400, 50),
                textStyle: const TextStyle(
                  color: Colors.black,
                ),
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
              ),
              child: const Text("Studio"),
            ),
          ],
        ),
      ),
    );
  }
}
