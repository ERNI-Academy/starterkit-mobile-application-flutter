// coverage:ignore-file

import 'package:drift/drift.dart';

abstract class DataTable extends Table {
  Column<Object> get id;

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
