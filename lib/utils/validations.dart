import 'package:shopping/utils/int_extensions.dart';
import 'package:flutter/material.dart';

abstract class Validation {
  const Validation();
  String? validate(String? value);
}

class PasswordValidation extends Validation {
  const PasswordValidation();

  @override
  String? validate(value) {
    if(value == null || value.isEmpty){
      return 'Field can\'t be empty';
    }

    if(value.length < 5){
      return 'Min length is 5!';
    }

    if(!value.codeUnits.any((element) => element.isDigit)){
      return 'Password must contain 1 digit';
    }

    if(!value.codeUnits.any((element) => element.isLetter)){
      return 'Password must contain 1 letter';
    }

    return null;
  }
}

class RepeatPasswordValidation extends Validation {
  RepeatPasswordValidation({required this.password});
  final TextEditingController password;

  @override
  String? validate(value) {
    if(value != password.text){
      return 'Passwords must be equal';
    }

    return null;
  }
}

class UsernameValidation extends Validation {
  const UsernameValidation({ this.usernames = const [] });

  final List<String> usernames;

  @override
  String? validate(value) {
    if(value == null || value.isEmpty){
      return 'Field can\'t be empty';
    }

    if(value.length < 5){
      return 'Min length is 5!';
    }

    if(usernames.contains(value)){
      return 'Username already in use';
    }

    return null;
  }
}

class EmailValidation extends Validation {
  const EmailValidation({ this.emails = const [] });
  final List<String> emails;
  static final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  String? validate(value) {
    if(value == null || value.isEmpty){
      return 'Field can\'t be empty';
    }

    if(!emailRegex.hasMatch(value)){
      return 'Email format error: example@example.com';
    }

    if(emails.contains(value)){
      return 'Email already in use';
    }

    return null;
  }

}