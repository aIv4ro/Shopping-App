import 'package:flutter/material.dart';
import 'package:shopping/utils/validations.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key, required this.emailValidation
  }) : super(key: key);

  final EmailValidation emailValidation;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: emailValidation.validate,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
    );
  }
}