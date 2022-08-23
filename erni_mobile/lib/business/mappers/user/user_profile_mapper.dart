import 'package:erni_mobile/business/models/user/user_profile_contract.dart';
import 'package:erni_mobile/business/models/user/user_profile_entity.dart';
import 'package:erni_mobile/domain/mappers/entity_from_contract_mapper.dart';
import 'package:injectable/injectable.dart';
import 'package:smartstruct/smartstruct.dart';

part 'user_profile_mapper.mapper.g.dart';

@Mapper(useInjection: true)
abstract class UserProfileEntityFromContractMapper
    extends EntityFromContractMapper<UserProfileEntity, UserProfileContract> {
  @override
  UserProfileEntity? fromContract(UserProfileContract? contract);
}
