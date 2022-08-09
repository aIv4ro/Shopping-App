import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/login/login_event.dart';
import 'package:shopping/blocs/login/login_state.dart';
import 'package:shopping/domain/repositories/i_auth_repository.dart';
import 'package:shopping/domain/repositories/i_user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.authRepository,
    required this.userRepository,
  }) : super(const LoginState()) {
    on<Authenticate>(_onAuthenticate);
  }

  final IAuthRepository authRepository;
  final IUserRepository userRepository;

  Future<void> _onAuthenticate(
    Authenticate event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: () => LoginStatus.authenticating));

    final loginSuccess = await authRepository.login(
      email: event.email,
      password: event.password,
    );

    emit(
      state.copyWith(
        status: () => loginSuccess
            ? LoginStatus.authenticated
            : LoginStatus.authenticationError,
      ),
    );
  }
}
