import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadEmails extends RegisterEvent {
  const LoadEmails();
}

class CreateUser extends RegisterEvent {
  const CreateUser({
    required this.email, required this.password,
    required this.name, required this.surname,
  });

  final String email;
  final String name;
  final String surname;
  final String password;

  @override
  List<Object> get props => [email, name, surname, password];
}