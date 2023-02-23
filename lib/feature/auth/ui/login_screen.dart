import 'package:chat_client/app/ui/components/app_text_button.dart';
import 'package:chat_client/app/ui/components/app_text_field.dart';
import 'package:chat_client/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:chat_client/feature/auth/ui/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final controllerLogin = TextEditingController();
  final controllerPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("LoginScreen")),
        body: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    controller: controllerLogin,
                    labelText: "Login",
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: controllerPassword,
                    labelText: "Password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  AppTextButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        _onTapToSignIn(context.read<AuthCubit>());
                      }
                    },
                    text: "LOGIN",
                  ),
                  AppTextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                    },
                    text: "Registration",
                    backgroundColor: Colors.blueGrey,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _onTapToSignIn(AuthCubit authCubit) =>
      Future.delayed(const Duration(milliseconds: 300), () {
        authCubit.signIn(
          username: controllerLogin.text,
          password: controllerPassword.text,
        );
      });
}
