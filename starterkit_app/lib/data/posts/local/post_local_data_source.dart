import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:meta/meta.dart';
import 'package:starterkit_app/core/data/database/isar_local_data_source.dart';
import 'package:starterkit_app/core/data/database/local_data_source.dart';
import 'package:starterkit_app/domain/posts/models/post_data_object.dart';

abstract interface class PostLocalDataSource implements LocalDataSource<PostDataObject> {
  Future<PostDataObject?> getPost(int postId);
}

@LazySingleton(as: PostLocalDataSource)
class PostLocalDataSourceImpl extends IsarLocalDataSource<PostDataObject> implements PostLocalDataSource {
  PostLocalDataSourceImpl(super._isarDatabaseFactory);

  @protected
  @override
  @visibleForTesting
  IsarGeneratedSchema get schema => PostDataObjectSchema;

  @override
  Future<PostDataObject?> getPost(int postId) async {
    final PostDataObject? object = await readWithIsar((Isar i) {
      return i.posts.where().postIdEqualTo(postId).findFirst();
    });

    return object;
  }
}
