import 'package:shopping/utils/string_extensions.dart';

class User {
  User({
    required this.id, required this.email,
    required this.name, required this.surname
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

  final String id;
  String email;
  String name;
  String surname;

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