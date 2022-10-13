// coverage:ignore-file

import 'package:drift/drift.dart';

abstract class DataTable extends Table {
  @override
  Set<Column> get primaryKey => {id};

  Column get id => integer()();
}
