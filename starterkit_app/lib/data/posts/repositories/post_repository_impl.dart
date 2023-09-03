import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/infrastructure/platform/connectivity_service.dart';
import 'package:starterkit_app/data/posts/local/post_local_data_source.dart';
import 'package:starterkit_app/data/posts/remote/post_remote_data_source.dart';
import 'package:starterkit_app/domain/posts/mappers/post_mapper.dart';
import 'package:starterkit_app/domain/posts/models/post_data_contract.dart';
import 'package:starterkit_app/domain/posts/models/post_data_object.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';
import 'package:starterkit_app/domain/posts/repositories/post_repository.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _postRemoteDataSource;
  final PostLocalDataSource _postLocalDataSource;
  final PostMapper _postMapper;
  final ConnectivityService _connectivityService;

  const PostRepositoryImpl(
    this._postRemoteDataSource,
    this._postLocalDataSource,
    this._postMapper,
    this._connectivityService,
  );

  @override
  Future<Iterable<PostEntity>> getPosts() async {
    final Iterable<PostEntity> postEntities;
    final bool isConnected = await _connectivityService.isConnected();

    if (isConnected) {
      final Iterable<PostDataContract> contracts = await _postRemoteDataSource.getPosts();
      final Iterable<PostDataObject> dataObjects = _postMapper.mapObjects(contracts);
      await _postLocalDataSource.deleteAll();
      await _postLocalDataSource.addOrUpdateAll(dataObjects);
      postEntities = _postMapper.mapObjects<PostDataContract, PostEntity>(contracts);
    } else {
      final Iterable<PostDataObject> dataObjects = await _postLocalDataSource.getAll();
      postEntities = _postMapper.mapObjects<PostDataObject, PostEntity>(dataObjects);
    }

    return postEntities;
  }
}
