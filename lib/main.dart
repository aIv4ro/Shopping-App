import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shopping/domain/clients/dio_client.dart';
import 'package:shopping/domain/clients/shared_preferences.dart';
import 'package:shopping/domain/repositories/dio/dio_auth_repository.dart';
import 'package:shopping/domain/repositories/dio/dio_user_repository.dart';
import 'package:shopping/ui/paths.dart';
import 'package:shopping/ui/routes.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const Shopping());
}

class Shopping extends StatelessWidget {
  const Shopping({super.key});

  Future<Map<String, dynamic>> getToken() async {
    await SharedPreferencesClient.init();

    final token = SharedPreferencesClient.getToken();

    return {
      'token': token,
      'isValid': token != null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getToken(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        final data = snapshot.data! as Map<String, dynamic>;
        final token = data['token'] as String?;
        final isValid = data['isValid'] as bool;

        FlutterNativeSplash.remove();

        return _buildRepositoryProvider(
          child: MaterialApp(
            title: 'Shopping',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(),
              ),
            ),
            routes: routes,
            initialRoute: isValid ? home : login,
            debugShowCheckedModeBanner: false,
          ),
          token: isValid ? token : null,
        );
      },
    );
  }

  Widget _buildRepositoryProvider({required Widget child, String? token}) {
    final dioClient = DioClient();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DioAuthRepository>(
          create: (_) =>
              DioAuthRepository(dioClient: dioClient, lastSessionToken: token),
        ),
        RepositoryProvider<DioUserRepository>(
          create: (_) => DioUserRepository(dioClient: dioClient),
        ),
      ],
      child: child,
    );
  }
}
