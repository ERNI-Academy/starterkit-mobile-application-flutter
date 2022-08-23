import 'package:erni_mobile/business/models/logging/app_log_event_entity.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/services/logging/app_logger_impl.dart';
import 'package:erni_mobile/domain/services/logging/app_log_formatter.dart';
import 'package:erni_mobile/domain/services/logging/app_log_writer.dart';
import 'package:erni_mobile/domain/services/platform/date_time_service.dart';
import 'package:erni_mobile/domain/services/platform/environment_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../unit_test_utils.dart';
import 'app_logger_impl_test.mocks.dart';

@GenerateMocks([
  AppLogFormatter,
  AppLogWriter,
  DateTimeService,
  EnvironmentConfig,
])
void main() {
  group(AppLoggerImpl, () {
    late MockAppLogFormatter mockAppLogFormatter;
    late MockAppLogWriter mockAppLogWriter;
    late MockDateTimeService mockDateTimeService;
    late MockEnvironmentConfig mockEnvironmentConfig;

    setUp(() {
      mockAppLogFormatter = MockAppLogFormatter();
      mockAppLogWriter = MockAppLogWriter();
      mockDateTimeService = MockDateTimeService();
      mockEnvironmentConfig = MockEnvironmentConfig();
    });

    AppLoggerImpl createUnitToTest() {
      return AppLoggerImpl(
        mockAppLogFormatter,
        [mockAppLogWriter],
        mockDateTimeService,
        mockEnvironmentConfig,
      );
    }

    void setupEnvironmentConfig(LogLevel minLogLevel, [String? sessionId]) {
      when(mockEnvironmentConfig.sessionId).thenReturn(sessionId ?? '');
      when(mockEnvironmentConfig.minLogLevel).thenReturn(minLogLevel);
    }

    void setupLogger({
      String expectedFormattedMessage = 'formatted test message',
      DateTime? expectedDateTime,
    }) {
      when(
        mockAppLogFormatter.format(
          anyInstanceOf<LogLevel?>(),
          anyInstanceOf<String?>(),
          anyInstanceOf<Object?>(),
          anyInstanceOf<StackTrace?>(),
        ),
      ).thenReturn(expectedFormattedMessage);
      when(mockDateTimeService.utcNow()).thenReturn(expectedDateTime ?? DateTime.now().toUtc());
    }

    List<AppLogEventEntity> getCapturedLogEvents() {
      return verify(
        mockAppLogWriter.write(captureAnyInstanceOf<AppLogEventEntity>()),
      ).captured.cast<AppLogEventEntity>();
    }

    test('logFor should describe identity of owner when called', () {
      // Arrange
      final expectedOwner = Object();
      final expectedDescribedIdentity = describeIdentity(expectedOwner);
      final unit = createUnitToTest();
      setupEnvironmentConfig(LogLevel.info);
      setupLogger();

      // Act
      unit.logFor(expectedOwner);
      unit.log(LogLevel.info, 'test message');

      // Assert
      final actualLogEvent = getCapturedLogEvents().first;
      expect(actualLogEvent.owner, expectedDescribedIdentity);
    });

    test('logForNamed should set the same value for owner when called', () {
      // Arrange
      const expectedOwnerName = 'owner';
      final unit = createUnitToTest();
      setupEnvironmentConfig(LogLevel.info);
      setupLogger();

      // Act
      unit.logForNamed(expectedOwnerName);
      unit.log(LogLevel.info, 'test message');

      // Assert
      final actualLogEvent = getCapturedLogEvents().first;
      expect(actualLogEvent.owner, expectedOwnerName);
    });

    test('log should write logEvent when called', () {
      // Arrange
      final unit = createUnitToTest();
      setupEnvironmentConfig(LogLevel.info);
      setupLogger();

      // Act
      unit.log(LogLevel.info, 'test message');

      // Assert
      verify(mockAppLogWriter.write(anyInstanceOf<AppLogEventEntity>())).called(1);
    });

    test('log should not write logEvent when environmentConfig logLevel is less than logEvent logLevel', () {
      // Arrange
      final unit = createUnitToTest();
      setupEnvironmentConfig(LogLevel.info);

      // Act
      unit.log(LogLevel.debug, 'test message');

      // Assert
      verifyNever(mockAppLogWriter.write(anyInstanceOf<AppLogEventEntity>()));
    });

    test('log should write correct logEvent properties when called', () {
      // Arrange
      const expectedLogLevel = LogLevel.info;
      const expectedSessionId = 'abc123';
      const expectedFormattedMessage = 'some test message';
      final expectedDateTime = DateTime.now();
      final expectedError = Error();
      final expectedStackTrace = StackTrace.current;
      final unit = createUnitToTest();
      setupEnvironmentConfig(LogLevel.info, expectedSessionId);
      setupLogger(expectedFormattedMessage: expectedFormattedMessage, expectedDateTime: expectedDateTime);

      // Act
      unit.log(expectedLogLevel, 'test message', expectedError, expectedStackTrace);

      // Assert
      final actualLogEvent = getCapturedLogEvents().first;
      expect(actualLogEvent.level, expectedLogLevel);
      expect(actualLogEvent.sessionId, expectedSessionId);
      expect(actualLogEvent.message, expectedFormattedMessage);
      expect(actualLogEvent.createdAt, expectedDateTime);
      expect(actualLogEvent.error, expectedError);
      expect(actualLogEvent.stackTrace, expectedStackTrace);
    });
  });
}
