import 'package:erni_mobile/data/database/logging/logging_database.dart';
import 'package:erni_mobile/data/database/logging/tables/app_log_events.dart';
import 'package:erni_mobile/data/database/repository.dart';

abstract class AppLogRepository implements Repository<AppLogEvents, AppLogEventObject> {}
