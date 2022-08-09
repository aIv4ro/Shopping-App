import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/register/register_bloc.dart';
import 'package:shopping/blocs/register/register_state.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: onPressed,
            child: state.status == RegisterStatus.registeringUser
                ? const CircularProgressIndicator()
                : const Text('Register'),
          ),
        );
      },
    );
  }
}
