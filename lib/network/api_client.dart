import 'package:dio/dio.dart';

class ApiClient {
  factory ApiClient() => instance;
  ApiClient._internal();

  final Dio _dio = _createDio();
  static final instance = ApiClient._internal();

  static Dio _createDio() {
    final dio = Dio();
    return dio;
  }

  void setToken({required String token}) {}
}
