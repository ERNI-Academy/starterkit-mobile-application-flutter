// coverage:ignore-file

import 'package:drift/drift.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/data/database/logging/converters/database_log_level_to_string_converter.dart';
import 'package:erni_mobile/data/database/logging/converters/database_map_to_string_converter.dart';
import 'package:erni_mobile/data/database/logging/query_executors/logging_query_executor.dart';
import 'package:erni_mobile/data/database/logging/tables/app_logs.dart';
import 'package:injectable/injectable.dart';

part 'logging_database.g.dart';

@lazySingleton
@DriftDatabase(tables: [AppLogs])
class LoggingDatabase extends _$LoggingDatabase {
  LoggingDatabase(LoggingQueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;
}
