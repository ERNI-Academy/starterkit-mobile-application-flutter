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
        const Iterable<PostDataObject> expectedObjects = <PostDataObject>[
          PostDataObject(userId: 1, id: 1, title: '', body: ''),
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
          const PostDataObject(userId: 1, id: 1, title: '', body: ''),
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
          const PostDataObject(userId: 1, id: 1, title: '', body: ''),
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

        verify(mockPostLocalDataSource.getAll()).called(1);
        expect(actualPosts, equals(expectedEntities));
      });
    });
  });
}
