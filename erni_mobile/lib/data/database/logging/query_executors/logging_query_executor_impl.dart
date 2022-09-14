// coverage:ignore-file

import 'package:erni_mobile/data/database/logging/query_executors/logging_query_executor.dart';
import 'package:erni_mobile/data/database/query_executors/query_executor.dart';
import 'package:erni_mobile/dependency_injection.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoggingQueryExecutor)
@running
class LoggingExecutorImpl extends BaseQueryExecutor implements LoggingQueryExecutor {
  LoggingExecutorImpl() : super('db_logging');
}
