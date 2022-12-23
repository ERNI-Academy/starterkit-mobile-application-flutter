// coverage:ignore-file

import 'package:erni_mobile/data/database/logging/logging_database.dart';
import 'package:erni_mobile/data/database/logging/tables/app_log_events.dart';
import 'package:erni_mobile/data/database/repository.dart';
import 'package:erni_mobile/domain/repositories/logging/app_log_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppLogRepository)
class AppLogRepositoryImpl extends BaseRepository<LoggingDatabase, AppLogEvents, AppLogEventObject>
    implements AppLogRepository {
  AppLogRepositoryImpl(LoggingDatabase db) : super(db);
}
