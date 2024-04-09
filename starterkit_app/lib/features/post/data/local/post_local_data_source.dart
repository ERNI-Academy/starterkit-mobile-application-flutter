import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:meta/meta.dart';
import 'package:starterkit_app/core/data/database/isar_local_data_source.dart';
import 'package:starterkit_app/core/data/database/local_data_source.dart';
import 'package:starterkit_app/features/post/domain/models/post_data_object.dart';

@lazySingleton
class PostLocalDataSource extends IsarLocalDataSource<PostDataObject> implements LocalDataSource<PostDataObject> {
  PostLocalDataSource(super._isarDatabaseFactory);

  @protected
  @override
  @visibleForTesting
  IsarGeneratedSchema get schema => PostDataObjectSchema;

  Future<PostDataObject?> getPost(int postId) async {
    final PostDataObject? object = await readWithIsar((Isar i) {
      return i.posts.where().postIdEqualTo(postId).findFirst();
    });

    return object;
  }
}
