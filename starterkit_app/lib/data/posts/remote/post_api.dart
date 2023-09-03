// coverage: ignore-file

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:starterkit_app/core/data/api/dio_provider.dart';
import 'package:starterkit_app/domain/posts/models/post_data_contract.dart';

part 'post_api.g.dart';

abstract interface class PostApi {
  Future<Iterable<PostDataContract>> getPosts();
}

@LazySingleton(as: PostApi)
@RestApi()
abstract interface class PostApiImpl implements PostApi {
  @factoryMethod
  factory PostApiImpl(DioProvider dioProvider) => _PostApiImpl(dioProvider.create<PostApi>());

  @override
  @GET('/posts')
  Future<List<PostDataContract>> getPosts();
}
