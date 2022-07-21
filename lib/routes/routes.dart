import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/login/login_bloc.dart';
import 'package:shopping/bloc/register/register_bloc.dart';
import 'package:shopping/bloc/register/register_event.dart';
import 'package:shopping/pages/home/home_page.dart';
import 'package:shopping/pages/login/login_page.dart';
import 'package:shopping/pages/register/register_page.dart';
import 'package:shopping/pages/splash/splash_page.dart';
import 'package:shopping/repositories/auth_repository.dart';
import 'package:shopping/repositories/user_repository.dart';
import 'package:shopping/routes/paths.dart';

final routes = <String, WidgetBuilder>{
  login: (context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(create: (_) => UserRepository()),
        RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
      ],
      child: BlocProvider(
        create: (blocProviderContext) => LoginBloc(
          authRepository: blocProviderContext.read(),
          userRepository: blocProviderContext.read(),
        ),
        child: const LoginPage(),
      ),
    );
  },
  register: (context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(create: (_) => UserRepository()),
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
  },
  home: (context) {
    return RepositoryProvider(
      create: (_) => AuthRepository(),
      child: const HomePage(),
    );
  },
  splash: (context) {
    return RepositoryProvider(
      create: (_) => UserRepository(),
      child: const SplashPage(),
    );
  }
};
