import 'package:erni_mobile/business/models/logging/app_log_object.dart';
import 'package:erni_mobile/domain/models/data/objectbox.g.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LocalDataModule {
  @lazySingleton
  @preResolve
  Future<Store> get store => openStore();

  @lazySingleton
  Box<AppLogObject> getAppLogObjectBox(Store store) => Box<AppLogObject>(store);
}
