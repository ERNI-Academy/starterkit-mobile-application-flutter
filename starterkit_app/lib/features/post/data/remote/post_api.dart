// coverage:ignore-file

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:starterkit_app/features/post/domain/models/post_data_contract.dart';

part 'post_api.g.dart';

@lazySingleton
@RestApi()
abstract interface class PostApi {
  @factoryMethod
  factory PostApi(Dio dio) = _PostApi;

  @GET('/posts')
  Future<List<PostDataContract>> getPosts();

  @GET('/posts/{id}')
  Future<PostDataContract> getPost(@Path('id') int id);
}
