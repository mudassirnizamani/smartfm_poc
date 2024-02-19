import 'package:dio/dio.dart';
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

      print(res.data);

      return Future(() => res.data["Data"] as bool);
    } on DioException {
      rethrow;
    }
  }
}
