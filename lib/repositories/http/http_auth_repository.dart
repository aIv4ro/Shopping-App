import 'dart:async';
import 'package:shopping/models/user_model.dart';
import 'package:shopping/repositories/repository.dart';

class HttpAuthRepository extends AuthRepository {
  @override
  FutureOr<String> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  FutureOr<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  FutureOr<User> register({required User newUser}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
