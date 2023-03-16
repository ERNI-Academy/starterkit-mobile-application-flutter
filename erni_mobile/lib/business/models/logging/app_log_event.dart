import 'package:erni_mobile/business/models/logging/log_level.dart';

class AppLogEvent {
  const AppLogEvent({
    required this.uid,
    required this.sessionId,
    required this.level,
    required this.message,
    required this.createdAt,
    required this.owner,
    this.error,
    this.stackTrace,
    this.extras = const {},
  });

  final String uid;
  final String sessionId;
  final LogLevel level;
  final String message;
  final DateTime createdAt;
  final String owner;
  final Object? error;
  final StackTrace? stackTrace;
  final Map<String, Object> extras;
}
