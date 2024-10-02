// coverage:ignore-file

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/data/database/app_database.dart';
import 'package:starterkit_app/core/data/database/base_repository.dart';
import 'package:starterkit_app/core/data/database/repository.dart';
import 'package:starterkit_app/features/post/domain/models/post_data_table.dart';

@lazySingleton
class PostRepository extends BaseRepository<AppDatabase, PostDataTable, PostDataObject>
    implements Repository<PostDataTable, PostDataObject> {
  PostRepository(super.attachedDatabase);

  Future<PostDataObject?> getPost(int postId) async {
    final SimpleSelectStatement<PostDataTable, PostDataObject> query = select(table)
      ..where((PostDataTable t) => t.postId.equals(postId));
    final PostDataObject? post = await query.getSingleOrNull();

    return post;
  }
}
