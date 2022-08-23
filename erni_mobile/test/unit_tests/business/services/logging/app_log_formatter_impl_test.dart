import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/services/logging/app_log_formatter_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(AppLogFormatterImpl, () {
    AppLogFormatterImpl createUnitToTest() => AppLogFormatterImpl();

    test(
      'format should return correct message format when logLevel is not error, exception and stack trace is null',
      () {
        // Arrange
        const expectedLogLevel = LogLevel.info;
        const expectedMessage = 'message';
        final tag = '[${expectedLogLevel.name.toUpperCase()}]';
        final expectedFormattedMessage = '$tag $expectedMessage';
        final unit = createUnitToTest();

        // Act
        final actualFormattedMessage = unit.format(expectedLogLevel, expectedMessage, null, null);

        // Assert
        expect(actualFormattedMessage, expectedFormattedMessage);
      },
    );

    test(
      'format should return correct message format when logLevel is error, exception and stack trace is not null',
      () {
        // Arrange
        const expectedLogLevel = LogLevel.error;
        const expectedMessage = 'error';
        final expectedError = Error();
        final expectedStackTrace = StackTrace.current;
        final tag = '[${expectedLogLevel.name.toUpperCase()}]';
        final expectedFormattedMessage =
            '$tag $expectedMessage\r\n${expectedError.runtimeType} $expectedError\r\n$expectedStackTrace';
        final unit = createUnitToTest();

        // Act
        final actualFormattedMessage =
            unit.format(expectedLogLevel, expectedMessage, expectedError, expectedStackTrace);

        // Assert
        expect(actualFormattedMessage, expectedFormattedMessage);
      },
    );
  });
}
