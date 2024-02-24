import 'package:dio/dio.dart';
import 'package:smartfm_poc/models/audio_book.dart';
import 'package:smartfm_poc/models/user.dart';
import 'package:smartfm_poc/services/api.dart';
import 'package:smartfm_poc/storage/user_storage.dart';

class UsersLibraryService {
  static Future<bool> addBookToUserLibrary(String audioBookId) async {
    try {
      User? user = await UserStorage.getUser();
      final res = await Api.dio.post("/users-library", data: {
        'bookId': audioBookId,
        'userId': user?.userId,
      });

      return Future(() => res.data["Success"] as bool);
    } on DioException {
      rethrow;
    }
  }

  static Future<bool> isBookSavedInUserLibrary(String audioBookId) async {
    try {
      User? user = await UserStorage.getUser();
      final res = await Api.dio.post("/users-library/saved", data: {
        'bookId': audioBookId,
        'userId': user?.userId,
      });

      return Future(() => res.data["Data"] as bool);
    } on DioException {
      rethrow;
    }
  }

  static Future<List<AudioBook>> fetchUserLibrary() async {
    try {
      User? user = await UserStorage.getUser();
      final res = await Api.dio.get("/users-library/${user?.userId ?? ""}");

      if (res.data["Data"] == null) {
        return [];
      }

      final books = res.data["Data"]
          .map<AudioBook>((json) => AudioBook.fromJson(json))
          .toList();

      return books;
    } on DioException {
      rethrow;
    }
  }
}
