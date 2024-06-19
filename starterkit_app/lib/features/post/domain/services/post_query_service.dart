import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/features/post/data/repositories/post_repository_impl.dart';
import 'package:starterkit_app/features/post/domain/models/post_entity.dart';

@lazySingleton
class PostQueryService {
  final PostRepository _postRepository;

  PostQueryService(this._postRepository);

  Future<Result<PostEntity>> getPost(int id) async {
    try {
      final PostEntity post = await _postRepository.getPost(id);
      return Success<PostEntity>(post);
    } catch (e, st) {
      return Failure<PostEntity>(Exception(e), st);
    }
  }

  Future<Result<Iterable<PostEntity>>> getPosts() async {
    try {
      final Iterable<PostEntity> posts = await _postRepository.getPosts();
      return Success<Iterable<PostEntity>>(posts);
    } catch (e, st) {
      return Failure<Iterable<PostEntity>>(Exception(e), st);
    }
  }
}
