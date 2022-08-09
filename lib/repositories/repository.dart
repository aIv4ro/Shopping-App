import 'dart:async';
import 'package:shopping/models/entity.dart';
import 'package:shopping/models/user_model.dart';

abstract class ModelRepository<T extends Entity> {
  FutureOr<T> findById({required String id});
  FutureOr<List<T>> findAll();
  FutureOr<T> create({required T model});
  FutureOr<T> update({required T model});
  FutureOr<bool> delete({required String id});
}

abstract class AuthRepository {
  FutureOr<String> login();
  FutureOr<bool> logout();
  FutureOr<User> register({required User newUser});
}
