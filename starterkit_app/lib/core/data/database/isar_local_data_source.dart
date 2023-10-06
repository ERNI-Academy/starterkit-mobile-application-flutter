import 'dart:async';

import 'package:isar/isar.dart';
import 'package:meta/meta.dart';
import 'package:starterkit_app/core/data/database/isar_database_factory.dart';
import 'package:starterkit_app/core/data/database/local_data_source.dart';
import 'package:starterkit_app/core/domain/models/data_object.dart';

typedef IsarTxnCallback<T, TResult> = TResult Function(IsarCollection<int, T> collection);

abstract class IsarLocalDataSource<T extends DataObject> implements LocalDataSource<T> {
  final IsarDatabaseFactory _isarDatabaseFactory;

  IsarLocalDataSource(this._isarDatabaseFactory);

  @protected
  IsarGeneratedSchema get schema;

  @override
  Future<T?> get(int id) async {
    final T? object = await readUsing((IsarCollection<int, T?> collection) {
      return collection.get(id);
    });

    return object;
  }

  @override
  Future<Iterable<T>> getAll({required int offset, required int limit}) async {
    final Iterable<T> objects = await readUsing((IsarCollection<int, T> collection) {
      return collection.where().findAll(offset: offset, limit: limit);
    });

    return objects;
  }

  @override
  Future<void> addOrUpdate(T object) async {
    await writeUsing((IsarCollection<int, T> collection) {
      collection.put(object);
    });
  }

  @override
  Future<void> addOrUpdateAll(Iterable<T> objects) async {
    await writeUsing((IsarCollection<int, T> collection) {
      collection.putAll(objects.toList());
    });
  }

  @override
  Future<void> delete(int id) async {
    await writeUsing((IsarCollection<int, T> collection) {
      collection.delete(id);
    });
  }

  @override
  Future<void> deleteAll(Iterable<int> ids) async {
    await writeUsing((IsarCollection<int, T> collection) {
      collection.deleteAll(ids.toList());
    });
  }

  @protected
  @nonVirtual
  Future<TResult> readUsing<TResult>(IsarTxnCallback<T, TResult> callback) async {
    final Isar isar = await getIsar();
    final TResult result = isar.read((Isar i) => callback(i.collection<int, T>()));

    return result;
  }

  @protected
  @nonVirtual
  Future<void> writeUsing(IsarTxnCallback<T, void> callback) async {
    final Isar isar = await getIsar();
    isar.write<void>((Isar i) => callback(i.collection<int, T>()));
  }

  @protected
  @nonVirtual
  Future<Isar> getIsar() async {
    final Isar isar = await _isarDatabaseFactory.getIsar(schema);

    return isar;
  }
}
