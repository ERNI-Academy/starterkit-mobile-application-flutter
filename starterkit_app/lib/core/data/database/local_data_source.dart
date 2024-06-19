import 'package:drift/drift.dart';
import 'package:starterkit_app/core/domain/models/data_table.dart';

abstract interface class LocalDataSource<TTable extends DataTable, TDataObject extends Insertable<TDataObject>> {
  Future<TDataObject?> get(int id);

  Future<Iterable<TDataObject>> getAll();

  Future<void> addOrUpdate(TDataObject object);

  Future<void> addOrUpdateAll(Iterable<TDataObject> objects);

  Future<void> remove(TDataObject object);

  Future<void> removeAll(Iterable<int> ids);
}
