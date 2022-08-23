// coverage:ignore-file

import 'package:erni_mobile/data/database/logging/query_executors/logging_query_executor.dart';
import 'package:erni_mobile_blueprint_core/data.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoggingQueryExecutor)
@test
class TestLoggingExecutorImpl extends BaseInMemmoryQueryExecutor implements LoggingQueryExecutor {
  TestLoggingExecutorImpl() : super('db_logging');
}
