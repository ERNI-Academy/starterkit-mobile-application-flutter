import 'package:starterkit_app/core/domain/models/data_object.dart';

abstract interface class LocalDataSource<T extends DataObject> {
  Future<T?> get(int id);

  Future<Iterable<T>> getAll();

  Future<void> addOrUpdate(T item);

  Future<void> addOrUpdateAll(Iterable<T> items);

  Future<void> delete(int id);

  Future<void> deleteAll();
}
