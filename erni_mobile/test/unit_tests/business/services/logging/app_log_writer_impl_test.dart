import 'package:erni_mobile/business/models/logging/app_log_event.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/services/logging/app_log_file_writer_impl.dart';
import 'package:erni_mobile/data/database/logging/logging_database.dart';
import 'package:erni_mobile/domain/repositories/logging/app_log_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../unit_test_utils.dart';
import 'app_log_writer_impl_test.mocks.dart';

@GenerateMocks([
  AppLogRepository,
  AppLogEvent,
  AppLogEventObject,
])
void main() {
  group(AppLogFileWriterImpl, () {
    late MockAppLogRepository mockRepository;

    setUp(() {
      mockRepository = MockAppLogRepository();
    });

    AppLogFileWriterImpl createUnitToTest() => AppLogFileWriterImpl(mockRepository);

    test('write should add log to repository when called', () {
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
      when(mockRepository.add(anyInstanceOf<AppLogEventObject>())).thenAnswer((_) => Future.value(1));

      // Act
      unit.write(expectedLogEvent);

      // Assert
      verify(mockRepository.add(anyInstanceOf<AppLogEventObject>())).called(1);
    });
  });
}
