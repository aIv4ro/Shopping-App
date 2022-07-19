import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/login/login_event.dart';
import 'package:shopping/bloc/login/login_state.dart';
import 'package:shopping/repositories/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.authRepository,
  }) : super(
    const LoginState()
  ) {
    on<Authenticate>(_onAuthenticate);
  }

  final AuthRepository authRepository;

  Future<void> _onAuthenticate(
    Authenticate event, Emitter<LoginState> emit
  ) async {
    emit(
      state.copyWith(status: () => LoginStatus.authenticating)
    );

    try{
      await authRepository.login(event.email, event.password);
      emit(
          state.copyWith(status: () => LoginStatus.authenticated)
      );
    }catch(err){
      emit(
        state.copyWith(status: () => LoginStatus.authenticationError)
      );
    }
  }
}