import 'package:dio/dio.dart';
import 'package:shopping/domain/clients/shared_preferences.dart';

class DioClient {
  factory DioClient() => instance;
  DioClient._internal();

  final Dio _dio = _createDio();
  Dio get dio => _dio;
  static final instance = DioClient._internal();

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(baseUrl: 'http://10.0.2.2:8000/'),
    );

    return dio;
  }

  void setToken({required String token}) {
    dio.options.headers['Authorization'] = 'Bearer $token';
    SharedPreferencesClient.setToken(token);
  }

  void unsetToken() {
    dio.options.headers['Authorization'] = '';
    SharedPreferencesClient.unsetToken();
  }
}
