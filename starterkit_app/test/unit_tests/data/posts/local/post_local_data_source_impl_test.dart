import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mockito/annotations.dart';
import 'package:starterkit_app/core/data/database/isar_database_factory.dart';
import 'package:starterkit_app/data/posts/local/post_local_data_source.dart';
import 'package:starterkit_app/domain/posts/models/post_data_object.dart';

import 'post_local_data_source_impl_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<IsarDatabaseFactory>(),
])
void main() {
  group(PostLocalDataSourceImpl, () {
    late MockIsarDatabaseFactory mockIsarDatabaseFactory;

    setUp(() {
      mockIsarDatabaseFactory = MockIsarDatabaseFactory();
    });

    PostLocalDataSourceImpl createUnitToTest() {
      return PostLocalDataSourceImpl(mockIsarDatabaseFactory);
    }

    group('schema', () {
      test('should return PostDataObjectSchema on get', () {
        final PostLocalDataSourceImpl unit = createUnitToTest();

        final IsarGeneratedSchema actualSchema = unit.schema;

        expect(actualSchema, equals(PostDataObjectSchema));
      });
    });
  });
}
