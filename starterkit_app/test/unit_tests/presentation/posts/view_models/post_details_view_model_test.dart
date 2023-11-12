import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';
import 'package:starterkit_app/domain/posts/use_cases/get_post_use_case.dart';
import 'package:starterkit_app/presentation/posts/view_models/post_details_view_model.dart';

import '../../../../test_matchers.dart';
import 'post_details_view_model_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<Logger>(),
  MockSpec<GetPostUseCase>(),
])
void main() {
  group(PostDetailsViewModel, () {
    late MockLogger mockLogger;
    late MockGetPostUseCase mockGetPostUseCase;

    setUp(() {
      mockLogger = MockLogger();
      mockGetPostUseCase = MockGetPostUseCase();
      provideDummy<Result<PostEntity>>(Failure<PostEntity>(Exception(), StackTrace.empty));
    });

    PostDetailsViewModel createUnitToTest() {
      return PostDetailsViewModel(mockGetPostUseCase, mockLogger);
    }

    group('onInitialize', () {
      test('should get post when result is success', () async {
        final PostDetailsViewModel unit = createUnitToTest();
        const PostEntity expectedPost = PostEntity.empty;
        final int expectedPostId = expectedPost.id;
        when(mockGetPostUseCase.execute(expectedPostId))
            .thenAnswer((_) async => const Success<PostEntity>(expectedPost));

        await unit.onInitialize();

        verify(mockGetPostUseCase.execute(expectedPostId)).called(1);
        expect(unit.post.value, equals(expectedPost));
      });

      test('should log error when result is failure', () async {
        final PostDetailsViewModel unit = createUnitToTest();
        final Exception expectedException = Exception();
        const StackTrace expectedStackTrace = StackTrace.empty;
        when(mockGetPostUseCase.execute(any))
            .thenAnswer((_) async => Failure<PostEntity>(expectedException, expectedStackTrace));

        await unit.onInitialize();

        verify(mockLogger.log(LogLevel.error, anyInstanceOf<String>(), expectedException, expectedStackTrace));
      });
    });
  });
}
