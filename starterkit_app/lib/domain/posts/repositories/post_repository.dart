import 'package:starterkit_app/domain/posts/models/post_entity.dart';

abstract interface class PostRepository {
  Future<Iterable<PostEntity>> getPosts({required int offset, required int limit});

  Future<PostEntity> getPost(int id);
}
