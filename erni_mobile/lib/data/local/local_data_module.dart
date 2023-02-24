import 'package:erni_mobile/business/models/logging/app_log_object.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LocalDataModule {
  @preResolve
  @lazySingleton
  Future<HiveInterface> get initHive async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(AppLogObjectAdapter())
      ..registerAdapter(LogLevelAdapter());

    return Hive;
  }

  @preResolve
  @lazySingleton
  Future<Box<AppLogObject>> getAppLogObjectBox(HiveInterface hive) => hive.openBox('appLogObjects');
}
