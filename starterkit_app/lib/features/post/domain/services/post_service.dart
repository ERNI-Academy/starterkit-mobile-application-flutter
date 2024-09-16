import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/data/database/app_database.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/infrastructure/platform/connectivity_service.dart';
import 'package:starterkit_app/features/post/data/local/post_repository.dart';
import 'package:starterkit_app/features/post/data/remote/post_api.dart';
import 'package:starterkit_app/features/post/domain/exceptions/get_post_exception.dart';
import 'package:starterkit_app/features/post/domain/exceptions/get_posts_exception.dart';
import 'package:starterkit_app/features/post/domain/mappers/post_mapper.dart';
import 'package:starterkit_app/features/post/domain/models/post_data_contract.dart';
import 'package:starterkit_app/features/post/domain/models/post_entity.dart';

@lazySingleton
class PostService {
  final Logger _logger;
  final PostApi _postApi;
  final PostRepository _postRepository;
  final PostMapper _postMapper;
  final ConnectivityService _connectivityService;

  PostService(
    this._logger,
    this._postApi,
    this._postRepository,
    this._postMapper,
    this._connectivityService,
  ) {
    _logger.logFor<PostService>();
  }

  Future<Result<Iterable<PostEntity>>> getPosts() async {
    try {
      final bool isConnected = await _connectivityService.isConnected();

      if (isConnected) {
        final Iterable<PostDataContract> contracts = await _postApi.getPosts();
        final Iterable<PostDataObject> dataObjects =
            _postMapper.convertIterable<PostDataContract, PostDataObject>(contracts);
        await _postRepository.addOrUpdateAll(dataObjects);
      }

      final Iterable<PostDataObject> dataObjects = await _postRepository.getAll();
      final Iterable<PostEntity> entities = _postMapper.convertIterable<PostDataObject, PostEntity>(dataObjects);

      return Success<Iterable<PostEntity>>(entities);
    } catch (e, st) {
      _logger.log(LogLevel.error, 'Error getting posts', e, st);
      return Failure<Iterable<PostEntity>>(GetPostsException('Error getting posts', e, st));
    }
  }

  Future<Result<PostEntity>> getPost(int postId) async {
    try {
      final bool isConnected = await _connectivityService.isConnected();

      if (isConnected) {
        final PostDataContract contract = await _postApi.getPost(postId);
        final PostDataObject dataObject = _postMapper.convert<PostDataContract, PostDataObject>(contract);
        await _postRepository.addOrUpdate(dataObject);
      }

      final PostDataObject? dataObject = await _postRepository.getPost(postId);
      final PostEntity entity = _postMapper.convert<PostDataObject, PostEntity>(dataObject);

      return Success<PostEntity>(entity);
    } catch (e, st) {
      _logger.log(LogLevel.error, 'Error getting post', e, st);
      return Failure<PostEntity>(GetPostException('Error getting post', e, st));
    }
  }
}
