import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_service.dart';
import 'package:starterkit_app/core/presentation/views/view_mixin.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';
import 'package:starterkit_app/features/posts/presentation/models/posts_list_state.dart';
import 'package:starterkit_app/features/posts/presentation/view_models/posts_view_model.dart';
import 'package:starterkit_app/shared/localization/localization.dart';

@RoutePage()
class PostsView extends StatelessWidget with ViewMixin<PostsViewModel> {
  const PostsView() : super(key: const Key(PostsViewRoute.name));

  @override
  Widget buildView(BuildContext context, PostsViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Il8n.of(context).posts),
      ),
      body: ValueListenableBuilder<PostsListState>(
        valueListenable: viewModel.postsState,
        builder: (context, postsState, _) {
          if (postsState is PostsListLoadedState) {
            return _PostsListView(postsState.posts.toList(), viewModel.onPostSelected);
          } else if (postsState is PostsListErrorState) {
            return Center(child: Text(postsState.message));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _PostsListView extends StatelessWidget {
  const _PostsListView(this.posts, this.onTap);

  final List<PostEntity> posts;
  final void Function(PostEntity) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];

        return ListTile(
          key: Key(post.id.toString()),
          title: Text(post.title),
          subtitle: Text(post.body),
          onTap: () => onTap(post),
        );
      },
    );
  }
}
