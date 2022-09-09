import 'package:erni_mobile/data/database/logging/logging_database.dart';
import 'package:erni_mobile/data/database/logging/tables/app_logs.dart';
import 'package:erni_mobile/data/repository/repository.dart';

abstract class AppLogRepository implements Repository<AppLogs, AppLogObject> {}
