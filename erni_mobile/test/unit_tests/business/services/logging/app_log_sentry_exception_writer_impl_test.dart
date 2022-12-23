import 'package:erni_mobile/business/models/logging/app_log_event.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/models/platform/app_environment.dart';
import 'package:erni_mobile/business/services/logging/app_log_sentry_exception_writer_impl.dart';
import 'package:erni_mobile/data/database/logging/logging_database.dart';
import 'package:erni_mobile/domain/repositories/logging/app_log_repository.dart';
import 'package:erni_mobile/domain/services/platform/environment_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sentry/sentry.dart';

import '../../../unit_test_utils.dart';
import 'app_log_sentry_exception_writer_impl_test.mocks.dart';

@GenerateMocks([
  AppLogRepository,
  Hub,
  EnvironmentConfig,
])
void main() {
  group(AppLogSentryExceptionWriterImpl, () {
    const String sessionId = '1';
    late MockAppLogRepository mockAppLogRepository;
    late MockHub mockHub;
    late MockEnvironmentConfig mockEnvironmentConfig;

    setUp(() {
      mockAppLogRepository = MockAppLogRepository();
      mockHub = MockHub();
      mockEnvironmentConfig = MockEnvironmentConfig();
      when(mockHub.options).thenReturn(SentryOptions());
      when(mockHub.captureEvent(anyInstanceOf<SentryEvent>())).thenAnswer((_) => Future.value(SentryId.newId()));
    });

    void setupAppLogRepository(List<AppLogEventObject> events) {
      when(mockAppLogRepository.selectAll()).thenAnswer((_) async => events);
    }

    void setupEnvironmentConfig([AppEnvironment appEnvironment = AppEnvironment.dev]) {
      when(mockEnvironmentConfig.appEnvironment).thenReturn(appEnvironment);
    }

    AppLogSentryExceptionWriterImpl createUnitToTest() =>
        AppLogSentryExceptionWriterImpl(mockAppLogRepository, mockHub, mockEnvironmentConfig);

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
        id: id,
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

    AppLogEventObject fromEntity(AppLogEvent entity) {
      return AppLogEventObject(
        id: entity.id,
        sessionId: entity.sessionId,
        message: entity.message,
        level: entity.level,
        extras: entity.extras,
        createdAt: entity.createdAt,
        owner: entity.owner,
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
      final appLogEventObjects = appLogEventEntities.map(fromEntity).toList();
      setupAppLogRepository(appLogEventObjects);
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
      final appLogEventObjects = appLogEventEntities.map(fromEntity).toList();
      const actualAppEnvironment = AppEnvironment.dev;
      setupAppLogRepository(appLogEventObjects);
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
