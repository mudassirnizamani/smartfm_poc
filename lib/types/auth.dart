import 'package:smartfm_poc/models/user.dart';

class AuthenticateResponse {
  AuthenticateResponse({
    this.user,
    this.type,
  });

  User? user;
  String? type;

  factory AuthenticateResponse.fromJson(Map<String, dynamic> json) =>
      AuthenticateResponse(
        user: User.fromJson(json["user"]),
        type: json["type"],
      );
}

class GenerateOtpResponse {
  GenerateOtpResponse({
    required this.otp,
  });

  int otp;

  factory GenerateOtpResponse.fromJson(Map<String, dynamic> json) =>
      GenerateOtpResponse(
        otp: json["otp"] as int,
      );
}
