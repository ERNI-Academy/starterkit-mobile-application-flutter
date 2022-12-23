import 'package:erni_mobile/business/models/logging/app_log_event.dart';

abstract class AppLogWriter {
  Future<void> write(AppLogEvent event);
}
