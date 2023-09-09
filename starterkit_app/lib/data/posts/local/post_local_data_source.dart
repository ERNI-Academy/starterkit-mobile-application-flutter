import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:starterkit_app/core/data/database/isar_local_data_source.dart';
import 'package:starterkit_app/core/data/database/local_data_source.dart';
import 'package:starterkit_app/domain/posts/models/post_data_object.dart';

abstract interface class PostLocalDataSource implements LocalDataSource<PostDataObject> {}

@LazySingleton(as: PostLocalDataSource)
class PostLocalDataSourceImpl extends IsarLocalDataSource<PostDataObject> implements PostLocalDataSource {
  const PostLocalDataSourceImpl(super._isarDatabaseFactory);

  @override
  IsarGeneratedSchema get schema => PostDataObjectSchema;
}
