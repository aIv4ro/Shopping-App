import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadAuthenticatedUser extends HomeEvent {
  const LoadAuthenticatedUser();
}

class CloseSession extends HomeEvent {
  const CloseSession();
}