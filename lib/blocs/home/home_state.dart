import 'package:equatable/equatable.dart';

enum HomeStatus {
  initialStatus,
  logginout,
  loggedout,
  loadingCurrentUser,
  currentUserLoaded,
  currentUserLoadError,
  creatingProduct,
  productCreated,
  productCreationError,
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
      status: status?.call() ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
