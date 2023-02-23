import 'package:erni_mobile/business/models/logging/app_log_object.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@module
abstract class LocalDataModule {
  @lazySingleton
  @preResolve
  Future<Isar> get isar => Isar.open([AppLogObjectSchema]);
}
