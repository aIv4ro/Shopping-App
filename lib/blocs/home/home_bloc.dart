import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/home/home_event.dart';
import 'package:shopping/blocs/home/home_state.dart';
import 'package:shopping/domain/repositories/i_auth_repository.dart';
import 'package:shopping/domain/repositories/i_user_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.authRepository,
    required this.userRepository,
  }) : super(const HomeState()) {
    on<LogoutEvent>(_logout);
  }

  final IAuthRepository authRepository;
  final IUserRepository userRepository;

  Future<void> _logout(
    LogoutEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: () => HomeStatus.logginout));
    authRepository.logout();
    emit(state.copyWith(status: () => HomeStatus.loggedout));
  }
}
