import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smartfm_poc/models/user.dart';
import 'package:smartfm_poc/services/api.dart';
import 'package:smartfm_poc/models/audio_book.dart';
import 'package:smartfm_poc/storage/user_storage.dart';

class BooksService {
  static Future<void> createBook(String title, String description, String genre,
      File cover, String language, String author) async {
    User? user = await UserStorage.getUser();

    FormData formData = FormData.fromMap({
      'name': title,
      'description': description,
      'genre': genre,
      'language': language,
      'userId': user?.userId ?? "",
      "author": author,
      'cover': await MultipartFile.fromFile(cover.path, filename: 'cover.png')
    });

    try {
      final res = await Api.dio.post('/books/', data: formData);

      if (res.data["Success"] as bool != true) {
        throw Exception("Error occurred");
      }
    } on DioException {
      rethrow;
    }
  }

  static Future<List<AudioBook>> fetchAudioBooks() async {
    try {
      final res = await Api.dio.get('/books/');

      print(AudioBook.fromJson(res.data["Data"][0]));

      if (res.data["Data"] == null) {
        return [];
      }

      final List<AudioBook> audioBooks = res.data["Data"]
          .map<AudioBook>((json) => AudioBook.fromJson(json))
          .toList();

      return audioBooks;
    } on DioException {
      rethrow;
    } catch (e) {
      print(e);
      throw Exception("error");
    }
  }

  static Future<List<AudioBook>> fetchAudioBooksUsingUserId(
      String userId) async {
    try {
      final res = await Api.dio.get('/books/user/$userId');

      if (res.data["Data"] == null) {
        return [];
      }

      final List<AudioBook> audioBooks = res.data["Data"]
          .map<AudioBook>((json) => AudioBook.fromJson(json))
          .toList();

      return audioBooks;
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }

  static Future<AudioBook?> fetchAudioBookUsingId(String audioBookId) async {
    try {
      final res = await Api.dio.get('/books/$audioBookId');

      return AudioBook.fromJson(res.data["Data"]);
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }
}
