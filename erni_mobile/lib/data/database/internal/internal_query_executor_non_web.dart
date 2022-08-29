import 'dart:ffi';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';

abstract class InternalQueryExecutor extends LazyDatabase {
  InternalQueryExecutor(String dbName) : super(() => _databaseOpener(dbName));
}

Future<NativeDatabase> _databaseOpener(String dbName) async {
  if (Platform.isWindows) {
    open.overrideFor(OperatingSystem.windows, _openOnWindows);

    final db = sqlite3.openInMemory();
    db.dispose();
  }

  final docsDir = await getApplicationSupportDirectory();
  final pkgInfo = await PackageInfo.fromPlatform();
  final dbDir = await Directory(join(docsDir.path, pkgInfo.appName)).create(recursive: true);
  final dbFile = File(join(dbDir.path, '$dbName.sqlite'));

  return NativeDatabase(dbFile);
}

DynamicLibrary _openOnWindows() {
  final script = File(Platform.resolvedExecutable);
  final libraryNextToScript = File(join(script.parent.path, 'sqlite3.dll'));

  return DynamicLibrary.open(libraryNextToScript.path);
}

abstract class InternalInMemmoryQueryExecutor extends LazyDatabase {
  // Parameter [dbName] is ignored to satisfy other class signature.
  // ignore: avoid_unused_constructor_parameters
  InternalInMemmoryQueryExecutor(String dbName) : super(NativeDatabase.memory);
}
