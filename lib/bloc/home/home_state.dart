import 'package:equatable/equatable.dart';

enum HomeStatus {
  initialStatus,
  loadingUserData,
  loadUserDataError,
  loggingOut,
  loggedOut,
  success
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initialStatus,
  });

  final HomeStatus status;

  HomeState copyWith({
    HomeStatus Function()? status,
  }) {
    return HomeState(
      status: status != null ? status() : this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
