import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/domain/clients/dio_client.dart';
import 'package:shopping/domain/repositories/dio/dio_auth_repository.dart';
import 'package:shopping/domain/repositories/dio/dio_user_repository.dart';
import 'package:shopping/firebase_options.dart';
import 'package:shopping/ui/paths.dart';
import 'package:shopping/ui/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Shopping());
}

class Shopping extends StatelessWidget {
  const Shopping({super.key});

  @override
  Widget build(BuildContext context) {
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
        initialRoute: login,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Widget _buildRepositoryProvider({required Widget child}) {
    final dioClient = DioClient();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DioAuthRepository>(
          create: (_) => DioAuthRepository(dioClient: dioClient),
        ),
        RepositoryProvider<DioUserRepository>(
          create: (_) => DioUserRepository(dioClient: dioClient),
        ),
      ],
      child: child,
    );
  }
}
