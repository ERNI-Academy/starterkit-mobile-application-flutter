import 'package:erni_mobile/business/mappers/logging/app_log_object_from_entity_mapper.dart';
import 'package:erni_mobile/business/models/logging/app_log_event_entity.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(AppLogObjectFromEntityMapperImpl, () {
    AppLogObjectFromEntityMapperImpl createUnitToTest() => AppLogObjectFromEntityMapperImpl();

    test('fromEntity should return app log event object when parameter is not null', () {
      // Arrange
      final actualLogEventEntity = AppLogEventEntity(
        id: '1',
        sessionId: '1',
        message: 'message',
        owner: 'owner',
        level: LogLevel.info,
        createdAt: DateTime.now(),
        extras: {},
      );
      final unit = createUnitToTest();

      // Act
      final actualLogEventObject = unit.fromEntity(actualLogEventEntity);

      // Assert
      expect(actualLogEventObject, isNotNull);
      expect(actualLogEventObject!.id, actualLogEventEntity.id);
      expect(actualLogEventObject.sessionId, actualLogEventEntity.sessionId);
      expect(actualLogEventObject.message, actualLogEventEntity.message);
      expect(actualLogEventObject.level, actualLogEventEntity.level);
      expect(actualLogEventObject.createdAt, actualLogEventEntity.createdAt);
      expect(actualLogEventObject.extras, actualLogEventEntity.extras);
    });

    test('fromEntity should return null when parameter is null', () {
      // Arrange
      final unit = createUnitToTest();

      // Act
      final actualLogEventObject = unit.fromEntity(null);

      // Assert
      expect(actualLogEventObject, isNull);
    });
  });
}
