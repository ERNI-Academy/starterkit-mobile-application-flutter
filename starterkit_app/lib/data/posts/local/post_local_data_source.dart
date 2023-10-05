import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:meta/meta.dart';
import 'package:starterkit_app/core/data/database/isar_local_data_source.dart';
import 'package:starterkit_app/core/data/database/local_data_source.dart';
import 'package:starterkit_app/domain/posts/models/post_data_object.dart';

abstract interface class PostLocalDataSource implements LocalDataSource<PostDataObject> {
  Future<Iterable<PostDataObject>> getAllByUserId(int userId);
}

@LazySingleton(as: PostLocalDataSource)
class PostLocalDataSourceImpl extends IsarLocalDataSource<PostDataObject> implements PostLocalDataSource {
  PostLocalDataSourceImpl(super._isarDatabaseFactory);

  @protected
  @override
  @visibleForTesting
  IsarGeneratedSchema get schema => PostDataObjectSchema;

  @override
  Future<Iterable<PostDataObject>> getAllByUserId(int userId) async {
    final Isar isar = await getIsar();
    final Iterable<PostDataObject> objects = isar.read((Isar i) {
      return i.posts.where().userIdEqualTo(userId).findAll();
    });

    return objects;
  }
}
