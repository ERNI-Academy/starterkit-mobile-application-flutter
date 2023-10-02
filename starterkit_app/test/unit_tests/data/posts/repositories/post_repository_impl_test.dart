import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/infrastructure/platform/connectivity_service.dart';
import 'package:starterkit_app/data/posts/local/post_local_data_source.dart';
import 'package:starterkit_app/data/posts/remote/post_remote_data_source.dart';
import 'package:starterkit_app/data/posts/repositories/post_repository_impl.dart';
import 'package:starterkit_app/domain/posts/mappers/post_mapper.dart';
import 'package:starterkit_app/domain/posts/models/post_data_contract.dart';
import 'package:starterkit_app/domain/posts/models/post_data_object.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';

import 'post_repository_impl_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<PostRemoteDataSource>(),
  MockSpec<PostLocalDataSource>(),
  MockSpec<PostMapper>(),
  MockSpec<ConnectivityService>(),
])
void main() {
  group(PostRepositoryImpl, () {
    late MockPostRemoteDataSource mockPostRemoteDataSource;
    late MockPostLocalDataSource mockPostLocalDataSource;
    late MockPostMapper mockPostMapper;
    late MockConnectivityService mockConnectivityService;

    setUp(() {
      mockPostRemoteDataSource = MockPostRemoteDataSource();
      mockPostLocalDataSource = MockPostLocalDataSource();
      mockPostMapper = MockPostMapper();
      mockConnectivityService = MockConnectivityService();
      provideDummy(PostDataObject(
        postId: 0,
        userId: 1,
        title: '',
        body: '',
      ));
      provideDummy(PostEntity.empty);
    });

    PostRepositoryImpl createUnitToTest() {
      return PostRepositoryImpl(
        mockPostRemoteDataSource,
        mockPostLocalDataSource,
        mockPostMapper,
        mockConnectivityService,
      );
    }

    group('getPosts', () {
      test('should return posts from remote data source when internet is connected', () async {
        const Iterable<PostDataContract> expectedContracts = <PostDataContract>[
          PostDataContract(userId: 1, id: 1, title: '', body: ''),
        ];
        const Iterable<PostEntity> expectedEntities = <PostEntity>[
          PostEntity(userId: 1, id: 1, title: '', body: ''),
        ];
        final Iterable<PostDataObject> expectedObjects = <PostDataObject>[
          PostDataObject(postId: 0, userId: 1, title: '', body: ''),
        ];
        final PostRepositoryImpl unit = createUnitToTest();
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
        when(mockPostRemoteDataSource.getPosts()).thenAnswer((_) async => expectedContracts);
        when(mockPostMapper.mapObjects<PostDataContract, PostDataObject>(expectedContracts)).thenAnswer((_) {
          when(mockPostMapper.mapObjects<PostDataObject, PostEntity>(expectedObjects)).thenReturn(expectedEntities);

          return expectedObjects;
        });
        when(mockPostLocalDataSource.getAll()).thenAnswer((_) async => expectedObjects);

        final Iterable<PostEntity> actualPosts = await unit.getPosts();

        verify(mockPostRemoteDataSource.getPosts()).called(1);
        expect(actualPosts, equals(expectedEntities));
      });

      test('should delete all posts and add new posts when internet is connected', () async {
        const Iterable<PostDataContract> expectedContracts = <PostDataContract>[
          PostDataContract(userId: 1, id: 1, title: '', body: ''),
        ];
        final Iterable<PostDataObject> expectedObjects = <PostDataObject>[
          PostDataObject(postId: 0, userId: 1, title: '', body: ''),
        ];
        final PostRepositoryImpl unit = createUnitToTest();
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
        when(mockPostRemoteDataSource.getPosts()).thenAnswer((_) async => expectedContracts);
        when(mockPostMapper.mapObjects<PostDataContract, PostDataObject>(expectedContracts)).thenAnswer((_) {
          when(mockPostMapper.mapObjects<PostDataContract, PostEntity>(expectedContracts)).thenReturn(<PostEntity>[]);

          return expectedObjects;
        });

        await unit.getPosts();

        verify(mockPostLocalDataSource.deleteAll()).called(1);
        verify(mockPostLocalDataSource.addOrUpdateAll(expectedObjects)).called(1);
      });

      test('should return posts from local data source when internet is not connected', () async {
        final Iterable<PostDataObject> expectedObjects = <PostDataObject>[
          PostDataObject(postId: 0, userId: 1, title: '', body: ''),
        ];
        const Iterable<PostEntity> expectedEntities = <PostEntity>[
          PostEntity(userId: 1, id: 1, title: '', body: ''),
        ];
        final PostRepositoryImpl unit = createUnitToTest();
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => false);
        when(mockPostLocalDataSource.getAll()).thenAnswer((_) async => expectedObjects);
        when(mockPostMapper.mapObjects<PostDataObject, PostEntity>(expectedObjects))
            .thenAnswer((_) => expectedEntities);

        final Iterable<PostEntity> actualPosts = await unit.getPosts();

        verifyNever(mockPostRemoteDataSource.getPosts());
        verify(mockPostLocalDataSource.getAll()).called(1);
        expect(actualPosts, equals(expectedEntities));
      });
    });

    group('getPost', () {
      test('should return post from remote data source when internet is connected', () async {
        const int expectedId = 1;
        const PostDataContract expectedContract = PostDataContract(userId: 1, id: expectedId, title: '', body: '');
        const PostEntity expectedEntity = PostEntity(userId: 1, id: expectedId, title: '', body: '');
        final PostDataObject expectedObject = PostDataObject(postId: 0, userId: 1, title: '', body: '');
        final PostRepositoryImpl unit = createUnitToTest();
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
        when(mockPostRemoteDataSource.getPost(expectedId)).thenAnswer((_) async => expectedContract);
        when(mockPostMapper.mapObject<PostDataContract, PostDataObject>(expectedContract)).thenAnswer((_) {
          when(mockPostMapper.mapObject<PostDataObject, PostEntity>(expectedObject)).thenReturn(expectedEntity);

          return expectedObject;
        });
        when(mockPostLocalDataSource.get(expectedId)).thenAnswer((_) async => expectedObject);

        final PostEntity actualPost = await unit.getPost(expectedId);

        verify(mockPostRemoteDataSource.getPost(expectedId)).called(1);
        expect(actualPost, equals(expectedEntity));
      });

      test('should add new post when internet is connected', () async {
        const int expectedId = 1;
        const PostDataContract expectedContract = PostDataContract(userId: 1, id: expectedId, title: '', body: '');
        final PostDataObject expectedObject = PostDataObject(postId: 0, userId: 1, title: '', body: '');
        final PostRepositoryImpl unit = createUnitToTest();
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
        when(mockPostRemoteDataSource.getPost(expectedId)).thenAnswer((_) async => expectedContract);
        when(mockPostMapper.mapObject<PostDataContract, PostDataObject>(expectedContract)).thenAnswer((_) {
          when(mockPostMapper.mapObject<PostDataContract, PostEntity>(expectedContract)).thenReturn(PostEntity.empty);

          return expectedObject;
        });

        await unit.getPost(expectedId);

        verify(mockPostLocalDataSource.addOrUpdate(expectedObject)).called(1);
      });

      test('should return post from local data source when internet is not connected', () async {
        const int expectedId = 1;
        final PostDataObject expectedObject = PostDataObject(postId: 0, userId: 1, title: '', body: '');
        const PostEntity expectedEntity = PostEntity(userId: 1, id: expectedId, title: '', body: '');
        final PostRepositoryImpl unit = createUnitToTest();
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => false);
        when(mockPostLocalDataSource.get(expectedId)).thenAnswer((_) async => expectedObject);
        when(mockPostMapper.mapObject<PostDataObject, PostEntity>(expectedObject)).thenAnswer((_) => expectedEntity);

        final PostEntity actualPost = await unit.getPost(expectedId);

        verifyNever(mockPostRemoteDataSource.getPost(expectedId));
        verify(mockPostLocalDataSource.get(expectedId)).called(1);
        expect(actualPost, equals(expectedEntity));
      });
    });
  });
}
