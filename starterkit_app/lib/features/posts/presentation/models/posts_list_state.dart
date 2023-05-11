import 'package:equatable/equatable.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';

sealed class PostsListState {
  const PostsListState();
}

class PostsListLoadingState extends PostsListState {
  const PostsListLoadingState();
}

class PostsListLoadedState extends PostsListState with EquatableMixin {
  final Iterable<PostEntity> posts;

  @override
  List<Object?> get props => [posts];

  const PostsListLoadedState(this.posts);
}

class PostsListErrorState extends PostsListState with EquatableMixin {
  final String message;

  @override
  List<Object?> get props => [message];

  const PostsListErrorState(this.message);
}
