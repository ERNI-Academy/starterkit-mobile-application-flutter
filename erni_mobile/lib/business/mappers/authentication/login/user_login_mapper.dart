import 'package:erni_mobile/business/models/authentication/login/user_login_contract.dart';
import 'package:erni_mobile/business/models/authentication/login/user_login_entity.dart';
import 'package:erni_mobile/domain/mappers/contract_from_entity_mapper.dart';
import 'package:injectable/injectable.dart';
import 'package:smartstruct/smartstruct.dart';

part 'user_login_mapper.mapper.g.dart';

@Mapper(useInjection: true)
abstract class UserLoginContractFromEntityMapper extends ContractFromEntityMapper<UserLoginContract, UserLoginEntity> {
  @override
  UserLoginContract? fromEntity(UserLoginEntity? entity);
}
