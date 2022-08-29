// coverage:ignore-file

import 'package:erni_mobile/domain/mappers/object_mapper.dart';
import 'package:erni_mobile/domain/models/data_contract.dart';
import 'package:erni_mobile/domain/models/entity.dart';

abstract class EntityFromContractMapper<E extends Entity, C extends DataContract> implements ObjectMapper<E, C> {
  @override
  E? map(C? source) => fromContract(source);

  E? fromContract(C? contract);
}
