import 'package:chat_client/app/di/init_di.dart';
import 'package:chat_client/app/domain/app_api.dart';
import 'package:chat_client/app/domain/error_entity/error_entity.dart';
import 'package:chat_client/app/ui/app_loader.dart';
import 'package:chat_client/app/ui/components/app_dialog.dart';
import 'package:chat_client/app/ui/components/app_snackbar.dart';
import 'package:chat_client/app/ui/components/app_text_button.dart';
import 'package:chat_client/app/ui/components/app_text_field.dart';
import 'package:chat_client/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:chat_client/feature/posts/domain/state/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Account"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<AuthCubit>().logOut();
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        state.whenOrNull(authorized: (userEntity) {
          if (userEntity.userState?.hasData == true) {
            AppSnackBar.showSnackBarWithMessage(
                context, userEntity.userState?.data);
          }
          if (userEntity.userState?.hasError == true) {
            AppSnackBar.showSnackBarWithError(context,
                ErrorEntity.fromException(userEntity.userState?.error));
          }
        });
      }, builder: (context, state) {
        final userEntity =
            state.whenOrNull(authorized: (userEntity) => userEntity);
        if (userEntity?.userState?.connectionState == ConnectionState.waiting) {
          return const AppLoader();
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Row(
              children: [
                CircleAvatar(
                    child: Text(
                  userEntity?.username.split("").first ??
                      "Personal data missing",
                )),
                const SizedBox(width: 16),
                Column(
                  children: [
                    Text(userEntity?.username ?? ""),
                    Text(userEntity?.email ?? "")
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AppDialog(
                              val1: "old",
                              val2: "new",
                              onPressed: (v1, v2) {
                                Navigator.pop(context);
                                context.read<AuthCubit>().passwordUpdate(
                                    oldPassword: v1, newPassword: v2);
                              }));
                    },
                    child: const Text("Refresh password")),
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AppDialog(
                              val1: "username",
                              val2: "email",
                              onPressed: (v1, v2) {
                                Navigator.pop(context);
                                context
                                    .read<AuthCubit>()
                                    .userUpdate(username: v1, email: v2);
                              }));
                    },
                    child: const Text("Refresh data"))
              ],
            )
          ]),
        );
      }),
    );
  }
}
