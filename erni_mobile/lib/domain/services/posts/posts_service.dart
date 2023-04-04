import 'package:erni_mobile/business/models/posts/post.dart';
import 'package:erni_mobile/domain/models/result.dart';

abstract class PostsService {
  Future<Result<Iterable<Post>>> getPosts();
}
