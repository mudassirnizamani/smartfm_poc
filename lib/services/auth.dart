import 'package:dio/dio.dart';
import 'package:smartfm_poc/services/api.dart';
import 'package:smartfm_poc/types/auth.dart';

class AuthService {
  Future<GenerateOtpResponse> generateOtp(String phoneNumber) async {
    try {
      final Response res = await Api.dio.post(
        '/generate-otp',
        data: {'phoneNumber': int.parse(phoneNumber.substring(1))},
      );

      if (res.statusCode == 200) {
        return GenerateOtpResponse.fromJson(res.data);
      }

      throw Exception(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<AuthenticateResponse> authenticate(
      String phoneNumber, String otp) async {
    try {
      final res = await Api.dio.post('/authenticate', data: {
        'phoneNumber': int.parse(phoneNumber.substring(1)),
        'otp': int.parse(otp)
      });

      if (res.statusCode == 200) {
        return AuthenticateResponse.fromJson(res.data);
      }

      throw Exception(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }
}
