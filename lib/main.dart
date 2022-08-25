import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shopping/domain/clients/dio_client.dart';
import 'package:shopping/domain/clients/shared_preferences.dart';
import 'package:shopping/domain/repositories/dio/dio_auth_repository.dart';
import 'package:shopping/domain/repositories/dio/dio_order_repository.dart';
import 'package:shopping/domain/repositories/dio/dio_product_repository.dart';
import 'package:shopping/domain/repositories/dio/dio_user_repository.dart';
import 'package:shopping/ui/paths.dart';
import 'package:shopping/ui/routes.dart';
import 'package:shopping/ui/theme/theme_bloc.dart';
import 'package:shopping/ui/theme/theme_state.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling a background message: ${message.notification}');
}

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SharedPreferencesClient.init();
  final token = SharedPreferencesClient.getToken();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    Shopping(
      lastSessionToken: token,
    ),
  );
}

class Shopping extends StatelessWidget {
  const Shopping({super.key, this.lastSessionToken});

  final String? lastSessionToken;

  Future<void> requestNotificationPermission() async {
    final settings = await FirebaseMessaging.instance.requestPermission();
    log('${settings.authorizationStatus}');
  }

  @override
  Widget build(BuildContext context) {
    requestNotificationPermission();
    FlutterNativeSplash.remove();
    final isValid = lastSessionToken != null;

    return _buildRepositoryProvider(
      child: BlocProvider(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Shopping',
              theme: state.theme.data,
              routes: routes,
              initialRoute: isValid ? home : login,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
      token: isValid ? lastSessionToken : null,
    );
  }

  Widget _buildRepositoryProvider({required Widget child, String? token}) {
    final dioClient = DioClient();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DioAuthRepository>(
          create: (_) => DioAuthRepository(
            dioClient: dioClient,
            lastSessionToken: token,
          ),
        ),
        RepositoryProvider<DioUserRepository>(
          create: (_) => DioUserRepository(dioClient: dioClient),
        ),
        RepositoryProvider<DioProductRepository>(
          create: (_) => DioProductRepository(dioClient: dioClient),
        ),
        RepositoryProvider<DioOrderRepository>(
          create: (_) => DioOrderRepository(dioClient: dioClient),
        ),
      ],
      child: child,
    );
  }
}
