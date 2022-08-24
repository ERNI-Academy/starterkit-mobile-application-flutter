// coverage:ignore-file

import 'package:erni_mobile/data/database/logging/query_executors/logging_query_executor.dart';
import 'package:erni_mobile_core/data.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoggingQueryExecutor)
@prod
class LoggingExecutorImpl extends BaseQueryExecutor implements LoggingQueryExecutor {
  LoggingExecutorImpl() : super('db_logging');
}
