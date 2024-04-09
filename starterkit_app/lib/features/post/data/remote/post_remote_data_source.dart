import 'package:injectable/injectable.dart';
import 'package:starterkit_app/features/post/data/remote/post_api.dart';
import 'package:starterkit_app/features/post/domain/models/post_data_contract.dart';

@lazySingleton
class PostRemoteDataSource {
  final PostApi _postApi;

  PostRemoteDataSource(this._postApi);

  Future<Iterable<PostDataContract>> getPosts() async {
    final Iterable<PostDataContract> contracts = await _postApi.getPosts();

    return contracts;
  }

  Future<PostDataContract> getPost(int id) async {
    final PostDataContract contract = await _postApi.getPost(id);

    return contract;
  }
}
