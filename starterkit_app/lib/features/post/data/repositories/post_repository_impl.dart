import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/data/database/app_database.dart';
import 'package:starterkit_app/core/infrastructure/platform/connectivity_service.dart';
import 'package:starterkit_app/features/post/data/local/post_local_data_source.dart';
import 'package:starterkit_app/features/post/data/remote/post_remote_data_source.dart';
import 'package:starterkit_app/features/post/domain/mappers/post_mapper.dart';
import 'package:starterkit_app/features/post/domain/models/post_data_contract.dart';
import 'package:starterkit_app/features/post/domain/models/post_entity.dart';

@lazySingleton
class PostRepository {
  final PostRemoteDataSource _postRemoteDataSource;
  final PostLocalDataSource _postLocalDataSource;
  final PostMapper _postMapper;
  final ConnectivityService _connectivityService;

  PostRepository(
    this._postRemoteDataSource,
    this._postLocalDataSource,
    this._postMapper,
    this._connectivityService,
  );

  Future<Iterable<PostEntity>> getPosts() async {
    final bool isConnected = await _connectivityService.isConnected();

    if (isConnected) {
      final Iterable<PostDataContract> contracts = await _postRemoteDataSource.getPosts();
      final Iterable<PostDataObject> dataObjects =
          _postMapper.convertIterable<PostDataContract, PostDataObject>(contracts);
      await _postLocalDataSource.addOrUpdateAll(dataObjects);
    }

    final Iterable<PostDataObject> dataObjects = await _postLocalDataSource.getAll();
    final Iterable<PostEntity> entities = _postMapper.convertIterable<PostDataObject, PostEntity>(dataObjects);

    return entities;
  }

  Future<PostEntity> getPost(int postId) async {
    final bool isConnected = await _connectivityService.isConnected();

    if (isConnected) {
      final PostDataContract contract = await _postRemoteDataSource.getPost(postId);
      final PostDataObject dataObject = _postMapper.convert<PostDataContract, PostDataObject>(contract);
      await _postLocalDataSource.addOrUpdate(dataObject);
    }

    final PostDataObject? dataObject = await _postLocalDataSource.getPost(postId);
    final PostEntity entity = _postMapper.convert<PostDataObject, PostEntity>(dataObject);

    return entity;
  }
}
