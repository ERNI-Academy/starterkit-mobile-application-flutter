// coverage:ignore-file

import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

abstract interface class DirectoryService {
  Future<Directory> getCacheDirectory();
}

@LazySingleton(as: DirectoryService)
class DirectoryServiceImpl implements DirectoryService {
  const DirectoryServiceImpl();

  @override
  Future<Directory> getCacheDirectory() async {
    final Directory directory = await getApplicationCacheDirectory();

    return directory;
  }
}
