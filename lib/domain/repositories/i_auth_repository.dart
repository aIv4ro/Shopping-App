import 'dart:async';

import 'package:shopping/domain/entities/user_entity.dart';

abstract class IAuthRepository {
  FutureOr<bool> register({required User user});
  FutureOr<bool> login({required String email, required String password});
  FutureOr<void> logout();
}
