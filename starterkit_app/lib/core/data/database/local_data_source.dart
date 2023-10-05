import 'package:starterkit_app/core/domain/models/data_object.dart';

abstract interface class LocalDataSource<T extends DataObject> {
  Future<T?> get(int id);

  Future<Iterable<T>> getAll({required int offset, required int limit});

  Future<void> addOrUpdate(T object);

  Future<void> addOrUpdateAll(Iterable<T> objects);

  Future<void> delete(T object);

  Future<void> deleteAll();
}
