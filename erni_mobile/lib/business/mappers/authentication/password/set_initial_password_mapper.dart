import 'package:erni_mobile/business/models/authentication/password/set_initial_password_contract.dart';
import 'package:erni_mobile/business/models/authentication/password/set_initial_password_entity.dart';
import 'package:erni_mobile/domain/mappers/contract_from_entity_mapper.dart';
import 'package:injectable/injectable.dart';
import 'package:smartstruct/smartstruct.dart';

part 'set_initial_password_mapper.mapper.g.dart';

@Mapper(useInjection: true)
abstract class SetInitialPasswordContractFromEntityMapper
    extends ContractFromEntityMapper<SetInitialPasswordContract, SetInitialPasswordEntity> {
  @override
  SetInitialPasswordContract? fromEntity(SetInitialPasswordEntity? entity);
}
