class Episode {
  final String bookId;
  final int episodeNo;
  final double length;
  final String url;
  final String title;
  final String episodeId;

  Episode({
    required this.bookId,
    required this.episodeNo,
    required this.length,
    required this.url,
    required this.title,
    required this.episodeId,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        bookId: json["bookId"] as String,
        episodeNo: json["episodeNo"] as int,
        length: json["length"] as double,
        url: json["url"] as String,
        title: json["title"] as String,
        episodeId: json["episodeId"] as String,
      );

  Map<String, dynamic> toJson() => {
        "bookId": bookId,
        "episodeNo": episodeNo,
        "length": length,
        "url": url,
        "title": title,
        "episodeId": episodeId,
      };
}
