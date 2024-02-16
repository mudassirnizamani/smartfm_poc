class Episode {
  final String audioBookId;
  final int chapterNumber;
  final double chapterDuration;
  final String url;
  final String title;
  final String episodeId;

  Episode({
    required this.audioBookId,
    required this.chapterNumber,
    required this.chapterDuration,
    required this.url,
    required this.title,
    required this.episodeId,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        audioBookId: json["audioBookId"] as String,
        chapterNumber: json["chapterNumber"] as int,
        chapterDuration: json["chapterDuration"] as double,
        url: json["url"] as String,
        title: json["title"] as String,
        episodeId: json["episodeId"] as String,
      );

  Map<String, dynamic> toJson() => {
        "audioBookId": audioBookId,
        "chapterNumber": chapterNumber,
        "chapterDuration": chapterDuration,
        "url": url,
        "title": title,
        "episodeId": episodeId,
      };
}
