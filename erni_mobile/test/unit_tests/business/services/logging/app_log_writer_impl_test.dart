import 'package:erni_mobile/business/mappers/logging/app_log_object_from_entity_mapper.dart';
import 'package:erni_mobile/business/models/logging/app_log_event_entity.dart';
import 'package:erni_mobile/business/services/logging/app_log_file_writer_impl.dart';
import 'package:erni_mobile/data/database/logging/logging_database.dart';
import 'package:erni_mobile/domain/repositories/logging/app_log_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_log_writer_impl_test.mocks.dart';

@GenerateMocks([
  AppLogObjectFromEntityMapper,
  AppLogRepository,
  AppLogEventEntity,
  AppLogObject,
])
void main() {
  group(AppLogFileWriterImpl, () {
    late MockAppLogObjectFromEntityMapper mockMapper;
    late MockAppLogRepository mockRepository;

    setUp(() {
      mockMapper = MockAppLogObjectFromEntityMapper();
      mockRepository = MockAppLogRepository();
    });

    AppLogFileWriterImpl createUnitToTest() => AppLogFileWriterImpl(mockRepository, mockMapper);

    test('write should add log to repository when called', () {
      // Arrange
      final unit = createUnitToTest();
      final expectedLogEvent = MockAppLogEventEntity();
      final expectedLogObject = MockAppLogObject();
      when(mockMapper.fromEntity(expectedLogEvent)).thenReturn(expectedLogObject);
      when(mockRepository.add(expectedLogObject)).thenAnswer((_) => Future.value(1));

      // Act
      unit.write(expectedLogEvent);

      // Assert
      verify(mockRepository.add(expectedLogObject)).called(1);
    });
  });
}
