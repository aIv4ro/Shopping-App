import 'package:equatable/equatable.dart';
import 'package:shopping/models/user_model.dart';

enum HomeStatus {
  initialStatus, loadingUserData, loadUserDataError, loggingOut, loggedOut,
  success
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initialStatus,
    this.currentUser = User.empty,
  });

  final HomeStatus status;
  final User currentUser;

  HomeState copyWith({
    HomeStatus Function()? status,
    User Function()? currentUser,
  }) {
    return HomeState(
      status: status != null ? status() : this.status,
      currentUser: currentUser != null ? currentUser() : this.currentUser,
    );
  }

  @override
  List<Object?> get props => [status];
}