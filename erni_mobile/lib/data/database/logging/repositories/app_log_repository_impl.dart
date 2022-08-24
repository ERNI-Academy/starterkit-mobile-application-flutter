// coverage:ignore-file

import 'package:erni_mobile/data/database/logging/logging_database.dart';
import 'package:erni_mobile/data/database/logging/tables/app_logs.dart';
import 'package:erni_mobile/domain/repositories/logging/app_log_repository.dart';
import 'package:erni_mobile_core/data.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppLogRepository)
class AppLogRepositoryImpl extends BaseRepository<LoggingDatabase, AppLogs, AppLogObject> implements AppLogRepository {
  AppLogRepositoryImpl(LoggingDatabase db) : super(db);
}
