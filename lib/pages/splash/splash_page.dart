import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/repositories/auth_repository.dart';
import 'package:shopping/repositories/user_repository.dart';
import 'package:shopping/routes/paths.dart';
import 'package:shopping/widgets/splash_screen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      navigateAfterFuture: () async {
        final authenticatedUser = AuthRepository.currentUser;

        try {
          final userRepository = context.read<UserRepository>();
          final currentUser =
              await userRepository.findUserByEmail(authenticatedUser!.email!);
          UserRepository.currentUser = currentUser;
          return home;
        } catch (err) {
          return login;
        }
      },
      logo: Image.network(
          'https://static-cdn.jtvnw.net/ttv-static-metadata/twitch_logo3.jpg'),
    );
  }
}
