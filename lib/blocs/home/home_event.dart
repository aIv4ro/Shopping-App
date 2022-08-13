import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LogoutEvent extends HomeEvent {
  const LogoutEvent();
}

class LoadCurrentUserEvent extends HomeEvent {
  const LoadCurrentUserEvent();
}

class CreateProductEvent extends HomeEvent {
  const CreateProductEvent({required this.name, this.description});

  final String name;
  final String? description;

  @override
  List<Object?> get props => [name, description];
}
