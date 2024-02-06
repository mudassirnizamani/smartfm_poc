import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smartfm_poc/models/user.dart';
import 'package:smartfm_poc/services/api.dart';
import 'package:smartfm_poc/models/audio_book.dart';
import 'package:smartfm_poc/storage/user_storage.dart';

class CreateAudioBookResponse {
  final String? id;
  final String? name;
  final String? description;
  final String? genre;

  CreateAudioBookResponse({this.id, this.name, this.description, this.genre});

  factory CreateAudioBookResponse.fromJson(Map<String, dynamic> json) {
    return CreateAudioBookResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      genre: json['genre'],
    );
  }
}

class AudioBookService {
  static Future<CreateAudioBookResponse> createAudioBook(String name,
      String description, String genre, File cover, String language) async {
    User? user = await UserStorage.getUser();

    FormData formData = FormData.fromMap({
      'name': name,
      'description': description,
      'genre': genre,
      'language': language,
      'userId': user?.userId ?? "",
      'cover': await MultipartFile.fromFile(cover.path, filename: 'cover.png')
    });

    try {
      final res = await Api.dio.post('/audiobook', data: formData);

      return CreateAudioBookResponse.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }

  static Future<void> createChapter(
      String title, String audioBookId, File chapter) async {
    FormData data = FormData.fromMap({
      'title': title,
      'audioBookId': audioBookId,
      'audioFile': await MultipartFile.fromFile(
        chapter.path,
        filename: chapter.uri.toString(),
      )
    });

    try {
      await Api.dio.post('/chapter', data: data);
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }

  static Future<List<AudioBook>> fetchAudioBooks() async {
    try {
      final res = await Api.dio.get('/audiobooks');

      if (res.data["audioBooks"] == null) {
        return [];
      }

      final List<AudioBook> audioBooks = res.data["audioBooks"]
          .map<AudioBook>((json) => AudioBook.fromJson(json))
          .toList();

      return audioBooks;
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }

  static Future<List<AudioBook>> fetchAudioBooksUsingUserId(
      String userId) async {
    try {
      final res = await Api.dio.get('/audiobooks/$userId');

      print("audioBooks ${res.data["audioBooks"]}");

      if (res.data["audioBooks"] == null) {
        return [];
      }

      final List<AudioBook> audioBooks = res.data["audioBooks"]
          .map<AudioBook>((json) => AudioBook.fromJson(json))
          .toList();

      return audioBooks;
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }

  static Future<AudioBook?> fetchAudioBookUsingId(String audioBookId) async {
    try {
      final res = await Api.dio.get('/audiobook/$audioBookId');

      return AudioBook.fromJson(res.data["audioBook"]);
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }
}
