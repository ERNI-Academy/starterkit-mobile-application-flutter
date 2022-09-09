// coverage:ignore-file

import 'package:drift/drift.dart';
import 'package:erni_mobile/domain/mappers/object_mapper.dart';
import 'package:erni_mobile/domain/models/entity.dart';

abstract class ObjectFromEntityMapper<O extends DataClass, E extends Entity> implements ObjectMapper<O, E> {
  @override
  O? map(E? source) => fromEntity(source);

  O? fromEntity(E? entity);
}
