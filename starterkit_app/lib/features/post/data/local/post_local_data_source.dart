import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/data/database/app_database.dart';
import 'package:starterkit_app/core/data/database/base_local_data_source.dart';
import 'package:starterkit_app/core/data/database/local_data_source.dart';
import 'package:starterkit_app/features/post/domain/models/post_data_table.dart';

@lazySingleton
class PostLocalDataSource extends BaseLocalDataSource<AppDatabase, PostDataTable, PostDataObject>
    implements LocalDataSource<PostDataTable, PostDataObject> {
  PostLocalDataSource(super.attachedDatabase);

  Future<PostDataObject?> getPost(int postId) async {
    final SimpleSelectStatement<PostDataTable, PostDataObject> query = select(table)
      ..where((PostDataTable t) => t.postId.equals(postId));
    final PostDataObject? post = await query.getSingleOrNull();

    return post;
  }
}
