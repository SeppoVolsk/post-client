import 'package:chat_client/app/ui/app_loader.dart';
import 'package:chat_client/feature/posts/domain/entity/post/post_entity.dart';
import 'package:chat_client/feature/posts/domain/state/cubit/post_cubit.dart';
import 'package:chat_client/feature/posts/ui/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
        builder: (context, state) {
          if (state.postList.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.postList.length,
              itemBuilder: (context, index) {
                return PostItem(
                  postEntity: state.postList[index],
                );
              },
            );
          }
          if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) {
            return const AppLoader();
          }
          return const SizedBox.shrink();
        },
        listener: (context, state) {});
  }
}
