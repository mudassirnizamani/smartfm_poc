import 'package:flutter/material.dart';
import 'package:smartfm_poc/config/routes.dart';
import 'package:smartfm_poc/storage/user_storage.dart';
import 'package:smartfm_poc/widgets/audio_books_list.dart';

class Studio extends StatefulWidget {
  const Studio({super.key});

  @override
  State<Studio> createState() => _StudioState();
}

class _StudioState extends State<Studio> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Text(
              "Smart Studio",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(child: Text("Publish")),
              Tab(child: Text("Published")),
              Tab(child: Text("Analytics")),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.transparent),
        ),
        body: const TabBarView(
          children: [Publish(), Published(), Analytics()],
        ),
      ),
    );
  }
}

class Publish extends StatelessWidget {
  const Publish({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.createEpisode);
                },
                style: OutlinedButton.styleFrom(
                  elevation: 3,
                  fixedSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Create Episode"),
              ),
              const SizedBox(
                height: 30,
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
    );
  }
}

class Published extends StatefulWidget {
  const Published({super.key});

  @override
  State<Published> createState() => _PublishedState();
}

class _PublishedState extends State<Published> {
  String? userId;

  @override
  void initState() {
    super.initState();

    UserStorage.getUser().then((user) => {
          if (user != null) {setState(() => userId = user.userId)}
        });
  }

  @override
  Widget build(BuildContext context) {
    return AudioBooksList(
      heading: "My Library",
      userId: userId,
    );
  }
}

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Analytics");
  }
}
