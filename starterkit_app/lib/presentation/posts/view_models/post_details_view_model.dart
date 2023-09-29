import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/presentation/view_models/initializable.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';
import 'package:starterkit_app/core/reflection.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';
import 'package:starterkit_app/domain/posts/use_cases/get_post_use_case.dart';

@injectable
@navigatable
class PostDetailsViewModel extends ViewModel implements Initializable {
  final GetPostUseCase _getPostUseCase;
  final Logger _logger;

  final ValueNotifier<PostEntity> _post = ValueNotifier<PostEntity>(PostEntity.empty);

  PostDetailsViewModel(this._getPostUseCase, this._logger) {
    _logger.logFor<PostDetailsViewModel>();
  }

  @postIdParam
  int postId = 0;

  ValueListenable<PostEntity> get post => _post;

  @override
  Future<void> onInitialize() async {
    final Result<PostEntity> getPostResult = await _getPostUseCase.execute(postId);

    switch (getPostResult) {
      case Success<PostEntity>():
        _post.value = getPostResult.value;

      case Failure<PostEntity>():
        _logger.log(LogLevel.error, 'Failed to get post', getPostResult.exception, getPostResult.stackTrace);
    }
  }
}

const PathParam postIdParam = PathParam('id');
