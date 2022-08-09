import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_event.dart';
import 'package:shopping/blocs/register/register_bloc.dart';
import 'package:shopping/blocs/register/register_event.dart';
import 'package:shopping/blocs/home/home_bloc.dart';
import 'package:shopping/blocs/login/login_bloc.dart';
import 'package:shopping/domain/repositories/dio/dio_auth_repository.dart';
import 'package:shopping/domain/repositories/dio/dio_user_repository.dart';
import 'package:shopping/pages/create_order/create_order_page.dart';
import 'package:shopping/pages/home/home_page.dart';
import 'package:shopping/pages/register/register_page.dart';
import 'package:shopping/pages/splash/splash_page.dart';
import 'package:shopping/repositories/firebase/auth_repository.dart';
import 'package:shopping/repositories/firebase/order_repository.dart';
import 'package:shopping/repositories/firebase/product_repository.dart';
import 'package:shopping/repositories/firebase/user_repository.dart';
import 'package:shopping/ui/pages/login_page.dart';
import 'package:shopping/ui/paths.dart';

final routes = <String, WidgetBuilder>{
  login: (context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        authRepository: context.read<DioAuthRepository>(),
        userRepository: context.read<DioUserRepository>(),
      ),
      child: const LoginPage(),
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(create: (_) => UserRepository()),
        RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
      ],
      child: BlocProvider(
        create: (blocProviderContext) => HomeBloc(
          authRepository: blocProviderContext.read(),
          userRepository: blocProviderContext.read(),
        ),
        child: const HomePage(),
      ),
    );
  },
  splash: (context) {
    return RepositoryProvider(
      create: (_) => UserRepository(),
      child: const SplashPage(),
    );
  },
  createOrder: (context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => ProductRepository()),
        RepositoryProvider(create: (_) => OrderRepository()),
        RepositoryProvider(create: (_) => UserRepository()),
      ],
      child: BlocProvider(
        create: (blocProviderContext) => CreateOrderBloc(
          userRepository: blocProviderContext.read(),
          productRepository: blocProviderContext.read(),
          orderRepository: blocProviderContext.read(),
        )..add(
            const InitialLoadEvent(),
          ),
        child: const CreateOrderPage(),
      ),
    );
  }
};
