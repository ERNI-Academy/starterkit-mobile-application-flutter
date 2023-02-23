import 'package:erni_mobile/business/models/logging/app_log_event.dart';
import 'package:erni_mobile/business/models/logging/app_log_object.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/services/logging/app_log_file_writer_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mockito/annotations.dart';

import '../../../unit_test_utils.dart';

@GenerateMocks([])
void main() {
  group(AppLogFileWriterImpl, () {
    late Isar isar;

    setUpAll(() async {
      isar = await setupIsar();
    });

    tearDownAll(() async {
      await isar.close();
    });

    AppLogFileWriterImpl createUnitToTest() => AppLogFileWriterImpl(isar);

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

      // Act
      await unit.write(expectedLogEvent);

      // Assert
      final actualLogObject = await isar.appLogObjects.where().findFirst();
      expect(actualLogObject, isNotNull);
      expect(actualLogObject!.uid, expectedLogEvent.uid);
    });
  });
}
