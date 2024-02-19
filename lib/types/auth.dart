import 'package:smartfm_poc/models/user.dart';

class AuthenticateResponseData {
  AuthenticateResponseData({required this.type, required this.user});

  final User user;
  final String type;

  factory AuthenticateResponseData.fromJson(Map<String, dynamic> json) =>
      AuthenticateResponseData(
          type: json["type"] as String,
          user: User.fromJson(json["user"] as Map<String, dynamic>));
}

class AuthenticateResponse {
  AuthenticateResponse({required this.success, required this.data});

  bool success;
  AuthenticateResponseData data;

  factory AuthenticateResponse.fromJson(Map<String, dynamic> json) =>
      AuthenticateResponse(
        success: json["Success"] as bool,
        data: AuthenticateResponseData.fromJson(
            json["Data"] as Map<String, dynamic>),
      );
}

class GenerateOtpResponse {
  GenerateOtpResponse({
    required this.success,
    required this.data,
  });

  bool success;
  int data;

  factory GenerateOtpResponse.fromJson(Map<String, dynamic> json) =>
      GenerateOtpResponse(
        success: json["Success"] as bool,
        data: json["Data"] as int,
      );
}
