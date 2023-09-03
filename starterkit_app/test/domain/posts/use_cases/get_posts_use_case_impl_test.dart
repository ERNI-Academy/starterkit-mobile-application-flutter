import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';
import 'package:starterkit_app/domain/posts/repositories/post_repository.dart';
import 'package:starterkit_app/domain/posts/use_cases/get_posts_use_case.dart';

import 'get_posts_use_case_impl_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<PostRepository>(),
])
void main() {
  group(GetPostsUseCaseImpl, () {
    late MockPostRepository mockPostRepository;

    setUp(() {
      mockPostRepository = MockPostRepository();
    });

    GetPostsUseCaseImpl createUnitToTest() {
      return GetPostsUseCaseImpl(mockPostRepository);
    }

    group('getAll', () {
      test('should return successful result when called', () async {
        const List<PostEntity> expectedPosts = <PostEntity>[PostEntity.empty()];
        const Success<Iterable<PostEntity>> expectedPostsResult = Success<Iterable<PostEntity>>(expectedPosts);
        when(mockPostRepository.getPosts()).thenAnswer((_) async => expectedPosts);
        final GetPostsUseCase unit = createUnitToTest();

        final Result<Iterable<PostEntity>> actualPostsResult = await unit.getAll();

        verify(mockPostRepository.getPosts()).called(1);
        expect(actualPostsResult, equals(expectedPostsResult));
      });

      test('should return failed result when called', () async {
        when(mockPostRepository.getPosts()).thenThrow(Exception());
        final GetPostsUseCase unit = createUnitToTest();

        final Result<Iterable<PostEntity>> actualPostsResult = await unit.getAll();

        verify(mockPostRepository.getPosts()).called(1);
        expect(actualPostsResult.isSuccess, isFalse);
      });
    });
  });
}
