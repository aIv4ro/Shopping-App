import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/repositories/auth_repository.dart';
import 'package:shopping/repositories/users_repository.dart';
import 'package:shopping/routes/paths.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthRepository authRepository;

  @override
  void initState() {
    super.initState();
    authRepository = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              authRepository.logout().then((value) {
                Navigator.of(context).pushReplacementNamed(login);
              });
            },
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: Column(
        children: [
          Text(UsersRepository.currentUser.fullName)
        ],
      ),
    );
  }
}