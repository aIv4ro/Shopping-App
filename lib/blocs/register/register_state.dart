import 'package:equatable/equatable.dart';

enum RegisterStatus {
  initialState,
  loadingData,
  dataLoadSucces,
  dataLoadError,
  registeringUser,
  registerSuccess,
  registerError,
}

class RegisterState extends Equatable {
  const RegisterState({
    this.status = RegisterStatus.initialState,
    this.emails = const [],
  });

  final RegisterStatus status;
  final List<String> emails;

  RegisterState copyWith({
    RegisterStatus Function()? status,
    List<String> Function()? emails,
  }) {
    return RegisterState(
      status: status?.call() ?? this.status,
      emails: emails?.call() ?? this.emails,
    );
  }

  @override
  List<Object?> get props => [status, emails];
}
