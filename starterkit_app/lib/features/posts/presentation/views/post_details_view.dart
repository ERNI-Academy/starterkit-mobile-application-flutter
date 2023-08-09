// coverage:ignore-file

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starterkit_app/core/infrastructure/navigation/root_auto_router.gr.dart';
import 'package:starterkit_app/core/presentation/views/view_mixin.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';
import 'package:starterkit_app/features/posts/presentation/view_models/post_details_view_model.dart';

@RoutePage()
class PostDetailsView extends StatelessWidget with ViewRouteMixin<PostDetailsViewModel> {
  const PostDetailsView({@postParam PostEntity? post}) : super(key: const Key(PostDetailsViewRoute.name));

  @override
  Widget buildView(BuildContext context, PostDetailsViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.post.title),
      ),
      body: Center(
        child: Text(viewModel.post.body),
      ),
    );
  }
}
