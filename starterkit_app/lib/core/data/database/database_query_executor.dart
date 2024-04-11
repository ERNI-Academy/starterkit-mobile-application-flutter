// coverage:ignore-file

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/data/database/database_factory.dart';

abstract interface class DatabaseQueryExecutor implements QueryExecutor {}

@LazySingleton(as: DatabaseQueryExecutor)
class IOQueryExecutor extends LazyDatabase implements DatabaseQueryExecutor {
  IOQueryExecutor(DatabaseFactory databaseFactory) : super(databaseFactory.open);
}
