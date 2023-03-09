import 'package:erni_mobile/business/models/posts/post.dart';

abstract class PostsService {
  Future<Iterable<Post>> getPosts();
}
