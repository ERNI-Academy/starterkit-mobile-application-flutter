// coverage:ignore-file

import 'package:drift/drift.dart';
import 'package:starterkit_app/core/domain/models/data_table.dart';
import 'package:uuid/uuid.dart';

@DataClassName('PostDataObject')
class PostDataTable extends DataTable {
  @override
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  IntColumn get postId => integer()();

  IntColumn get userId => integer()();

  TextColumn get title => text()();

  TextColumn get body => text()();
}
