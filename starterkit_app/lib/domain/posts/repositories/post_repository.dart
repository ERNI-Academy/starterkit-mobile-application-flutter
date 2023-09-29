import 'package:starterkit_app/domain/posts/models/post_entity.dart';

abstract interface class PostRepository {
  Future<Iterable<PostEntity>> getPosts();

  Future<PostEntity> getPost(int id);
}
