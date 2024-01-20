import 'package:flutter/material.dart';
import 'package:smartfm_poc/config/routes.dart';

class Studio extends StatefulWidget {
  const Studio({super.key});

  @override
  State<Studio> createState() => _StudioState();
}

class _StudioState extends State<Studio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: Text(
                "Smart Studio",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  const Text(
                    "Create and Share",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Create audiobooks and share with the world",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.createAudioBook);
                    },
                    style: OutlinedButton.styleFrom(
                      elevation: 6,
                      fixedSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: Colors.redAccent,
                    ),
                    child: const Text("Create AudioBook"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
