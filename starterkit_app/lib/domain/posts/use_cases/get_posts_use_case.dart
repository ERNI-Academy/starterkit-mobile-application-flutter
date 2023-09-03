import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';
import 'package:starterkit_app/domain/posts/repositories/post_repository.dart';

abstract interface class GetPostsUseCase {
  Future<Result<Iterable<PostEntity>>> getAll();
}

@LazySingleton(as: GetPostsUseCase)
class GetPostsUseCaseImpl implements GetPostsUseCase {
  final PostRepository _postRepository;

  const GetPostsUseCaseImpl(this._postRepository);

  @override
  Future<Result<Iterable<PostEntity>>> getAll() async {
    try {
      final Iterable<PostEntity> posts = await _postRepository.getPosts();

      return Success<Iterable<PostEntity>>(posts);
    } catch (e, st) {
      return Failure<Iterable<PostEntity>>(Exception(e), st);
    }
  }
}
