import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shopping/domain/clients/dio_client.dart';
import 'package:shopping/domain/entities/user_entity.dart';
import 'package:shopping/domain/repositories/dio/dio_repository.dart';
import 'package:shopping/domain/repositories/i_auth_repository.dart';

class DioAuthRepository extends IAuthRepository implements DioRepository {
  DioAuthRepository({required this.dioClient, String? lastSessionToken}) {
    if (lastSessionToken != null) {
      dioClient.setToken(token: lastSessionToken);
    }
  }

  @override
  final DioClient dioClient;
  Dio get dio => dioClient.dio;

  @override
  final String basePath = '/api/auth';

  @override
  Future<bool> login({
    required String email,
    required String password,
    String? device,
    bool? keepLogged,
  }) async {
    final res = await dio.post(
      '$basePath/login/',
      data: {'email': email, 'password': password, 'device': device},
    );

    final body = res.data as Map<String, dynamic>;
    final token = body['token'] as String?;
    if (token != null && token.isNotEmpty) {
      dioClient.setToken(token: token);
      return true;
    } else {
      return false;
    }
  }

  @override
  void logout() {
    dioClient.unsetToken();
  }

  @override
  Future<bool> register({required User user}) async {
    return dio
        .post('$basePath/register', data: user.toJson())
        .then((value) => true)
        .catchError((err) => false);
  }

  @override
  FutureOr<List<String>> getAllEmails() async {
    final res = await dio.get('$basePath/getAllEmails');
    final body = res.data as List;

    return List<String>.from(body);
  }

  @override
  FutureOr<bool> tryAutoLogin({required String token}) async {
    dioClient.setToken(token: token);
    try {
      final res = await dio.get('api/user/getUserFromToken');
      final user = User.fromJson(json: res.data as Map<String, dynamic>);
      currentUser = user;
    } catch (err) {
      return false;
    }

    return true;
  }

  @override
  FutureOr<User> getUserFromToken() async {
    final res = await dio.get('api/user/getUserFromToken');
    final user = User.fromJson(json: res.data as Map<String, dynamic>);
    return user;
  }
}
