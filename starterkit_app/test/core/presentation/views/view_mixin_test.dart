import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starterkit_app/core/service_locator.dart';

import '../view_models/test_view_model.dart';
import 'test_child_view.dart';
import 'test_view.dart';

void main() {
  group('ViewMixin', () {
    late TestViewModel viewModel;

    setUp(() {
      ServiceLocator.registerDependencies();
      viewModel = TestViewModel();
      ServiceLocator.instance.registerSingleton(viewModel);
    });

    TestView createUnitToTest(String expectedText) {
      return TestView(expectedText);
    }

    group('build', () {
      testWidgets('should build widget layout when called', (WidgetTester tester) async {
        const String expectedText = 'Test';
        final TestView unit = createUnitToTest(expectedText);

        await tester.pumpWidget(MaterialApp(home: unit));

        expect(find.byType(TestView), findsOneWidget);
        expect(find.text(expectedText), findsOneWidget);
      });
    });

    group('onCreateViewModel', () {
      testWidgets('should return create view model when called', (WidgetTester tester) async {
        final TestView unit = createUnitToTest('Test');

        await tester.pumpWidget(MaterialApp(home: unit));
        final Finder listenableBuilderFinder = find.byWidgetPredicate((Widget widget) {
          return widget is ListenableBuilder && widget.listenable == viewModel;
        });
        final Finder viewListenableBuilderFinder =
            find.ancestor(of: find.byType(TestChildView), matching: listenableBuilderFinder);
        final ListenableBuilder actualViewListenableBuilder = tester.widget(viewListenableBuilderFinder);

        expect(actualViewListenableBuilder.listenable, equals(viewModel));
      });
    });

    group('onDisposeViewModel', () {
      testWidgets('should dispose view model when called', (WidgetTester tester) async {
        final TestView unit = createUnitToTest('Test');

        await tester.pumpWidget(MaterialApp(home: unit));
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();

        expect(viewModel.isDisposed, isTrue);
      });
    });
  });
}
