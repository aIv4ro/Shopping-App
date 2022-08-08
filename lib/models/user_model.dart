import 'package:shopping/models/entity.dart';
import 'package:shopping/utils/string_extensions.dart';

class User extends Entity {
  const User({
    required super.id,
    required this.email,
    required this.name,
    required this.surname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final email = json['email'];
    final name = json['name'];
    final surname = json['surname'];

    return User(
      id: id as String,
      email: email as String,
      name: name as String,
      surname: surname as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'surname': surname,
    };
  }

  static const empty = User(id: '', email: '', name: '', surname: '');

  final String email;
  final String name;
  final String surname;

  @override
  String toString() {
    return 'User{id: $id, email: $email, name: $name, surname: $surname}';
  }

  String get fullName => '${name.capitalize} ${surname.capitalize}';
}
