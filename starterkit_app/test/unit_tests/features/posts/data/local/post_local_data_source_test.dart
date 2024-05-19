import 'package:flutter_test/flutter_test.dart';
import 'package:starterkit_app/core/data/database/app_database.dart';
import 'package:starterkit_app/features/post/data/local/post_local_data_source.dart';

import '../../../../../database/in_memory_app_database.dart';

void main() {
  group(PostLocalDataSource, () {
    PostLocalDataSource createUnitToTest() {
      return PostLocalDataSource(InMemoryAppDatabase());
    }

    group('getPost', () {
      test('should return objects from database when called', () async {
        const PostDataObject expectedSavedObject = PostDataObject(
          id: 0,
          postId: 1,
          userId: 1,
          title: 'title',
          body: 'body',
        );
        final PostLocalDataSource unit = createUnitToTest();

        await unit.addOrUpdate(expectedSavedObject);
        final PostDataObject? actualSavedObject = await unit.getPost(1);

        expect(actualSavedObject?.postId, equals(expectedSavedObject.postId));
      });
    });
  });
}
