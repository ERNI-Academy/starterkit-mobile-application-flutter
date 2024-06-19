// coverage:ignore-file

import 'package:drift/drift.dart';

abstract class DataTable extends Table {
  Column<int> get id => integer().withDefault(const Constant<int>(0)).autoIncrement()();
}
