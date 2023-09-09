import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starterkit_app/core/presentation/views/view_model_holder.dart';
import 'package:starterkit_app/core/service_locator.dart';

import '../view_models/test_view_model.dart';
import 'test_child_view.dart';
import 'test_view.dart';

void main() {
  group('ChildViewMixin', () {
    late TestViewModel viewModel;

    setUp(() {
      viewModel = TestViewModel();
      ServiceLocator.registerDependencies();
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

        expect(find.byType(TestChildView), findsOneWidget);
        expect(find.text(expectedText), findsOneWidget);
      });
    });

    group('onCreateViewModel', () {
      testWidgets(
        'should be called from ListenableBuilder with ViewModelHolder when built',
        (WidgetTester tester) async {
          final TestView unit = createUnitToTest('Test');

          await tester.pumpWidget(MaterialApp(home: unit));
          final Finder listenableBuilderFinder = find.byWidgetPredicate((Widget widget) {
            return widget is ListenableBuilder && widget.listenable == viewModel;
          });
          final Finder viewModelHolderFinder = find.byWidgetPredicate((Widget widget) {
            return widget is ViewModelHolder<TestViewModel> && widget.viewModel == viewModel;
          });
          final Finder childViewMixinListenableBuilderFinder =
              find.descendant(of: find.byType(TestChildView), matching: listenableBuilderFinder);
          final Finder childViewMixinViewModelHolderFinder =
              find.descendant(of: find.byType(TestChildView), matching: viewModelHolderFinder);

          expect(childViewMixinListenableBuilderFinder, findsOneWidget);
          expect(childViewMixinViewModelHolderFinder, findsOneWidget);
        },
      );
    });
  });
}
