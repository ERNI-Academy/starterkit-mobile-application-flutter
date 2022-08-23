import 'package:drift/drift.dart';
import 'package:erni_mobile/domain/mappers/object_mapper.dart';
import 'package:erni_mobile/domain/models/data_contracts/data_contract.dart';

abstract class ContractFromObjectMapper<C extends DataContract, O extends DataClass> implements ObjectMapper<C, O> {
  @override
  C? map(O? source) => fromObject(source);

  C? fromObject(O? object);
}
