import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/presentation/view_models/initializable.dart';
import 'package:starterkit_app/features/post/domain/models/post_entity.dart';
import 'package:starterkit_app/features/post/domain/services/post_query_service.dart';

@injectable
class PostDetailsViewModel implements Initializable<int> {
  final PostQueryService _postQueryService;
  final Logger _logger;

  PostDetailsViewModel(this._postQueryService, this._logger) {
    _logger.logFor<PostDetailsViewModel>();
  }

  final ValueNotifier<PostEntity> _post = ValueNotifier<PostEntity>(PostEntity.empty);
  ValueListenable<PostEntity> get post => _post;

  @override
  Future<void> onInitialize(int postId) async {
    final Result<PostEntity> getPostResult = await _postQueryService.getPost(postId);

    switch (getPostResult) {
      case Success<PostEntity>():
        _post.value = getPostResult.value;

      case Failure<PostEntity>():
        _logger.log(LogLevel.error, 'Failed to get post', getPostResult.exception, getPostResult.stackTrace);
    }
  }
}
