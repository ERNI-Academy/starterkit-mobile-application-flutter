import 'package:erni_mobile/business/models/authentication/password/set_password_request_contract.dart';
import 'package:erni_mobile/domain/models/data_contracts/data_contract.dart';

part 'change_password_contract.g.dart';

@JsonSerializable()
class ChangePasswordContract extends SetPasswordContract {
  const ChangePasswordContract({
    required this.email,
    required this.oldPassword,
    required super.newPassword,
    required super.confirmPassword,
  });

  factory ChangePasswordContract.fromJson(Map<String, dynamic> json) => _$ChangePasswordContractFromJson(json);

  final String email;
  final String oldPassword;

  @override
  Map<String, dynamic> toJson() => _$ChangePasswordContractToJson(this);
}
