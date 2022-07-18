import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/repositories/auth_repository.dart';
import 'package:shopping/repositories/users_repository.dart';
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
  late UsersRepository usersRepository = context.read<UsersRepository>();
  late AuthRepository authRepository = context.read<AuthRepository>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onKeepLoggedChange(value) => setState(() => keepLogged = value);


  @override
  void initState() {
    super.initState();
    if(authRepository.currentUser != null) {
      usersRepository.findUserByEmail(authRepository.currentUser!.email!).then((value) {
        UsersRepository.currentUser = value;
        Navigator.of(context).pushReplacementNamed(home);
      });
    }
  }

  void login() {
    authRepository.login(
      emailController.text, passwordController.text
    ).then((value) {
      usersRepository.findUserByEmail(authRepository.currentUser!.email!).then((value) {
        UsersRepository.currentUser = value;
        Navigator.of(context).pushReplacementNamed(home);
      });
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials'))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping'),
      ),
      body: Center(
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
                child: ElevatedButton(
                    onPressed: login,
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('LOGIN'),
                      ),
                    )
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
      ),
    );
  }
}