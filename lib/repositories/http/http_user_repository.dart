import 'dart:async';
import 'package:shopping/models/user_model.dart';
import 'package:shopping/repositories/repository.dart';

class HttpUserRepository extends ModelRepository<User> {
  @override
  FutureOr<User> create({required User model}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  FutureOr<bool> delete({required String id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  FutureOr<List<User>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  FutureOr<User> findById({required String id}) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  FutureOr<User> update({required User model}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
