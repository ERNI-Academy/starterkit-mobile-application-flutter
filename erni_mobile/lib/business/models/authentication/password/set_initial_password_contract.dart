import 'package:erni_mobile/business/models/authentication/password/set_password_request_contract.dart';
import 'package:erni_mobile/domain/models/data_contracts/data_contract.dart';

part 'set_initial_password_contract.g.dart';

@JsonSerializable()
class SetInitialPasswordContract extends SetPasswordContract {
  const SetInitialPasswordContract({
    required super.newPassword,
    required super.confirmPassword,
    required super.confirmationCode,
  });

  factory SetInitialPasswordContract.fromJson(Map<String, dynamic> json) => _$SetInitialPasswordContractFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SetInitialPasswordContractToJson(this);
}
