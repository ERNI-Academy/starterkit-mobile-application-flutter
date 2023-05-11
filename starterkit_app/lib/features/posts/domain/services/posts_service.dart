import 'package:injectable/injectable.dart';
import 'package:starterkit_app/features/posts/data/api/posts_api.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';

abstract interface class PostsService {
  Future<Iterable<PostEntity>> getPosts();
}

@LazySingleton(as: PostsService)
class PostsServiceImpl implements PostsService {
  final PostsApi _postsApi;

  PostsServiceImpl(this._postsApi);

  @override
  Future<Iterable<PostEntity>> getPosts() async {
    final contracts = await _postsApi.getPosts();
    final posts = contracts.map(PostEntity.fromContract);

    return posts;
  }
}
