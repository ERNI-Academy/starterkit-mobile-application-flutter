import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/data/database/isar_database_factory.dart';

import '../../../unit_test_utils.dart';
import 'isar_local_data_source_test.mocks.dart';
import 'test_local_data_source.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<IsarDatabaseFactory>(),
  MockSpec<Isar>(),
  MockSpec<IsarCollection<int, TestDataObject>>(),
  MockSpec<IsarQuery<TestDataObject>>(),
])
void main() {
  group('IsarLocalDataSource', () {
    late MockIsarDatabaseFactory mockIsarDatabaseFactory;
    late MockIsar mockIsar;
    late MockIsarCollection mockIsarCollection;

    setUp(() {
      mockIsarDatabaseFactory = MockIsarDatabaseFactory();
      mockIsar = MockIsar();
      mockIsarCollection = MockIsarCollection();
      when(unawaited(mockIsarDatabaseFactory.getIsar(any))).thenAnswer((_) => Future<Isar>.value(mockIsar));
      when(mockIsar.collection<int, TestDataObject>()).thenReturn(mockIsarCollection);
    });

    TestLocalDataSource createUnitToTest() {
      return TestLocalDataSource(mockIsarDatabaseFactory);
    }

    group('get', () {
      test('should return object from database when called', () async {
        const TestDataObject expectedObject = TestDataObject(1);
        when(mockIsar.read<TestDataObject?>(anyInstanceOf<_IsarCallback>())).thenAnswer((Invocation i) {
          final _IsarResultCallback<TestDataObject?> callback =
              i.positionalArguments.elementAtOrNull(0) as _IsarResultCallback<TestDataObject?>;

          return callback(mockIsar);
        });
        when(mockIsarCollection.get(expectedObject.id)).thenAnswer((_) => expectedObject);
        final TestLocalDataSource unit = createUnitToTest();

        final TestDataObject? actualObject = await unit.get(1);

        verify(mockIsarCollection.get(expectedObject.id)).called(1);
        expect(actualObject?.id, equals(expectedObject.id));
      });
    });

    group('getAll', () {
      test('should return objects from database when called', () async {
        final Iterable<TestDataObject> expectedSavedObjects = <TestDataObject>[const TestDataObject(1)];
        when(
          mockIsar.read<Iterable<TestDataObject>>(anyInstanceOf<_IsarResultCallback<Iterable<TestDataObject>>>()),
        ).thenAnswer((Invocation i) {
          final _IsarResultCallback<Iterable<TestDataObject>> callback =
              i.positionalArguments.elementAtOrNull(0) as _IsarResultCallback<Iterable<TestDataObject>>;

          return callback(mockIsar);
        });
        final MockIsarQuery mockIsarQuery = MockIsarQuery();
        final _MockQueryBuilder mockQueryBuilder = _MockQueryBuilder(collection: mockIsarCollection);
        when(mockIsarCollection.buildQuery<TestDataObject>(
          filter: anyNamed('filter'),
          sortBy: anyNamed('sortBy'),
          distinctBy: anyNamed('distinctBy'),
          properties: anyNamed('properties'),
        )).thenReturn(mockIsarQuery);
        when(mockIsarCollection.where()).thenReturn(mockQueryBuilder);
        when(mockIsarQuery.findAll(offset: anyNamed('offset'), limit: anyNamed('limit')))
            .thenReturn(expectedSavedObjects.toList());
        final TestLocalDataSource unit = createUnitToTest();

        final Iterable<TestDataObject> actualSavedObjects = await unit.getAll();

        verify(mockIsarQuery.findAll(offset: anyNamed('offset'), limit: anyNamed('limit'))).called(1);
        expect(actualSavedObjects.firstOrNull?.id, equals(expectedSavedObjects.firstOrNull?.id));
      });
    });

    group('addOrUpdate', () {
      test('should add object to database when called', () async {
        const TestDataObject expectedObject = TestDataObject(1);
        when(mockIsar.write<void>(anyInstanceOf<_IsarCallback>())).thenAnswer((Invocation i) {
          final _IsarCallback callback = i.positionalArguments.elementAtOrNull(0) as _IsarCallback;
          callback(mockIsar);
        });
        final TestLocalDataSource unit = createUnitToTest();

        await unit.addOrUpdate(expectedObject);

        final VerificationResult putVerificationResult =
            verify(mockIsarCollection.put(captureAnyInstanceOf<TestDataObject>()));
        final TestDataObject actualObject = putVerificationResult.captured.firstOrNull as TestDataObject;
        putVerificationResult.called(1);
        expect(actualObject.id, equals(expectedObject.id));
      });
    });

    group('addOrUpdateAll', () {
      test('should add objects to database when called', () async {
        final Iterable<TestDataObject> expectedObjectsToSave = <TestDataObject>[const TestDataObject(1)];
        when(mockIsar.write<void>(anyInstanceOf<_IsarCallback>())).thenAnswer((Invocation i) {
          final _IsarCallback callback = i.positionalArguments.elementAtOrNull(0) as _IsarCallback;
          callback(mockIsar);
        });
        final TestLocalDataSource unit = createUnitToTest();

        await unit.addOrUpdateAll(expectedObjectsToSave);

        final VerificationResult putAllVerificationResult =
            verify(mockIsarCollection.putAll(captureAnyInstanceOf<Iterable<TestDataObject>>()));
        final List<TestDataObject> actualObject =
            (putAllVerificationResult.captured.firstOrNull as List<Object>).cast<TestDataObject>();
        putAllVerificationResult.called(1);
        expect(actualObject.firstOrNull?.id, equals(expectedObjectsToSave.firstOrNull?.id));
      });
    });

    group('delete', () {
      test('should delete object from database when called', () async {
        const TestDataObject expectedObject = TestDataObject(1);
        when(mockIsar.write<void>(anyInstanceOf<_IsarCallback>())).thenAnswer((Invocation i) {
          final _IsarCallback callback = i.positionalArguments.elementAtOrNull(0) as _IsarCallback;
          callback(mockIsar);
        });
        final TestLocalDataSource unit = createUnitToTest();

        await unit.delete(expectedObject);

        verify(mockIsarCollection.delete(expectedObject.id)).called(1);
      });
    });

    group('deleteAll', () {
      test('should delete all objects from database when called', () async {
        when(mockIsar.write<void>(anyInstanceOf<_IsarCallback>())).thenAnswer((Invocation i) {
          final _IsarCallback callback = i.positionalArguments.elementAtOrNull(0) as _IsarCallback;
          callback(mockIsar);
        });
        final TestLocalDataSource unit = createUnitToTest();

        await unit.deleteAll();

        verify(mockIsarCollection.clear()).called(1);
      });
    });
  });
}

typedef _IsarCallback = void Function(Isar isar);
typedef _IsarResultCallback<T> = T Function(Isar isar);

class _MockQueryBuilder extends QueryBuilder<TestDataObject, TestDataObject, QStart> {
  _MockQueryBuilder({required MockIsarCollection collection}) : super(collection);
}
