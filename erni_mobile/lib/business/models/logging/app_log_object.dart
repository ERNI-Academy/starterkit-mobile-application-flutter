import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:isar/isar.dart';

part 'app_log_object.g.dart';

@collection
class AppLogObject {
  AppLogObject({
    this.id = Isar.autoIncrement,
    required this.uid,
    required this.sessionId,
    required this.level,
    required this.message,
    required this.createdAt,
    required this.owner,
  });

  final Id id;

  @Index(type: IndexType.value)
  final String uid;

  final String sessionId;

  @enumerated
  final LogLevel level;

  final String message;
  final DateTime createdAt;
  final String owner;
}
