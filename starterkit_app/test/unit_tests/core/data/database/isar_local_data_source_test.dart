import 'package:flutter_test/flutter_test.dart';

import '../../../../database/test_isar_database_factory.dart';
import 'test_local_data_source.dart';

void main() {
  group('IsarLocalDataSource', () {
    late TestIsarDatabaseFactory testIsarDatabaseFactory;

    setUp(() {
      testIsarDatabaseFactory = TestIsarDatabaseFactory();
    });

    tearDown(() async {
      (await testIsarDatabaseFactory.getIsar(TestDataObjectSchema)).close(deleteFromDisk: true);
    });

    TestLocalDataSource createUnitToTest() {
      return TestLocalDataSource(testIsarDatabaseFactory);
    }

    group('get', () {
      test('should return object from database when called', () async {
        final TestDataObject expectedObject = TestDataObject();
        final TestLocalDataSource unit = createUnitToTest();

        await unit.addOrUpdate(expectedObject);
        final TestDataObject? actualObject = await unit.get(expectedObject.id);

        expect(actualObject?.id, equals(expectedObject.id));
      });
    });

    group('getAll', () {
      test('should return objects from database when called', () async {
        final Iterable<TestDataObject> expectedSavedObjects = <TestDataObject>[TestDataObject()];
        final TestLocalDataSource unit = createUnitToTest();

        await unit.addOrUpdateAll(expectedSavedObjects);
        final Iterable<TestDataObject> actualSavedObjects = await unit.getAll(offset: 0, limit: 1);

        expect(actualSavedObjects.firstOrNull?.id, equals(expectedSavedObjects.firstOrNull?.id));
      });
    });

    group('addOrUpdate', () {
      test('should add object to database when called', () async {
        final TestDataObject expectedObject = TestDataObject();
        final TestLocalDataSource unit = createUnitToTest();

        await unit.addOrUpdate(expectedObject);
        final TestDataObject? actualObject = await unit.get(expectedObject.id);

        expect(actualObject?.id, equals(expectedObject.id));
      });
    });

    group('addOrUpdateAll', () {
      test('should add objects to database when called', () async {
        final Iterable<TestDataObject> expectedObjectsToSave = <TestDataObject>[TestDataObject()];
        final TestLocalDataSource unit = createUnitToTest();

        await unit.addOrUpdateAll(expectedObjectsToSave);
        final Iterable<TestDataObject> actualObjectsToSave = await unit.getAll(offset: 0, limit: 1);

        expect(actualObjectsToSave.firstOrNull?.id, equals(expectedObjectsToSave.firstOrNull?.id));
      });
    });

    group('delete', () {
      test('should delete object from database when called', () async {
        final TestDataObject expectedObject = TestDataObject();
        final TestLocalDataSource unit = createUnitToTest();

        await unit.addOrUpdate(expectedObject);
        await unit.delete(expectedObject);
        final TestDataObject? actualObject = await unit.get(expectedObject.id);

        expect(actualObject, isNull);
      });
    });

    group('deleteAll', () {
      test('should delete all objects from database when called', () async {
        final List<TestDataObject> expectedObjectsToSave = <TestDataObject>[TestDataObject()];
        final TestLocalDataSource unit = createUnitToTest();

        await unit.addOrUpdateAll(expectedObjectsToSave);
        await unit.deleteAll();
        final Iterable<TestDataObject> actualObjectsToSave = await unit.getAll(offset: 0, limit: 1);

        expect(actualObjectsToSave, isEmpty);
      });
    });
  });
}
