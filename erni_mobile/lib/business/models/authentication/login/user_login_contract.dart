import 'package:erni_mobile/domain/models/data_contracts/data_contract.dart';

part 'user_login_contract.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserLoginContract extends DataContract {
  const UserLoginContract({required this.email, required this.password});

  factory UserLoginContract.fromJson(Map<String, dynamic> json) => _$UserLoginContractFromJson(json);

  final String email;
  final String password;

  @override
  Map<String, dynamic> toJson() => _$UserLoginContractToJson(this);
}
