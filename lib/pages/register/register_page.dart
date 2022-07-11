import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/register/register_bloc.dart';
import 'package:shopping/bloc/register/register_event.dart';
import 'package:shopping/bloc/register/register_state.dart';
import 'package:shopping/routes/paths.dart';
import 'package:shopping/utils/validations.dart';
import 'package:shopping/widgets/list_with_footer.dart';
import 'package:shopping/widgets/password_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Register error, try again'),
                ),
              );
          }

          if(state.status == RegisterStatus.userRegistered) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User registered'),),
            );

            Navigator.of(context).pushReplacementNamed(login);
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            if (state.status == RegisterStatus.loadingData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final bloc = context.read<RegisterBloc>();

            return Form(
              key: _formKey,
              child: ListWithFooter(
                padding: const EdgeInsets.all(10),
                footer: [
                  SizedBox(
                    width: double.infinity,
                    child: state.status == RegisterStatus.creatingUser ?
                    const Center(child: CircularProgressIndicator(),) :
                    ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState == null || !_formKey.currentState!.validate()){
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error, check inputs',),)
                          );

                          return;
                        }

                        bloc.add(
                          CreateUser(
                              email: emailController.text,
                              password: passwordController.text
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20,),
                        child: Text('REGISTER'),
                      ),
                    ),
                  )
                ],
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: EmailValidation(emails: state.emails).validate,
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PasswordInput(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: const PasswordValidation().validate,
                    controller: passwordController,
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.password),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PasswordInput(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator:
                    RepeatPasswordValidation(password: passwordController)
                        .validate,
                    labelText: 'Repeat Password',
                    prefixIcon: const Icon(Icons.password),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          },
        )
      ),
    );
  }
}
