import 'package:erni_mobile/business/models/logging/app_log_event_entity.dart';
import 'package:erni_mobile/data/database/logging/logging_database.dart';
import 'package:erni_mobile/domain/mappers/object_from_entity_mapper.dart';
import 'package:injectable/injectable.dart';

abstract class AppLogObjectFromEntityMapper extends ObjectFromEntityMapper<AppLogObject, AppLogEventEntity> {}

@LazySingleton(as: AppLogObjectFromEntityMapper)
class AppLogObjectFromEntityMapperImpl extends AppLogObjectFromEntityMapper {
  @override
  AppLogObject? fromEntity(AppLogEventEntity? entity) {
    if (entity == null) {
      return null;
    }

    return AppLogObject(
      id: entity.id,
      sessionId: entity.sessionId,
      level: entity.level,
      message: entity.message,
      createdAt: entity.createdAt,
      extras: entity.extras,
      owner: entity.owner,
    );
  }
}
