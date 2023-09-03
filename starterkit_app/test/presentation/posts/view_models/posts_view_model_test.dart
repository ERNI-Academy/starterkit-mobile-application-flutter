import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_service.dart';
import 'package:starterkit_app/core/presentation/navigation/root_auto_router.gr.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';
import 'package:starterkit_app/domain/posts/models/posts_list_state.dart';
import 'package:starterkit_app/domain/posts/use_cases/get_posts_use_case.dart';
import 'package:starterkit_app/presentation/posts/view_models/posts_view_model.dart';

import '../../../test_utils.dart';
import '../../../unit_test_utils.dart';
import 'posts_view_model_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<Logger>(),
  MockSpec<NavigationService>(),
  MockSpec<GetPostsUseCase>(),
])
void main() {
  group(PostsViewModel, () {
    late MockLogger mockLogger;
    late MockNavigationService mockNavigationService;
    late MockGetPostsUseCase mockGetPostsUseCase;
    late Il8n il8n;

    setUp(() async {
      mockLogger = MockLogger();
      mockNavigationService = MockNavigationService();
      mockGetPostsUseCase = MockGetPostsUseCase();
      il8n = await setupLocale();

      provideDummy<Result<Iterable<PostEntity>>>(Failure<Iterable<PostEntity>>(Exception()));
    });

    PostsViewModel createUnitToTest() {
      return PostsViewModel(mockLogger, mockNavigationService, mockGetPostsUseCase);
    }

    group('onInitialize', () {
      test('should get posts when called', () async {
        const List<PostEntity> expectedPostEntities = <PostEntity>[PostEntity.empty()];
        const PostsListLoadedState expectedPostState = PostsListLoadedState(expectedPostEntities);
        when(mockGetPostsUseCase.getAll())
            .thenAnswer((_) async => const Success<List<PostEntity>>(expectedPostEntities));

        final PostsViewModel unit = createUnitToTest();
        await unit.onInitialize();

        verify(mockGetPostsUseCase.getAll()).called(1);
        await expectLater(unit.postsState.value, equals(expectedPostState));
      });

      test('should log error when get posts fails', () async {
        final Exception expectedException = Exception();
        const StackTrace expectedStackTrace = StackTrace.empty;
        final PostsListErrorState expectedPostState = PostsListErrorState(il8n.failedToGetPosts);
        when(mockGetPostsUseCase.getAll())
            .thenAnswer((_) async => Failure<List<PostEntity>>(expectedException, expectedStackTrace));

        final PostsViewModel unit = createUnitToTest();
        await unit.onInitialize();

        verify(mockGetPostsUseCase.getAll()).called(1);
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
