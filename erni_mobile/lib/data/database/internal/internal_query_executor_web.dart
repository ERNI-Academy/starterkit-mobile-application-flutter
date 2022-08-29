import 'package:drift/web.dart';

abstract class InternalQueryExecutor extends WebDatabase {
  InternalQueryExecutor(String dbName) : super(dbName);
}

abstract class InternalInMemmoryQueryExecutor extends WebDatabase {
  InternalInMemmoryQueryExecutor(String dbName) : super(dbName);
}
