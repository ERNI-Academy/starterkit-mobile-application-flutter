import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/infrastructure/mapping/object_mapper.dart';
import 'package:starterkit_app/features/posts/data/api/posts_api.dart';
import 'package:starterkit_app/features/posts/data/contracts/post_contract.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';

abstract interface class PostsService {
  Future<Iterable<PostEntity>> getPosts();
}

@LazySingleton(as: PostsService)
class PostsServiceImpl implements PostsService {
  final PostsApi _postsApi;
  final ObjectMapper _objectMapper;

  PostsServiceImpl(this._postsApi, this._objectMapper);

  @override
  Future<Iterable<PostEntity>> getPosts() async {
    final contracts = await _postsApi.getPosts();
    final posts = _objectMapper.convertIterable<PostContract, PostEntity>(contracts);

    return posts;
  }
}
