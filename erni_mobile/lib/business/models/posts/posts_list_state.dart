import 'package:erni_mobile/business/models/posts/post.dart';

abstract class PostsListState {
  const PostsListState();
}

class PostsListLoadingState extends PostsListState {
  const PostsListLoadingState();
}

class PostsListLoadedState extends PostsListState {
  const PostsListLoadedState(this.posts);

  final Iterable<Post> posts;
}

class PostsListErrorState extends PostsListState {
  const PostsListErrorState(this.error, [this.fallbackPosts = const []]);

  final Object error;
  final Iterable<Post> fallbackPosts;
}
