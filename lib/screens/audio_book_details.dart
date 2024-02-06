import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smartfm_poc/config/config.dart';
import 'package:smartfm_poc/config/routes.dart';
import 'package:smartfm_poc/models/audio_book.dart';
import 'package:smartfm_poc/screens/player.dart';
import 'package:smartfm_poc/services/audio_books.dart';

class AudioBookParams {
  final String audioBookId;

  AudioBookParams({required this.audioBookId});
}

class AudioBookDetails extends StatefulWidget {
  const AudioBookDetails({super.key});

  @override
  State<AudioBookDetails> createState() => _AudioBookDetailsState();
}

class _AudioBookDetailsState extends State<AudioBookDetails> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as AudioBookParams;

    return FutureBuilder<AudioBook?>(
      future: AudioBookService.fetchAudioBookUsingId(args.audioBookId),
      builder: (context, AsyncSnapshot<AudioBook?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: Text("Loading"),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text(snapshot.data?.name ?? ""),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 25,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                    child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 30,
                            ),
                            height: MediaQuery.of(context).size.height * 0.32,
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 25,
                                        offset: const Offset(8, 8),
                                        spreadRadius: 3,
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 25,
                                        offset: const Offset(-8, -8),
                                        spreadRadius: 3,
                                      )
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      "${Config.apiBaseUrl}/${snapshot.data?.coverImage}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.3),
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.3),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            snapshot.data?.name ?? "",
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "By ${snapshot.data?.genre}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                ignoreGestures: true,
                                itemSize: 20,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "3.0",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton.outlined(
                                onPressed: () {},
                                icon: const Icon(Icons.bookmark_border),
                                iconSize: 18,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () => Navigator.pushNamed(
                                        context,
                                        Routes.player,
                                        arguments: PlayerParams(
                                            audioBookId: args.audioBookId),
                                      ),
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(300, 40),
                                      padding: const EdgeInsets.all(0)),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.play_arrow),
                                      Text(
                                        "Play",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )),
              );
            }
        }
      },
    );
  }
}
