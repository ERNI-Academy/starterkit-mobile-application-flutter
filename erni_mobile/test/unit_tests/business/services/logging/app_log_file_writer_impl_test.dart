import 'package:erni_mobile/business/models/logging/app_log_event.dart';
import 'package:erni_mobile/business/models/logging/app_log_object.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/services/logging/app_log_file_writer_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../unit_test_utils.dart';
import 'app_log_sentry_exception_writer_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<Box>(),
])
void main() {
  group(AppLogFileWriterImpl, () {
    late MockBox<AppLogObject> mockAppLogObjectBox;

    setUp(() {
      mockAppLogObjectBox = MockBox<AppLogObject>();
    });

    AppLogFileWriterImpl createUnitToTest() => AppLogFileWriterImpl(mockAppLogObjectBox);

    test('write should put log to box when called', () async {
      // Arrange
      final unit = createUnitToTest();
      final expectedLogEvent = AppLogEvent(
        uid: 'id',
        sessionId: 'sessionId',
        level: LogLevel.error,
        message: 'message',
        createdAt: DateTime.now(),
        owner: 'owner',
      );
      when(mockAppLogObjectBox.add(anyInstanceOf<AppLogObject>())).thenAnswer((_) => Future.value(1));

      // Act
      await unit.write(expectedLogEvent);

      // Assert
      verify(mockAppLogObjectBox.add(anyInstanceOf<AppLogObject>()));
    });
  });
}
