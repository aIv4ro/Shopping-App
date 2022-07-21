import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/login/login_bloc.dart';
import 'package:shopping/bloc/login/login_event.dart';
import 'package:shopping/bloc/login/login_state.dart';
import 'package:shopping/repositories/auth_repository.dart';
import 'package:shopping/repositories/user_repository.dart';
import 'package:shopping/routes/paths.dart';
import 'package:shopping/widgets/list_with_footer.dart';
import 'package:shopping/widgets/password_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool keepLogged = false;
  late UserRepository userRepository = context.read<UserRepository>();
  late AuthRepository authRepository = context.read<AuthRepository>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onKeepLoggedChange(value) => setState(() => keepLogged = value);


  @override
  void initState() {
    super.initState();
    if(authRepository.currentUser != null) {
      Navigator.of(context).pushReplacementNamed(home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping'),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final status = state.status;

          if(status == LoginStatus.authenticated) {
            Navigator.of(context).pushReplacementNamed(home);
            return;
          }

          if(status == LoginStatus.authenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User or password invalid')),
            );

            return;
          }
        },
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
                maxWidth: 600,
                maxHeight: 800
            ),
            child: ListWithFooter(
              footer: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if(state.status == LoginStatus.authenticating){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ElevatedButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(
                            Authenticate(email: emailController.text, password: passwordController.text)
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('LOGIN'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(register);
                  },
                  child: const Text("Don't have account? Register now!"),
                ),
              ],
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                  ),
                ),
                PasswordInput(
                  controller: passwordController,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.password),
                  padding: const EdgeInsets.all(10),
                  labelText: 'Password',
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CheckboxListTile(
                    value: keepLogged,
                    onChanged: onKeepLoggedChange,
                    title: const Text('Keep logged?'),
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}