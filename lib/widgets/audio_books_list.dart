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
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: Text("Loading"),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.audioBook,
                      arguments: AudioBookParams(
                          audioBookId: snapshot.data?[index].bookId ?? ""),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 5,
                            right: 10,
                          ),
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.3,
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
                        Text(
                          snapshot.data?[index].title ?? "",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          snapshot.data?[index].description ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
        }
      },
    );
  }
}
