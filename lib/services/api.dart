export 'api.dart';
import 'package:dio/dio.dart';
import 'package:smartfm_poc/config/config.dart';

class Api {
  static final dio = Dio(BaseOptions(
    baseUrl: Config.apiBaseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    headers: {},
    contentType: 'application/json',
  ));
}
