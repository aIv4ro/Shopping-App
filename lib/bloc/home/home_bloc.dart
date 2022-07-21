import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/home/home_event.dart';
import 'package:shopping/bloc/home/home_state.dart';
import 'package:shopping/repositories/auth_repository.dart';
import 'package:shopping/repositories/user_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.authRepository,
    required this.userRepository,
  }) : super(
    const HomeState()
  ) {
    on<CloseSession>(_closeSession);
    on<LoadAuthenticatedUser>(_loadAuthenticatedUser);
  }

  final AuthRepository authRepository;
  final UserRepository userRepository;

  Future<void> _closeSession(CloseSession event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(status: () => HomeStatus.loggingOut)
    );
    await authRepository.logout();
    emit(
      state.copyWith(status: () => HomeStatus.loggedOut)
    );
  }

  Future<void> _loadAuthenticatedUser(LoadAuthenticatedUser event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(status: () => HomeStatus.loadingUserData),
    );

    final authenticatedUserEmail = authRepository.currentUser!.email!;
    final currentUser = await userRepository.findUserByEmail(authenticatedUserEmail);

    emit(
      state.copyWith(
        status: () => HomeStatus.success,
        currentUser: () => currentUser,
      )
    );
  }
}