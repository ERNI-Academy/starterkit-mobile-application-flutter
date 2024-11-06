// ignore_for_file: unreachable_from_main

import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starterkit_app/core/data/database/base_repository.dart';
import 'package:starterkit_app/core/domain/models/data_table.dart';

part 'base_repository_test.g.dart';

@DriftDatabase(tables: <Type>[_TestDataTableWithIntId, _TestDataTableWithStringId])
class _TestDatabase extends _$_TestDatabase {
  _TestDatabase() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
}

@DataClassName('TestDataObjectWithIntId')
class _TestDataTableWithIntId extends DataTable {
  @override
  IntColumn get id => integer().withDefault(const Constant<int>(0))();
}

@DataClassName('TestDataObjectWithStringId')
class _TestDataTableWithStringId extends DataTable {
  @override
  TextColumn get id => text().withDefault(const Constant<String>(''))();
}

class _TestWithIntIdRepository extends BaseRepository<_TestDatabase, _TestDataTableWithIntId, TestDataObjectWithIntId> {
  _TestWithIntIdRepository(super.attachedDatabase);
}

class _TestWithStringIdRepository
    extends BaseRepository<_TestDatabase, _TestDataTableWithStringId, TestDataObjectWithStringId> {
  _TestWithStringIdRepository(super.attachedDatabase);
}

void main() {
  group('BaseRepository with int ID', () {
    late _TestDatabase database;

    setUp(() {
      driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
      database = _TestDatabase();
    });

    _TestWithIntIdRepository createUnitToTest() {
      return _TestWithIntIdRepository(database);
    }

    group('get', () {
      test('should return object from database when called', () async {
        const TestDataObjectWithIntId expectedObject = TestDataObjectWithIntId(id: 1);
        final _TestWithIntIdRepository unit = createUnitToTest();

        await unit.addOrUpdate(expectedObject);
        final TestDataObjectWithIntId? actualObject = await unit.get(expectedObject.id);

        expect(actualObject?.id, equals(expectedObject.id));
      });
    });

    group('getAll', () {
      test('should return objects from database when called', () async {
        final Iterable<TestDataObjectWithIntId> expectedSavedObjects = <TestDataObjectWithIntId>[
          const TestDataObjectWithIntId(id: 1)
        ];
        final _TestWithIntIdRepository unit = createUnitToTest();

        await unit.addOrUpdateAll(expectedSavedObjects);
        final Iterable<TestDataObjectWithIntId> actualSavedObjects = await unit.getAll();

        expect(actualSavedObjects.firstOrNull?.id, equals(expectedSavedObjects.firstOrNull?.id));
      });
    });

    group('addOrUpdate', () {
      test('should add object to database when called', () async {
        const TestDataObjectWithIntId expectedObject = TestDataObjectWithIntId(id: 1);
        final _TestWithIntIdRepository unit = createUnitToTest();

        await unit.addOrUpdate(expectedObject);
        final TestDataObjectWithIntId? actualObject = await unit.get(expectedObject.id);

        expect(actualObject?.id, equals(expectedObject.id));
      });
    });

    group('addOrUpdateAll', () {
      test('should add objects to database when called', () async {
        final Iterable<TestDataObjectWithIntId> expectedObjectsToSave = <TestDataObjectWithIntId>[
          const TestDataObjectWithIntId(id: 1)
        ];
        final _TestWithIntIdRepository unit = createUnitToTest();

        await unit.addOrUpdateAll(expectedObjectsToSave);
        final Iterable<TestDataObjectWithIntId> actualObjectsToSave = await unit.getAll();

        expect(actualObjectsToSave.firstOrNull?.id, equals(expectedObjectsToSave.firstOrNull?.id));
      });
    });

    group('delete', () {
      test('should delete object from database when called', () async {
        const TestDataObjectWithIntId expectedObject = TestDataObjectWithIntId(id: 1);
        final _TestWithIntIdRepository unit = createUnitToTest();

        await unit.addOrUpdate(expectedObject);
        await unit.remove(expectedObject.id);
        final TestDataObjectWithIntId? actualObject = await unit.get(expectedObject.id);

        expect(actualObject, isNull);
      });
    });

    group('deleteAll', () {
      test('should delete all objects from database when called', () async {
        final List<TestDataObjectWithIntId> expectedObjectsToSave = <TestDataObjectWithIntId>[
          const TestDataObjectWithIntId(id: 1)
        ];
        final _TestWithIntIdRepository unit = createUnitToTest();

        await unit.addOrUpdateAll(expectedObjectsToSave);
        final Iterable<TestDataObjectWithIntId> actualSavedObjects = await unit.getAll();
        final List<int> actualSavedObjectIds =
            actualSavedObjects.map((TestDataObjectWithIntId object) => object.id).toList();
        await unit.removeAll(actualSavedObjectIds);
        final Iterable<TestDataObjectWithIntId> actualObjectsToSave = await unit.getAll();

        expect(actualObjectsToSave, isEmpty);
      });
    });
  });

  group('BaseRepository with string ID', () {
    late _TestDatabase database;

    setUp(() {
      driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
      database = _TestDatabase();
    });

    _TestWithStringIdRepository createUnitToTest() {
      return _TestWithStringIdRepository(database);
    }

    group('deleteAll', () {
      test('should delete all objects from database when called', () async {
        final List<TestDataObjectWithStringId> expectedObjectsToSave = <TestDataObjectWithStringId>[
          const TestDataObjectWithStringId(id: 'abc')
        ];
        final _TestWithStringIdRepository unit = createUnitToTest();

        await unit.addOrUpdateAll(expectedObjectsToSave);
        final Iterable<TestDataObjectWithStringId> actualSavedObjects = await unit.getAll();
        final List<String> actualSavedObjectIds =
            actualSavedObjects.map((TestDataObjectWithStringId object) => object.id).toList();
        await unit.removeAll(actualSavedObjectIds);
        final Iterable<TestDataObjectWithStringId> actualObjectsToSave = await unit.getAll();

        expect(actualObjectsToSave, isEmpty);
      });
    });
  });
}
