// coverage:ignore-file

import 'dart:io';

import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:starterkit_app/core/infrastructure/environment/environment_variables.dart';

@lazySingleton
class DatabaseFactory {
  final EnvironmentVariables _environmentVariables;

  DatabaseFactory(this._environmentVariables);

  Future<NativeDatabase> open() async {
    final String dbFileName = '${_environmentVariables.appId}.sqlite';
    final Directory cacheDir = await getApplicationCacheDirectory();
    final Directory appDir = Directory(join(cacheDir.path, 'database'))..createSync();
    final File dbFile = File(join(appDir.path, dbFileName));

    return NativeDatabase(dbFile);
  }
}
