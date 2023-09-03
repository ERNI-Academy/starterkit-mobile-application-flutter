import 'package:equatable/equatable.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';

sealed class PostsListState {
  const PostsListState();
}

class PostsListLoadingState extends PostsListState {
  const PostsListLoadingState();
}

class PostsListLoadedState extends PostsListState with EquatableMixin {
  const PostsListLoadedState(this.posts);

  final Iterable<PostEntity> posts;

  @override
  List<Object?> get props => <Object?>[posts];
}

class PostsListErrorState extends PostsListState with EquatableMixin {
  const PostsListErrorState(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
