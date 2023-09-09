import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/core/presentation/navigation/root_auto_router.gr.dart';
import 'package:starterkit_app/core/service_locator.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';
import 'package:starterkit_app/domain/posts/use_cases/get_posts_use_case.dart';
import 'package:starterkit_app/presentation/app/views/app.dart';
import 'package:starterkit_app/presentation/posts/views/post_details_view.dart';
import 'package:starterkit_app/presentation/posts/views/posts_view.dart';

import '../../../test_utils.dart';
import '../../../widget_test_utils.dart';
import 'posts_view_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<GetPostsUseCase>(),
])
void main() {
  group(PostsView, () {
    late Il8n il8n;
    late MockGetPostsUseCase mockGetPostsUseCase;

    setUp(() async {
      await setupWidgetTest();
      il8n = await setupLocale();
      mockGetPostsUseCase = MockGetPostsUseCase();

      ServiceLocator.instance.registerSingleton<GetPostsUseCase>(mockGetPostsUseCase);
      provideDummy<Result<Iterable<PostEntity>>>(Failure<Iterable<PostEntity>>(Exception()));
    });

    group('AppBar', () {
      testGoldens('should show correct title when shown', (WidgetTester tester) async {
        when(mockGetPostsUseCase.getAll()).thenAnswer((_) async => const Success<Iterable<PostEntity>>(<PostEntity>[]));

        await tester.pumpWidget(const App(initialRoute: PostsViewRoute()));
        await tester.pumpAndSettle();

        await tester.matchGolden('posts_view_app_bar_title');
        expect(find.text(il8n.posts), findsOneWidget);
      });
    });

    group('ListView', () {
      testGoldens('should show posts when loaded', (WidgetTester tester) async {
        const PostEntity expectedPost = PostEntity(userId: 0, id: 0, title: 'Lorem Ipsum', body: 'Dolor sit amet');
        when(mockGetPostsUseCase.getAll())
            .thenAnswer((_) async => const Success<Iterable<PostEntity>>(<PostEntity>[expectedPost]));

        await tester.pumpWidget(const App(initialRoute: PostsViewRoute()));
        await tester.pumpAndSettle();

        await tester.matchGolden('posts_view_loaded');
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(ListTile), findsOneWidget);
        expect(find.text(expectedPost.title), findsOneWidget);
        expect(find.text(expectedPost.body), findsOneWidget);
      });
    });

    group('ListTile', () {
      testGoldens('should navigate to PostDetailsView when post tapped', (WidgetTester tester) async {
        const PostEntity expectedPost = PostEntity(userId: 0, id: 0, title: 'Lorem Ipsum', body: 'Dolor sit amet');
        when(mockGetPostsUseCase.getAll())
            .thenAnswer((_) async => const Success<Iterable<PostEntity>>(<PostEntity>[expectedPost]));

        await tester.pumpWidget(const App(initialRoute: PostsViewRoute()));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(Key(expectedPost.id.toString())));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        await tester.matchGolden('posts_view_navigate_to_post_details_view');
        expect(find.byType(PostsView), findsNothing);
        expect(find.byType(PostDetailsView), findsOneWidget);
      });
    });
  });
}
