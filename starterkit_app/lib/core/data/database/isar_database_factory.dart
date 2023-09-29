// coverage:ignore-file

import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:starterkit_app/core/infrastructure/platform/directory_service.dart';

abstract interface class IsarDatabaseFactory {
  Future<Isar> getIsar(IsarGeneratedSchema schema);
}

@LazySingleton(as: IsarDatabaseFactory)
class IsarDatabaseFactoryImpl implements IsarDatabaseFactory {
  final DirectoryService _directoryService;

  IsarDatabaseFactoryImpl(this._directoryService);

  @override
  Future<Isar> getIsar(IsarGeneratedSchema schema) async {
    final Directory cacheDirectory = await _directoryService.getCacheDirectory();
    final Isar isar = await Isar.openAsync(
      schemas: <IsarGeneratedSchema>[schema],
      directory: cacheDirectory.path,
      engine: IsarEngine.sqlite,
      inspector: true,
    );

    return isar;
  }
}
