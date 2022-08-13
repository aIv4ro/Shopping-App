import 'package:shopping/domain/entities/entity.dart';

class User extends Entity {
  const User({
    required super.id,
    required this.email,
    required this.name,
    required this.surname,
    this.hashedPassword,
  });

  factory User.fromJson({
    required Map<String, dynamic> json,
  }) {
    final id = json['id'] as String;
    final email = json['email'] as String;
    final name = json['name'] as String;
    final surname = json['surname'] as String;
    final hashedPassword = json['hashedPassword'] as String?;

    return User(
      id: id,
      email: email,
      name: name,
      surname: surname,
      hashedPassword: hashedPassword,
    );
  }

  final String email;
  final String name;
  final String surname;
  final String? hashedPassword;

  String get fullName => '$name $surname';

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'surname': surname,
      'hashedPassword': hashedPassword,
    };
  }

  @override
  String toString() {
    return 'User: $id, $email, $fullName';
  }
}
