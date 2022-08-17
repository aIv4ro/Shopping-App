import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/home/home_bloc.dart';
import 'package:shopping/blocs/login/login_bloc.dart';
import 'package:shopping/blocs/order/order_bloc.dart';
import 'package:shopping/blocs/order/order_event.dart';
import 'package:shopping/blocs/pending_orders/pending_orders_bloc.dart';
import 'package:shopping/blocs/pending_orders/pending_orders_event.dart';
import 'package:shopping/blocs/products_bloc/products_bloc.dart';
import 'package:shopping/blocs/register/register_bloc.dart';
import 'package:shopping/blocs/register/register_event.dart';
import 'package:shopping/domain/repositories/dio/dio_auth_repository.dart';
import 'package:shopping/domain/repositories/dio/dio_order_repository.dart';
import 'package:shopping/domain/repositories/dio/dio_product_repository.dart';
import 'package:shopping/domain/repositories/dio/dio_user_repository.dart';
import 'package:shopping/ui/pages/create-order/create_order_page.dart';
import 'package:shopping/ui/pages/home/home_page.dart';
import 'package:shopping/ui/pages/login/login_page.dart';
import 'package:shopping/ui/pages/order/order_page.dart';
import 'package:shopping/ui/pages/pending_orders/pending_orders_page.dart';
import 'package:shopping/ui/pages/products/products_page.dart';
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
  products: (context) {
    return BlocProvider(
      create: (_) => ProductsBloc(
        productRepository: context.read<DioProductRepository>(),
      ),
      child: const ProductsPage(),
    );
  },
  pendingOrders: (context) {
    return BlocProvider(
      create: (_) => PendingOrdersBloc(
        orderRepository: context.read<DioOrderRepository>(),
        userRepository: context.read<DioUserRepository>(),
        productRepository: context.read<DioProductRepository>(),
      )..add(const LoadPendingOrdersEvent()),
      child: const PendingOrdersPage(),
    );
  },
  order: (context) {
    final id = ModalRoute.of(context)?.settings.arguments as String?;

    if (id == null) {
      throw UnimplementedError();
    }

    return BlocProvider(
      create: (_) => OrderBloc(
        orderRepository: context.read<DioOrderRepository>(),
        userRepository: context.read<DioUserRepository>(),
        productRepository: context.read<DioProductRepository>(),
      )..add(LoadOrderEvent(id: id)),
      child: const OrderPage(),
    );
  },
  createOrder: (context) {
    return const CreateOrderPage();
  }
};
