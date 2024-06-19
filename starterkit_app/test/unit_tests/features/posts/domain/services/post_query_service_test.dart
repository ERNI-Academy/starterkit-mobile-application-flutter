import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/features/post/data/repositories/post_repository_impl.dart';
import 'package:starterkit_app/features/post/domain/models/post_entity.dart';
import 'package:starterkit_app/features/post/domain/services/post_query_service.dart';

import 'post_query_service_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<PostRepository>(),
])
void main() {
  group(PostQueryService, () {
    late MockPostRepository mockPostRepository;

    setUp(() {
      mockPostRepository = MockPostRepository();
    });

    PostQueryService createUnitToTest() {
      return PostQueryService(mockPostRepository);
    }

    group('getPost', () {
      test('should return successful result when called', () async {
        final PostQueryService unit = createUnitToTest();
        const PostEntity expectedPost = PostEntity.empty;
        final int expectedPostId = expectedPost.id;
        when(mockPostRepository.getPost(expectedPostId)).thenAnswer((_) async => expectedPost);

        final Result<PostEntity> actualResult = await unit.getPost(expectedPostId);

        verify(mockPostRepository.getPost(expectedPostId)).called(1);
        expect(actualResult, isA<Success<PostEntity>>());
      });

      test('should return failed result when exception thrown', () async {
        final PostQueryService unit = createUnitToTest();
        const int expectedPostId = 1;
        when(mockPostRepository.getPost(expectedPostId)).thenThrow(Exception());

        final Result<PostEntity> actualResult = await unit.getPost(expectedPostId);

        verify(mockPostRepository.getPost(expectedPostId)).called(1);
        expect(actualResult, isA<Failure<PostEntity>>());
      });
    });

    group('getPosts', () {
      test('should return successful result when called', () async {
        const List<PostEntity> expectedPosts = <PostEntity>[PostEntity.empty];
        const Success<Iterable<PostEntity>> expectedPostsResult = Success<Iterable<PostEntity>>(expectedPosts);
        when(mockPostRepository.getPosts()).thenAnswer((_) async => expectedPosts);
        final PostQueryService unit = createUnitToTest();

        final Result<Iterable<PostEntity>> actualPostsResult = await unit.getPosts();

        verify(mockPostRepository.getPosts()).called(1);
        expect(actualPostsResult, equals(expectedPostsResult));
      });

      test('should return failed result when exception thrown', () async {
        when(mockPostRepository.getPosts()).thenThrow(Exception());
        final PostQueryService unit = createUnitToTest();

        final Result<Iterable<PostEntity>> actualPostsResult = await unit.getPosts();

        verify(mockPostRepository.getPosts()).called(1);
        expect(actualPostsResult.isSuccess, false);
      });
    });
  });
}
