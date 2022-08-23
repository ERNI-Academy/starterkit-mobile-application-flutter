import 'package:erni_mobile/business/models/logging/log_level.dart';

abstract class AppLogger {
  void logFor(Object owner);

  void logForNamed(String owner);

  void log(
    LogLevel logLevel,
    String message, [
    Object? exception,
    StackTrace? stackTrace,
    Map<String, Object> extras = const {},
  ]);
}
