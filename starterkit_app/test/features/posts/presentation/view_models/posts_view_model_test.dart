import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/domain/result.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_service.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';
import 'package:starterkit_app/features/posts/presentation/models/posts_list_state.dart';
import 'package:starterkit_app/features/posts/presentation/view_models/posts_view_model.dart';
import 'package:starterkit_app/shared/localization/localization.dart';

import '../../../../core/infrastructure/mocks.mocks.dart';
import '../../../../test_utils.dart';
import '../../../../unit_test_utils.dart';
import '../../domain/mocks.mocks.dart';

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
    });

    PostsViewModel createUnitToTest() {
      return PostsViewModelImpl(mockLogger, mockNavigationService, mockPostsService);
    }

    test('initialize should get posts when called', () async {
      const expectedPostEntities = [PostEntity.empty];
      const expectedPostState = PostsListLoadedState(expectedPostEntities);
      when(mockPostsService.getPosts()).thenAnswer((_) async => const Success(expectedPostEntities));

      final unit = createUnitToTest();
      await unit.onInitialize();

      verify(mockPostsService.getPosts()).called(1);
      await expectLater(unit.postsState.value, expectedPostState);
    });

    test('initialize should log error when get posts fails', () async {
      final expectedException = Exception();
      const expectedStackTrace = StackTrace.empty;
      final expectedPostState = PostsListErrorState(il8n.failedToGetPosts);
      when(mockPostsService.getPosts()).thenAnswer((_) async => Failure(expectedException, expectedStackTrace));

      final unit = createUnitToTest();
      await unit.onInitialize();

      verify(mockPostsService.getPosts()).called(1);
      verify(mockLogger.log(LogLevel.error, anyInstanceOf<String>(), expectedException, expectedStackTrace)).called(1);
      await expectLater(unit.postsState.value, expectedPostState);
    });

    test('onPostSelected should push post details view when called', () async {
      const expectedPostEntity = PostEntity.empty;

      final unit = createUnitToTest();
      await unit.onPostSelected(expectedPostEntity);

      verify(mockNavigationService.push(PostDetailsViewRoute(post: expectedPostEntity))).called(1);
    });
  });
}
