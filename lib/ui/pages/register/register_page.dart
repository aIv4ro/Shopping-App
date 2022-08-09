import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/register/register_bloc.dart';
import 'package:shopping/blocs/register/register_state.dart';
import 'package:shopping/ui/pages/register/widgets/register_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void _showSnackbarMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.registerError) {
            _showSnackbarMessage(message: 'An error ocurred on register');
            return;
          }

          if (state.status == RegisterStatus.registerSuccess) {
            _showSnackbarMessage(message: 'User registered');
            Navigator.of(context).pop();
            return;
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          buildWhen: (previous, current) {
            return current.status == RegisterStatus.loadingData ||
                current.status == RegisterStatus.dataLoadSucces;
          },
          builder: (context, state) {
            return state.status == RegisterStatus.loadingData
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RegisterForm(
                    emails: state.emails,
                  );
          },
        ),
      ),
    );
  }
}
