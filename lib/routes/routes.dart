import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/register/register_bloc.dart';
import 'package:shopping/bloc/register/register_event.dart';
import 'package:shopping/pages/login/login_page.dart';
import 'package:shopping/pages/register/register_page.dart';
import 'package:shopping/repositories/AuthRepository.dart';
import 'package:shopping/repositories/UsersRepository.dart';
import 'package:shopping/routes/paths.dart';

final routes = <String, WidgetBuilder>{
  login: (context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UsersRepository>(create: (_) => UsersRepository()),
        RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
      ],
      child: const LoginPage(),
    );
  },
  register: (context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UsersRepository>(create: (_) => UsersRepository()),
        RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
      ],
      child: BlocProvider(
        create: (blocProviderContext) => RegisterBloc(
          authRepository: blocProviderContext.read(),
          usersRepository: blocProviderContext.read(),
        )..add(const LoadEmails()),
        child: const RegisterPage(),
      ),
    );
  }
};