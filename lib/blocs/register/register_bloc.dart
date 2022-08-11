import 'dart:async';
import 'package:bcrypt/bcrypt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/register/register_event.dart';
import 'package:shopping/blocs/register/register_state.dart';
import 'package:shopping/domain/entities/user_entity.dart';
import 'package:shopping/domain/repositories/i_auth_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required this.authRepository,
  }) : super(const RegisterState()) {
    on<LoadEmails>(_onLoadEmails);
    on<RegisterUser>(_onRegisterUser);
  }

  final IAuthRepository authRepository;

  Future<void> _onLoadEmails(
    LoadEmails event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: () => RegisterStatus.loadingData));
    final emails = await authRepository.getAllEmails();
    emit(
      state.copyWith(
        status: () => RegisterStatus.dataLoadSucces,
        emails: () => emails,
      ),
    );
  }

  Future<void> _onRegisterUser(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: () => RegisterStatus.registeringUser));
    final hashedPassword = BCrypt.hashpw(event.password, BCrypt.gensalt());

    final user = User(
      id: '',
      email: event.email,
      name: event.name,
      surname: event.surname,
      hashedPassword: hashedPassword,
    );

    final registerResult = await authRepository.register(user: user);
    emit(
      state.copyWith(
        status: () => registerResult
            ? RegisterStatus.registerSuccess
            : RegisterStatus.registerError,
      ),
    );
  }
}
