import 'package:dio/dio.dart';

class DioClient {
  factory DioClient() => instance;
  DioClient._internal();

  final Dio _dio = _createDio();
  Dio get dio => _dio;
  static final instance = DioClient._internal();

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(baseUrl: 'http://localhost:8000/'),
    );

    return dio;
  }

  void setToken({required String token}) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void unsetToken() {
    dio.options.headers['Authorization'] = '';
  }
}
