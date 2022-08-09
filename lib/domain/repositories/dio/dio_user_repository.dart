import 'dart:async';
import 'package:shopping/domain/entities/user_entity.dart';
import 'package:shopping/domain/repositories/dio/dio_repository.dart';
import 'package:shopping/domain/repositories/i_user_repository.dart';

class DioUserRepository extends DioRepository implements IUserRepository {
  DioUserRepository({required super.dioClient});

  static const _baseUrl = 'api/user';

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
    final res = await dio.get('$_baseUrl/$id');
    final body = res.data as Map<String, dynamic>;
    return User.fromJson(json: body);
  }

  @override
  FutureOr<User> update({required User model}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
