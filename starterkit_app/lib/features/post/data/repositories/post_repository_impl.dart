import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/infrastructure/platform/connectivity_service.dart';
import 'package:starterkit_app/features/post/data/local/post_local_data_source.dart';
import 'package:starterkit_app/features/post/data/remote/post_remote_data_source.dart';
import 'package:starterkit_app/features/post/domain/mappers/post_mapper.dart';
import 'package:starterkit_app/features/post/domain/models/post_data_contract.dart';
import 'package:starterkit_app/features/post/domain/models/post_data_object.dart';
import 'package:starterkit_app/features/post/domain/models/post_entity.dart';
import 'package:starterkit_app/features/post/domain/repositories/post_repository.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _postRemoteDataSource;
  final PostLocalDataSource _postLocalDataSource;
  final PostMapper _postMapper;
  final ConnectivityService _connectivityService;

  PostRepositoryImpl(
    this._postRemoteDataSource,
    this._postLocalDataSource,
    this._postMapper,
    this._connectivityService,
  );

  @override
  Future<Iterable<PostEntity>> getPosts({required int offset, required int limit}) async {
    final bool isConnected = await _connectivityService.isConnected();

    if (isConnected) {
      final Iterable<PostDataContract> contracts = await _postRemoteDataSource.getPosts();
      final Iterable<PostDataObject> dataObjects =
          _postMapper.convertIterable<PostDataContract, PostDataObject>(contracts);
      await _postLocalDataSource.addOrUpdateAll(dataObjects);
    }

    final Iterable<PostDataObject> dataObjects = await _postLocalDataSource.getAll(offset: offset, limit: limit);
    final Iterable<PostEntity> entities = _postMapper.convertIterable<PostDataObject, PostEntity>(dataObjects);

    return entities;
  }

  @override
  Future<PostEntity> getPost(int id) async {
    final bool isConnected = await _connectivityService.isConnected();

    if (isConnected) {
      final PostDataContract contract = await _postRemoteDataSource.getPost(id);
      final PostDataObject dataObject = _postMapper.convert<PostDataContract, PostDataObject>(contract);
      await _postLocalDataSource.addOrUpdate(dataObject);
    }

    final PostDataObject? dataObject = await _postLocalDataSource.getPost(id);
    final PostEntity entity = _postMapper.convert<PostDataObject, PostEntity>(dataObject);

    return entity;
  }
}
