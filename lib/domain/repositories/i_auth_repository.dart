import 'dart:async';

abstract class IAuthRepository {
  FutureOr<bool> login({required String email, required String password});
  FutureOr<void> logout();
}
