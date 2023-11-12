import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';
import 'package:starterkit_app/domain/posts/repositories/post_repository.dart';
import 'package:starterkit_app/domain/posts/use_cases/get_post_use_case.dart';

import 'get_post_use_case_impl_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<PostRepository>(),
])
void main() {
  group(GetPostUseCaseImpl, () {
    late MockPostRepository mockPostRepository;

    setUp(() {
      mockPostRepository = MockPostRepository();
    });

    GetPostUseCase createUnitToTest() {
      return GetPostUseCaseImpl(mockPostRepository);
    }

    group('execute', () {
      test('should return successful result when called', () async {
        final GetPostUseCase unit = createUnitToTest();
        const PostEntity expectedPost = PostEntity.empty;
        final int expectedPostId = expectedPost.id;
        when(mockPostRepository.getPost(expectedPostId)).thenAnswer((_) async => expectedPost);

        final Result<PostEntity> actualResult = await unit.execute(expectedPostId);

        verify(mockPostRepository.getPost(expectedPostId)).called(1);
        expect(actualResult, isA<Success<PostEntity>>());
      });

      test('should return failed result when exception thrown', () async {
        final GetPostUseCase unit = createUnitToTest();
        const int expectedPostId = 1;
        when(mockPostRepository.getPost(expectedPostId)).thenThrow(Exception());

        final Result<PostEntity> actualResult = await unit.execute(expectedPostId);

        verify(mockPostRepository.getPost(expectedPostId)).called(1);
        expect(actualResult, isA<Failure<PostEntity>>());
      });
    });
  });
}
