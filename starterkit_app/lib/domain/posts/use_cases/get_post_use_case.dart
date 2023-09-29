import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';
import 'package:starterkit_app/domain/posts/repositories/post_repository.dart';

abstract interface class GetPostUseCase {
  Future<Result<PostEntity>> execute(int id);
}

@LazySingleton(as: GetPostUseCase)
class GetPostUseCaseImpl implements GetPostUseCase {
  final PostRepository _postRepository;

  GetPostUseCaseImpl(this._postRepository);

  @override
  Future<Result<PostEntity>> execute(int id) async {
    try {
      final PostEntity post = await _postRepository.getPost(id);

      return Success<PostEntity>(post);
    } catch (e, st) {
      return Failure<PostEntity>(Exception(e), st);
    }
  }
}
