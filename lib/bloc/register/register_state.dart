import 'package:equatable/equatable.dart';

enum RegisterStatus {
  initialState,
  loadingData,
  success,
  creatingUser,
  userRegistered,
  registerError
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
      status: status != null ? status() : this.status,
      emails: emails != null ? emails() : this.emails,
    );
  }

  @override
  List<Object?> get props => [status, emails];
}
