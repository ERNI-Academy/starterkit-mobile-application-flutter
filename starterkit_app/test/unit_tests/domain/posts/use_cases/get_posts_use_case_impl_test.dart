import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/features/post/domain/models/post_entity.dart';
import 'package:starterkit_app/features/post/domain/repositories/post_repository.dart';
import 'package:starterkit_app/features/post/domain/use_cases/get_posts_use_case.dart';

import '../../../../test_matchers.dart';
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

    group('execute', () {
      test('should return successful result when called', () async {
        const List<PostEntity> expectedPosts = <PostEntity>[PostEntity.empty];
        const Success<Iterable<PostEntity>> expectedPostsResult = Success<Iterable<PostEntity>>(expectedPosts);
        when(mockPostRepository.getPosts(
          offset: anyInstanceOf<int>(named: 'offset'),
          limit: anyInstanceOf<int>(named: 'limit'),
        )).thenAnswer((_) async => expectedPosts);
        final GetPostsUseCase unit = createUnitToTest();

        final Result<Iterable<PostEntity>> actualPostsResult = await unit.execute(offset: 0, limit: 1);

        verify(mockPostRepository.getPosts(
          offset: anyInstanceOf<int>(named: 'offset'),
          limit: anyInstanceOf<int>(named: 'limit'),
        )).called(1);
        expect(actualPostsResult, equals(expectedPostsResult));
      });

      test('should return failed result when exception thrown', () async {
        when(mockPostRepository.getPosts(
          offset: anyInstanceOf<int>(named: 'offset'),
          limit: anyInstanceOf<int>(named: 'limit'),
        )).thenThrow(Exception());
        final GetPostsUseCase unit = createUnitToTest();

        final Result<Iterable<PostEntity>> actualPostsResult = await unit.execute(offset: 0, limit: 1);

        verify(mockPostRepository.getPosts(
          offset: anyInstanceOf<int>(named: 'offset'),
          limit: anyInstanceOf<int>(named: 'limit'),
        )).called(1);
        expect(actualPostsResult.isSuccess, isFalse);
      });
    });
  });
}
