import 'package:drift/drift.dart';
import 'package:erni_mobile/domain/mappers/object_mapper.dart';
import 'package:erni_mobile/domain/models/entity.dart';

abstract class EntityFromObjectMapper<E extends Entity, O extends DataClass> implements ObjectMapper<E, O> {
  @override
  E? map(O? source) => fromObject(source);

  E? fromObject(O? object);
}
