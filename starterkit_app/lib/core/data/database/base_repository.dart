import 'package:drift/drift.dart';
import 'package:meta/meta.dart';
import 'package:starterkit_app/core/data/database/repository.dart';
import 'package:starterkit_app/core/domain/models/data_table.dart';

abstract class BaseRepository<
  TDb extends GeneratedDatabase,
  TTable extends DataTable,
  TDataObject extends Insertable<TDataObject>
>
    extends DatabaseAccessor<TDb>
    implements Repository<TTable, TDataObject> {
  BaseRepository(super.attachedDatabase)
    : table =
          attachedDatabase.allTables.firstWhere((TableInfo<Table, dynamic> element) => element is TTable)
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
  Future<void> remove(Object id) async {
    await transaction(() async {
      await (delete(table)..where((TTable t) => t.id.equals(id))).go();
    });
  }

  @override
  Future<void> removeAll(Iterable<Object> ids) async {
    await transaction(() async {
      final bool isStringList = ids.every((Object id) => id is String);
      final bool isIntList = ids.every((Object id) => id is int);

      // Needs to be explicitly casted
      if (isStringList) {
        await (delete(table)..where((TTable t) => t.id.isIn(ids.cast<String>()))).go();
      } else if (isIntList) {
        await (delete(table)..where((TTable t) => t.id.isIn(ids.cast<int>()))).go();
      }
    });
  }

  @override
  Future<TDataObject?> get(Object id) async {
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
