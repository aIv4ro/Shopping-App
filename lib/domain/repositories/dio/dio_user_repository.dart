import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shopping/domain/clients/dio_client.dart';
import 'package:shopping/domain/entities/user_entity.dart';
import 'package:shopping/domain/repositories/dio/dio_repository.dart';
import 'package:shopping/domain/repositories/i_user_repository.dart';

class DioUserRepository extends IUserRepository implements DioRepository {
  DioUserRepository({required this.dioClient});

  @override
  final DioClient dioClient;
  Dio get dio => dioClient.dio;

  @override
  final basePath = 'login/';

  @override
  Future<User> create({required User model}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  FutureOr<bool> delete({required String id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<User>> findAll() async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<User> findById({required String id}) async {
    final res = await dio.get('$basePath/$id');
    final body = res.data as Map<String, dynamic>;
    return User.fromJson(json: body);
  }

  @override
  FutureOr<User> update({required User model}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
