class AudioBook {
  final String publishedAt;
  final String title;
  final String genre;
  final String author;
  final String description;
  final String language;
  final String coverImage;
  final int totalDuration;
  final String bookId;
  final String userId;

  AudioBook({
    required this.publishedAt,
    required this.coverImage,
    required this.description,
    required this.genre,
    required this.language,
    required this.totalDuration,
    required this.author,
    required this.bookId,
    required this.title,
    required this.userId,
  });

  factory AudioBook.fromJson(Map<String, dynamic> json) => AudioBook(
        publishedAt: json["publishedAt"] as String,
        bookId: json["bookId"] as String,
        coverImage: json["coverImage"] as String,
        description: json["description"] as String,
        genre: json["genre"] as String,
        language: json["language"] as String,
        title: json["title"] as String,
        totalDuration: json["totalDuration"] as int,
        author: json["author"] as String,
        userId: json["userId"] as String,
      );

  Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt,
        "bookId": bookId,
        "coverImage": coverImage,
        "description": description,
        "genre": genre,
        "language": language,
        "title": title,
        "totalDuration": totalDuration,
        "author": author,
      };
}
