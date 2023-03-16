import 'package:erni_mobile/business/models/logging/app_log_event.dart';
import 'package:erni_mobile/common/constants/hive_type_ids.dart';
import 'package:hive/hive.dart';

part 'app_log_object.g.dart';

@HiveType(typeId: HiveTypeIds.appLogObject)
class AppLogObject {
  AppLogObject({
    required this.uid,
    required this.sessionId,
    required this.level,
    required this.message,
    required this.createdAt,
    required this.owner,
  });

  factory AppLogObject.fromAppLogEvent(AppLogEvent event) {
    return AppLogObject(
      uid: event.uid,
      sessionId: event.sessionId,
      level: event.level.name,
      message: event.message,
      createdAt: event.createdAt,
      owner: event.owner,
    );
  }

  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String sessionId;

  @HiveField(2)
  final String level;

  @HiveField(3)
  final String message;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final String owner;
}
