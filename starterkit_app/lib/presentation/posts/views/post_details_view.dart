// coverage:ignore-file

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starterkit_app/core/presentation/navigation/root_auto_router.gr.dart';
import 'package:starterkit_app/core/presentation/views/view_route_mixin.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';
import 'package:starterkit_app/presentation/posts/view_models/post_details_view_model.dart';

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
