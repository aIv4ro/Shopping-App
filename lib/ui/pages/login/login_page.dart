import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/login/login_bloc.dart';
import 'package:shopping/blocs/login/login_event.dart';
import 'package:shopping/blocs/login/login_state.dart';
import 'package:shopping/ui/pages/login/widgets/login_button.dart';
import 'package:shopping/ui/paths.dart';
import 'package:shopping/ui/widgets/password_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final LoginBloc _bloc;

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

  void _handleLoginClick() {
    final isFormValid = _formKey.currentState?.validate();
    if (isFormValid == null || !isFormValid) {
      _showSnackbarMessage(message: 'Form not valid, check the inputs');
      return;
    }

    _bloc.add(
      Authenticate(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _handleRegisterNowClick() => Navigator.of(context).pushNamed(register);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.authenticationError) {
            _showSnackbarMessage(message: 'Invalid user credentials');
          }

          if (state.status == LoginStatus.authenticated) {
            Navigator.of(context).pushReplacementNamed(home);
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                PasswordInput(
                  controller: _passwordController,
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                ),
                Expanded(child: Container()),
                LoginButton(onPressed: _handleLoginClick),
                TextButton(
                  onPressed: _handleRegisterNowClick,
                  child: const Text("Dont't have account? register now"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
