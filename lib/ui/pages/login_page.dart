import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/login/login_bloc.dart';
import 'package:shopping/blocs/login/login_state.dart';
import 'package:shopping/utils/validations.dart';
import 'package:shopping/widgets/password_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _fromKey = GlobalKey<FormState>();
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
    final isFormValid = _fromKey.currentState?.validate();
    if (isFormValid == null || !isFormValid) {
      _showSnackbarMessage(message: 'Form not valid, check the inputs');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {},
        child: Form(
          key: _fromKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: const EmailValidation().validate,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 10),
                const PasswordInput(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                Expanded(child: Container()),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleLoginClick,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text('Login'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
