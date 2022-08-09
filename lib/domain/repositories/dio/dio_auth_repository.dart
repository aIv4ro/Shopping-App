import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shopping/domain/clients/dio_client.dart';
import 'package:shopping/domain/repositories/dio/dio_repository.dart';
import 'package:shopping/domain/repositories/i_auth_repository.dart';

class DioAuthRepository extends IAuthRepository implements DioRepository {
  DioAuthRepository({required this.dioClient});

  @override
  final DioClient dioClient;
  Dio get dio => dioClient.dio;

  @override
  final basePath = 'login/';

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final res = await dio.post(
      basePath,
      data: {'email': email, 'password': password},
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
}
