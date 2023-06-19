import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/domain/result.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_service.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';
import 'package:starterkit_app/features/posts/domain/services/posts_service.dart';
import 'package:starterkit_app/features/posts/presentation/models/posts_list_state.dart';
import 'package:starterkit_app/shared/localization/localization.dart';

abstract interface class PostsViewModel implements ViewModel {
  ValueListenable<PostsListState> get postsState;

  Future<void> onPostSelected(PostEntity post);
}

@Injectable(as: PostsViewModel)
class PostsViewModelImpl extends ViewModel implements PostsViewModel {
  @override
  final ValueNotifier<PostsListState> postsState = ValueNotifier(const PostsListLoadingState());

  final Logger _logger;
  final NavigationService _navigationService;
  final PostsService _postsService;

  PostsViewModelImpl(this._logger, this._navigationService, this._postsService) {
    _logger.logFor(this);
  }

  @override
  Future<void> onPostSelected(PostEntity post) async {
    await _navigationService.push(PostDetailsViewRoute(post: post));
  }

  @override
  Future<void> onInitialize() async {
    await _onGetPosts();
  }

  Future<void> _onGetPosts() async {
    _logger.log(LogLevel.info, 'Getting posts');
    postsState.value = const PostsListLoadingState();

    final getPostsResult = await _postsService.getPosts();

    switch (getPostsResult) {
      case Success(:final value):
        postsState.value = PostsListLoadedState(value);
        _logger.log(LogLevel.info, '${value.length} posts loaded');
        break;
      case Failure(:final error, :final stackTrace):
        _logger.log(LogLevel.error, 'Failed to get posts', error, stackTrace);
        postsState.value = PostsListErrorState(Il8n.current.failedToGetPosts);
        break;
    }
  }
}
