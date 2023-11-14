import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path/path.dart';
import 'package:starterkit_app/core/data/database/isar_database_factory.dart';

// Download the latest libraries from https://github.com/isar/isar/releases

class TestIsarDatabaseFactory implements IsarDatabaseFactory {
  static String get _isarLibraryFile {
    const String fileName = 'isar';

    return switch (Platform.operatingSystem) {
      'windows' => '$fileName.dll',
      'linux' => '$fileName.so',
      'macos' => '$fileName.dylib',
      _ => throw UnsupportedError('Unsupported platform: ${Platform.operatingSystem}'),
    };
  }

  @override
  Future<Isar> getIsar(IsarGeneratedSchema schema) async {
    await Future<void>.value(Isar.initialize(join('test', 'assets', _isarLibraryFile)));
    const String databasePath = Isar.sqliteInMemory;
    final Isar isar = Isar.open(
      schemas: <IsarGeneratedSchema>[schema],
      directory: databasePath,
      engine: IsarEngine.sqlite,
      inspector: false,
    );

    return isar;
  }
}
