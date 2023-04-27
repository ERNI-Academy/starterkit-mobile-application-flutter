import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/app.dart';
import 'package:starterkit_app/core/dependency_injection.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_service.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';
import 'package:starterkit_app/features/posts/domain/services/posts_service.dart';
import 'package:starterkit_app/features/posts/presentation/view_models/posts_view_model.dart';
import 'package:starterkit_app/features/posts/presentation/views/posts_view.dart';
import 'package:starterkit_app/shared/localization/localization.dart';

import '../../../../test_utils.dart';
import '../../../../widget_test_utils.dart';
import 'posts_view_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<Logger>(),
  MockSpec<NavigationService>(),
  MockSpec<PostsService>(),
])
void main() {
  group(PostsView, () {
    late Il8n il8n;
    late MockNavigationService mockNavigationService;
    late MockPostsService mockPostsService;

    setUp(() async {
      await setupWidgetTest();
      il8n = await setupLocale();
      mockNavigationService = MockNavigationService();
      mockPostsService = MockPostsService();

      final viewModel = PostsViewModel(MockLogger(), mockNavigationService, mockPostsService);
      ServiceLocator.instance.registerSingleton(viewModel);
    });

    testGoldens('should show correct app bar title when shown', (tester) async {
      await tester.pumpWidget(const App(initialRoute: PostsViewRoute()));
      await tester.pumpAndSettle();

      await matchGolden(tester, 'posts_view_app_bar_title');
      expect(find.text(il8n.posts), findsOneWidget);
    });

    testGoldens('should show list view when posts are loaded', (tester) async {
      const expectedPost = PostEntity(userId: 0, id: 0, title: 'Lorem Ipsum', body: 'Dolor sit amet');
      when(mockPostsService.getPosts()).thenAnswer((_) async => [expectedPost]);

      await tester.pumpWidget(const App(initialRoute: PostsViewRoute()));
      await tester.pumpAndSettle();

      await matchGolden(tester, 'posts_view_loaded');
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text(expectedPost.title), findsOneWidget);
      expect(find.text(expectedPost.body), findsOneWidget);
    });
  });
}
