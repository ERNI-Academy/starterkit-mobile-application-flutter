import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/domain/services/logging/app_log_formatter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppLogFormatter)
class AppLogFormatterImpl implements AppLogFormatter {
  @override
  String format(LogLevel level, String message, Object? error, StackTrace? stackTrace) {
    final tag = '[${level.name.toUpperCase()}]';
    message = '$tag $message';

    if (level == LogLevel.error && error != null) {
      message += '\r\n${error.runtimeType} $error';
    }

    if (level == LogLevel.error && stackTrace != null) {
      message += '\r\n$stackTrace';
    }

    return message;
  }
}
