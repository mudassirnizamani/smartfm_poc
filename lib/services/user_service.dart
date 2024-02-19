import 'package:dio/dio.dart';
import 'package:smartfm_poc/models/user.dart';
import 'package:smartfm_poc/services/api.dart';
import 'package:smartfm_poc/storage/user_storage.dart';

class UserService {
  static Future<User> fetchUser() async {
    try {
      User? user = await UserStorage.getUser();
      final res = await Api.dio.get("/users/${user?.userId}");
      return User.fromJson(res.data["Data"] as Map<String, dynamic>);
    } on DioException {
      rethrow;
    }
  }
}
