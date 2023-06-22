import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/dependency_injection.dart';
import 'package:starterkit_app/core/domain/result.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_service.dart';
import 'package:starterkit_app/features/app/presentation/views/app.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';
import 'package:starterkit_app/features/posts/domain/services/posts_service.dart';
import 'package:starterkit_app/features/posts/presentation/views/post_details_view.dart';
import 'package:starterkit_app/features/posts/presentation/views/posts_view.dart';
import 'package:starterkit_app/shared/localization/localization.dart';

import '../../../../test_utils.dart';
import '../../../../widget_test_utils.dart';
import 'posts_view_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PostsService>(),
])
void main() {
  group(PostsView, () {
    late Il8n il8n;
    late MockPostsService mockPostsService;

    setUp(() async {
      await setupWidgetTest();
      il8n = await setupLocale();
      mockPostsService = MockPostsService();

      ServiceLocator.instance.registerSingleton<PostsService>(mockPostsService);
      provideDummy<Result<Iterable<PostEntity>>>(const Success([]));
    });

    testGoldens('should show correct app bar title when shown', (tester) async {
      await tester.pumpWidget(const App(initialRoute: PostsViewRoute()));
      await tester.pumpAndSettle();

      await tester.matchGolden('posts_view_app_bar_title');
      expect(find.text(il8n.posts), findsOneWidget);
    });

    testGoldens('should show list view when posts are loaded', (tester) async {
      const expectedPost = PostEntity(userId: 0, id: 0, title: 'Lorem Ipsum', body: 'Dolor sit amet');
      when(mockPostsService.getPosts()).thenAnswer((_) async => const Success([expectedPost]));

      await tester.pumpWidget(const App(initialRoute: PostsViewRoute()));
      await tester.pumpAndSettle();

      await tester.matchGolden('posts_view_loaded');
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text(expectedPost.title), findsOneWidget);
      expect(find.text(expectedPost.body), findsOneWidget);
    });

    testGoldens('should navigate to PostDetailsView when post tapped', (tester) async {
      const expectedPost = PostEntity(userId: 0, id: 0, title: 'Lorem Ipsum', body: 'Dolor sit amet');
      when(mockPostsService.getPosts()).thenAnswer((_) async => const Success([expectedPost]));

      await tester.pumpWidget(const App(initialRoute: PostsViewRoute()));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key(expectedPost.id.toString())));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await tester.matchGolden('posts_view_navigate_to_post_details_view');
      expect(find.byType(PostsView), findsNothing);
      expect(find.byType(PostDetailsView), findsOneWidget);
    });
  });
}
