import 'package:erni_mobile/business/models/posts/post.dart';
import 'package:erni_mobile/domain/apis/posts/posts_api.dart';
import 'package:erni_mobile/domain/models/result.dart';
import 'package:erni_mobile/domain/services/posts/posts_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PostsService)
class PostsServiceImpl implements PostsService {
  final PostsApi _postsApi;

  PostsServiceImpl(this._postsApi);

  @override
  Future<Result<Iterable<Post>>> getPosts() async {
    try {
      final contracts = await _postsApi.getPosts();
      final posts = contracts.map(
        (c) => Post(
          userId: c.userId,
          id: c.id,
          title: c.title,
          body: c.body,
        ),
      );

      return Result.succeeded(posts);
    } catch (e) {
      return Result.failed(e);
    }
  }
}
