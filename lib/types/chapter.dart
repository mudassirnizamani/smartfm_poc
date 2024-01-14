class Chapter {
  final String audioBookId;
  final int chapterNumber;
  final int chapterDuration;
  final String url;
  final String title;
  final String chapterId;

  Chapter({
    required this.audioBookId,
    required this.chapterNumber,
    required this.chapterDuration,
    required this.url,
    required this.title,
    required this.chapterId,
  });

  Chapter fromJson(Map<String, dynamic> json) => Chapter(
        audioBookId: json["audioBookId"] as String,
        chapterNumber: json["chapterNumber"] as int,
        chapterDuration: json["chapterDuration"] as int,
        url: json["url"] as String,
        title: json["title"] as String,
        chapterId: json["chapterId"] as String,
      );

  Map<String, dynamic> toJson() => {
        "audioBookId": audioBookId,
        "chapterNumber": chapterNumber,
        "chapterDuration": chapterDuration,
        "url": url,
        "title": title,
        "chapterId": chapterId,
      };
}
