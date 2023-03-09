// coverage:ignore-file

import 'package:erni_mobile/business/models/posts/post.dart';
import 'package:erni_mobile/business/models/posts/posts_list_state.dart';
import 'package:erni_mobile/domain/services/ui/navigation/navigation_service.dart';
import 'package:erni_mobile/domain/ui/views/view_mixin.dart';
import 'package:erni_mobile/ui/view_models/posts/posts_view_model.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';

class PostsView extends StatelessWidget with ViewMixin<PostsViewModel> {
  const PostsView() : super(key: const Key(PostsViewRoute.name));

  @override
  Widget buildView(BuildContext context, PostsViewModel viewModel) {
    return Scaffold(
      body: StreamBuilder<PostsListState>(
        stream: viewModel.postsState,
        builder: (context, postsStateSnapshot) {
          final postsState = postsStateSnapshot.data;

          if (postsState is PostsListLoadedState) {
            return _PostsListView(postsState.posts.toList());
          } else if (postsState is PostsListErrorState) {
            return Center(child: Text(postsState.error.toString()));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _PostsListView extends StatelessWidget {
  const _PostsListView(this.posts);

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];

        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.body),
        );
      },
    );
  }
}
