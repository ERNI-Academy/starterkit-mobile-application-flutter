import 'package:starterkit_app/features/post/domain/models/post_entity.dart';

abstract interface class PostRepository {
  Future<Iterable<PostEntity>> getPosts();

  Future<PostEntity> getPost(int postId);
}
