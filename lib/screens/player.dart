import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:smartfm_poc/config/config.dart';
import 'package:smartfm_poc/models/audio_book.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartfm_poc/models/episode.dart';
import 'package:smartfm_poc/widgets/seek_bar.dart';

class PlayerParams {
  final Episode? episode;
  final AudioBook audioBook;

  PlayerParams({required this.episode, required this.audioBook});
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => SizedBox(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: const TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

T? ambiguate<T>(T? value) => value;

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as PlayerParams;

    if (args.episode != null) {
      _player.setAudioSource(AudioSource.uri(
          Uri.parse("${Config.apiBaseUrl}/${args.episode?.url}")));
    }

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          backgroundColor: const Color(0xfffff8ee),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          showUnselectedLabels: true,
          elevation: 0,
          selectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          onTap: (index) async {
            if (index == 0) {
            } else if (index == 1) {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: _player.speed,
                stream: _player.speedStream,
                onChanged: _player.setSpeed,
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Chapters',
              icon: Icon(Icons.book, size: 25),
            ),
            BottomNavigationBarItem(
              label: "Speed",
              icon: Icon(Icons.speed),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.88,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "${Config.apiBaseUrl}/${args.audioBook.coverImage}"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20,
                sigmaY: 20,
              ),
              child: Container(
                alignment: Alignment.center,
                color: Colors.black.withOpacity(0.1),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        right: 10,
                        left: 10,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_downward_rounded),
                              iconSize: 25,
                              color: Colors.grey[200],
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            IconButton(
                              icon: const Icon(Icons.share),
                              iconSize: 20,
                              color: Colors.grey[200],
                              onPressed: () {},
                            )
                          ]),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.38,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
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
                                  "${Config.apiBaseUrl}/${args.audioBook.coverImage}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          )
                          // Container(
                          //   height: double.infinity,
                          //   width: double.infinity,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20),
                          //     gradient: LinearGradient(
                          //       colors: [
                          //         Colors.black.withOpacity(0.3),
                          //         Colors.transparent,
                          //         Colors.black.withOpacity(0.3),
                          //       ],
                          //       begin: Alignment.centerLeft,
                          //       end: Alignment.centerRight,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Text(
                      args.audioBook.name,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "By ${args.audioBook.genre}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xfffff8ee),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Chapter 2",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            StreamBuilder<PositionData>(
                              stream: _positionDataStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<PositionData> snapshot) {
                                final positionData = snapshot.data;
                                return SeekBar(
                                  duration:
                                      positionData?.duration ?? Duration.zero,
                                  position:
                                      positionData?.position ?? Duration.zero,
                                  bufferedPosition:
                                      positionData?.bufferedPosition ??
                                          Duration.zero,
                                  onChangeEnd: _player.seek,
                                );
                              },
                            ),
                            ControlButtons(_player),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.skip_previous_outlined),
          iconSize: 26,
          color: Colors.black,
        ),
        IconButton(
          color: Colors.black,
          onPressed: () {
            player.seek(
                Duration(milliseconds: player.position.inMicroseconds + 10));
          },
          icon: const Icon(Icons.forward_10_outlined),
          iconSize: 26,
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, AsyncSnapshot<PlayerState> snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                color: Colors.black,
                icon: const Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 64.0,
                color: Colors.black,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
                color: Colors.black,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        IconButton(
          color: Colors.black,
          onPressed: () {
            player.seek(
                Duration(milliseconds: player.position.inMicroseconds + 10));
          },
          icon: const Icon(Icons.replay_10_outlined),
          iconSize: 26,
        ),
        IconButton(
          color: Colors.black,
          onPressed: () {},
          icon: const Icon(Icons.skip_next_outlined),
          iconSize: 26,
        ),
      ],
    );
  }
}
