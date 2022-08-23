import 'package:erni_mobile/business/models/logging/app_log_event_entity.dart';

abstract class AppLogWriter {
  Future<void> write(AppLogEventEntity event);
}
