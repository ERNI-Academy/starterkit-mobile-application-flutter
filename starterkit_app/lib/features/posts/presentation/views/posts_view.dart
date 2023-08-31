import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';
import 'package:starterkit_app/core/infrastructure/navigation/root_auto_router.gr.dart';
import 'package:starterkit_app/core/presentation/views/view_mixin.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';
import 'package:starterkit_app/features/posts/presentation/models/posts_list_state.dart';
import 'package:starterkit_app/features/posts/presentation/view_models/posts_view_model.dart';

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
        builder: (BuildContext context, PostsListState postsState, _) {
          return switch (postsState) {
            PostsListLoadingState _ => const Center(child: CircularProgressIndicator()),
            PostsListLoadedState _ => _PostsListView(postsState.posts.toList(), viewModel.onPostSelected),
            PostsListErrorState _ => Center(child: Text(postsState.message)),
          };
        },
      ),
    );
  }
}

class _PostsListView extends StatelessWidget {
  const _PostsListView(this.posts, this.onTap);

  final List<PostEntity> posts;
  final void Function(PostEntity entity) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        Widget? listWidget;
        final PostEntity? post = posts.elementAtOrNull(index);

        if (post != null) {
          listWidget = ListTile(
            key: Key(post.id.toString()),
            title: Text(post.title),
            subtitle: Text(post.body),
            onTap: () => onTap(post),
          );
        }

        return listWidget;
      },
      itemCount: posts.length,
    );
  }
}
