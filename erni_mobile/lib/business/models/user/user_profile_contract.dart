import 'package:erni_mobile/domain/models/data_contracts/data_contract.dart';

part 'user_profile_contract.g.dart';

@JsonSerializable()
class UserProfileContract extends DataContract {
  const UserProfileContract({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isAccountLocked,
    required this.isConfirmed,
  });

  factory UserProfileContract.fromJson(Map<String, dynamic> json) => _$UserProfileContractFromJson(json);

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final bool isAccountLocked;
  final bool isConfirmed;

  @override
  Map<String, dynamic> toJson() => _$UserProfileContractToJson(this);
}
