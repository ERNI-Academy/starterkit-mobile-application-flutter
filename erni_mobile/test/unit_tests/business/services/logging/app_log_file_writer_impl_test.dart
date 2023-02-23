import 'package:erni_mobile/business/models/logging/app_log_event.dart';
import 'package:erni_mobile/business/models/logging/app_log_object.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/services/logging/app_log_file_writer_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectbox/objectbox.dart';

import '../../../unit_test_utils.dart';
import 'app_log_file_writer_impl_test.mocks.dart';

@GenerateMocks([
  Box<AppLogObject>,
])
void main() {
  group(AppLogFileWriterImpl, () {
    late MockBox<AppLogObject> mockAppLogObjectBox;

    setUp(() {
      mockAppLogObjectBox = MockBox<AppLogObject>();
    });

    AppLogFileWriterImpl createUnitToTest() => AppLogFileWriterImpl(mockAppLogObjectBox);

    test('write should put log to box when called', () {
      // Arrange
      final unit = createUnitToTest();
      final expectedLogEvent = AppLogEvent(
        id: 'id',
        sessionId: 'sessionId',
        level: LogLevel.error,
        message: 'message',
        createdAt: DateTime.now(),
        owner: 'owner',
      );
      when(mockAppLogObjectBox.putAsync(anyInstanceOf<AppLogObject>())).thenAnswer((_) => Future.value(1));

      // Act
      unit.write(expectedLogEvent);

      // Assert
      verify(mockAppLogObjectBox.putAsync(anyInstanceOf<AppLogObject>())).called(1);
    });
  });
}
