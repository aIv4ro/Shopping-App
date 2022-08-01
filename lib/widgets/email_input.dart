import 'package:flutter/material.dart';
import 'package:shopping/utils/validations.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    super.key,
    required this.emailValidation,
  });

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
