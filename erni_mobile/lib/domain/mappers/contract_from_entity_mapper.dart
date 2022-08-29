// coverage:ignore-file

import 'package:erni_mobile/domain/mappers/object_mapper.dart';
import 'package:erni_mobile/domain/models/data_contract.dart';
import 'package:erni_mobile/domain/models/entity.dart';

abstract class ContractFromEntityMapper<C extends DataContract, E extends Entity> implements ObjectMapper<C, E> {
  @override
  C? map(E? source) => fromEntity(source);

  C? fromEntity(E? entity);
}
