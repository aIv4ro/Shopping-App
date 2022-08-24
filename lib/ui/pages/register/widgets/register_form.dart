import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/register/register_bloc.dart';
import 'package:shopping/blocs/register/register_event.dart';
import 'package:shopping/ui/pages/register/widgets/register_button.dart';
import 'package:shopping/ui/widgets/list_with_footer.dart';
import 'package:shopping/ui/widgets/password_input.dart';
import 'package:shopping/utils/validations.dart';

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

  @override
  void dispose() {
    super.dispose();
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
        footer: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [RegisterButton(onPressed: _handleRegisterClick)],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: EmailValidation(emails: widget.emails).validate,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(height: 5),
          PasswordInput(
            controller: _passwordController,
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            validator: const PasswordValidation().validate,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: _surnameController,
              decoration: const InputDecoration(
                labelText: 'Surname',
                prefixIcon: Icon(Icons.person),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
