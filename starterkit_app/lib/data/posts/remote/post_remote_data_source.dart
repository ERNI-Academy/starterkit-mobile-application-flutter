import 'package:injectable/injectable.dart';
import 'package:starterkit_app/data/posts/remote/post_api.dart';
import 'package:starterkit_app/domain/posts/models/post_data_contract.dart';

abstract interface class PostRemoteDataSource {
  Future<Iterable<PostDataContract>> getPosts();

  Future<PostDataContract> getPost(int id);
}

@LazySingleton(as: PostRemoteDataSource)
class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final PostApi _postApi;

  PostRemoteDataSourceImpl(this._postApi);

  @override
  Future<Iterable<PostDataContract>> getPosts() async {
    final Iterable<PostDataContract> contracts = await _postApi.getPosts();

    return contracts;
  }

  @override
  Future<PostDataContract> getPost(int id) async {
    final PostDataContract contract = await _postApi.getPost(id);

    return contract;
  }
}
