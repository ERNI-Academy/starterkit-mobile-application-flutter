import 'dart:developer' as dev;

import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/infrastructure/logging/log_level.dart';

export 'log_level.dart';

abstract class Logger {
  void logFor<T>();

  void log(LogLevel level, String message, [Object? error, StackTrace? stackTrace]);
}

@Injectable(as: Logger)
class LoggerImpl implements Logger {
  String _owner = '';

  @override
  void logFor<T>() {
    _owner = T.toString();
  }

  @override
  void log(LogLevel level, String message, [Object? error, StackTrace? stackTrace]) {
    dev.log(
      _formatMessage(level, message, error, stackTrace),
      name: _owner,
      level: level.value,
      time: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );
  }

  static String _formatMessage(LogLevel level, String message, Object? error, StackTrace? stackTrace) {
    final tag = '[${level.name.toUpperCase()}]';
    var formattedMessage = '$tag $message';

    if (level == LogLevel.error && error != null) {
      formattedMessage += '\r\n${error.runtimeType} $error';
    }

    if (level == LogLevel.error && stackTrace != null) {
      formattedMessage += '\r\n$stackTrace';
    }

    return formattedMessage;
  }
}
