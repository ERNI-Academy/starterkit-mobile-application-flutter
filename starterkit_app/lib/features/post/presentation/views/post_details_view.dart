import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.gr.dart';
import 'package:starterkit_app/core/presentation/views/view_model_builder.dart';
import 'package:starterkit_app/core/presentation/views/view_model_provider.dart';
import 'package:starterkit_app/features/post/domain/models/post_entity.dart';
import 'package:starterkit_app/features/post/presentation/view_models/post_details_view_model.dart';

@RoutePage()
class PostDetailsView extends StatelessWidget {
  final int postId;

  const PostDetailsView({@PathParam('postId') this.postId = 0}) : super(key: const Key(PostDetailsViewRoute.name));

  @override
  Widget build(BuildContext context) {
    return AutoViewModelBuilder<PostDetailsViewModel>(
      builder: (BuildContext context, PostDetailsViewModel viewModel) {
        return const Scaffold(
          appBar: _PostDetailsAppBar(),
          body: _PostDetailsBody(),
        );
      },
    );
  }
}

class _PostDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _PostDetailsAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PostEntity>(
      valueListenable: context.viewModel<PostDetailsViewModel>().post,
      builder: (BuildContext context, PostEntity post, _) {
        return AppBar(
          title: Text(post.title),
        );
      },
    );
  }
}

class _PostDetailsBody extends StatelessWidget {
  const _PostDetailsBody();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PostEntity>(
      valueListenable: context.viewModel<PostDetailsViewModel>().post,
      builder: (BuildContext context, PostEntity post, _) {
        return switch (post) {
          PostEntity.empty => const Center(child: CircularProgressIndicator()),
          _ => Center(child: Text(post.body)),
        };
      },
    );
  }
}
