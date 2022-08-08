import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/register/register_event.dart';
import 'package:shopping/bloc/register/register_state.dart';
import 'package:shopping/models/user_model.dart';
import 'package:shopping/repositories/auth_repository.dart';
import 'package:shopping/repositories/user_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required this.usersRepository,
    required this.authRepository,
  }) : super(
          const RegisterState(),
        ) {
    on<LoadEmails>(_onLoadEmails);
    on<CreateUser>(_onCreateUser);
  }

  final UserRepository usersRepository;
  final AuthRepository authRepository;

  Future<void> _onLoadEmails(
    LoadEmails event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: () => RegisterStatus.loadingData));
    final emails = await usersRepository.loadAllEmails();

    emit(
      state.copyWith(
        status: () => RegisterStatus.success,
        emails: () => emails,
      ),
    );
  }

  Future<void> _onCreateUser(
    CreateUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: () => RegisterStatus.creatingUser));
    try {
      await authRepository.registerUser(event.email, event.password);
      final newUser = User(
        id: '',
        email: event.email,
        name: event.name,
        surname: event.surname,
      );

      await usersRepository.create(model: newUser);
      emit(state.copyWith(status: () => RegisterStatus.userRegistered));
    } catch (err) {
      emit(state.copyWith(status: () => RegisterStatus.registerError));
    }
  }
}
