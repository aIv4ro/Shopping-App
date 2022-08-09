import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/register/register_bloc.dart';
import 'package:shopping/blocs/register/register_event.dart';
import 'package:shopping/ui/pages/register/widgets/register_button.dart';
import 'package:shopping/utils/validations.dart';
import 'package:shopping/widgets/list_with_footer.dart';
import 'package:shopping/widgets/password_input.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, this.emails = const []});

  final List<String> emails;

  @override
  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  late final RegisterBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  void _showSnackbarMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _handleRegisterClick() {
    final isFormValid = _formKey.currentState?.validate();
    if (isFormValid == null || !isFormValid) {
      _showSnackbarMessage(message: 'Form not valid, check the inputs');
      return;
    }

    _bloc.add(
      RegisterUser(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        surname: _surnameController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListWithFooter(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        footer: [
          RegisterButton(onPressed: _handleRegisterClick),
        ],
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: EmailValidation(emails: widget.emails).validate,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          PasswordInput(
            controller: _passwordController,
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            validator: const PasswordValidation().validate,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 10),
          PasswordInput(
            controller: _repeatPasswordController,
            labelText: 'Repeat password',
            prefixIcon: const Icon(Icons.lock),
            validator: RepeatPasswordValidation(
              password: _passwordController,
            ).validate,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              prefixIcon: Icon(Icons.person),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _surnameController,
            decoration: const InputDecoration(
              labelText: 'Surname',
              prefixIcon: Icon(Icons.person),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
