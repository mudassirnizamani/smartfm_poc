import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smartfm_poc/config/config.dart';
import 'package:smartfm_poc/config/routes.dart';
import 'package:smartfm_poc/models/audio_book.dart';
import 'package:smartfm_poc/models/episode.dart';
import 'package:smartfm_poc/screens/player.dart';
import 'package:smartfm_poc/services/audio_books.dart';
import 'package:smartfm_poc/services/user_service.dart';

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
              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(snapshot.data?.name ?? ""),
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.share,
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
                            BookDetails(
                              audioBook: snapshot.data,
                            ),
                            const SizedBox(
                              height: 50,
                              child: TabBar(
                                tabs: [
                                  Tab(
                                    child: Text("Episodes"),
                                  ),
                                  Tab(
                                    child: Text("Reviews"),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  Episodes(audioBook: snapshot.data!),
                                  const Reviews(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
                ),
              );
            }
        }
      },
    );
  }
}

class BookDetails extends StatefulWidget {
  final AudioBook? audioBook;

  const BookDetails({required this.audioBook, super.key});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  bool bookmarked = false;

  void changeBookMarkStatus(bool status) {
    setState(() {
      bookmarked = status;
    });
  }

  @override
  void initState() {
    super.initState();

    UserService.isBookSavedInUserLibrary(widget.audioBook?.audioBookId ?? "")
        .then((value) => changeBookMarkStatus(value));
  }

  void addBookToLibrary() async {
    final res = await UserService.addBookToUserLibrary(
        widget.audioBook?.audioBookId ?? "");

    setState(() {
      bookmarked = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
            top: 20,
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
                    "${Config.apiBaseUrl}/${widget.audioBook?.coverImage}",
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
          widget.audioBook?.name ?? "",
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "By ${widget.audioBook?.genre}",
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
              onPressed: () {
                if (!bookmarked) {
                  addBookToLibrary();
                }
              },
              icon: Icon(bookmarked == true
                  ? Icons.bookmark_added
                  : Icons.bookmark_outline),
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
                          audioBook: widget.audioBook!, episode: null),
                    ),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 40),
                    padding: const EdgeInsets.all(0)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow),
                    Text(
                      "Play",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ))
          ],
        ),
        Text(widget.audioBook?.description ?? ""),
      ],
    );
  }
}

class Episodes extends StatefulWidget {
  final AudioBook audioBook;

  const Episodes({required this.audioBook, super.key});

  @override
  State<Episodes> createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Episode>>(
        future: AudioBookService.fetchEpisodesUsingAudioBookId(
            widget.audioBook.audioBookId),
        builder: (BuildContext context, AsyncSnapshot<List<Episode>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          } else if (snapshot.hasError) {
            return Text("Error occurred, ${snapshot.error}");
          } else {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) => ListTile(
                      onTap: () => Navigator.pushNamed(
                        context,
                        Routes.player,
                        arguments: PlayerParams(
                            episode: snapshot.data![index],
                            audioBook: widget.audioBook),
                      ),
                      leading: const Icon(Icons.one_k),
                      title: Text(snapshot.data![index].title),
                      subtitle: Row(children: [
                        const Icon(Icons.alarm),
                        Text(snapshot.data![index].chapterDuration.toString())
                      ]),
                    ));
          }
        });
  }
}

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Reviews");
  }
}
