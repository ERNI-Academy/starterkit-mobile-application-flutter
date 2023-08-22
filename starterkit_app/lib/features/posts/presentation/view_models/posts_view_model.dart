import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/domain/result.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_service.dart';
import 'package:starterkit_app/core/infrastructure/navigation/root_auto_router.gr.dart';
import 'package:starterkit_app/core/presentation/view_models/initializable.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';
import 'package:starterkit_app/features/posts/domain/services/posts_service.dart';
import 'package:starterkit_app/features/posts/presentation/models/posts_list_state.dart';
import 'package:starterkit_app/shared/localization/generated/l10n.dart';

@injectable
class PostsViewModel extends ViewModel implements Initializable {
  final Logger _logger;
  final NavigationService _navigationService;
  final PostsService _postsService;

  final ValueNotifier<PostsListState> _postsState = ValueNotifier<PostsListState>(const PostsListLoadingState());

  PostsViewModel(this._logger, this._navigationService, this._postsService) {
    _logger.logFor(this);
  }

  ValueListenable<PostsListState> get postsState => _postsState;

  @override
  Future<void> onInitialize() async {
    await _onGetPosts();
  }

  Future<void> onPostSelected(PostEntity post) async {
    await _navigationService.push(PostDetailsViewRoute(post: post));
  }

  Future<void> _onGetPosts() async {
    _logger.log(LogLevel.info, 'Getting posts');
    _postsState.value = const PostsListLoadingState();

    final Result<Iterable<PostEntity>> getPostsResult = await _postsService.getPosts();

    switch (getPostsResult) {
      case Success<Iterable<PostEntity>>(:final Iterable<PostEntity> value):
        _postsState.value = PostsListLoadedState(value);
        _logger.log(LogLevel.info, '${value.length} posts loaded');

      case Failure<Iterable<PostEntity>>(exception: final Exception ex, stackTrace: final StackTrace? st):
        _logger.log(LogLevel.error, 'Failed to get posts', ex, st);
        _postsState.value = PostsListErrorState(Il8n.current.failedToGetPosts);
    }
  }
}
