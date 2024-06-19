import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/features/app/presentation/view_models/app_view_model.dart';

import '../../../../../test_matchers.dart';
import 'app_view_model_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<Logger>(),
])
void main() {
  group(AppViewModel, () {
    late MockLogger mockLogger;

    setUp(() {
      mockLogger = MockLogger();
    });

    AppViewModel createUnitToTest() {
      return AppViewModel(mockLogger);
    }

    group('ctor', () {
      test('should log AppViewModel when called', () {
        createUnitToTest();

        verify(mockLogger.logFor<AppViewModel>()).called(1);
      });
    });

    group('onAppDetached', () {
      test('should log App detached when called', () async {
        final AppViewModel unit = createUnitToTest();

        await unit.onAppDetached();

        verify(mockLogger.log(LogLevel.info, anyInstanceOf<String>())).called(1);
      });
    });

    group('onAppHidden', () {
      test('should log App hidden when called', () async {
        final AppViewModel unit = createUnitToTest();

        await unit.onAppHidden();

        verify(mockLogger.log(LogLevel.info, anyInstanceOf<String>())).called(1);
      });
    });

    group('onAppInactive', () {
      test('should log App inactive when called', () async {
        final AppViewModel unit = createUnitToTest();

        await unit.onAppInactive();

        verify(mockLogger.log(LogLevel.info, anyInstanceOf<String>())).called(1);
      });
    });

    group('onAppPaused', () {
      test('should log App paused when called', () async {
        final AppViewModel unit = createUnitToTest();

        await unit.onAppPaused();

        verify(mockLogger.log(LogLevel.info, anyInstanceOf<String>())).called(1);
      });
    });

    group('onAppResumed', () {
      test('should log App resumed when called', () async {
        final AppViewModel unit = createUnitToTest();

        await unit.onAppResumed();

        verify(mockLogger.log(LogLevel.info, anyInstanceOf<String>())).called(1);
      });
    });
  });
}
