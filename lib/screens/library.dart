import 'package:flutter/material.dart';
import 'package:smartfm_poc/config/config.dart';
import 'package:smartfm_poc/config/routes.dart';
import 'package:smartfm_poc/models/audio_book.dart';
import 'package:smartfm_poc/screens/audio_book_details.dart';
import 'package:smartfm_poc/services/users_library_service.dart';
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
      body: const Column(
        children: [
          UserLibraryBooks(),
        ],
      ),
    );
  }
}

class UserLibraryBooks extends StatefulWidget {
  const UserLibraryBooks({super.key});

  @override
  State<UserLibraryBooks> createState() => _UserLibraryBooksState();
}

class _UserLibraryBooksState extends State<UserLibraryBooks> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AudioBook>>(
        future: UsersLibraryService.fetchUserLibrary(),
        builder:
            (BuildContext context, AsyncSnapshot<List<AudioBook>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading...");
          } else if (snapshot.hasError) {
            return Text("error occurred ${snapshot.error}");
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.audioBook,
                  arguments: AudioBookParams(
                    audioBookId: snapshot.data?[index].bookId ?? "",
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 6,
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    width: 500,
                                    "${Config.apiBaseUrl}/${snapshot.data?[index].coverImage}",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index].title,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data![index].author,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
