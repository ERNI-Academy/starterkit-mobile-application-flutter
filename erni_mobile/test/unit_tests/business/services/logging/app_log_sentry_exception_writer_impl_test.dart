import 'package:erni_mobile/business/models/logging/app_log_event.dart';
import 'package:erni_mobile/business/models/logging/app_log_object.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/models/platform/app_environment.dart';
import 'package:erni_mobile/business/services/logging/app_log_sentry_exception_writer_impl.dart';
import 'package:erni_mobile/domain/services/platform/environment_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sentry/sentry.dart';

import '../../../unit_test_utils.dart';
import 'app_log_sentry_exception_writer_impl_test.mocks.dart';

@GenerateMocks([
  Box,
  Hub,
  EnvironmentConfig,
])
void main() {
  group(AppLogSentryExceptionWriterImpl, () {
    const String sessionId = '1';
    late MockBox<AppLogObject> mockAppLogObjectBox;
    late MockHub mockHub;
    late MockEnvironmentConfig mockEnvironmentConfig;

    setUp(() {
      mockAppLogObjectBox = MockBox<AppLogObject>();
      mockHub = MockHub();
      mockEnvironmentConfig = MockEnvironmentConfig();
      when(mockHub.options).thenReturn(SentryOptions());
      when(mockHub.captureEvent(anyInstanceOf<SentryEvent>())).thenAnswer((_) => Future.value(SentryId.newId()));
    });

    void setupAppLogObjectBox(List<AppLogObject> events) {
      when(mockAppLogObjectBox.values).thenAnswer((_) => events);
    }

    void setupEnvironmentConfig([AppEnvironment appEnvironment = AppEnvironment.dev]) {
      when(mockEnvironmentConfig.appEnvironment).thenReturn(appEnvironment);
    }

    AppLogSentryExceptionWriterImpl createUnitToTest() =>
        AppLogSentryExceptionWriterImpl(mockAppLogObjectBox, mockHub, mockEnvironmentConfig);

    // ignore:long-parameter-list
    AppLogEvent createLogEventEntity(
      String id,
      String message,
      String owner,
      LogLevel level, [
      Object? error,
      StackTrace? stackTrace,
      Map<String, Object> extras = const {},
    ]) {
      return AppLogEvent(
        uid: id,
        sessionId: sessionId,
        message: message,
        level: level,
        error: error,
        stackTrace: stackTrace,
        owner: owner,
        createdAt: DateTime.now(),
        extras: extras,
      );
    }

    test('write should capture event when event error is not null', () async {
      // Arrange
      final appLogEventEntityBeforeError = createLogEventEntity(
        '1',
        'log before error',
        'owner',
        LogLevel.info,
      );
      final appLogEventEntityWithError = createLogEventEntity(
        '2',
        'log with error',
        'owner',
        LogLevel.error,
        Exception(),
        StackTrace.current,
      );
      final appLogEventEntities = [appLogEventEntityBeforeError, appLogEventEntityWithError];
      final appLogEventObjects = appLogEventEntities.map(AppLogObject.fromAppLogEvent).toList();
      setupAppLogObjectBox(appLogEventObjects);
      setupEnvironmentConfig();

      final unit = createUnitToTest();

      // Act
      await unit.write(appLogEventEntityWithError);

      // Assert
      verify(mockHub.captureEvent(anyInstanceOf<SentryEvent>())).called(1);
    });

    test('write should capture event with correct values when called', () async {
      // Arrange
      final appLogEventEntityBeforeError = createLogEventEntity(
        '1',
        'log before error',
        'owner',
        LogLevel.info,
      );
      final appLogEventEntityWithError = createLogEventEntity(
        '2',
        'log with error',
        'owner',
        LogLevel.error,
        Exception(),
        StackTrace.current,
        {'key': 'value'},
      );
      final appLogEventEntities = [
        appLogEventEntityBeforeError,
        appLogEventEntityWithError,
      ];
      final appLogEventObjects = appLogEventEntities.map(AppLogObject.fromAppLogEvent).toList();
      const actualAppEnvironment = AppEnvironment.dev;
      setupAppLogObjectBox(appLogEventObjects);
      setupEnvironmentConfig();

      final unit = createUnitToTest();

      // Act
      await unit.write(appLogEventEntityWithError);

      // Assert
      final captured = verify(mockHub.captureEvent(captureAnyInstanceOf<SentryEvent>())).captured;
      final actualSentryEvent = captured.first as SentryEvent;
      expect(actualSentryEvent.message?.formatted, appLogEventEntityWithError.message);
      expect(actualSentryEvent.extra, appLogEventEntityWithError.extras);
      expect(actualSentryEvent.logger, appLogEventEntityWithError.owner);
      expect(actualSentryEvent.exceptions, isNotEmpty);
      expect(actualSentryEvent.breadcrumbs, isNotEmpty);
      expect(actualSentryEvent.environment, actualAppEnvironment.name);
    });

    test('write should not capture event when event error is null', () async {
      // Arrange
      final appLogEventEntityWithoutError = createLogEventEntity(
        '1',
        'log before error',
        'owner',
        LogLevel.info,
      );
      setupEnvironmentConfig();

      final unit = createUnitToTest();

      // Act
      await unit.write(appLogEventEntityWithoutError);

      // Assert
      verifyNever(mockHub.captureEvent(anyInstanceOf<SentryEvent>()));
    });
  });
}
