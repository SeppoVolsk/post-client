import 'package:chat_client/app/di/init_di.dart';
import 'package:chat_client/app/domain/app_builder.dart';
import 'package:chat_client/app/ui/root_screen.dart';
import 'package:chat_client/feature/auth/domain/auth_repository.dart';
import 'package:chat_client/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:chat_client/feature/posts/domain/post_repo.dart';
import 'package:chat_client/feature/posts/domain/state/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppBuilder implements AppBuilder {
  @override
  Widget buildApp() {
    return const _GlobalProviders(
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: RootScreen(),
          ),
        ),
      ),
    );
  }
}

class _GlobalProviders extends StatelessWidget {
  const _GlobalProviders({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => locator.get<AuthCubit>()),
      BlocProvider(
          create: (context) =>
              PostBloc(locator.get<PostRepo>(), locator.get<AuthCubit>())
                ..add(PostEvent.fetch())),
    ], child: child);
  }
}
