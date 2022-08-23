import 'package:erni_mobile/domain/models/data_contracts/data_contract.dart';

part 'forgot_password_contract.g.dart';

@JsonSerializable()
class ForgotPasswordContract extends DataContract {
  const ForgotPasswordContract(this.email);

  factory ForgotPasswordContract.fromJson(Map<String, dynamic> json) => _$ForgotPasswordContractFromJson(json);

  final String email;

  @override
  Map<String, dynamic> toJson() => _$ForgotPasswordContractToJson(this);
}
