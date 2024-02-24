// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:smartfm_poc/config/config.dart';
import 'package:smartfm_poc/config/routes.dart';
import 'package:smartfm_poc/models/audio_book.dart';
import 'package:smartfm_poc/screens/audio_book_details.dart';
import 'package:smartfm_poc/services/books_service.dart';

class AudioBooksList extends StatelessWidget {
  final String heading;
  final String? userId;

  const AudioBooksList({super.key, required this.heading, this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AudioBook>>(
      future: userId == null
          ? BooksService.fetchAudioBooks() as Future<List<AudioBook>>
          : BooksService.fetchAudioBooksUsingUserId(userId!)
              as Future<List<AudioBook>>,
      builder: (BuildContext context, AsyncSnapshot<List<AudioBook>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("loading..");
        } else if (snapshot.hasError) {
          return const Text("Error Occurred");
        } else {
          return Flexible(
              flex: 1,
              child: ListView.builder(
                itemCount: snapshot.data?.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.audioBook,
                      arguments: AudioBookParams(
                        audioBookId: snapshot.data?[index].bookId ?? "",
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3.9,
                            width: MediaQuery.of(context).size.width / 2.6,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 5,
                                        offset: const Offset(5, 5),
                                        spreadRadius: 1,
                                      )
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      "${Config.apiBaseUrl}/${snapshot.data?[index].coverImage}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              snapshot.data?[index].title ?? "",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              snapshot.data![index].author.length > 8
                                  ? snapshot.data![index].author.substring(1, 8)
                                  : snapshot.data![index].author,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ));
        }
      },
    );
  }
}
