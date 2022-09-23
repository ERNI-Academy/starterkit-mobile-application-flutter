// coverage:ignore-file

import 'package:drift/drift.dart';
import 'package:erni_mobile/data/database/query_executors/io_query_executor.dart'
    if (dart.library.html) 'package:erni_mobile/data/database/query_executors/web_query_executor.dart';

abstract class BaseQueryExecutor extends InternalQueryExecutor implements QueryExecutor {
  BaseQueryExecutor(String dbName) : super(dbName);
}

abstract class BaseInMemoryQueryExecutor extends InternalInMemmoryQueryExecutor implements QueryExecutor {
  BaseInMemoryQueryExecutor(String dbName) : super(dbName);
}
