import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';
import 'package:starterkit_app/core/domain/result.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_service.dart';
import 'package:starterkit_app/core/infrastructure/navigation/root_auto_router.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';
import 'package:starterkit_app/features/posts/domain/services/posts_service.dart';
import 'package:starterkit_app/features/posts/presentation/models/posts_list_state.dart';
import 'package:starterkit_app/features/posts/presentation/view_models/posts_view_model.dart';

import '../../../../test_utils.dart';
import '../../../../unit_test_utils.dart';
import 'posts_view_model_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<Logger>(),
  MockSpec<NavigationService>(),
  MockSpec<PostsService>(),
])
void main() {
  group(PostsViewModel, () {
    late MockLogger mockLogger;
    late MockNavigationService mockNavigationService;
    late MockPostsService mockPostsService;
    late Il8n il8n;

    setUp(() async {
      mockLogger = MockLogger();
      mockNavigationService = MockNavigationService();
      mockPostsService = MockPostsService();
      il8n = await setupLocale();

      provideDummy<Result<Iterable<PostEntity>>>(Failure<Iterable<PostEntity>>(Exception()));
    });

    PostsViewModel createUnitToTest() {
      return PostsViewModel(mockLogger, mockNavigationService, mockPostsService);
    }

    group('onInitialize', () {
      test('should get posts when called', () async {
        const List<PostEntity> expectedPostEntities = <PostEntity>[PostEntity.empty()];
        const PostsListLoadedState expectedPostState = PostsListLoadedState(expectedPostEntities);
        when(mockPostsService.getPosts())
            .thenAnswer((_) async => const Success<List<PostEntity>>(expectedPostEntities));

        final PostsViewModel unit = createUnitToTest();
        await unit.onInitialize();

        verify(mockPostsService.getPosts()).called(1);
        await expectLater(unit.postsState.value, equals(expectedPostState));
      });

      test('should log error when get posts fails', () async {
        final Exception expectedException = Exception();
        const StackTrace expectedStackTrace = StackTrace.empty;
        final PostsListErrorState expectedPostState = PostsListErrorState(il8n.failedToGetPosts);
        when(mockPostsService.getPosts())
            .thenAnswer((_) async => Failure<List<PostEntity>>(expectedException, expectedStackTrace));

        final PostsViewModel unit = createUnitToTest();
        await unit.onInitialize();

        verify(mockPostsService.getPosts()).called(1);
        verify(mockLogger.log(LogLevel.error, anyInstanceOf<String>(), expectedException, expectedStackTrace))
            .called(1);
        await expectLater(unit.postsState.value, equals(expectedPostState));
      });
    });

    group('onPostSelected', () {
      test('should push post details view when called', () async {
        const PostEntity expectedPostEntity = PostEntity.empty();

        final PostsViewModel unit = createUnitToTest();
        await unit.onPostSelected(expectedPostEntity);

        verify(mockNavigationService.push(PostDetailsViewRoute(post: expectedPostEntity))).called(1);
      });
    });
  });
}
