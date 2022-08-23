import 'package:erni_mobile/business/models/logging/app_log_event_entity.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/domain/services/logging/app_log_formatter.dart';
import 'package:erni_mobile/domain/services/logging/app_log_writer.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/services/platform/date_time_service.dart';
import 'package:erni_mobile/domain/services/platform/environment_config.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@Injectable(as: AppLogger)
class AppLoggerImpl implements AppLogger {
  AppLoggerImpl(this._formatter, this._logWriters, this._dateTimeService, this._environmentConfig);

  final AppLogFormatter _formatter;
  final List<AppLogWriter> _logWriters;
  final DateTimeService _dateTimeService;
  final EnvironmentConfig _environmentConfig;
  String? _owner;

  @override
  void logFor(Object owner) {
    _owner = describeIdentity(owner);
  }

  @override
  void logForNamed(String owner) {
    _owner = owner;
  }

  @override
  void log(
    LogLevel logLevel,
    String message, [
    Object? exception,
    StackTrace? stackTrace,
    Map<String, Object> extras = const {},
  ]) {
    if (logLevel.value < _environmentConfig.minLogLevel.value) {
      return;
    }

    final formattedMessage = _formatter.format(logLevel, message, exception, stackTrace);
    final logEvent = AppLogEventEntity(
      id: const Uuid().v1(),
      sessionId: _environmentConfig.sessionId,
      level: logLevel,
      message: formattedMessage,
      createdAt: _dateTimeService.utcNow(),
      owner: _owner ?? '',
      error: exception,
      stackTrace: stackTrace,
      extras: extras,
    );

    _internalWriteLog(logEvent);
  }

  Future<void> _internalWriteLog(AppLogEventEntity log) async {
    for (final writer in _logWriters) {
      await writer.write(log);
    }
  }
}
