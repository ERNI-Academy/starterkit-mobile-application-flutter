import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/data/database/logging/logging_database.dart';

class AppLogEvent {
  const AppLogEvent({
    required this.id,
    required this.sessionId,
    required this.level,
    required this.message,
    required this.createdAt,
    required this.owner,
    this.error,
    this.stackTrace,
    this.extras = const {},
  });

  final String id;
  final String sessionId;
  final LogLevel level;
  final String message;
  final DateTime createdAt;
  final String owner;
  final Object? error;
  final StackTrace? stackTrace;
  final Map<String, Object> extras;

  AppLogEventObject toDatabaseObject() {
    return AppLogEventObject(
      id: id,
      sessionId: sessionId,
      level: level,
      message: message,
      createdAt: createdAt,
      extras: extras,
      owner: owner,
    );
  }
}
