// coverage:ignore-file

import 'package:erni_mobile/data/database/logging/query_executors/logging_query_executor.dart';
import 'package:erni_mobile/data/database/query_executors/query_executor.dart';
import 'package:erni_mobile/dependency_injection.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoggingQueryExecutor)
@testing
class InMemoryLoggingExecutorImpl extends BaseInMemoryQueryExecutor implements LoggingQueryExecutor {
  InMemoryLoggingExecutorImpl() : super('db_logging');
}
