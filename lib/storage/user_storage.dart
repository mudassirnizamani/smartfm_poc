import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfm_poc/models/user.dart';

class UserStorage {
  static Future<void> saveUser(User? user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', user?.userId ?? '');
    prefs.setString('user_name', user?.name ?? '');
    prefs.setString('user_number', user?.phoneNumber.toString() ?? '');
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    final userName = prefs.getString('user_name');
    final userNumber = prefs.getString('user_number');

    if (userId == null || userName == null || userNumber == null) {
      return null;
    }

    return User(
        userId: userId, name: userName, phoneNumber: int.parse(userNumber));
  }
}
