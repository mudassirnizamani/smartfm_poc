import 'package:dio/dio.dart';
import 'package:smartfm_poc/models/user.dart';
import 'package:smartfm_poc/services/api.dart';
import 'package:smartfm_poc/storage/user_storage.dart';

class UserService {
  static Future<User> fetchUser() async {
    try {
      User? user = await UserStorage.getUser();
      final res = await Api.dio.get("/users/${user?.userId}");
      return User.fromJson(res.data["user"]);
    } on DioException {
      rethrow;
    }
  }

  static Future<bool> addBookToUserLibrary(String audioBookId) async {
    try {
      User? user = await UserStorage.getUser();
      final res = await Api.dio.post("/user-library", data: {
        'audioBookId': audioBookId,
        'userId': user?.userId,
      });

      if (res.statusCode == 201) {
        return Future(() => true);
      }

      return Future(() => false);
    } on DioException {
      rethrow;
    }
  }

  static Future<bool> isBookSavedInUserLibrary(String audioBookId) async {
    try {
      User? user = await UserStorage.getUser();
      final res = await Api.dio.post("/user-library/saved", data: {
        'audioBookId': audioBookId,
        'userId': user?.userId,
      });

      if (res.statusCode == 200) {
        return Future(() => true);
      }

      return Future(() => false);
    } on DioException {
      rethrow;
    }
  }
}
