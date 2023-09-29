import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starterkit_app/core/presentation/navigation/root_auto_router.gr.dart';
import 'package:starterkit_app/core/presentation/views/child_view_mixin.dart';
import 'package:starterkit_app/core/presentation/views/view_route_mixin.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';
import 'package:starterkit_app/presentation/posts/view_models/post_details_view_model.dart';

@RoutePage()
class PostDetailsView extends StatelessWidget with ViewRouteMixin<PostDetailsViewModel> {
  const PostDetailsView({@postIdParam int postId = 0}) : super(key: const Key(PostDetailsViewRoute.name));

  @override
  Widget buildView(BuildContext context, PostDetailsViewModel viewModel) {
    return const Scaffold(
      appBar: _PostDetailsAppBar(),
      body: _PostDetailsBody(),
    );
  }
}

class _PostDetailsAppBar extends StatelessWidget
    with ChildViewMixin<PostDetailsViewModel>
    implements PreferredSizeWidget {
  const _PostDetailsAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget buildView(BuildContext context, PostDetailsViewModel viewModel) {
    return ValueListenableBuilder<PostEntity>(
      valueListenable: viewModel.post,
      builder: (BuildContext context, PostEntity post, _) {
        return AppBar(title: Text(post.title));
      },
    );
  }
}

class _PostDetailsBody extends StatelessWidget with ChildViewMixin<PostDetailsViewModel> {
  const _PostDetailsBody();

  @override
  Widget buildView(BuildContext context, PostDetailsViewModel viewModel) {
    return ValueListenableBuilder<PostEntity>(
      valueListenable: viewModel.post,
      builder: (BuildContext context, PostEntity post, _) {
        return switch (post) {
          PostEntity.empty => const Center(child: CircularProgressIndicator()),
          _ => Center(child: Text(post.body)),
        };
      },
    );
  }
}
