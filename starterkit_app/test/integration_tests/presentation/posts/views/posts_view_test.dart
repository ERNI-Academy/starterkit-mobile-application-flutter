// ignore_for_file: prefer-moving-to-variable

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';
import 'package:starterkit_app/core/data/database/isar_database_factory.dart';
import 'package:starterkit_app/core/domain/models/result.dart';
import 'package:starterkit_app/core/infrastructure/platform/connectivity_service.dart';
import 'package:starterkit_app/core/presentation/navigation/root_auto_router.gr.dart';
import 'package:starterkit_app/core/service_locator.dart';
import 'package:starterkit_app/data/posts/remote/post_api.dart';
import 'package:starterkit_app/domain/posts/models/post_data_contract.dart';
import 'package:starterkit_app/domain/posts/models/post_entity.dart';
import 'package:starterkit_app/presentation/app/views/app.dart';
import 'package:starterkit_app/presentation/posts/views/post_details_view.dart';
import 'package:starterkit_app/presentation/posts/views/posts_view.dart';

import '../../../../test_utils.dart';
import '../../../../widget_test_utils.dart';
import '../../../core/data/database/test_isar_database_factory.dart';
import 'posts_view_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<PostApi>(),
  MockSpec<ConnectivityService>(),
])
void main() {
  group(PostsView, () {
    late Il8n il8n;
    late MockPostApi mockPostApi;
    late MockConnectivityService mockConnectivityService;

    setUp(() async {
      await setupWidgetTest();
      mockPostApi = MockPostApi();
      mockConnectivityService = MockConnectivityService();

      il8n = await setupLocale();

      ServiceLocator.instance.registerLazySingleton<IsarDatabaseFactory>(TestIsarDatabaseFactory.new);
      ServiceLocator.instance.registerLazySingleton<PostApi>(() => mockPostApi);
      ServiceLocator.instance.registerLazySingleton<ConnectivityService>(() => mockConnectivityService);
      provideDummy<Result<Iterable<PostEntity>>>(Failure<Iterable<PostEntity>>(Exception()));
      provideDummy<Result<PostEntity>>(Failure<PostEntity>(Exception()));
    });

    group('AppBar', () {
      testGoldens('should show correct title when shown', (WidgetTester tester) async {
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
        when(mockPostApi.getPosts()).thenAnswer((_) async => const <PostDataContract>[]);

        await tester.pumpWidget(const App(initialRoute: PostsViewRoute()));
        await tester.pumpAndSettle();

        await tester.matchGolden('posts_view_app_bar_title');
        expect(find.text(il8n.posts), findsOneWidget);
      });
    });

    group('ListView', () {
      testGoldens('should show posts when loaded', (WidgetTester tester) async {
        const PostDataContract expectedPost = PostDataContract(
          userId: 0,
          id: 0,
          title: 'Lorem Ipsum',
          body: 'Dolor sit amet',
        );
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
        when(mockPostApi.getPosts()).thenAnswer((_) async => const <PostDataContract>[expectedPost]);

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
        const PostDataContract expectedPost = PostDataContract(
          userId: 0,
          id: 0,
          title: 'Lorem Ipsum',
          body: 'Dolor sit amet',
        );
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
        when(mockPostApi.getPosts()).thenAnswer((_) async => const <PostDataContract>[expectedPost]);
        when(mockPostApi.getPost(expectedPost.id)).thenAnswer((_) async => expectedPost);

        await tester.pumpWidget(const App(initialRoute: PostsViewRoute()));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(Key(expectedPost.id.toString())));
        await tester.pumpAndSettle();

        await tester.matchGolden('posts_view_navigate_to_post_details_view');
        expect(find.byType(PostsView), findsNothing);
        expect(find.byType(PostDetailsView), findsOneWidget);
        expect(find.text(expectedPost.title), findsOneWidget);
        expect(find.text(expectedPost.body), findsOneWidget);
      });
    });
  });
}
