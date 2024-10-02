import 'package:drift/drift.dart';
import 'package:meta/meta.dart';
import 'package:starterkit_app/core/data/database/repository.dart';
import 'package:starterkit_app/core/domain/models/data_table.dart';

abstract class BaseRepository<TDb extends GeneratedDatabase, TTable extends DataTable,
        TDataObject extends Insertable<TDataObject>> extends DatabaseAccessor<TDb>
    implements Repository<TTable, TDataObject> {
  BaseRepository(super.attachedDatabase)
      : table = attachedDatabase.allTables.firstWhere((TableInfo<Table, dynamic> element) => element is TTable)
            as TableInfo<TTable, TDataObject>;

  @protected
  final TableInfo<TTable, TDataObject> table;

  @override
  Future<void> addOrUpdate(TDataObject object) async {
    await transaction(() async {
      await into(table).insert(object, mode: InsertMode.insertOrReplace);
    });
  }

  @override
  Future<void> addOrUpdateAll(Iterable<TDataObject> objects) async {
    await transaction(() async {
      await batch((Batch b) => b.insertAll(table, objects, mode: InsertMode.insertOrReplace));
    });
  }

  @override
  Future<void> remove(TDataObject object) async {
    await transaction(() async {
      await delete(table).delete(object);
    });
  }

  @override
  Future<void> removeAll(Iterable<int> ids) async {
    await transaction(() async {
      await (delete(table)..where((TTable t) => t.id.isIn(ids))).go();
    });
  }

  @override
  Future<TDataObject?> get(int id) async {
    final TDataObject? result = await transaction(() async {
      final SimpleSelectStatement<TTable, TDataObject> query = select(table)..where((TTable t) => t.id.equals(id));
      final TDataObject? result = await query.getSingleOrNull();
      return result;
    });

    return result;
  }

  @override
  Future<Iterable<TDataObject>> getAll() {
    return transaction(() async {
      final List<TDataObject> results = await select(table).get();
      return results;
    });
  }
}
