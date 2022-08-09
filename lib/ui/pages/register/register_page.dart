import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  late final RegisterBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
