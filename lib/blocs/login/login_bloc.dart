import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/login/login_event.dart';
import 'package:shopping/blocs/login/login_state.dart';
import 'package:shopping/domain/notifications/firebase_notification.dart';
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
    emit(
      state.copyWith(
        status: () => LoginStatus.authenticating,
      ),
    );

    try {
      final device = await FirebaseMessaging.instance.getToken();
      log('$device');
      await authRepository.login(
        email: event.email,
        password: event.password,
        device: device,
      );

      emit(
        state.copyWith(status: () => LoginStatus.authenticated),
      );
    } catch (err) {
      emit(
        state.copyWith(status: () => LoginStatus.authenticationError),
      );
    }
  }
}
