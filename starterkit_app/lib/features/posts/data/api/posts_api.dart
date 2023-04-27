// coverage: ignore-file

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:starterkit_app/core/data/api/dio_provider.dart';
import 'package:starterkit_app/features/posts/data/contracts/post_contract.dart';

part 'posts_api.g.dart';

@lazySingleton
@RestApi()
abstract class PostsApi {
  @factoryMethod
  factory PostsApi(DioProvider dioProvider) => _PostsApi(dioProvider.create<PostsApi>());

  @GET('/posts')
  Future<List<PostContract>> getPosts();
}
