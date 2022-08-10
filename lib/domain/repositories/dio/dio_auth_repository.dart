import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shopping/domain/clients/dio_client.dart';
import 'package:shopping/domain/entities/user_entity.dart';
import 'package:shopping/domain/repositories/dio/dio_repository.dart';
import 'package:shopping/domain/repositories/i_auth_repository.dart';

class DioAuthRepository extends IAuthRepository implements DioRepository {
  DioAuthRepository({required this.dioClient});

  @override
  final DioClient dioClient;
  Dio get dio => dioClient.dio;

  @override
  final String? basePath = null;

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final res = await dio.post(
      'login/',
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

  @override
  Future<bool> register({required User user}) async {
    return dio
        .post('register', data: user.toJson())
        .then((value) => true)
        .catchError((err) => false);
  }

  @override
  FutureOr<List<String>> getAllEmails() async {
    final res = await dio.get('register/getAllEmails');
    final body = res.data as List;

    return List.castFrom<dynamic, String>(body);
  }
}
