import 'package:injectable/injectable.dart';
import 'package:starterkit_app/data/posts/remote/post_api.dart';
import 'package:starterkit_app/domain/posts/models/post_data_contract.dart';

abstract interface class PostRemoteDataSource {
  Future<Iterable<PostDataContract>> getPosts();
}

@LazySingleton(as: PostRemoteDataSource)
class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final PostApi _postApi;

  const PostRemoteDataSourceImpl(this._postApi);

  @override
  Future<Iterable<PostDataContract>> getPosts() async {
    final Iterable<PostDataContract> contracts = await _postApi.getPosts();

    return contracts;
  }
}
