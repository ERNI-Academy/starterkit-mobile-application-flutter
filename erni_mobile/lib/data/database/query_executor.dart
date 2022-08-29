import 'package:drift/drift.dart';
import 'package:erni_mobile/data/database/internal/internal_query_executor_non_web.dart'
    if (dart.library.html) 'package:erni_mobile_core/src/data/database/internal/internal_query_executor_web.dart';

abstract class BaseQueryExecutor extends InternalQueryExecutor implements QueryExecutor {
  BaseQueryExecutor(String dbName) : super(dbName);
}

abstract class BaseInMemmoryQueryExecutor extends InternalInMemmoryQueryExecutor implements QueryExecutor {
  BaseInMemmoryQueryExecutor(String dbName) : super(dbName);
}
