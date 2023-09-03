import 'dart:async';

import 'package:isar/isar.dart';
import 'package:meta/meta.dart';
import 'package:starterkit_app/core/data/database/isar_database_factory.dart';
import 'package:starterkit_app/core/data/database/local_data_source.dart';
import 'package:starterkit_app/core/domain/models/data_object.dart';

abstract class IsarLocalDataSource<T extends DataObject> implements LocalDataSource<T> {
  final IsarDatabaseFactory _isarDatabaseFactory;

  const IsarLocalDataSource(this._isarDatabaseFactory);

  @protected
  IsarGeneratedSchema get schema;

  @override
  Future<T?> get(int id) async {
    final T? item = await readUsing((IsarCollection<int, T?> collection) {
      return collection.get(id);
    });

    return item;
  }

  @override
  Future<Iterable<T>> getAll() async {
    final Iterable<T> items = await readUsing((IsarCollection<int, T> collection) {
      return collection.where().findAll();
    });

    return items;
  }

  @override
  Future<void> addOrUpdate(T item) async {
    await writeUsing((IsarCollection<int, T> collection) {
      collection.put(item);
    });
  }

  @override
  Future<void> addOrUpdateAll(Iterable<T> items) async {
    await writeUsing((IsarCollection<int, T> collection) {
      collection.putAll(items.toList());
    });
  }

  @override
  Future<void> delete(int id) async {
    await writeUsing((IsarCollection<int, T> collection) {
      collection.delete(id);
    });
  }

  @override
  Future<void> deleteAll() async {
    await writeUsing((IsarCollection<int, T> collection) {
      collection.clear();
    });
  }

  @protected
  @nonVirtual
  Future<TResult> readUsing<TResult>(TResult Function(IsarCollection<int, T> collection) callback) async {
    final Isar isar = await _getIsar();
    final TResult result = await isar.readAsync((Isar isar) => callback(isar.collection<int, T>()));
    isar.close();

    return result;
  }

  @protected
  @nonVirtual
  Future<void> writeUsing(void Function(IsarCollection<int, T> collection) callback) async {
    final Isar isar = await _getIsar();
    await isar.writeAsync((Isar isar) => callback(isar.collection<int, T>()));
    isar.close();
  }

  Future<Isar> _getIsar() async {
    final Isar isar = await _isarDatabaseFactory.getIsar(schema);

    return isar;
  }
}
