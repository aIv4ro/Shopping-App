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
  final basePath = 'api/user';

  @override
  Future<User> create({required User model}) async {
    final res = await dio.post(basePath, data: {'user': model.toJson()});
    final body = res.data as Map<String, dynamic>;
    return User.fromJson(json: body);
  }

  @override
  FutureOr<bool> delete({required String id}) {
    return dio
        .delete('$basePath/$id')
        .then((value) => true)
        .catchError((err) => false);
  }

  @override
  Future<List<User>> findAll() async {
    final res = await dio.get(basePath);
    final body = res.data as List;
    final usersJson = List<Map<String, dynamic>>.from(body);
    return usersJson.map((userJson) => User.fromJson(json: userJson)).toList();
  }

  @override
  Future<User> findById({required String id}) async {
    final res = await dio.get('$basePath/$id');
    final body = res.data as Map<String, dynamic>;
    return User.fromJson(json: body);
  }

  @override
  Future<User> update({required User model}) async {
    final res = await dio.patch(
      '$basePath/${model.id}',
      data: {'updatedFields': model.toJson()},
    );
    final body = res.data as Map<String, dynamic>;
    return User.fromJson(json: body);
  }
}
