import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/data/database/database_query_executor.dart';
import 'package:starterkit_app/features/post/domain/models/post_data_table.dart';
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

@lazySingleton
@DriftDatabase(tables: <Type>[PostDataTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase(DatabaseQueryExecutor super.e);

  @override
  int get schemaVersion => 1;
}
