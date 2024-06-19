import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.gr.dart';
import 'package:starterkit_app/features/post/domain/models/post_entity.dart';
import 'package:starterkit_app/features/post/domain/services/post_query_service.dart';
import 'package:starterkit_app/features/post/presentation/view_models/post_details_view_model.dart';

import '../../../../../test_matchers.dart';
import 'post_details_view_model_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<Logger>(),
  MockSpec<PostQueryService>(),
])
void main() {
  group(PostDetailsViewModel, () {
    late MockLogger mockLogger;
    late MockPostQueryService mockPostQueryService;

    setUp(() {
      mockLogger = MockLogger();
      mockPostQueryService = MockPostQueryService();
      provideDummy<Result<PostEntity>>(Failure<PostEntity>(Exception(), StackTrace.empty));
    });

    PostDetailsViewModel createUnitToTest() {
      return PostDetailsViewModel(mockPostQueryService, mockLogger);
    }

    group('onInitialize', () {
      test('should get post when result is success', () async {
        final PostDetailsViewModel unit = createUnitToTest();
        const PostEntity expectedPost = PostEntity.empty;
        final int expectedPostId = expectedPost.id;
        when(mockPostQueryService.getPost(expectedPostId))
            .thenAnswer((_) async => const Success<PostEntity>(expectedPost));

        await unit.onInitialize(PostDetailsViewRouteArgs(postId: expectedPostId));

        verify(mockPostQueryService.getPost(expectedPostId)).called(1);
        expect(unit.post.value, equals(expectedPost));
      });

      test('should log error when result is failure', () async {
        final PostDetailsViewModel unit = createUnitToTest();
        final Exception expectedException = Exception();
        const StackTrace expectedStackTrace = StackTrace.empty;
        when(mockPostQueryService.getPost(any))
            .thenAnswer((_) async => Failure<PostEntity>(expectedException, expectedStackTrace));

        await unit.onInitialize(const PostDetailsViewRouteArgs(postId: 1));

        verify(mockLogger.log(LogLevel.error, anyInstanceOf<String>(), expectedException, expectedStackTrace));
      });
    });
  });
}
