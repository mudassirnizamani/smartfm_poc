class AudioBook {
  final String publishedAt;
  final String name;
  final String genre;
  final String description;
  final String language;
  final String coverImage;
  final int totalDuration;
  final String audioBookId;

  AudioBook({
    required this.publishedAt,
    required this.audioBookId,
    required this.coverImage,
    required this.description,
    required this.genre,
    required this.language,
    required this.name,
    required this.totalDuration,
  });

  factory AudioBook.fromJson(Map<String, dynamic> json) => AudioBook(
        publishedAt: json["publishedAt"] as String,
        audioBookId: json["audioBookId"] as String,
        coverImage: json["coverImage"] as String,
        description: json["description"] as String,
        genre: json["genre"] as String,
        language: json["language"] as String,
        name: json["name"] as String,
        totalDuration: json["totalDuration"] as int,
      );

  Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt,
        "audioBookId": audioBookId,
        "coverImage": coverImage,
        "description": description,
        "genre": genre,
        "language": language,
        "name": name,
        "totalDuration": totalDuration,
      };
}
