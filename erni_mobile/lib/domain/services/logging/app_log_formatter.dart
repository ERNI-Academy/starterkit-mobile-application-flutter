import 'package:erni_mobile/business/models/logging/log_level.dart';

abstract class AppLogFormatter {
  String format(LogLevel level, String message, Object? error, StackTrace? stackTrace);
}
