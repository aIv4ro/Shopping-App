import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/login/login_event.dart';
import 'package:shopping/bloc/login/login_state.dart';
import 'package:shopping/repositories/firebase/auth_repository.dart';
import 'package:shopping/repositories/firebase/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.authRepository, required this.userRepository})
      : super(const LoginState()) {
    on<Authenticate>(_onAuthenticate);
  }

  final AuthRepository authRepository;
  final UserRepository userRepository;

  Future<void> _onAuthenticate(
    Authenticate event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: () => LoginStatus.authenticating));

    try {
      await authRepository.login(event.email, event.password);
      final currentUser = await userRepository
          .findUserByEmail(AuthRepository.currentUser!.email!);
      UserRepository.currentUser = currentUser;
      emit(state.copyWith(status: () => LoginStatus.authenticated));
    } catch (err) {
      emit(state.copyWith(status: () => LoginStatus.authenticationError));
    }
  }
}
