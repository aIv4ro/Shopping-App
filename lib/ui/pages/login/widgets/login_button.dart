import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/login/login_bloc.dart';
import 'package:shopping/blocs/login/login_state.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: onPressed,
            child: state.status == LoginStatus.authenticating
                ? const CircularProgressIndicator()
                : const Text('Login'),
          ),
        );
      },
    );
  }
}
