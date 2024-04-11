import 'package:drift/drift.dart';
import 'package:meta/meta.dart';
import 'package:starterkit_app/core/data/database/local_data_source.dart';
import 'package:starterkit_app/core/domain/models/data_table.dart';

abstract class BaseLocalDataSource<TDb extends GeneratedDatabase, TTable extends DataTable,
        TDataObject extends Insertable<TDataObject>> extends DatabaseAccessor<TDb>
    implements LocalDataSource<TTable, TDataObject> {
  BaseLocalDataSource(super.attachedDatabase);

  @protected
  TableInfo<TTable, TDataObject> get table =>
      db.allTables.firstWhere((TableInfo<Table, dynamic> element) => element is TTable)
          as TableInfo<TTable, TDataObject>;

  @override
  Future<void> addOrUpdate(TDataObject object) {
    return into(table).insert(object, mode: InsertMode.insertOrReplace);
  }

  @override
  Future<void> addOrUpdateAll(Iterable<TDataObject> objects) {
    return db.batch(
      (Batch b) => b.insertAll(
        table,
        objects,
        mode: InsertMode.insertOrReplace,
      ),
    );
  }

  @override
  Future<void> remove(TDataObject object) {
    return delete(table).delete(object);
  }

  @override
  Future<void> removeAll(Iterable<int> ids) {
    return db.batch((Batch batch) => batch.deleteWhere(table, (TTable tbl) => tbl.id.isIn(ids)));
  }

  @override
  Future<TDataObject?> get(int id) {
    final SimpleSelectStatement<TTable, TDataObject> query = select(table)..where((TTable t) => t.id.equals(id));

    return query.getSingleOrNull();
  }

  @override
  Future<Iterable<TDataObject>> getAll() {
    return select(table).get();
  }
}
