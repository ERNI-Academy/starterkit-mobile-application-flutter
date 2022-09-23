// coverage:ignore-file

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract class InternalQueryExecutor extends LazyDatabase {
  InternalQueryExecutor(String dbName) : super(() => _databaseOpener(dbName));
}

Future<NativeDatabase> _databaseOpener(String dbName) async {
  if (Platform.isWindows) {
    sqfliteFfiInit();
  }

  final docsDir = await getApplicationSupportDirectory();
  final pkgInfo = await PackageInfo.fromPlatform();
  final dbDir = await Directory(join(docsDir.path, pkgInfo.appName)).create(recursive: true);
  final dbFile = File(join(dbDir.path, '$dbName.sqlite'));

  return NativeDatabase(dbFile);
}

abstract class InternalInMemmoryQueryExecutor extends LazyDatabase {
  // Parameter [dbName] is ignored to satisfy other class signature.
  InternalInMemmoryQueryExecutor(String _) : super(NativeDatabase.memory);
}
