import 'package:erni_mobile/business/models/authentication/password/reset_password_contract.dart';
import 'package:erni_mobile/business/models/authentication/password/reset_password_entity.dart';
import 'package:erni_mobile/domain/mappers/contract_from_entity_mapper.dart';
import 'package:injectable/injectable.dart';
import 'package:smartstruct/smartstruct.dart';

part 'reset_password_mapper.mapper.g.dart';

@Mapper(useInjection: true)
abstract class ResetPasswordContractFromEntityMapper
    extends ContractFromEntityMapper<ResetPasswordContract, ResetPasswordEntity> {
  @override
  ResetPasswordContract? fromEntity(ResetPasswordEntity? entity);
}
