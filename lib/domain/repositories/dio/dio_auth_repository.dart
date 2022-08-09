import 'dart:async';
import 'package:shopping/domain/clients/dio_client.dart';
import 'package:shopping/domain/repositories/dio/dio_repository.dart';
import 'package:shopping/domain/repositories/dio/dio_user_repository.dart';
import 'package:shopping/domain/repositories/i_auth_repository.dart';

class DioAuthRepository extends DioRepository implements IAuthRepository {
  DioAuthRepository({required super.dioClient});

  static const _baseUrl = 'login/';

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final res = await dio.post(
      _baseUrl,
      data: {'email': email, 'password': password},
    );

    final body = res.data as Map<String, dynamic>;
    final token = body['token'] as String?;
    if (token != null && token.isNotEmpty) {
      client.setToken(token: token);
      return true;
    } else {
      return false;
    }
  }

  @override
  void logout() {
    client.unsetToken();
  }
}
