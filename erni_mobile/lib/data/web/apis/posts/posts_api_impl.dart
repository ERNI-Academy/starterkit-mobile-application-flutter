import 'package:erni_mobile/business/models/posts/post_item_contract.dart';
import 'package:erni_mobile/data/web/apis/api.dart';
import 'package:erni_mobile/domain/apis/dio_provider.dart';
import 'package:erni_mobile/domain/apis/posts/posts_api.dart';
import 'package:injectable/injectable.dart';

part 'posts_api_impl.g.dart';

@LazySingleton(as: PostsApi)
@RestApi()
abstract class PostsApiImpl implements PostsApi {
  @factoryMethod
  factory PostsApiImpl(DioProvider dioProvider, @apiBaseUrl String baseUrl) =>
      _PostsApiImpl(dioProvider.createFor<PostsApiImpl>(), baseUrl: baseUrl);

  @override
  @GET('/posts')
  Future<List<PostItemContract>> getPosts();
}
