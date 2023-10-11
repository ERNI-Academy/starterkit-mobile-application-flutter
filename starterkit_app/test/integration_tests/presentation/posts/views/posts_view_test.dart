import 'dart:convert';

import 'package:dio/dio.dart';
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
import 'package:starterkit_app/domain/posts/models/post_entity.dart';
import 'package:starterkit_app/presentation/app/views/app.dart';
import 'package:starterkit_app/presentation/posts/views/post_details_view.dart';
import 'package:starterkit_app/presentation/posts/views/posts_view.dart';

import '../../../../database/test_isar_database_factory.dart';
import '../../../../test_utils.dart';
import '../../../../widget_test_utils.dart';
import 'posts_view_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<ConnectivityService>(),
  MockSpec<Dio>(),
])
void main() {
  group(PostsView, () {
    late Il8n il8n;
    late MockConnectivityService mockConnectivityService;
    late MockDio mockDio;

    setUp(() async {
      await setUpWidgetTest();
      mockConnectivityService = MockConnectivityService();
      mockDio = MockDio();
      il8n = await setupLocale();

      ServiceLocator.instance.registerLazySingleton<IsarDatabaseFactory>(TestIsarDatabaseFactory.new);
      ServiceLocator.instance.registerLazySingleton<PostApi>(() => PostApi(mockDio));
      ServiceLocator.instance.registerLazySingleton<ConnectivityService>(() => mockConnectivityService);
      provideDummy<Result<Iterable<PostEntity>>>(Failure<Iterable<PostEntity>>(Exception()));
      provideDummy<Result<PostEntity>>(Failure<PostEntity>(Exception()));
    });

    void setUpApi<TResponse>({
      required Matcher expectedPath,
      required Matcher expectedMethod,
      required String expectedResponseFile,
      VoidCallback? onAnswer,
    }) {
      final String expectedPostsJsonString = readFileAsString(expectedResponseFile);
      // these values are not used for testing, but are required by Dio
      when(mockDio.options).thenReturn(BaseOptions(method: 'GET', baseUrl: 'https://www.example.com'));
      // False positive
      // ignore: discarded_futures
      when(mockDio.fetch<TResponse>(
        argThat(
          isA<RequestOptions>()
              .having((RequestOptions r) => r.path, 'path', expectedPath)
              .having((RequestOptions r) => r.method, 'method', expectedMethod),
        ),
      )).thenAnswer((_) async {
        onAnswer?.call();

        return Response<TResponse>(
          data: jsonDecode(expectedPostsJsonString) as TResponse,
          requestOptions: RequestOptions(),
        );
      });
    }

    group('AppBar', () {
      testGoldens('should show correct title when shown', (WidgetTester tester) async {
        setUpApi<List<dynamic>>(
          expectedPath: endsWith('/posts'),
          expectedMethod: matches('GET'),
          expectedResponseFile: 'posts.json',
        );
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);

        await tester.pumpWidget(const App(initialRoute: PostsViewRoute()));
        await tester.pumpAndSettle();

        await tester.matchGolden('posts_view_app_bar_title');
        expect(find.text(il8n.posts), findsOneWidget);
      });
    });

    group('ListView', () {
      testGoldens('should show posts when loaded', (WidgetTester tester) async {
        setUpApi<List<dynamic>>(
          expectedPath: endsWith('/posts'),
          expectedMethod: matches('GET'),
          expectedResponseFile: 'posts.json',
        );
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);

        await tester.pumpWidget(const App(initialRoute: PostsViewRoute()));
        await tester.pumpAndSettle();

        await tester.matchGolden('posts_view_loaded');
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(ListTile), findsAtLeastNWidgets(1));
      });
    });

    group('ListTile', () {
      testGoldens('should navigate to post details when post tapped', (WidgetTester tester) async {
        setUpApi<List<dynamic>>(
          expectedPath: endsWith('/posts'),
          expectedMethod: matches('GET'),
          expectedResponseFile: 'posts.json',
          onAnswer: () {
            reset(mockDio);
            setUpApi<Map<String, dynamic>>(
              expectedPath: contains('/posts/'),
              expectedMethod: matches('GET'),
              expectedResponseFile: 'post.json',
            );
          },
        );
        when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);

        await tester.pumpWidget(const App(initialRoute: PostsViewRoute()));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ListTile));
        await tester.pumpAndSettle();

        await tester.matchGolden('posts_view_navigate_to_post_details_view');
        expect(find.byType(PostsView), findsNothing);
        expect(find.byType(PostDetailsView), findsOneWidget);
      });
    });
  });
}
