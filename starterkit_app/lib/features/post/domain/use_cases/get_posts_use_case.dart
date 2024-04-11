import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/features/post/domain/models/post_entity.dart';
import 'package:starterkit_app/features/post/domain/repositories/post_repository.dart';

abstract interface class GetPostsUseCase {
  Future<Result<Iterable<PostEntity>>> execute();
}

@LazySingleton(as: GetPostsUseCase)
class GetPostsUseCaseImpl implements GetPostsUseCase {
  final PostRepository _postRepository;

  GetPostsUseCaseImpl(this._postRepository);

  @override
  Future<Result<Iterable<PostEntity>>> execute() async {
    try {
      final Iterable<PostEntity> posts = await _postRepository.getPosts();

      return Success<Iterable<PostEntity>>(posts);
    } catch (e, st) {
      return Failure<Iterable<PostEntity>>(Exception(e), st);
    }
  }
}
