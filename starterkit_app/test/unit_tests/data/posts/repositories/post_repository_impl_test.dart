import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/data/database/app_database.dart';
import 'package:starterkit_app/core/infrastructure/platform/connectivity_service.dart';
import 'package:starterkit_app/features/post/data/local/post_local_data_source.dart';
import 'package:starterkit_app/features/post/data/remote/post_remote_data_source.dart';
import 'package:starterkit_app/features/post/data/repositories/post_repository_impl.dart';
import 'package:starterkit_app/features/post/domain/mappers/post_mapper.dart';
import 'package:starterkit_app/features/post/domain/models/post_data_contract.dart';
import 'package:starterkit_app/features/post/domain/models/post_entity.dart';

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
      provideDummy(const PostDataObject(
        id: 0,
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
          const PostDataObject(id: 0, postId: 0, userId: 1, title: '', body: ''),
        ];
        final PostRepositoryImpl unit = createUnitToTest();
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
        when(mockPostRemoteDataSource.getPosts()).thenAnswer((_) async => expectedContracts);
        when(mockPostMapper.convertIterable<PostDataContract, PostDataObject>(expectedContracts)).thenAnswer((_) {
          when(mockPostMapper.convertIterable<PostDataObject, PostEntity>(expectedObjects))
              .thenReturn(expectedEntities);

          return expectedObjects;
        });
        when(mockPostLocalDataSource.getAll()).thenAnswer((_) async => expectedObjects);

        final Iterable<PostEntity> actualPosts = await unit.getPosts();

        verify(mockPostRemoteDataSource.getPosts()).called(1);
        expect(actualPosts, equals(expectedEntities));
      });

      test('should add new posts when internet is connected', () async {
        const Iterable<PostDataContract> expectedContracts = <PostDataContract>[
          PostDataContract(userId: 1, id: 1, title: '', body: ''),
        ];
        final Iterable<PostDataObject> expectedObjects = <PostDataObject>[
          const PostDataObject(id: 0, postId: 0, userId: 1, title: '', body: ''),
        ];
        final PostRepositoryImpl unit = createUnitToTest();
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
        when(mockPostRemoteDataSource.getPosts()).thenAnswer((_) async => expectedContracts);
        when(mockPostMapper.convertIterable<PostDataContract, PostDataObject>(expectedContracts)).thenAnswer((_) {
          when(mockPostMapper.convertIterable<PostDataContract, PostEntity>(expectedContracts))
              .thenReturn(<PostEntity>[]);

          return expectedObjects;
        });

        await unit.getPosts();

        verify(mockPostLocalDataSource.addOrUpdateAll(expectedObjects)).called(1);
      });

      test('should return posts from local data source when internet is not connected', () async {
        final Iterable<PostDataObject> expectedObjects = <PostDataObject>[
          const PostDataObject(id: 0, postId: 0, userId: 1, title: '', body: ''),
        ];
        const Iterable<PostEntity> expectedEntities = <PostEntity>[
          PostEntity(userId: 1, id: 1, title: '', body: ''),
        ];
        final PostRepositoryImpl unit = createUnitToTest();
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => false);
        when(mockPostLocalDataSource.getAll()).thenAnswer((_) async => expectedObjects);
        when(mockPostMapper.convertIterable<PostDataObject, PostEntity>(expectedObjects))
            .thenAnswer((_) => expectedEntities);

        final Iterable<PostEntity> actualPosts = await unit.getPosts();

        verifyNever(mockPostRemoteDataSource.getPosts());
        verify(mockPostLocalDataSource.getAll()).called(1);
        expect(actualPosts, equals(expectedEntities));
      });
    });

    group('getPost', () {
      test('should return post from remote data source when internet is connected', () async {
        const int expectedPostId = 1;
        const PostDataContract expectedContract = PostDataContract(userId: 1, id: expectedPostId, title: '', body: '');
        const PostEntity expectedEntity = PostEntity(userId: 1, id: expectedPostId, title: '', body: '');
        const PostDataObject expectedObject =
            PostDataObject(id: 0, postId: expectedPostId, userId: 1, title: '', body: '');
        final PostRepositoryImpl unit = createUnitToTest();
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
        when(mockPostRemoteDataSource.getPost(expectedPostId)).thenAnswer((_) async => expectedContract);
        when(mockPostMapper.convert<PostDataContract, PostDataObject>(expectedContract))
            .thenAnswer((_) => expectedObject);
        when(mockPostMapper.convert<PostDataObject, PostEntity>(expectedObject)).thenReturn(expectedEntity);
        when(mockPostLocalDataSource.getPost(expectedPostId)).thenAnswer((_) async => expectedObject);

        final PostEntity actualPost = await unit.getPost(expectedPostId);

        verify(mockPostRemoteDataSource.getPost(expectedPostId)).called(1);
        expect(actualPost, equals(expectedEntity));
      });

      test('should add new post when internet is connected', () async {
        const int expectedId = 1;
        const PostDataContract expectedContract = PostDataContract(userId: 1, id: expectedId, title: '', body: '');
        const PostDataObject expectedObject = PostDataObject(id: 0, postId: expectedId, userId: 1, title: '', body: '');
        final PostRepositoryImpl unit = createUnitToTest();
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
        when(mockPostRemoteDataSource.getPost(expectedId)).thenAnswer((_) async => expectedContract);
        when(mockPostMapper.convert<PostDataContract, PostDataObject>(expectedContract)).thenAnswer((_) {
          when(mockPostMapper.convert<PostDataContract, PostEntity>(expectedContract)).thenReturn(PostEntity.empty);

          return expectedObject;
        });

        await unit.getPost(expectedId);

        verify(mockPostLocalDataSource.addOrUpdate(expectedObject)).called(1);
      });

      test('should return post from local data source when internet is not connected', () async {
        const int expectedId = 1;
        const PostDataObject expectedObject = PostDataObject(id: 0, postId: expectedId, userId: 1, title: '', body: '');
        const PostEntity expectedEntity = PostEntity(userId: 1, id: expectedId, title: '', body: '');
        final PostRepositoryImpl unit = createUnitToTest();
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => false);
        when(mockPostLocalDataSource.getPost(expectedId)).thenAnswer((_) async => expectedObject);
        when(mockPostMapper.convert<PostDataObject, PostEntity>(expectedObject)).thenAnswer((_) => expectedEntity);

        final PostEntity actualPost = await unit.getPost(expectedId);

        verifyNever(mockPostRemoteDataSource.getPost(expectedId));
        verify(mockPostLocalDataSource.getPost(expectedId)).called(1);
        expect(actualPost, equals(expectedEntity));
      });
    });
  });
}
