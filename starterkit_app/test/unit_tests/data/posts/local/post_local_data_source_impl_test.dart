import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:starterkit_app/data/posts/local/post_local_data_source.dart';
import 'package:starterkit_app/domain/posts/models/post_data_object.dart';

import '../../../../database/test_isar_database_factory.dart';

void main() {
  group(PostLocalDataSourceImpl, () {
    PostLocalDataSourceImpl createUnitToTest() {
      return PostLocalDataSourceImpl(TestIsarDatabaseFactory());
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
