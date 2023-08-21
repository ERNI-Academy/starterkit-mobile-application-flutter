import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/infrastructure/logging/log_level.dart';

export 'log_level.dart';

abstract interface class Logger {
  void logFor<T>([T? object]);

  void log(LogLevel level, String message, [Object? error, StackTrace? stackTrace]);
}

@Injectable(as: Logger)
class LoggerImpl implements Logger {
  String _owner = '';

  @override
  void logFor<T>([T? object]) {
    _owner = object == null ? '$T' : describeIdentity(object);
  }

  @override
  void log(LogLevel level, String message, [Object? error, StackTrace? stackTrace]) {
    dev.log(
      _formatMessage(level, message, error, stackTrace),
      time: DateTime.now(),
      level: level.value,
      name: _owner,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static String _formatMessage(LogLevel level, String message, Object? error, StackTrace? stackTrace) {
    final String tag = '[${level.name.toUpperCase()}]';
    String formattedMessage = '$tag $message';

    if (level == LogLevel.error && error != null) {
      formattedMessage += '\r\n${error.runtimeType} $error';
    }

    if (level == LogLevel.error && stackTrace != null) {
      formattedMessage += '\r\n$stackTrace';
    }

    return formattedMessage;
  }
}
