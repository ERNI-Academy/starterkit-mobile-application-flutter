// ignore_for_file: unreachable_from_main

import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starterkit_app/core/data/database/base_repository.dart';
import 'package:starterkit_app/core/domain/models/data_table.dart';

part 'base_repository_test.g.dart';

@DriftDatabase(tables: <Type>[_TestDataTable])
class _TestDatabase extends _$_TestDatabase {
  _TestDatabase() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
}

@DataClassName('TestDataObject')
class _TestDataTable extends DataTable {}

class _TestRepository extends BaseRepository<_TestDatabase, _TestDataTable, TestDataObject> {
  _TestRepository(super.attachedDatabase);
}

void main() {
  group(BaseRepository, () {
    late _TestDatabase database;

    setUp(() {
      driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
      database = _TestDatabase();
    });

    _TestRepository createUnitToTest() {
      return _TestRepository(database);
    }

    group('get', () {
      test('should return object from database when called', () async {
        const TestDataObject expectedObject = TestDataObject(id: 1);
        final _TestRepository unit = createUnitToTest();

        await unit.addOrUpdate(expectedObject);
        final TestDataObject? actualObject = await unit.get(expectedObject.id);

        expect(actualObject?.id, equals(expectedObject.id));
      });
    });

    group('getAll', () {
      test('should return objects from database when called', () async {
        final Iterable<TestDataObject> expectedSavedObjects = <TestDataObject>[const TestDataObject(id: 1)];
        final _TestRepository unit = createUnitToTest();

        await unit.addOrUpdateAll(expectedSavedObjects);
        final Iterable<TestDataObject> actualSavedObjects = await unit.getAll();

        expect(actualSavedObjects.firstOrNull?.id, equals(expectedSavedObjects.firstOrNull?.id));
      });
    });

    group('addOrUpdate', () {
      test('should add object to database when called', () async {
        const TestDataObject expectedObject = TestDataObject(id: 1);
        final _TestRepository unit = createUnitToTest();

        await unit.addOrUpdate(expectedObject);
        final TestDataObject? actualObject = await unit.get(expectedObject.id);

        expect(actualObject?.id, equals(expectedObject.id));
      });
    });

    group('addOrUpdateAll', () {
      test('should add objects to database when called', () async {
        final Iterable<TestDataObject> expectedObjectsToSave = <TestDataObject>[const TestDataObject(id: 1)];
        final _TestRepository unit = createUnitToTest();

        await unit.addOrUpdateAll(expectedObjectsToSave);
        final Iterable<TestDataObject> actualObjectsToSave = await unit.getAll();

        expect(actualObjectsToSave.firstOrNull?.id, equals(expectedObjectsToSave.firstOrNull?.id));
      });
    });

    group('delete', () {
      test('should delete object from database when called', () async {
        const TestDataObject expectedObject = TestDataObject(id: 1);
        final _TestRepository unit = createUnitToTest();

        await unit.addOrUpdate(expectedObject);
        await unit.remove(expectedObject);
        final TestDataObject? actualObject = await unit.get(expectedObject.id);

        expect(actualObject, isNull);
      });
    });

    group('deleteAll', () {
      test('should delete all objects from database when called', () async {
        final List<TestDataObject> expectedObjectsToSave = <TestDataObject>[const TestDataObject(id: 1)];
        final _TestRepository unit = createUnitToTest();

        await unit.addOrUpdateAll(expectedObjectsToSave);
        final Iterable<TestDataObject> actualSavedObjects = await unit.getAll();
        final List<int> actualSavedObjectIds = actualSavedObjects.map((TestDataObject object) => object.id).toList();
        await unit.removeAll(actualSavedObjectIds);
        final Iterable<TestDataObject> actualObjectsToSave = await unit.getAll();

        expect(actualObjectsToSave, isEmpty);
      });
    });
  });
}
