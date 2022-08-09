import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/register/register_event.dart';
import 'package:shopping/blocs/register/register_state.dart';
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
    emit(state.copyWith(status: () => RegisterStatus.dataLoadSucces));
  }

  Future<void> _onRegisterUser(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {}
}
