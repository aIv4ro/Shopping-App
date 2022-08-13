import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_event.dart';
import 'package:shopping/blocs/home/home_bloc.dart';
import 'package:shopping/blocs/login/login_bloc.dart';
import 'package:shopping/blocs/register/register_bloc.dart';
import 'package:shopping/blocs/register/register_event.dart';
import 'package:shopping/domain/repositories/dio/dio_auth_repository.dart';
import 'package:shopping/domain/repositories/dio/dio_product_repository.dart';
import 'package:shopping/domain/repositories/dio/dio_user_repository.dart';
import 'package:shopping/pages/create_order/create_order_page.dart';
import 'package:shopping/pages/splash/splash_page.dart';
import 'package:shopping/repositories/firebase/order_repository.dart';
import 'package:shopping/repositories/firebase/product_repository.dart';
import 'package:shopping/repositories/firebase/user_repository.dart';
import 'package:shopping/ui/pages/home/home_page.dart';
import 'package:shopping/ui/pages/login/login_page.dart';
import 'package:shopping/ui/pages/register/register_page.dart';
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
    return BlocProvider(
      create: (_) => RegisterBloc(
        authRepository: context.read<DioAuthRepository>(),
      )..add(const LoadEmails()),
      child: const RegisterPage(),
    );
  },
  home: (context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        authRepository: context.read<DioAuthRepository>(),
        userRepository: context.read<DioUserRepository>(),
        productRepository: context.read<DioProductRepository>(),
      ),
      child: const HomePage(),
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
