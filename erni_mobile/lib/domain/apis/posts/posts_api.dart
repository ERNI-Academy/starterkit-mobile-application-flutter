import 'package:erni_mobile/business/models/posts/post_item_contract.dart';

abstract class PostsApi {
  Future<Iterable<PostItemContract>> getPosts();
}
