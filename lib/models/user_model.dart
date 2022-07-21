import 'package:shopping/utils/string_extensions.dart';

class User {
  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.surname
  });

  factory User.fromJson(Map<String, dynamic> json){
    final id = json['id'];
    final email = json['email'];
    final name = json['name'];
    final surname = json['surname'];

    return User(
      id: id,
      email: email,
      name: name,
      surname: surname,
    );
  }

  static const empty = User(id: '', email: '', name: '', surname: '');

  final String id;
  final String email;
  final String name;
  final String surname;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'surname': surname,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, name: $name, surname: $surname}';
  }

  String get fullName => '${name.capitalize} ${surname.capitalize}';
}