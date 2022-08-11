import 'dart:async';

import 'package:shopping/domain/entities/user_entity.dart';

abstract class IAuthRepository {
  FutureOr<bool> register({required User user});
  FutureOr<List<String>> getAllEmails();
  FutureOr<bool> login({
    required String email,
    required String password,
    bool? keepLogged,
  });
  FutureOr<void> logout();
  FutureOr<bool> tryAutoLogin({required String token});

  User? currentUser;
}
