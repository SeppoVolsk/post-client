import 'package:chat_client/app/ui/app_loader.dart';
import 'package:chat_client/feature/auth/ui/components/auth_builder.dart';
import 'package:chat_client/feature/auth/ui/login_screen.dart';
import 'package:chat_client/feature/main/ui/main_screen.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthBuilder(
      isNotAuthorized: (context) => LoginScreen(),
      isWaiting: (context) => const AppLoader(),
      isAuthorized: (context, value, child) => MainScreen(userEntity: value),
    );
  }
}
