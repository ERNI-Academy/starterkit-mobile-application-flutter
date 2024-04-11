// coverage:ignore-file

import 'package:drift/drift.dart';
import 'package:starterkit_app/core/domain/models/data_table.dart';

@DataClassName('PostDataObject')
class PostDataTable extends DataTable {
  IntColumn get postId => integer()();

  IntColumn get userId => integer()();

  TextColumn get title => text()();

  TextColumn get body => text()();
}
