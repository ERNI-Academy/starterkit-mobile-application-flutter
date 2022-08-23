import 'package:erni_mobile/business/models/authentication/password/set_password_request_contract.dart';
import 'package:erni_mobile/domain/models/data_contracts/data_contract.dart';

part 'reset_password_contract.g.dart';

@JsonSerializable()
class ResetPasswordContract extends SetPasswordContract {
  const ResetPasswordContract({
    required super.newPassword,
    required super.confirmPassword,
    required super.confirmationCode,
  });

  factory ResetPasswordContract.fromJson(Map<String, dynamic> json) => _$ResetPasswordContractFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResetPasswordContractToJson(this);
}
