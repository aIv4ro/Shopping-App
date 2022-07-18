
import 'package:equatable/equatable.dart';

enum LoginStatus {
  notAuthenticated, authenticating, authenticationError, authenticated,
}

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.notAuthenticated,
  });

  final LoginStatus status;

  LoginState copyWith({
    LoginStatus Function()? status,
  }) {
    return LoginState(
      status: status != null ? status() : this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}