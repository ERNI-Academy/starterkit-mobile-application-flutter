import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:starterkit_app/features/post/data/local/post_local_data_source.dart';
import 'package:starterkit_app/features/post/domain/models/post_data_object.dart';

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

    group('getPost', () {
      test('should return objects from database when called', () async {
        final PostDataObject expectedSavedObject = PostDataObject(postId: 1, userId: 1, title: 'title', body: 'body');
        final PostLocalDataSourceImpl unit = createUnitToTest();

        await unit.addOrUpdate(expectedSavedObject);
        final PostDataObject? actualSavedObject = await unit.getPost(1);

        expect(actualSavedObject?.postId, equals(expectedSavedObject.postId));
      });
    });
  });
}
