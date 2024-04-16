import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.gr.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_service.dart';
import 'package:starterkit_app/core/presentation/view_models/initializable.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';
import 'package:starterkit_app/features/post/domain/models/post_entity.dart';
import 'package:starterkit_app/features/post/domain/models/posts_list_state.dart';
import 'package:starterkit_app/features/post/domain/services/post_query_service.dart';

@injectable
class PostsViewModel extends ViewModel implements Initializable {
  final Logger _logger;
  final NavigationService _navigationService;
  final PostQueryService _postQueryService;

  final ValueNotifier<PostsListState> _postsState = ValueNotifier<PostsListState>(const PostsListLoadingState());

  PostsViewModel(this._logger, this._navigationService, this._postQueryService) {
    _logger.logFor(this);
  }

  ValueListenable<PostsListState> get postsState => _postsState;

  @override
  Future<void> onInitialize(Object? parameter) async {
    await onGetPosts();
  }

  Future<void> onGetPosts() async {
    _logger.log(LogLevel.info, 'Getting posts');

    final Result<Iterable<PostEntity>> getPostsResult = await _postQueryService.getPosts();

    switch (getPostsResult) {
      case Success<Iterable<PostEntity>>(value: final Iterable<PostEntity> postsToBeAdded):
        _onAddNewPosts(postsToBeAdded);

      case Failure<Iterable<PostEntity>>(exception: final Exception ex, stackTrace: final StackTrace? st):
        _logger.log(LogLevel.error, 'Failed to get posts', ex, st);
        _postsState.value = PostsListErrorState(Il8n.current.failedToGetPosts);
    }
  }

  Future<void> onPostSelected(PostEntity post) async {
    await _navigationService.push(PostDetailsViewRoute(postId: post.id));
  }

  void _onAddNewPosts(Iterable<PostEntity> postsToBeAdded) {
    final List<PostEntity> newPosts = <PostEntity>[];

    if (_postsState.value case PostsListLoadedState(posts: final Iterable<PostEntity> currentPosts)) {
      newPosts.addAll(currentPosts);
    }

    newPosts.addAll(postsToBeAdded);

    _postsState.value = PostsListLoadedState(newPosts);
    _logger.log(LogLevel.info, '${newPosts.length} posts loaded');
  }
}
