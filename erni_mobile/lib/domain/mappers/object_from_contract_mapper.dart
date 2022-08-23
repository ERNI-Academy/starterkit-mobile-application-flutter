import 'package:drift/drift.dart';
import 'package:erni_mobile/domain/mappers/object_mapper.dart';
import 'package:erni_mobile/domain/models/data_contracts/data_contract.dart';

abstract class ObjectFromContractMapper<O extends DataClass, C extends DataContract> implements ObjectMapper<O, C> {
  @override
  O? map(C? source) => fromContract(source);

  O? fromContract(C? contract);
}
