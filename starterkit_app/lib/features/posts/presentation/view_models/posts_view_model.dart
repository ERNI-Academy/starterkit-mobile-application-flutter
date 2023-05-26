import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_service.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';
import 'package:starterkit_app/core/reflection.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';
import 'package:starterkit_app/features/posts/domain/services/posts_service.dart';
import 'package:starterkit_app/features/posts/presentation/models/posts_list_state.dart';
import 'package:starterkit_app/shared/localization/localization.dart';

@injectable
@navigatable
class PostsViewModel extends ViewModel {
  final Logger _logger;
  final NavigationService _navigationService;
  final PostsService _postsService;

  final ValueNotifier<PostsListState> _postsState = ValueNotifier(const PostsListLoadingState());

  ValueListenable<PostsListState> get postsState => _postsState;

  PostsViewModel(this._logger, this._navigationService, this._postsService) {
    _logger.logFor(this);
  }

  Future<void> onPostSelected(PostEntity post) async {
    await _navigationService.push(PostDetailsViewRoute(post: post));
  }

  @override
  Future<void> onInitialize() async {
    await _onGetPosts();
  }

  Future<void> _onGetPosts() async {
    try {
      _logger.log(LogLevel.info, 'Getting posts');
      _postsState.value = const PostsListLoadingState();
      final postEntities = await _postsService.getPosts();
      _postsState.value = PostsListLoadedState(postEntities);
      _logger.log(LogLevel.info, '${postEntities.length} posts loaded');
    } catch (e, st) {
      _logger.log(LogLevel.error, 'Failed to get posts', e, st);
      _postsState.value = PostsListErrorState(Il8n.current.failedToGetPosts);
    }
  }
}
